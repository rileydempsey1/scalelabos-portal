'use client'
import { useState, useEffect } from 'react'
import { useParams } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase'
import { CheckCircle, Circle, Lock, ChevronRight, BookOpen, FileText, Upload, HelpCircle, BarChart2 } from 'lucide-react'

const COURSES = {
  'sales-conversion-tracker': () => import('@/content/courses/sales-conversion-tracker'),
  'job-costing-worksheet': () => import('@/content/courses/job-costing-worksheet').catch(() => ({ course: null, lessons: [] })),
  'overhead-calculator': () => import('@/content/courses/overhead-calculator').catch(() => ({ course: null, lessons: [] })),
  'production-leak-calculator': () => import('@/content/courses/production-leak-calculator').catch(() => ({ course: null, lessons: [] })),
  'lead-machine-blueprint': () => import('@/content/courses/lead-machine-blueprint').catch(() => ({ course: null, lessons: [] })),
  'first-hire-blueprint': () => import('@/content/courses/first-hire-blueprint').catch(() => ({ course: null, lessons: [] })),
}

const TYPE_ICONS = {
  reading: BookOpen,
  form: FileText,
  upload: Upload,
  quiz: HelpCircle,
  summary: BarChart2,
}

const TYPE_LABELS = {
  reading: 'Read',
  form: 'Enter numbers',
  upload: 'Upload file',
  quiz: 'Quiz',
  summary: 'Summary',
}

export default function CoursePage() {
  const { courseId } = useParams()
  const [course, setCourse] = useState(null)
  const [lessons, setLessons] = useState([])
  const [completedIds, setCompletedIds] = useState(new Set())
  const [loading, setLoading] = useState(true)
  const supabase = createClient()

  useEffect(() => {
    async function load() {
      const loader = COURSES[courseId]
      if (!loader) { setLoading(false); return }
      const mod = await loader()
      if (!mod.course) { setLoading(false); return }
      setCourse(mod.course)
      setLessons(mod.lessons || [])
      const { data: { user } } = await supabase.auth.getUser()
      if (user) {
        const { data } = await supabase
          .from('lesson_state')
          .select('lesson_id')
          .eq('user_id', user.id)
          .eq('course_id', courseId)
          .eq('completed', true)
        if (data) setCompletedIds(new Set(data.map(r => r.lesson_id)))
      }
      setLoading(false)
    }
    load()
  }, [courseId, supabase])

  if (loading) return (
    <div className="flex items-center justify-center py-24">
      <div className="w-6 h-6 border-2 border-steel border-t-transparent rounded-full animate-spin" />
    </div>
  )

  if (!course) return (
    <div className="text-center py-24">
      <p className="text-brand-muted">Course not found.</p>
      <Link href="/dashboard" className="text-steel text-sm mt-2 inline-block hover:underline">Back to dashboard</Link>
    </div>
  )

  const pct = lessons.length > 0 ? Math.round((completedIds.size / lessons.length) * 100) : 0
  const firstIncomplete = lessons.find(l => !completedIds.has(l.id))
  const startLesson = firstIncomplete || lessons[0]

  return (
    <div className="max-w-2xl mx-auto">
      <div className="mb-6">
        <Link href="/dashboard" className="text-sm text-brand-muted hover:text-navy transition-colors">
          Dashboard
        </Link>
        <span className="text-brand-muted mx-2">/</span>
        <span className="text-sm text-navy font-medium">{course.title}</span>
      </div>

      <div className="card p-6 mb-6">
        <div className="flex items-start justify-between gap-4">
          <div>
            <h1 className="text-xl font-bold text-navy">{course.title}</h1>
            <p className="text-sm text-brand-muted mt-1">{course.description}</p>
          </div>
          {startLesson && (
            <Link href={`/courses/${courseId}/lessons/${startLesson.id}`} className="btn-primary shrink-0 text-sm py-2.5">
              {pct > 0 ? 'Continue' : 'Start'}
            </Link>
          )}
        </div>
        <div className="mt-5">
          <div className="flex items-center justify-between text-xs text-brand-muted mb-2">
            <span>{completedIds.size} of {lessons.length} lessons complete</span>
            <span className="font-semibold text-navy">{pct}%</span>
          </div>
          <div className="h-2 bg-brand-border rounded-full overflow-hidden">
            <div className="h-2 bg-steel rounded-full transition-all duration-500" style={{ width: `${pct}%` }} />
          </div>
        </div>
      </div>

      <div className="space-y-2">
        {lessons.map((lesson, i) => {
          const done = completedIds.has(lesson.id)
          const Icon = TYPE_ICONS[lesson.lesson_type] || BookOpen
          const locked = i > 0 && !completedIds.has(lessons[i - 1].id) && pct === 0
          return (
            <Link
              key={lesson.id}
              href={locked ? '#' : `/courses/${courseId}/lessons/${lesson.id}`}
              className={`flex items-center gap-4 p-4 rounded-xl border transition-all ${
                done
                  ? 'bg-emerald-50 border-emerald-200 hover:border-emerald-300'
                  : locked
                  ? 'bg-white border-brand-border opacity-50 cursor-not-allowed'
                  : 'bg-white border-brand-border hover:border-steel hover:shadow-sm'
              }`}
              onClick={e => locked && e.preventDefault()}
            >
              <div className="shrink-0">
                {done
                  ? <CheckCircle size={20} className="text-emerald-500" />
                  : locked
                  ? <Lock size={20} className="text-brand-muted" />
                  : <Circle size={20} className="text-brand-border" />
                }
              </div>
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2">
                  <span className="text-xs text-brand-muted">{i + 1}.</span>
                  <span className="text-sm font-semibold text-navy truncate">{lesson.title}</span>
                </div>
                <div className="flex items-center gap-1.5 mt-0.5">
                  <Icon size={11} className="text-brand-muted shrink-0" />
                  <span className="text-xs text-brand-muted">{TYPE_LABELS[lesson.lesson_type]}</span>
                </div>
              </div>
              {!locked && <ChevronRight size={16} className="text-brand-muted shrink-0" />}
            </Link>
          )
        })}
      </div>
    </div>
  )
}
