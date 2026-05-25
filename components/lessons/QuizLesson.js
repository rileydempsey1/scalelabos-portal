'use client'
import { useState } from 'react'
import { CheckCircle, XCircle, Trophy } from 'lucide-react'
import { createClient } from '@/lib/supabase'

export default function QuizLesson({ lesson, userId, courseId, lessonId, onComplete }) {
  const [answers, setAnswers] = useState({})
  const [submitted, setSubmitted] = useState(false)
  const [score, setScore] = useState(null)
  const supabase = createClient()

  const questions = lesson.content.questions || []

  function selectAnswer(qIndex, optionIndex) {
    if (submitted) return
    setAnswers(prev => ({ ...prev, [qIndex]: optionIndex }))
  }

  async function handleSubmit() {
    let correct = 0
    questions.forEach((q, i) => {
      if (answers[i] === q.correct) correct++
    })
    const total = questions.length
    const pct = Math.round((correct / total) * 100)
    const passed = pct >= 70
    setScore({ correct, total, pct, passed })
    setSubmitted(true)
    await supabase.from('quiz_results').insert({
      user_id: userId,
      course_id: courseId,
      lesson_id: lessonId,
      score: correct,
      total,
      answers,
      passed,
    })
  }

  if (submitted && score) {
    return (
      <div className="space-y-6">
        <div className={`rounded-xl p-8 text-center ${score.passed ? 'bg-emerald-50 border border-emerald-200' : 'bg-amber-50 border border-amber-200'}`}>
          <Trophy size={40} className={`mx-auto mb-3 ${score.passed ? 'text-emerald-500' : 'text-amber-500'}`} />
          <div className="text-4xl font-bold text-navy mb-1">{score.pct}%</div>
          <div className="text-sm font-semibold text-brand-muted">{score.correct} of {score.total} correct</div>
          <div className={`mt-3 text-sm font-semibold ${score.passed ? 'text-emerald-700' : 'text-amber-700'}`}>
            {score.passed ? 'Passed. Move to the next lesson.' : 'Review the lesson and try again.'}
          </div>
        </div>
        <div className="space-y-4">
          {questions.map((q, i) => {
            const userAnswer = answers[i]
            const correct = userAnswer === q.correct
            return (
              <div key={i} className={`bg-white border rounded-xl p-5 ${correct ? 'border-emerald-200' : 'border-red-200'}`}>
                <div className="flex items-start gap-3">
                  {correct
                    ? <CheckCircle size={18} className="text-emerald-500 mt-0.5 shrink-0" />
                    : <XCircle size={18} className="text-red-500 mt-0.5 shrink-0" />
                  }
                  <div className="flex-1">
                    <p className="text-sm font-semibold text-navy mb-3">{q.question}</p>
                    <div className="space-y-1.5">
                      {q.options.map((o, oi) => (
                        <div key={oi} className={`text-sm px-3 py-2 rounded-lg ${
                          oi === q.correct ? 'bg-emerald-50 text-emerald-800 font-medium' :
                          oi === userAnswer && !correct ? 'bg-red-50 text-red-700' :
                          'text-gray-500'
                        }`}>
                          {o}
                        </div>
                      ))}
                    </div>
                    {q.explanation && (
                      <p className="text-xs text-brand-muted mt-3 italic">{q.explanation}</p>
                    )}
                  </div>
                </div>
              </div>
            )
          })}
        </div>
        <div className="flex justify-end">
          <button onClick={onComplete} className="btn-primary">
            {score.passed ? 'View Progress Report' : 'Retake Quiz'}
          </button>
        </div>
      </div>
    )
  }

  return (
    <div className="space-y-5">
      <div className="bg-white border border-brand-border rounded-xl p-5">
        <p className="text-sm text-brand-muted">
          {questions.length} questions. 70% to pass. Take your time — use what you learned in this course.
        </p>
      </div>
      {questions.map((q, i) => (
        <div key={i} className="bg-white border border-brand-border rounded-xl p-5">
          <p className="text-sm font-semibold text-navy mb-4">
            <span className="text-brand-muted font-normal mr-2">{i + 1}.</span>
            {q.question}
          </p>
          <div className="space-y-2">
            {q.options.map((o, oi) => (
              <button
                key={oi}
                onClick={() => selectAnswer(i, oi)}
                className={`w-full text-left text-sm px-4 py-3 rounded-lg border transition-all ${
                  answers[i] === oi
                    ? 'border-steel bg-blue-50 text-steel font-medium'
                    : 'border-brand-border hover:border-steel hover:bg-blue-50/50'
                }`}
              >
                {o}
              </button>
            ))}
          </div>
        </div>
      ))}
      <div className="flex justify-end">
        <button
          onClick={handleSubmit}
          className="btn-primary"
          disabled={Object.keys(answers).length < questions.length}
        >
          Submit answers
        </button>
      </div>
    </div>
  )
}
