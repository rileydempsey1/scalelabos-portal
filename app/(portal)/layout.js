import PortalNav from '@/components/PortalNav'

export default function PortalLayout({ children }) {
  return (
    <div className="min-h-screen bg-brand-bg">
      <PortalNav />
      <main className="max-w-6xl mx-auto px-4 py-8">
        {children}
      </main>
    </div>
  )
}
