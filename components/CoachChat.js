'use client'
import { useState, useRef, useEffect } from 'react'
import { MessageCircle, X, Send, Loader2, ChevronRight } from 'lucide-react'

export default function CoachChat({ courseId, lessonId, userId }) {
  const [open, setOpen] = useState(false)
  const [messages, setMessages] = useState([])
  const [input, setInput] = useState('')
  const [loading, setLoading] = useState(false)
  const [remaining, setRemaining] = useState(30)
  const [error, setError] = useState('')
  const bottomRef = useRef(null)
  const inputRef = useRef(null)

  useEffect(() => {
    if (open && inputRef.current) inputRef.current.focus()
  }, [open])

  useEffect(() => {
    bottomRef.current?.scrollIntoView({ behavior: 'smooth' })
  }, [messages])

  async function sendMessage(e) {
    e.preventDefault()
    if (!input.trim() || loading) return
    const userMsg = input.trim()
    setInput('')
    setError('')
    setMessages(prev => [...prev, { role: 'user', content: userMsg }])
    setLoading(true)
    try {
      const res = await fetch('/api/coach', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          message: userMsg,
          courseId,
          lessonId,
          conversationHistory: messages,
        }),
      })
      const data = await res.json()
      if (!res.ok) {
        if (res.status === 429) {
          setError(data.error)
        } else {
          throw new Error(data.error)
        }
        return
      }
      setMessages(prev => [...prev, { role: 'assistant', content: data.message }])
      setRemaining(data.messagesRemaining)
    } catch (err) {
      setError(err.message || 'Failed to get response. Try again.')
    } finally {
      setLoading(false)
    }
  }

  return (
    <>
      {/* Floating button */}
      <button
        onClick={() => setOpen(true)}
        className={`fixed bottom-6 right-6 bg-navy text-white rounded-full p-4 shadow-xl hover:bg-navy-light transition-all z-40 ${open ? 'opacity-0 pointer-events-none' : 'opacity-100'}`}
        aria-label="Open AI Coach"
      >
        <MessageCircle size={22} />
      </button>

      {/* Overlay (mobile) */}
      {open && (
        <div className="fixed inset-0 bg-black/40 z-40 lg:hidden" onClick={() => setOpen(false)} />
      )}

      {/* Drawer */}
      <div className={`fixed top-0 right-0 h-full w-full max-w-sm bg-white shadow-2xl z-50 flex flex-col transition-transform duration-300 ease-out ${open ? 'translate-x-0' : 'translate-x-full'}`}>
        {/* Header */}
        <div className="bg-navy px-5 py-4 flex items-center justify-between shrink-0">
          <div>
            <div className="text-white font-bold text-sm">AI Business Coach</div>
            <div className="text-blue-300 text-xs mt-0.5">{remaining} messages remaining today</div>
          </div>
          <button onClick={() => setOpen(false)} className="text-gray-400 hover:text-white transition-colors">
            <X size={20} />
          </button>
        </div>

        {/* Messages */}
        <div className="flex-1 overflow-y-auto px-4 py-4 space-y-4">
          {messages.length === 0 && (
            <div className="text-center py-8">
              <MessageCircle size={32} className="mx-auto text-brand-border mb-3" />
              <p className="text-sm font-semibold text-navy mb-2">Your coach is ready.</p>
              <p className="text-xs text-brand-muted leading-relaxed px-4">
                Ask anything about this lesson. Your coach has full context of your numbers and uploaded files.
              </p>
              <div className="mt-5 space-y-2">
                {[
                  'What is my biggest problem right now?',
                  'How do I fix my close rate?',
                  'What should I focus on first?',
                ].map(suggestion => (
                  <button
                    key={suggestion}
                    onClick={() => setInput(suggestion)}
                    className="w-full text-left text-xs bg-brand-bg border border-brand-border rounded-lg px-3 py-2.5 hover:border-steel hover:bg-blue-50 transition-all flex items-center justify-between gap-2"
                  >
                    <span>{suggestion}</span>
                    <ChevronRight size={12} className="text-brand-muted shrink-0" />
                  </button>
                ))}
              </div>
            </div>
          )}

          {messages.map((msg, i) => (
            <div key={i} className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}>
              <div className={`max-w-[85%] text-sm leading-relaxed rounded-2xl px-4 py-3 ${
                msg.role === 'user'
                  ? 'bg-steel text-white rounded-br-sm'
                  : 'bg-brand-bg border border-brand-border text-navy rounded-bl-sm'
              }`}>
                {msg.content}
              </div>
            </div>
          ))}

          {loading && (
            <div className="flex justify-start">
              <div className="bg-brand-bg border border-brand-border rounded-2xl rounded-bl-sm px-4 py-3">
                <Loader2 size={16} className="text-steel animate-spin" />
              </div>
            </div>
          )}

          {error && (
            <div className="bg-red-50 border border-red-200 rounded-lg px-4 py-3 text-xs text-red-700">
              {error}
            </div>
          )}
          <div ref={bottomRef} />
        </div>

        {/* Input */}
        <form onSubmit={sendMessage} className="border-t border-brand-border px-4 py-3 flex gap-2 shrink-0">
          <input
            ref={inputRef}
            type="text"
            className="input-field flex-1 py-2.5 text-sm"
            placeholder="Ask your coach..."
            value={input}
            onChange={e => setInput(e.target.value)}
            disabled={loading}
          />
          <button
            type="submit"
            disabled={loading || !input.trim()}
            className="bg-steel text-white rounded-lg p-2.5 hover:bg-steel-dark transition-colors disabled:opacity-40"
          >
            <Send size={16} />
          </button>
        </form>
      </div>
    </>
  )
}
