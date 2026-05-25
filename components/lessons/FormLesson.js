'use client'
import { useState, useEffect } from 'react'

function formatCurrency(val) {
  const n = parseFloat(String(val).replace(/[^0-9.]/g, ''))
  if (isNaN(n)) return ''
  return n.toLocaleString('en-US', { style: 'currency', currency: 'USD', maximumFractionDigits: 0 })
}

function formatPercent(val) {
  const n = parseFloat(val)
  if (isNaN(n)) return ''
  return n.toFixed(1) + '%'
}

export default function FormLesson({ lesson, savedData, onSave, onComplete }) {
  const [values, setValues] = useState(savedData?.inputs || {})
  const [computed, setComputed] = useState({})

  useEffect(() => {
    if (lesson.content.formulas) {
      const newComputed = {}
      for (const [key, formula] of Object.entries(lesson.content.formulas)) {
        try {
          const result = formula(values)
          newComputed[key] = result
        } catch {}
      }
      setComputed(newComputed)
    }
  }, [values, lesson.content.formulas])

  function handleChange(fieldId, value) {
    const updated = { ...values, [fieldId]: value }
    setValues(updated)
    onSave({ inputs: updated, computed })
  }

  const fields = lesson.content.fields || []
  const results = lesson.content.results || []

  return (
    <div className="space-y-6">
      {lesson.content.intro && (
        <div className="bg-white border border-brand-border rounded-xl p-6">
          <p className="text-sm text-gray-700 leading-relaxed">{lesson.content.intro}</p>
        </div>
      )}
      <div className="bg-white border border-brand-border rounded-xl p-6">
        <h3 className="font-bold text-navy mb-5">Enter your numbers</h3>
        <div className="space-y-5">
          {fields.map(field => (
            <div key={field.id}>
              <label className="label">{field.label}</label>
              {field.hint && <p className="text-xs text-brand-muted mb-2">{field.hint}</p>}
              {field.type === 'select' ? (
                <select
                  className="input-field"
                  value={values[field.id] || ''}
                  onChange={e => handleChange(field.id, e.target.value)}
                >
                  <option value="">Select...</option>
                  {field.options.map(o => <option key={o.value} value={o.value}>{o.label}</option>)}
                </select>
              ) : field.type === 'textarea' ? (
                <textarea
                  className="input-field min-h-[80px] resize-y"
                  value={values[field.id] || ''}
                  onChange={e => handleChange(field.id, e.target.value)}
                  placeholder={field.placeholder || ''}
                />
              ) : (
                <div className="relative">
                  {field.prefix && (
                    <span className="absolute left-3 top-1/2 -translate-y-1/2 text-brand-muted text-sm font-medium">{field.prefix}</span>
                  )}
                  <input
                    type={field.type || 'number'}
                    className={`input-field ${field.prefix ? 'pl-7' : ''} ${field.suffix ? 'pr-12' : ''}`}
                    value={values[field.id] || ''}
                    onChange={e => handleChange(field.id, e.target.value)}
                    placeholder={field.placeholder || '0'}
                    min={field.min}
                    max={field.max}
                    step={field.step || 'any'}
                  />
                  {field.suffix && (
                    <span className="absolute right-3 top-1/2 -translate-y-1/2 text-brand-muted text-sm">{field.suffix}</span>
                  )}
                </div>
              )}
            </div>
          ))}
        </div>
      </div>

      {results.length > 0 && (
        <div className="bg-navy rounded-xl p-6">
          <h3 className="text-white font-bold mb-4 text-sm uppercase tracking-wide">Your Results</h3>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            {results.map(result => {
              const rawVal = computed[result.id]
              let display = '—'
              if (rawVal !== undefined && rawVal !== null && !isNaN(rawVal)) {
                if (result.format === 'currency') display = formatCurrency(rawVal)
                else if (result.format === 'percent') display = formatPercent(rawVal)
                else if (result.format === 'number') display = Math.round(rawVal).toLocaleString()
                else display = rawVal
              }
              const flag = result.benchmark ? (rawVal < result.benchmark.low ? 'red' : rawVal > result.benchmark.high ? 'green' : 'yellow') : null
              return (
                <div key={result.id} className={`rounded-lg p-4 ${flag === 'red' ? 'bg-red-900/40' : flag === 'green' ? 'bg-green-900/40' : 'bg-white/10'}`}>
                  <div className="text-xs text-blue-200 mb-1">{result.label}</div>
                  <div className="text-2xl font-bold text-white">{display}</div>
                  {result.benchmark && rawVal !== undefined && (
                    <div className="text-xs text-blue-300 mt-1">
                      Target: {result.benchmark.label}
                    </div>
                  )}
                </div>
              )
            })}
          </div>
        </div>
      )}

      <div className="flex justify-end">
        <button onClick={onComplete} className="btn-primary">
          Save and Continue
        </button>
      </div>
    </div>
  )
}
