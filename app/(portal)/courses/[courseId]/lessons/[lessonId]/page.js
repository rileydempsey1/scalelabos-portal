'use client'
import { useState, useEffect } from 'react'
import { useParams, useRouter } from 'next/navigation'
import Link from 'next/link'
import { createClient } from '@/lib/supabase'
import ReadingLesson from '@/components/lessons/ReadingLesson'
import FormLesson from '@/components/lessons/FormLesson'
import UploadLesson from '@/components/lessons/UploadLesson'
import QuizLesson from '@/components/lessons/QuizLesson'
import SummaryLesson from '@/components/lessons/SummaryLesson'
import CoachChat from '@/components/CoachChat'
import { ChevronLeft, ChevronRight } from 'lucide-react'

const COURSES = {
  'sales-conversion-tracker': () => import('@/content/courses/sales-conversion-tracker'),
  'job-costing-worksheet': () => import('@/content/courses/job-costing-worksheet').catch(() => ({ course: null, lessons: [] })),
  'overhead-calculator': () => import('@/content/courses/overhead-calculator').catch(() => ({ course: null, lessons: [] })),
  'production-leak-calculator': () => import('@/content/courses/production-leak-calculator').catch(() => ({ course: null, lessons: [] })),
  'lead-machine-blueprint': () => import('@/content/courses/lead-machine-blueprint').catch(() => ({ course: null, lessons: [] })),
  'first-hire-blueprint': () => import('@/content/courses/first-hire-blueprint').catch(() => ({ course: null, lessons: [] })),
}

