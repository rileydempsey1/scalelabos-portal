'use client'
import { useState } from 'react'
import { createClient } from '@/lib/supabase'
import { useRouter } from 'next/navigation'
import Link from 'next/link'

export const dynamic = 'force-dynamic'

export default function SignupPage() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [company, setCompany] = useState('')
  const [revenue, setRevenue] = useState('')
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')
  const router = useRouter()
  const supabase = createClient()

  async function handleSignup(e) {
    e.preventDefault()
    setLoading(true)
    setError('')
    const { error } = await supabase.auth.signUp({
      email,
      password,
      options: { data: { company_name: company, annual_revenue: revenue } }
    })
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
          <h1 className="text-xl font-bold text-navy mb-6">Create your account</h1>
          {error && (
            <div className="bg-red-50 border border-red-200 text-red-700 text-sm rounded-lg p-3 mb-4">{error}</div>
          )}
          <form onSubmit={handleSignup} className="space-y-4">
            <div>
              <label className="label">Company Name</label>
              <input type="text" className="input-field" value={company} onChange={e => setCompany(e.target.value)} required placeholder="Your Company LLC" />
            </div>
            <div>
              <label className="label">Annual Revenue</label>
              <select className="input-field" value={revenue} onChange={e => setRevenue(e.target.value)} required>
                <option value="">Select range</option>
                <option value="under_1m">Under $1M</option>
                <option value="1m_3m">$1M - $3M</option>
                <option value="3m_5m">$3M - $5M</option>
                <option value="5m_10m">$5M - $10M</option>
                <option value="over_10m">Over $10M</option>
              </select>
            </div>
            <div>
              <label className="label">Email</label>
              <input type="email" className="input-field" value={email} onChange={e => setEmail(e.target.value)} required placeholder="you@company.com" />
            </div>
            <div>
              <label className="label">Password</label>
              <input type="password" className="input-field" value={password} onChange={e => setPassword(e.target.value)} required placeholder="Min 8 characters" minLength={8} />
            </div>
            <button type="submit" className="btn-primary w-full" disabled={loading}>
              {loading ? 'Creating account...' : 'Create account'}
            </button>
          </form>
          <p className="text-center text-sm text-brand-muted mt-6">
            Already have an account?{' '}
            <Link href="/login" className="text-steel font-medium hover:underline">Sign in</Link>
          </p>
        </div>
      </div>
    </div>
  )
}
