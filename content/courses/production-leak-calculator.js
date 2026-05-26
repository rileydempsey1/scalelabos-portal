export const course = {
  id: 'production-leak-calculator',
  title: 'Production Leak Calculator',
  description: 'Find the money bleeding out of your jobs across 7 leak types. Most contractors find $40K-$180K.',
  category: 'Operations',
  lesson_count: 12,
}

export const lessons = [
  {
    id: 'plc-01',
    course_id: 'production-leak-calculator',
    title: 'The Money You Are Losing Without Knowing It',
    lesson_type: 'reading',
    position: 1,
    content: {
      body: `## You are not losing money on bad jobs. You are losing it on good jobs, slowly.

Production leaks are not catastrophic losses. They are small, recurring, invisible drains on your margin that compound across every job you run.

A $200 loss per job looks like nothing. At 80 jobs a year, that is $16,000. Add up seven different leak categories and most contractors find $40,000 to $180,000 in annual losses they had no idea existed.

This course walks through the seven most common production leaks in contracting businesses. For each one, you will enter your numbers and calculate the annual cost of that specific leak in your operation.

At the end, you get a total annual leak number. That is money you can recover without adding a single new customer.

## The seven leak types

1. Materials not returned to the supplier
2. Jobs running longer than estimated
3. No-materials delays (crew waiting while materials are sourced)
4. Paying list price on materials instead of negotiating discounts
5. Missed change orders (work done, not billed)
6. Material over-ordering and job-site waste
7. Callbacks and warranty work

Each one is measurable. Each one is fixable.

## How to use this course

Work through each lesson with real numbers from your operation. If you do not know an exact number, use your best estimate and note it so you can verify later. The goal is directional accuracy, not accounting precision.

A 20% error in your estimate still gives you a number worth acting on.`,
      callout: 'Most contractors who complete this exercise find their top two leak categories account for 60-70% of the total. Fix those two first.',
    },
  },
  {
    id: 'plc-02',
    course_id: 'production-leak-calculator',
    title: 'Leak 1: Materials Not Returned',
    lesson_type: 'form',
    position: 2,
    content: {
      intro: 'Calculate the annual cost of unused materials that never make it back to the supplier for credit.',
      fields: [
        { id: 'jobs_per_month', label: 'Jobs Completed Per Month', type: 'number', placeholder: '0' },
        { id: 'pct_jobs_with_unreturned', label: 'Estimated % of Jobs With Unreturned Materials', type: 'number', placeholder: '40', suffix: '%', hint: 'Think about how often you see leftover materials at job end. 30-50% is typical.' },
        { id: 'avg_unreturned_value', label: 'Average Value of Unreturned Materials Per Job', type: 'number', placeholder: '0', prefix: '$', hint: 'Think shingles, fasteners, underlayment, trim pieces left on site or in trucks. $100-$400 is common.' },
      ],
      formulas: {
        leak_materials_not_returned: (v) => {
          const jobs = parseFloat(v.jobs_per_month) || 0
          const pct = parseFloat(v.pct_jobs_with_unreturned) || 0
          const val = parseFloat(v.avg_unreturned_value) || 0
          return jobs * 12 * (pct / 100) * val
        },
      },
      results: [
        { id: 'leak_materials_not_returned', label: 'Annual Leak: Materials Not Returned', format: 'currency', benchmark: { low: 0, high: 20000, label: 'Fix: require a materials sweep before crew leaves any job site. One person is accountable.' } },
      ],
    },
  },
  {
    id: 'plc-03',
    course_id: 'production-leak-calculator',
    title: 'Leak 2: Jobs Running Over Estimated Time',
    lesson_type: 'form',
    position: 3,
    content: {
      intro: 'Calculate the cost of jobs that take longer than you estimated, eating crew time you did not price in.',
      fields: [
        { id: 'jobs_running_long_pct', label: '% of Jobs That Run Longer Than Estimated', type: 'number', placeholder: '30', suffix: '%', hint: 'If you do not track this, estimate. Most contractors see 25-40% of jobs run over.' },
        { id: 'avg_extra_days', label: 'Average Extra Days When a Job Runs Long', type: 'number', placeholder: '1', hint: 'Usually 0.5 to 2 extra days for most trade jobs' },
        { id: 'crew_cost_per_day', label: 'Full Crew Cost Per Day (burdened wages)', type: 'number', placeholder: '0', prefix: '$', hint: 'Crew size x hourly rate x burden multiplier x 8 hours. E.g., 3 workers at $32 burdened = $768/day.' },
        { id: 'jobs_per_month_plc2', label: 'Jobs Completed Per Month', type: 'number', placeholder: '0' },
      ],
      formulas: {
        leak_jobs_running_long: (v) => {
          const pct = parseFloat(v.jobs_running_long_pct) || 0
          const extraDays = parseFloat(v.avg_extra_days) || 0
          const crewCost = parseFloat(v.crew_cost_per_day) || 0
          const jobs = parseFloat(v.jobs_per_month_plc2) || 0
          return jobs * 12 * (pct / 100) * extraDays * crewCost
        },
      },
      results: [
        { id: 'leak_jobs_running_long', label: 'Annual Leak: Jobs Running Over Time', format: 'currency', benchmark: { low: 0, high: 50000, label: 'Fix: track actual vs estimated hours on every job. Find the job types that consistently run long and add a time buffer to those bids.' } },
      ],
    },
  },
  {
    id: 'plc-04',
    course_id: 'production-leak-calculator',
    title: 'Leak 3: No-Materials Delays',
    lesson_type: 'form',
    position: 4,
    content: {
      intro: 'Calculate the cost of crew time lost waiting for materials that were not staged or ordered correctly.',
      fields: [
        { id: 'delay_incidents_per_month', label: 'Material Delay Incidents Per Month', type: 'number', placeholder: '0', hint: 'Times per month the crew had to wait or leave a job because materials were not there. Even once a week = 4/month.' },
        { id: 'idle_hours_per_incident', label: 'Average Idle Hours Per Incident', type: 'number', placeholder: '2', hint: 'How long does the crew sit or how many hours are lost per delay? Usually 1-4 hours.' },
        { id: 'crew_hourly_cost_burdened', label: 'Full Crew Hourly Cost (burdened)', type: 'number', placeholder: '0', prefix: '$', hint: 'Crew size x burdened hourly rate per worker' },
      ],
      formulas: {
        leak_no_materials_delays: (v) => {
          const incidents = parseFloat(v.delay_incidents_per_month) || 0
          const hours = parseFloat(v.idle_hours_per_incident) || 0
          const cost = parseFloat(v.crew_hourly_cost_burdened) || 0
          return incidents * 12 * hours * cost
        },
      },
      results: [
        { id: 'leak_no_materials_delays', label: 'Annual Leak: No-Materials Delays', format: 'currency', benchmark: { low: 0, high: 30000, label: 'Fix: require materials to be confirmed on-site the day before crew arrives. Assign one person to pre-job materials verification.' } },
      ],
    },
  },
  {
    id: 'plc-05',
    course_id: 'production-leak-calculator',
    title: 'Leak 4: Paying List Price on Materials',
    lesson_type: 'form',
    position: 5,
    content: {
      intro: 'Calculate the cost of buying materials at list price instead of negotiating supplier discounts.',
      fields: [
        { id: 'annual_materials_spend', label: 'Annual Materials Spend', type: 'number', placeholder: '0', prefix: '$', hint: 'Total you spent on materials last year across all jobs' },
        { id: 'current_discount_pct', label: 'Current Discount You Receive From Primary Supplier', type: 'number', placeholder: '0', suffix: '%', hint: 'If you get no discount, enter 0. Most contractors who ask get 8-15%.' },
        { id: 'achievable_discount_pct', label: 'Achievable Discount With Negotiation or Volume Commitment', type: 'number', placeholder: '10', suffix: '%', hint: 'A realistic target based on your volume. 10-15% is achievable for most contractors doing $500K+ in materials.' },
      ],
      formulas: {
        leak_list_price_materials: (v) => {
          const spend = parseFloat(v.annual_materials_spend) || 0
          const current = parseFloat(v.current_discount_pct) || 0
          const achievable = parseFloat(v.achievable_discount_pct) || 0
          const gap = achievable - current
          if (gap <= 0) return 0
          return spend * (gap / 100)
        },
      },
      results: [
        { id: 'leak_list_price_materials', label: 'Annual Leak: Unrealized Materials Discount', format: 'currency', benchmark: { low: 0, high: 40000, label: 'Fix: request a supplier meeting. Bring your annual spend number. Ask for a volume discount or preferred pricing tier. Most suppliers will negotiate.' } },
      ],
    },
  },
  {
    id: 'plc-06',
    course_id: 'production-leak-calculator',
    title: 'Leak 5: Missed Change Orders',
    lesson_type: 'form',
    position: 6,
    content: {
      intro: 'Calculate the annual cost of work you did but did not bill for.',
      fields: [
        { id: 'jobs_with_unbilled_changes_pct', label: '% of Jobs Where You Did Extra Work Without a Change Order', type: 'number', placeholder: '25', suffix: '%', hint: 'Think about how often you do small extras "as a favor." Most contractors see 20-35% of jobs.' },
        { id: 'avg_unbilled_change_value', label: 'Average Value of Unbilled Change Per Occurrence', type: 'number', placeholder: '0', prefix: '$', hint: 'Small extras: $150-$500. Larger scope additions: $500-$2,000. Use a realistic average.' },
        { id: 'jobs_per_month_plc5', label: 'Jobs Completed Per Month', type: 'number', placeholder: '0' },
      ],
      formulas: {
        leak_missed_change_orders: (v) => {
          const pct = parseFloat(v.jobs_with_unbilled_changes_pct) || 0
          const val = parseFloat(v.avg_unbilled_change_value) || 0
          const jobs = parseFloat(v.jobs_per_month_plc5) || 0
          return jobs * 12 * (pct / 100) * val
        },
      },
      results: [
        { id: 'leak_missed_change_orders', label: 'Annual Leak: Missed Change Orders', format: 'currency', benchmark: { low: 0, high: 60000, label: 'Fix: require a written change order for anything outside original scope. Even small items. Customers respect contractors with clear processes.' } },
      ],
    },
  },
  {
    id: 'plc-07',
    course_id: 'production-leak-calculator',
    title: 'Leak 6: Material Over-Ordering and Waste',
    lesson_type: 'form',
    position: 7,
    content: {
      intro: 'Calculate the cost of ordering more materials than needed and absorbing the waste.',
      fields: [
        { id: 'jobs_per_month_plc6', label: 'Jobs Completed Per Month', type: 'number', placeholder: '0' },
        { id: 'avg_wasted_materials_per_job', label: 'Average Wasted or Over-Ordered Materials Per Job', type: 'number', placeholder: '0', prefix: '$', hint: 'Materials ordered but not used AND not returned. Estimate from your typical job size. $50-$300 per job is common.' },
      ],
      formulas: {
        leak_material_overorder: (v) => {
          const jobs = parseFloat(v.jobs_per_month_plc6) || 0
          const waste = parseFloat(v.avg_wasted_materials_per_job) || 0
          return jobs * 12 * waste
        },
      },
      results: [
        { id: 'leak_material_overorder', label: 'Annual Leak: Material Over-Ordering and Waste', format: 'currency', benchmark: { low: 0, high: 25000, label: 'Fix: improve take-off accuracy for each job type. Use historical actuals to refine material quantities in your estimating template.' } },
      ],
    },
  },
  {
    id: 'plc-08',
    course_id: 'production-leak-calculator',
    title: 'Leak 7: Callbacks and Warranty Work',
    lesson_type: 'form',
    position: 8,
    content: {
      intro: 'Calculate the annual cost of sending your crew back to fix problems after a job is done.',
      fields: [
        { id: 'callbacks_per_month', label: 'Callbacks Per Month (warranty calls, re-do visits)', type: 'number', placeholder: '0', hint: 'Include any time you send crew back after job completion at no charge to the customer' },
        { id: 'avg_callback_cost', label: 'Average Cost Per Callback', type: 'number', placeholder: '0', prefix: '$', hint: 'Labor (burdened) + materials + any subcontractor cost. Typical range: $300-$1,500 depending on trade.' },
      ],
      formulas: {
        leak_callbacks: (v) => {
          const callbacks = parseFloat(v.callbacks_per_month) || 0
          const cost = parseFloat(v.avg_callback_cost) || 0
          return callbacks * 12 * cost
        },
      },
      results: [
        { id: 'leak_callbacks', label: 'Annual Leak: Callbacks and Warranty Work', format: 'currency', benchmark: { low: 0, high: 40000, label: 'Fix: track every callback by job type and cause. Most callbacks cluster around 2-3 installation patterns. Fix those patterns and callbacks drop sharply.' } },
      ],
    },
  },
  {
    id: 'plc-09',
    course_id: 'production-leak-calculator',
    title: 'Total Annual Leak Summary',
    lesson_type: 'form',
    position: 9,
    content: {
      intro: 'Enter your results from each leak calculation to see your total annual production loss.',
      fields: [
        { id: 'leak1_materials_returned', label: 'Leak 1: Materials Not Returned (from lesson 2)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'leak2_jobs_long', label: 'Leak 2: Jobs Running Over Time (from lesson 3)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'leak3_delays', label: 'Leak 3: No-Materials Delays (from lesson 4)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'leak4_list_price', label: 'Leak 4: Paying List Price on Materials (from lesson 5)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'leak5_change_orders', label: 'Leak 5: Missed Change Orders (from lesson 6)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'leak6_overorder', label: 'Leak 6: Material Over-Ordering and Waste (from lesson 7)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'leak7_callbacks', label: 'Leak 7: Callbacks and Warranty Work (from lesson 8)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'annual_revenue_plc', label: 'Annual Revenue', type: 'number', placeholder: '0', prefix: '$' },
      ],
      formulas: {
        total_annual_leak: (v) => {
          return (parseFloat(v.leak1_materials_returned) || 0) +
            (parseFloat(v.leak2_jobs_long) || 0) +
            (parseFloat(v.leak3_delays) || 0) +
            (parseFloat(v.leak4_list_price) || 0) +
            (parseFloat(v.leak5_change_orders) || 0) +
            (parseFloat(v.leak6_overorder) || 0) +
            (parseFloat(v.leak7_callbacks) || 0)
        },
        leak_as_pct_revenue: (v) => {
          const rev = parseFloat(v.annual_revenue_plc) || 0
          if (rev === 0) return null
          const total = (parseFloat(v.leak1_materials_returned) || 0) +
            (parseFloat(v.leak2_jobs_long) || 0) +
            (parseFloat(v.leak3_delays) || 0) +
            (parseFloat(v.leak4_list_price) || 0) +
            (parseFloat(v.leak5_change_orders) || 0) +
            (parseFloat(v.leak6_overorder) || 0) +
            (parseFloat(v.leak7_callbacks) || 0)
          return (total / rev) * 100
        },
      },
      results: [
        { id: 'total_annual_leak', label: 'Total Annual Production Leak', format: 'currency', benchmark: { low: 0, high: 180000, label: 'Most contractors find $40K-$180K. This is money recoverable without adding new customers.' } },
        { id: 'leak_as_pct_revenue', label: 'Leak as % of Revenue', format: 'percent', benchmark: { low: 2, high: 8, label: '2-5% is typical before fixes. Above 8% indicates systemic operational issues that need immediate attention.' } },
      ],
    },
  },
  {
    id: 'plc-10',
    course_id: 'production-leak-calculator',
    title: 'Prioritizing Your Fixes',
    lesson_type: 'reading',
    position: 10,
    content: {
      body: `## You found the leaks. Now you pick two to fix first.

Do not try to fix all seven at once. You will fix none of them. Pick the two largest leaks and build a specific 30-day action for each.

## How to prioritize

Sort your seven leak numbers from largest to smallest. The top two get your attention first. Here is the typical ranking for most contractors:

1. Missed change orders (often the largest single leak)
2. Jobs running over time
3. Paying list price on materials
4. Callbacks
5. Materials not returned
6. No-materials delays
7. Material over-ordering

Your ranking will differ based on your specific operation. Use your actual numbers.

## Building a 30-day fix

For each of your top two leaks, you need:

**A specific action.** Not "we will do better at change orders." A specific action: "We will create a one-page change order form this week. By next Friday, every crew member has it in their truck. Any scope addition gets written up before work starts."

**An owner or designated person.** One person is responsible for implementing and tracking the fix. Not the whole team.

**A measurement.** How will you know if it is working? Examples:
- Missed change orders: track change order revenue per month. Target: up 15% in 30 days.
- Jobs running long: track estimated vs actual hours per job. Target: average variance below 10% within 60 days.
- Callbacks: track callbacks per month. Target: below 3 per month.

**A review date.** Check in 30 days. Did the number move? Why or why not?

## What happens if you fix just two leaks

If your top two leaks total $60,000/year and you recover 50% of that in the first quarter, you have added $7,500/quarter to your bottom line with no new customers, no new marketing, and no new equipment.

That is the math. The fixes are operational. The payoff is financial.`,
      callout: 'Write the names of your top two leaks on a piece of paper. Put it somewhere you will see it daily for the next 30 days. That is your focus.',
    },
  },
  {
    id: 'plc-11',
    course_id: 'production-leak-calculator',
    title: 'Knowledge Check',
    lesson_type: 'quiz',
    position: 11,
    content: {
      questions: [
        {
          question: 'A contractor does 60 jobs per year. On 35% of jobs, $275 in materials goes unreturned. What is the annual leak from this category?',
          options: ['$4,800', '$5,775', '$6,300', '$7,200'],
          correct: 1,
          explanation: '60 x 0.35 x $275 = $5,775/year. This is a fixable leak with one policy change: a materials sweep before crew leaves any job.',
        },
        {
          question: 'A crew of 4 workers, each costing $32/hour burdened, loses 2 hours per delay incident. There are 3 delay incidents per month. What is the annual cost?',
          options: ['$7,372', '$9,216', '$12,288', '$14,400'],
          correct: 2,
          explanation: 'Crew cost per hour: 4 x $32 = $128. Hours lost per year: 3 x 12 x 2 = 72 hours. Annual cost: 72 x $128 = $9,216.',
        },
        {
          question: 'A contractor spends $400,000/year on materials and currently gets a 5% discount. A competitor gets 15%. What is the annual gap if they negotiated to 12%?',
          options: ['$20,000', '$28,000', '$40,000', '$48,000'],
          correct: 1,
          explanation: 'Gap = 12% - 5% = 7%. $400,000 x 0.07 = $28,000/year in unrealized savings from better supplier negotiation.',
        },
        {
          question: 'Which production leak is typically the largest single category for most contractors?',
          options: ['Materials not returned', 'Callbacks', 'Missed change orders', 'No-materials delays'],
          correct: 2,
          explanation: 'Missed change orders are usually the largest single leak. Small unbilled extras across many jobs compound quickly. A $300 unbilled change on 30% of 80 jobs = $7,200/year, often much more.',
        },
        {
          question: 'How many leaks should you focus on fixing first?',
          options: ['All seven at once', 'The five largest', 'The two largest', 'The one that is easiest to fix'],
          correct: 2,
          explanation: 'Fix your two largest leaks first. Trying to fix all seven at once typically results in fixing none. Pick two, build specific 30-day actions, measure results, then move to the next two.',
        },
        {
          question: 'What is the typical annual production leak range for contractors who complete this analysis?',
          options: ['$5,000-$20,000', '$20,000-$40,000', '$40,000-$180,000', '$200,000-$500,000'],
          correct: 2,
          explanation: 'Most contractors find $40,000 to $180,000 in annual production leaks. This is recoverable revenue that requires no new customers, just tighter operations.',
        },
      ],
    },
  },
  {
    id: 'plc-12',
    course_id: 'production-leak-calculator',
    title: 'Your Leak Fix Action Plan',
    lesson_type: 'summary',
    position: 12,
    content: {
      next_steps: [
        'Complete all seven leak calculators with real numbers from your operation. Use your best estimate where you lack exact data, then note what you need to verify.',
        'Rank your seven leaks from largest to smallest annual cost. Your top two are your 30-day priorities.',
        'For each top-two leak: write down one specific action, one person responsible, and one measurable target. No vague intentions.',
        'Build a monthly tracking log for your top two leak categories. Measure the key metric monthly for the next 90 days.',
        'After 90 days, review progress on your top two fixes. If recovered, move to the next two leaks on your list.',
      ],
    },
  },
]