export default function LessonPage() {
  const { courseId, lessonId } = useParams()
  const router = useRouter()
  const supabase = createClient()

  const [course, setCourse] = useState(null)
  const [lessons, setLessons] = useState([])
  const [lesson, setLesson] = useState(null)
  const [user, setUser] = useState(null)
  const [savedData, setSavedData] = useState({})
  const [allLessonStates, setAllLessonStates] = useState([])
  const [quizResults, setQuizResults] = useState([])
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)

  useEffect(() => {
    async function load() {
      const { data: { user: u } } = await supabase.auth.getUser()
      if (!u) { router.push('/login'); return }
      setUser(u)

      const loader = COURSES[courseId]
      if (!loader) { setLoading(false); return }
      const mod = await loader()
      if (!mod.course) { setLoading(false); return }
      setCourse(mod.course)
      setLessons(mod.lessons || [])
      const found = (mod.lessons || []).find(l => l.id === lessonId)
      setLesson(found || null)

      const [stateResult, quizResult] = await Promise.all([
        supabase.from('lesson_state').select('*').eq('user_id', u.id).eq('course_id', courseId),
        supabase.from('quiz_results').select('*').eq('user_id', u.id).eq('course_id', courseId).order('created_at', { ascending: false }),
      ])
      const states = stateResult.data || []
      setAllLessonStates(states)
      setQuizResults(quizResult.data || [])
      const thisState = states.find(s => s.lesson_id === lessonId)
      if (thisState) setSavedData(thisState.data || {})

      setLoading(false)
    }
    load()
  }, [courseId, lessonId, router, supabase])

  async function saveData(data) {
    if (!user) return
    setSaving(true)
    setSavedData(data)
    await supabase.from('lesson_state').upsert({
      user_id: user.id,
      course_id: courseId,
      lesson_id: lessonId,
      data,
      completed: false,
    }, { onConflict: 'user_id,lesson_id' })
    setSaving(false)
  }

  async function completeLesson() {
    if (!user) return
    await supabase.from('lesson_state').upsert({
      user_id: user.id,
      course_id: courseId,
      lesson_id: lessonId,
      data: savedData,
      completed: true,
    }, { onConflict: 'user_id,lesson_id' })
    const currentIndex = lessons.findIndex(l => l.id === lessonId)
    const nextLesson = lessons[currentIndex + 1]
    if (nextLesson) {
      router.push(`/courses/${courseId}/lessons/${nextLesson.id}`)
    } else {
      router.push(`/courses/${courseId}`)
    }
  }

  if (loading) return (
    <div className="flex items-center justify-center py-24">
      <div className="w-6 h-6 border-2 border-steel border-t-transparent rounded-full animate-spin" />
    </div>
  )

  if (!lesson) return (
    <div className="text-center py-24">
      <p className="text-brand-muted">Lesson not found.</p>
      <Link href={`/courses/${courseId}`} className="text-steel text-sm mt-2 inline-block hover:underline">Back to course</Link>
    </div>
  )

  const currentIndex = lessons.findIndex(l => l.id === lessonId)
  const prevLesson = currentIndex > 0 ? lessons[currentIndex - 1] : null
  const nextLesson = currentIndex < lessons.length - 1 ? lessons[currentIndex + 1] : null
  const pct = lessons.length > 0 ? Math.round(((currentIndex + 1) / lessons.length) * 100) : 0

  return (
    <div className="max-w-2xl mx-auto pb-24">
      {/* Progress bar */}
      <div className="fixed top-16 left-0 right-0 z-30 h-1 bg-brand-border">
        <div className="h-1 bg-steel transition-all duration-500" style={{ width: `${pct}%` }} />
      </div>

      {/* Breadcrumb */}
      <div className="mb-6 flex items-center justify-between">
        <div className="flex items-center gap-1 text-sm text-brand-muted">
          <Link href="/dashboard" className="hover:text-navy transition-colors">Dashboard</Link>
          <span className="mx-1">/</span>
          <Link href={`/courses/${courseId}`} className="hover:text-navy transition-colors">{course?.title}</Link>
          <span className="mx-1">/</span>
          <span className="text-navy font-medium truncate max-w-[200px]">{lesson.title}</span>
        </div>
        <div className="text-xs text-brand-muted shrink-0">
          {currentIndex + 1} of {lessons.length}
          {saving && <span className="ml-2 text-steel">Saving...</span>}
        </div>
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

      {/* Lesson content */}
      {lesson.lesson_type === 'reading' && (
        <ReadingLesson lesson={lesson} onComplete={completeLesson} />
      )}
      {lesson.lesson_type === 'form' && (
        <FormLesson
          lesson={lesson}
          savedData={savedData}
          onSave={saveData}
          onComplete={completeLesson}
        />
      )}
      {lesson.lesson_type === 'upload' && (
        <UploadLesson
          lesson={lesson}
          userId={user?.id}
          courseId={courseId}
          lessonId={lessonId}
          savedData={savedData}
          onSave={saveData}
          onComplete={completeLesson}
        />
      )}
      {lesson.lesson_type === 'quiz' && (
        <QuizLesson
          lesson={lesson}
          userId={user?.id}
          courseId={courseId}
          lessonId={lessonId}
          onComplete={completeLesson}
        />
      )}
      {lesson.lesson_type === 'summary' && (
        <SummaryLesson
          lesson={lesson}
          courseData={course}
          allLessonStates={allLessonStates}
          quizResults={quizResults}
          onComplete={() => router.push('/dashboard')}
        />
      )}

      {/* Prev/Next nav */}
      <div className="flex items-center justify-between mt-8 pt-6 border-t border-brand-border">
        {prevLesson ? (
          <Link href={`/courses/${courseId}/lessons/${prevLesson.id}`} className="flex items-center gap-1.5 text-sm text-brand-muted hover:text-navy transition-colors">
            <ChevronLeft size={16} />
            <span className="hidden sm:inline">{prevLesson.title}</span>
            <span className="sm:hidden">Previous</span>
          </Link>
        ) : <div />}
        {nextLesson && (
          <Link href={`/courses/${courseId}/lessons/${nextLesson.id}`} className="flex items-center gap-1.5 text-sm text-brand-muted hover:text-navy transition-colors">
            <span className="hidden sm:inline">{nextLesson.title}</span>
            <span className="sm:hidden">Next</span>
            <ChevronRight size={16} />
          </Link>
        )}
      </div>

      {/* AI Coach */}
      {user && (
        <CoachChat courseId={courseId} lessonId={lessonId} userId={user.id} />
      )}
    </div>
  )
}
