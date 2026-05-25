'use client'
import { CheckCircle, TrendingUp, AlertTriangle } from 'lucide-react'

export default function SummaryLesson({ lesson, courseData, allLessonStates, quizResults, onComplete }) {
  const passedQuiz = quizResults?.length > 0 && quizResults[quizResults.length - 1].passed
  const completedLessons = allLessonStates?.filter(ls => ls.completed).length || 0
  const totalLessons = courseData?.lesson_count || 0
  const pctComplete = totalLessons > 0 ? Math.round((completedLessons / totalLessons) * 100) : 0

  const keyNumbers = lesson.content.key_numbers || []
  const nextSteps = lesson.content.next_steps || []

  return (
    <div className="space-y-6">
      <div className="bg-navy rounded-xl p-8 text-white">
        <div className="flex items-center gap-3 mb-2">
          <CheckCircle size={28} className="text-emerald-400" />
          <h2 className="text-xl font-bold">Course Complete</h2>
        </div>
        <p className="text-blue-200 text-sm mt-1">{courseData?.title}</p>
        <div className="mt-6 grid grid-cols-3 gap-4">
          <div className="text-center">
            <div className="text-3xl font-bold">{pctComplete}%</div>
            <div className="text-xs text-blue-300 mt-1">Complete</div>
          </div>
          <div className="text-center border-x border-white/10">
            <div className="text-3xl font-bold">{completedLessons}</div>
            <div className="text-xs text-blue-300 mt-1">Lessons Done</div>
          </div>
          <div className="text-center">
            <div className="text-3xl font-bold">{passedQuiz ? 'Pass' : 'N/A'}</div>
            <div className="text-xs text-blue-300 mt-1">Quiz Result</div>
          </div>
        </div>
      </div>

      {keyNumbers.length > 0 && (
        <div className="bg-white border border-brand-border rounded-xl p-6">
          <div className="flex items-center gap-2 mb-4">
            <TrendingUp size={18} className="text-steel" />
            <h3 className="font-bold text-navy">Your Numbers</h3>
          </div>
          <div className="space-y-3">
            {keyNumbers.map((kn, i) => (
              <div key={i} className="flex items-center justify-between py-2 border-b border-brand-border last:border-0">
                <span className="text-sm text-brand-muted">{kn.label}</span>
                <span className="text-sm font-bold text-navy">{kn.value || 'Not entered'}</span>
              </div>
            ))}
          </div>
        </div>
      )}

      {nextSteps.length > 0 && (
        <div className="bg-white border border-brand-border rounded-xl p-6">
          <div className="flex items-center gap-2 mb-4">
            <AlertTriangle size={18} className="text-amber-500" />
            <h3 className="font-bold text-navy">Your Next 3 Actions</h3>
          </div>
          <div className="space-y-3">
            {nextSteps.map((step, i) => (
              <div key={i} className="flex items-start gap-3">
                <div className="w-6 h-6 rounded-full bg-steel text-white text-xs font-bold flex items-center justify-center shrink-0 mt-0.5">{i + 1}</div>
                <p className="text-sm text-gray-700">{step}</p>
              </div>
            ))}
          </div>
        </div>
      )}

      <div className="flex justify-end">
        <button onClick={onComplete} className="btn-primary">
          Back to Dashboard
        </button>
      </div>
    </div>
  )
}
