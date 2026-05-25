'use client'
import { createClient } from '@/lib/supabase'
import { useRouter } from 'next/navigation'
import Link from 'next/link'

export default function PortalNav() {
  const router = useRouter()
  const supabase = createClient()

  async function handleSignOut() {
    await supabase.auth.signOut()
    router.push('/login')
  }

  return (
    <nav className="bg-navy border-b border-navy-light">
      <div className="max-w-6xl mx-auto px-4 h-16 flex items-center justify-between">
        <Link href="/dashboard" className="text-white font-bold text-lg tracking-tight">
          Scale Lab OS
        </Link>
        <div className="flex items-center gap-6">
          <Link href="/dashboard" className="text-gray-300 hover:text-white text-sm font-medium transition-colors">
            Dashboard
          </Link>
          <Link href="/courses" className="text-gray-300 hover:text-white text-sm font-medium transition-colors">
            Courses
          </Link>
          <button onClick={handleSignOut} className="text-gray-400 hover:text-white text-sm transition-colors">
            Sign out
          </button>
        </div>
      </div>
    </nav>
  )
}
