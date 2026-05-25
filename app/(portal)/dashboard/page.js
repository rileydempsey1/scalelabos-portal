import Link from 'next/link'

const courses = [
  {
    id: 'sales-conversion-tracker',
    title: 'Sales Conversion Tracker',
    description: 'Find exactly where your deals are dying and fix it. 6-stage funnel analysis with live conversion math.',
    lessons: 14,
    category: 'Sales',
    color: 'bg-blue-500',
  },
  {
    id: 'job-costing-worksheet',
    title: 'Job Costing Worksheet',
    description: 'Know your real margin on every job. Materials, labor, overhead allocation, and gross profit.',
    lessons: 12,
    category: 'Finance',
    color: 'bg-emerald-500',
  },
  {
    id: 'overhead-calculator',
    title: 'Overhead Calculator',
    description: 'Map every fixed cost, calculate your breakeven, and measure your Operator Output Score.',
    lessons: 10,
    category: 'Finance',
    color: 'bg-violet-500',
  },
  {
    id: 'production-leak-calculator',
    title: 'Production Leak Calculator',
    description: 'Find the revenue bleeding out of your jobs. Materials delays, rework, trip charge gaps.',
    lessons: 10,
    category: 'Operations',
    color: 'bg-orange-500',
  },
  {
    id: 'lead-machine-blueprint',
    title: 'Lead Machine Blueprint',
    description: 'Build consistent lead flow from 4 sources. GBP, reviews, referrals, and paid ads.',
    lessons: 12,
    category: 'Marketing',
    color: 'bg-pink-500',
  },
  {
    id: 'first-hire-blueprint',
    title: 'First Hire Blueprint',
    description: 'Hire your first person right. Role clarity, interview scorecard, offer, and 30-day onboarding.',
    lessons: 12,
    category: 'People',
    color: 'bg-amber-500',
  },
]

export default function DashboardPage() {
  return (
    <div>
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-navy">Your Operator Dashboard</h1>
        <p className="text-brand-muted mt-1">Six core systems. Work through them in order or jump to your biggest problem.</p>
      </div>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
        {courses.map(course => (
          <Link key={course.id} href={`/courses/${course.id}`} className="card p-6 hover:shadow-md transition-shadow group">
            <div className="flex items-start justify-between mb-4">
              <span className={`text-xs font-semibold text-white px-2.5 py-1 rounded-full ${course.color}`}>
                {course.category}
              </span>
              <span className="text-xs text-brand-muted">{course.lessons} lessons</span>
            </div>
            <h2 className="font-bold text-navy text-lg mb-2 group-hover:text-steel transition-colors">{course.title}</h2>
            <p className="text-sm text-brand-muted leading-relaxed">{course.description}</p>
            <div className="mt-4 pt-4 border-t border-brand-border flex items-center justify-between">
              <div className="flex items-center gap-2">
                <div className="h-1.5 bg-brand-border rounded-full w-32">
                  <div className="h-1.5 bg-steel rounded-full w-0"></div>
                </div>
                <span className="text-xs text-brand-muted">0%</span>
              </div>
              <span className="text-xs font-medium text-steel group-hover:underline">Start</span>
            </div>
          </Link>
        ))}
      </div>
    </div>
  )
}
