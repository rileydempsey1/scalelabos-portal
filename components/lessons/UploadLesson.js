'use client'
import { useState, useCallback } from 'react'
import { useDropzone } from 'react-dropzone'
import { createClient } from '@/lib/supabase'
import { Upload, FileText, CheckCircle, AlertCircle, X } from 'lucide-react'

export default function UploadLesson({ lesson, userId, courseId, lessonId, savedData, onSave, onComplete }) {
  const [uploads, setUploads] = useState(savedData?.uploads || [])
  const [uploading, setUploading] = useState(false)
  const [error, setError] = useState('')
  const supabase = createClient()

  const onDrop = useCallback(async (acceptedFiles) => {
    setUploading(true)
    setError('')
    const newUploads = []
    for (const file of acceptedFiles) {
      try {
        const path = `${userId}/${lessonId}/${Date.now()}-${file.name}`
        const { error: uploadError } = await supabase.storage
          .from('lesson-uploads')
          .upload(path, file)
        if (uploadError) throw uploadError
        let parsedData = {}
        if (file.name.endsWith('.csv') || file.name.endsWith('.xlsx') || file.name.endsWith('.xls')) {
          const formData = new FormData()
          formData.append('file', file)
          formData.append('lessonId', lessonId)
          const res = await fetch('/api/upload', { method: 'POST', body: formData })
          if (res.ok) {
            const result = await res.json()
            parsedData = result.parsed || {}
          }
        }
        const uploadRecord = {
          storage_path: path,
          original_filename: file.name,
          file_size: file.size,
          mime_type: file.type,
          uploaded_at: new Date().toISOString(),
          parsed_data: parsedData,
        }
        await supabase.from('uploads').insert({
          user_id: userId,
          course_id: courseId,
          lesson_id: lessonId,
          ...uploadRecord,
        })
        newUploads.push(uploadRecord)
      } catch (err) {
        setError(`Failed to upload ${file.name}: ${err.message}`)
      }
    }
    const updated = [...uploads, ...newUploads]
    setUploads(updated)
    onSave({ uploads: updated })
    setUploading(false)
  }, [uploads, userId, lessonId, courseId, supabase, onSave])

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    onDrop,
    accept: {
      'application/pdf': ['.pdf'],
      'text/csv': ['.csv'],
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': ['.xlsx'],
      'application/vnd.ms-excel': ['.xls'],
    },
    maxSize: 25 * 1024 * 1024,
  })

  function formatSize(bytes) {
    if (bytes < 1024) return bytes + ' B'
    if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB'
    return (bytes / 1024 / 1024).toFixed(1) + ' MB'
  }

  return (
    <div className="space-y-6">
      {lesson.content.intro && (
        <div className="bg-white border border-brand-border rounded-xl p-6">
          <p className="text-sm text-gray-700 leading-relaxed">{lesson.content.intro}</p>
          {lesson.content.accepts && (
            <div className="mt-3 flex flex-wrap gap-2">
              {lesson.content.accepts.map(a => (
                <span key={a} className="text-xs bg-brand-bg border border-brand-border rounded-full px-3 py-1 text-brand-muted font-medium">{a}</span>
              ))}
            </div>
          )}
        </div>
      )}

      <div
        {...getRootProps()}
        className={`border-2 border-dashed rounded-xl p-10 text-center cursor-pointer transition-all ${
          isDragActive ? 'border-steel bg-blue-50' : 'border-brand-border bg-white hover:border-steel hover:bg-blue-50/30'
        }`}
      >
        <input {...getInputProps()} />
        <Upload className={`mx-auto mb-3 ${isDragActive ? 'text-steel' : 'text-brand-muted'}`} size={32} />
        {uploading ? (
          <p className="text-sm font-medium text-steel">Uploading...</p>
        ) : isDragActive ? (
          <p className="text-sm font-medium text-steel">Drop it here</p>
        ) : (
          <>
            <p className="text-sm font-semibold text-navy">Drag and drop your file here</p>
            <p className="text-xs text-brand-muted mt-1">or click to browse — PDF, Excel, CSV up to 25MB</p>
          </>
        )}
      </div>

      {error && (
        <div className="flex items-start gap-2 bg-red-50 border border-red-200 rounded-lg p-3">
          <AlertCircle size={16} className="text-red-500 mt-0.5 shrink-0" />
          <p className="text-sm text-red-700">{error}</p>
        </div>
      )}

      {uploads.length > 0 && (
        <div className="bg-white border border-brand-border rounded-xl p-4 space-y-2">
          <div className="text-xs font-semibold text-brand-muted uppercase tracking-wide mb-3">Uploaded Files</div>
          {uploads.map((u, i) => (
            <div key={i} className="flex items-center justify-between p-3 bg-brand-bg rounded-lg">
              <div className="flex items-center gap-3">
                <FileText size={16} className="text-steel shrink-0" />
                <div>
                  <div className="text-sm font-medium text-navy">{u.original_filename}</div>
                  <div className="text-xs text-brand-muted">{formatSize(u.file_size)}</div>
                </div>
              </div>
              <CheckCircle size={16} className="text-emerald-500 shrink-0" />
            </div>
          ))}
          {lesson.content.parsed_note && uploads.some(u => u.parsed_data && Object.keys(u.parsed_data).length > 0) && (
            <p className="text-xs text-brand-muted pt-2">{lesson.content.parsed_note}</p>
          )}
        </div>
      )}

      <div className="flex justify-end gap-3">
        {lesson.content.optional && (
          <button onClick={onComplete} className="btn-secondary">
            Skip for now
          </button>
        )}
        <button onClick={onComplete} className="btn-primary" disabled={!lesson.content.optional && uploads.length === 0}>
          {uploads.length > 0 ? 'Continue' : 'Upload to continue'}
        </button>
      </div>
    </div>
  )
}
