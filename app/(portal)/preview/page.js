'use client'
import { useState } from 'react'
import ReadingLesson from '@/components/lessons/ReadingLesson'
import FormLesson from '@/components/lessons/FormLesson'
import QuizLesson from '@/components/lessons/QuizLesson'
import CoachChat from '@/components/CoachChat'
import { lessons } from '@/content/courses/sales-conversion-tracker'
import { ChevronLeft, ChevronRight } from 'lucide-react'

export default function PreviewPage() {
  const [index, setIndex] = useState(0)
  const [savedData, setSavedData] = useState({})
  const lesson = lessons[index]
  const total = lessons.length
  const pct = Math.round(((index + 1) / total) * 100)

  return (
    <div className="max-w-2xl mx-auto pb-24">
      {/* Progress bar */}
      <div className="fixed top-16 left-0 right-0 z-30 h-1 bg-brand-border">
        <div className="h-1 bg-steel transition-all duration-500" style={{ width: `${pct}%` }} />
      </div>

      {/* Header */}
      <div className="mb-6 flex items-center justify-between mt-2">
        <div className="text-sm text-brand-muted">
          Sales Conversion Tracker
        </div>
        <div className="text-xs text-brand-muted">{index + 1} of {total}</div>
      </div>

      {/* Lesson header */}
      <div className="mb-6">
        <div className="text-xs font-bold text-brand-muted uppercase tracking-widest mb-1">
          {lesson.lesson_type === 'quiz' ? 'Knowledge Check' :
           lesson.lesson_type === 'summary' ? 'Progress Report' :
           lesson.lesson_type === 'upload' ? 'Upload Your Data' :
           lesson.lesson_type === 'form' ? 'Enter Your Numbers' : 'Lesson'}
        </div>
        <h1 className="text-2xl font-bold text-navy">{lesson.title}</h1>
      </div>

      {lesson.lesson_type === 'reading' && (
        <ReadingLesson lesson={lesson} onComplete={() => setIndex(i => Math.min(i + 1, total - 1))} />
      )}
      {lesson.lesson_type === 'form' && (
        <FormLesson
          lesson={lesson}
          savedData={savedData}
          onSave={setSavedData}
          onComplete={() => setIndex(i => Math.min(i + 1, total - 1))}
        />
      )}
      {lesson.lesson_type === 'quiz' && (
        <QuizLesson
          lesson={lesson}
          userId="preview"
          courseId="preview"
          lessonId={lesson.id}
          onComplete={() => setIndex(i => Math.min(i + 1, total - 1))}
        />
      )}
      {lesson.lesson_type === 'upload' && (
        <div className="space-y-6">
          <div className="bg-white border border-brand-border rounded-xl p-6">
            <p className="text-sm text-gray-700">{lesson.content.intro}</p>
          </div>
          <div className="border-2 border-dashed border-brand-border rounded-xl p-10 text-center bg-white">
            <p className="text-sm font-semibold text-navy">Drag and drop your file here</p>
            <p className="text-xs text-brand-muted mt-1">PDF, Excel, CSV up to 25MB</p>
          </div>
          <div className="flex justify-end gap-3">
            <button onClick={() => setIndex(i => Math.min(i + 1, total - 1))} className="btn-secondary">Skip for now</button>
            <button onClick={() => setIndex(i => Math.min(i + 1, total - 1))} className="btn-primary">Continue</button>
          </div>
        </div>
      )}

      {/* Nav */}
      <div className="flex items-center justify-between mt-8 pt-6 border-t border-brand-border">
        <button
          onClick={() => setIndex(i => Math.max(i - 1, 0))}
          disabled={index === 0}
          className="flex items-center gap-1.5 text-sm text-brand-muted hover:text-navy transition-colors disabled:opacity-30"
        >
          <ChevronLeft size={16} /> Previous
        </button>
        <button
          onClick={() => setIndex(i => Math.min(i + 1, total - 1))}
          disabled={index === total - 1}
          className="flex items-center gap-1.5 text-sm text-brand-muted hover:text-navy transition-colors disabled:opacity-30"
        >
          Next <ChevronRight size={16} />
        </button>
      </div>

      {/* Coach preview (no API calls) */}
      <div className="fixed bottom-6 right-6 bg-navy text-white rounded-full p-4 shadow-xl z-40">
        <svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
      </div>
    </div>
  )
}
