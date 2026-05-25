'use client'
import { useState } from 'react'
import { createClient } from '@/lib/supabase'
import { useRouter } from 'next/navigation'
import Link from 'next/link'

export const dynamic = 'force-dynamic'

export default function LoginPage() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const router = useRouter()
  const supabase = createClient()

  async function handleLogin(e) {
    e.preventDefault()
    setLoading(true)
    setError('')
    const { error } = await supabase.auth.signInWithPassword({ email, password })
    if (error) {
      setError(error.message)
      setLoading(false)
    } else {
      router.push('/dashboard')
    }
  }

  return (
    <div className="min-h-screen bg-navy flex items-center justify-center p-4">
      <div className="w-full max-w-md">
        <div className="text-center mb-8">
          <div className="text-white text-2xl font-bold tracking-tight">Scale Lab OS</div>
          <div className="text-gray-400 text-sm mt-1">Operator Portal</div>
        </div>
        <div className="card p-8">
          <h1 className="text-xl font-bold text-navy mb-6">Sign in to your account</h1>
          {error && (
            <div className="bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg p-3 mb-4">{error}</div>
          )}
          <form onSubmit={handleLogin} className="space-y-4">
            <div>
              <label className="label">Email</label>
              <input type="email" className="input-field" value={email} onChange={e => setEmail(e.target.value)} required placeholder="you@company.com" />
            </div>
            <div>
              <label className="label">Password</label>
              <input type="password" className="input-field" value={password} onChange={e => setPassword(e.target.value)} required placeholder="••••••••" />
            </div>
            <button type="submit" className="btn-primary w-full" disabled={loading}>
              {loading ? 'Signing in...' : 'Sign in'}
            </button>
          </form>
          <p className="text-center text-sm text-brand-muted mt-6">
            Don&apos;t have an account?{' '}
            <Link href="/signup" className="text-steel font-medium hover:underline">Sign up</Link>
          </p>
        </div>
      </div>
    </div>
  )
}
