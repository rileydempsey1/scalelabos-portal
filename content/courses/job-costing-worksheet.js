export const course = {
  id: 'job-costing-worksheet',
  title: 'Job Costing Worksheet',
  description: 'Track estimated vs actual costs on every job. Know your margin before you cash the check.',
  category: 'Finance',
  lesson_count: 13,
}

export const lessons = [
  {
    id: 'jcw-01',
    course_id: 'job-costing-worksheet',
    title: 'Why Most Contractors Are Flying Blind',
    lesson_type: 'reading',
    position: 1,
    content: {
      body: `## The problem is not your revenue. It is your margin.

Most contractors know roughly what they billed last month. Almost none of them know what they actually made on each job.

That is the difference between a busy contractor and a profitable one.

Job costing is the practice of tracking every dollar in and every dollar out on a job-by-job basis. Materials. Labor. Subs. Overhead allocation. You compare what you estimated to what you actually spent, and you know your real gross profit margin for that job.

Without this, you are guessing. And guessing at scale gets expensive fast.

## What happens without job costing

A roofing contractor bills $1.2M in a year. Feels good. Then in December he looks at his bank account and wonders where the money went.

Here is what happened: he was running 18% gross margin without knowing it. His materials costs were 5% higher than estimated because he never tracked variance. His labor burden was calculated wrong. Two jobs had uncaptured change orders. Three had callbacks that cost $4,200 total.

He needed 28% gross margin to cover overhead and pay himself. He was 10 points short, consistently, on every job.

## What job costing gives you

- **Accurate estimates.** When you know your actual costs, your future bids reflect reality.
- **Early warnings.** You catch a job going sideways while you can still do something about it.
- **Better job selection.** You learn which job types make money and which ones eat it.
- **Negotiating leverage.** You know your true cost basis going into supplier and sub conversations.

## The benchmarks

Gross margin targets by job type:

- Renovation and remodeling: 30-40%
- New construction: 20-30%
- Service and repair: 40-55%
- Below 20%: warning. Review immediately.

You are going to build your job costing worksheet in this course. By the end, you will have a working model you can fill out on every job.`,
      callout: 'Gross margin is revenue minus direct job costs, divided by revenue. It is not net profit. Overhead and owner pay come out after.',
    },
  },
  {
    id: 'jcw-02',
    course_id: 'job-costing-worksheet',
    title: 'Job Information Setup',
    lesson_type: 'form',
    position: 2,
    content: {
      intro: 'Enter the basic information for a real job you completed recently. Use actual numbers.',
      fields: [
        { id: 'contract_value', label: 'Contract Value', type: 'number', placeholder: '0', hint: 'Total amount billed to the customer including any change orders', prefix: '$' },
        {
          id: 'job_type', label: 'Job Type', type: 'select', options: [
            { value: 'renovation', label: 'Renovation / Remodeling' },
            { value: 'new_construction', label: 'New Construction' },
            { value: 'service_repair', label: 'Service / Repair' },
            { value: 'commercial', label: 'Commercial' },
          ],
        },
        { id: 'job_duration_days', label: 'Job Duration (days)', type: 'number', placeholder: '0', hint: 'Calendar days from start to completion' },
        { id: 'crew_size', label: 'Crew Size (workers on this job)', type: 'number', placeholder: '0' },
        { id: 'target_margin_pct', label: 'What margin did you estimate at bid time?', type: 'number', placeholder: '30', suffix: '%', hint: 'If you did not estimate a margin, enter 0' },
      ],
      formulas: {
        target_profit: (v) => {
          const cv = parseFloat(v.contract_value) || 0
          const tm = parseFloat(v.target_margin_pct) || 0
          return cv * (tm / 100)
        },
      },
      results: [
        { id: 'target_profit', label: 'Target Gross Profit at Bid', format: 'currency', benchmark: null },
      ],
    },
  },
  {
    id: 'jcw-03',
    course_id: 'job-costing-worksheet',
    title: 'Material Costs: Estimated vs Actual',
    lesson_type: 'reading',
    position: 3,
    content: {
      body: `## Materials are where margin goes to die.

Material cost variance is the single most common cause of blown job margins. You bid $8,400 in materials. You spent $9,700. That $1,300 delta comes straight out of profit.

Here is how it happens:

1. **You estimated from memory, not supplier quotes.** Prices change. Always get a quote tied to the job.
2. **You ordered extra and did not return it.** A pallet of shingles left on a job site, a box of fasteners riding around in the truck for three weeks.
3. **Change orders added material but you forgot to update the cost side.** You billed the customer for the extra work but did not track the material cost against the original estimate.
4. **Waste factor was underestimated.** Depending on the roof pitch and complexity, waste runs 10-20% on cut-up roofs. If you are bidding flat, you are eating the difference.

## How to track it

The worksheet has two columns for every material line item: Estimated and Actual.

Estimated is what you put in the bid. Actual is what you actually spent, from supplier invoices.

You fill in Actual when the job closes. You pull the invoices, add them up, and compare.

The variance column does the math. Red means you went over. Green means you came in under. Most contractors who do this for the first time are surprised at how often they are red.

## The return problem

Materials not returned is a separate line item because it is so common and so fixable. If your crew is leaving $200-$400 in unused materials on a job site each month, you are throwing away $2,400-$4,800 a year. Across a crew that does 80 jobs a year, even getting half that back matters.

Build a policy: before the crew leaves a job, they do a sweep and return anything unopened. One person is accountable. Track it.`,
      callout: "Get a supplier quote for every bid. Do not estimate materials from last year's prices. Steel, lumber, and roofing products move with commodity markets.",
    },
  },
  {
    id: 'jcw-04',
    course_id: 'job-costing-worksheet',
    title: 'Material Cost Calculator',
    lesson_type: 'form',
    position: 4,
    content: {
      intro: 'Enter your material costs for the job you selected in lesson 2. Use actual supplier invoices for the Actual columns.',
      fields: [
        { id: 'materials_estimated', label: 'Total Materials Estimated', type: 'number', placeholder: '0', prefix: '$', hint: 'Sum of all material line items from your original bid' },
        { id: 'materials_actual', label: 'Total Materials Actual', type: 'number', placeholder: '0', prefix: '$', hint: 'Sum of all supplier invoices for this job' },
        { id: 'materials_returned_value', label: 'Value of Materials Returned', type: 'number', placeholder: '0', prefix: '$', hint: 'Credit value of any materials returned to supplier' },
      ],
      formulas: {
        materials_variance: (v) => {
          const est = parseFloat(v.materials_estimated) || 0
          const act = parseFloat(v.materials_actual) || 0
          const ret = parseFloat(v.materials_returned_value) || 0
          return est - (act - ret)
        },
        materials_variance_pct: (v) => {
          const est = parseFloat(v.materials_estimated) || 0
          if (est === 0) return null
          const act = parseFloat(v.materials_actual) || 0
          const ret = parseFloat(v.materials_returned_value) || 0
          return ((est - (act - ret)) / est) * 100
        },
      },
      results: [
        { id: 'materials_variance', label: 'Materials Variance (positive = under budget)', format: 'currency', benchmark: null },
        { id: 'materials_variance_pct', label: 'Materials Variance %', format: 'percent', benchmark: { low: -5, high: 5, label: 'Within 5% is acceptable. More than 5% over needs a root cause review.' } },
      ],
    },
  },
  {
    id: 'jcw-05',
    course_id: 'job-costing-worksheet',
    title: 'Labor Costs and Burden Rate',
    lesson_type: 'reading',
    position: 5,
    content: {
      body: `## What labor actually costs you

If you pay a worker $22/hour, their labor cost to your business is not $22/hour. It is more like $27-$31/hour once you factor in the burden.

Labor burden includes:
- FICA (Social Security and Medicare): 7.65%
- Federal and state unemployment taxes: 2-4%
- Workers compensation insurance: varies by trade, often 8-15% for roofing and construction
- General liability allocation: 1-3%
- Any benefits you provide

The burden multiplier for most trades contractors is 1.25-1.40. That means every dollar of base wages costs $1.25 to $1.40 when you run it through the business.

**Formula:**

Actual labor cost = base wages paid x burden multiplier

If you paid $4,200 in base wages on a job and your burden multiplier is 1.32, your actual labor cost is:

$4,200 x 1.32 = $5,544

If you bid labor at $4,800, you have a $744 variance. That is real money.

## Why contractors undercount labor

1. They forget to include the owner's labor when the owner works in the field.
2. They use base wage only, not burdened cost.
3. They do not account for drive time, cleanup, or travel to the supply house.
4. They estimate hours but do not track actual hours per job.

## How to track it

You need a simple time log. Each worker records hours by job. At end of job, you multiply total hours by their burdened hourly rate. Compare to your labor estimate.

If you do not have time tracking, start with a paper sheet on the truck. Job name, in time, out time. It takes 30 seconds and gives you the data you need.`,
      callout: "If you do not know your burden multiplier, calculate it: divide total payroll cost for last year (including taxes and insurance) by total base wages paid. That ratio is your multiplier.",
    },
  },
  {
    id: 'jcw-06',
    course_id: 'job-costing-worksheet',
    title: 'Labor Cost Calculator',
    lesson_type: 'form',
    position: 6,
    content: {
      intro: 'Calculate your true labor cost on the job using burdened rates.',
      fields: [
        { id: 'labor_estimated', label: 'Labor Estimated at Bid', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'base_wages_paid', label: 'Total Base Wages Paid (from payroll)', type: 'number', placeholder: '0', prefix: '$', hint: 'Sum of all paychecks issued for this job, before burden' },
        { id: 'burden_multiplier', label: 'Your Burden Multiplier', type: 'number', placeholder: '1.32', hint: "Typical range 1.25-1.40. Calculate from last year's payroll records." },
        { id: 'owner_hours', label: 'Owner Hours Worked on This Job', type: 'number', placeholder: '0', hint: 'Enter 0 if owner did not work in the field' },
        { id: 'owner_hourly_rate', label: 'Owner Hourly Rate (market value)', type: 'number', placeholder: '0', prefix: '$', hint: 'What you would pay a foreman to do what you did. Usually $35-$60/hr.' },
      ],
      formulas: {
        burdened_labor: (v) => {
          const wages = parseFloat(v.base_wages_paid) || 0
          const mult = parseFloat(v.burden_multiplier) || 1.32
          const ownerHours = parseFloat(v.owner_hours) || 0
          const ownerRate = parseFloat(v.owner_hourly_rate) || 0
          return (wages * mult) + (ownerHours * ownerRate)
        },
        labor_variance: (v) => {
          const est = parseFloat(v.labor_estimated) || 0
          const wages = parseFloat(v.base_wages_paid) || 0
          const mult = parseFloat(v.burden_multiplier) || 1.32
          const ownerHours = parseFloat(v.owner_hours) || 0
          const ownerRate = parseFloat(v.owner_hourly_rate) || 0
          const actual = (wages * mult) + (ownerHours * ownerRate)
          return est - actual
        },
      },
      results: [
        { id: 'burdened_labor', label: 'True Labor Cost (burdened)', format: 'currency', benchmark: null },
        { id: 'labor_variance', label: 'Labor Variance (positive = under budget)', format: 'currency', benchmark: null },
      ],
    },
  },
  {
    id: 'jcw-07',
    course_id: 'job-costing-worksheet',
    title: 'Subcontractor and Overhead Costs',
    lesson_type: 'form',
    position: 7,
    content: {
      intro: 'Track subcontractor costs and allocate overhead to this job.',
      fields: [
        { id: 'sub_estimated', label: 'Subcontractor Costs Estimated', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'sub_actual', label: 'Subcontractor Costs Actual', type: 'number', placeholder: '0', prefix: '$', hint: 'Total of all sub invoices for this job' },
        { id: 'sub_markup_pct', label: 'Sub Management Markup Applied', type: 'number', placeholder: '12', suffix: '%', hint: 'Standard range is 10-15%. This covers your coordination cost and risk.' },
        { id: 'monthly_overhead', label: 'Your Monthly Overhead (total fixed + variable)', type: 'number', placeholder: '0', prefix: '$', hint: 'Rent, insurance, admin salaries, etc.' },
        { id: 'monthly_revenue', label: 'Your Average Monthly Revenue', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'contract_value_jcw', label: 'Contract Value for This Job', type: 'number', placeholder: '0', prefix: '$' },
      ],
      formulas: {
        sub_variance: (v) => {
          const est = parseFloat(v.sub_estimated) || 0
          const act = parseFloat(v.sub_actual) || 0
          return est - act
        },
        overhead_rate: (v) => {
          const mo = parseFloat(v.monthly_overhead) || 0
          const mr = parseFloat(v.monthly_revenue) || 0
          if (mr === 0) return null
          return (mo / mr) * 100
        },
        overhead_allocated: (v) => {
          const mo = parseFloat(v.monthly_overhead) || 0
          const mr = parseFloat(v.monthly_revenue) || 0
          const cv = parseFloat(v.contract_value_jcw) || 0
          if (mr === 0) return null
          return cv * (mo / mr)
        },
      },
      results: [
        { id: 'sub_variance', label: 'Sub Cost Variance (positive = under budget)', format: 'currency', benchmark: null },
        { id: 'overhead_rate', label: 'Your Overhead Rate', format: 'percent', benchmark: { low: 15, high: 25, label: 'Target: 15-25%. Above 30% requires immediate review.' } },
        { id: 'overhead_allocated', label: 'Overhead Allocated to This Job', format: 'currency', benchmark: null },
      ],
    },
  },
  {
    id: 'jcw-08',
    course_id: 'job-costing-worksheet',
    title: 'Job Gross Profit Summary',
    lesson_type: 'form',
    position: 8,
    content: {
      intro: 'Pull together all cost categories to calculate your true gross profit on this job.',
      fields: [
        { id: 'summary_contract_value', label: 'Contract Value', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'total_materials_actual', label: 'Total Materials (actual, net of returns)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'total_labor_burdened', label: 'Total Labor (burdened, including owner hours)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'total_subs_actual', label: 'Total Subcontractor Costs (actual)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'other_direct_costs', label: 'Other Direct Costs (permits, equipment rental, etc.)', type: 'number', placeholder: '0', prefix: '$' },
      ],
      formulas: {
        total_job_cost: (v) => {
          const mat = parseFloat(v.total_materials_actual) || 0
          const lab = parseFloat(v.total_labor_burdened) || 0
          const sub = parseFloat(v.total_subs_actual) || 0
          const other = parseFloat(v.other_direct_costs) || 0
          return mat + lab + sub + other
        },
        gross_profit: (v) => {
          const cv = parseFloat(v.summary_contract_value) || 0
          const mat = parseFloat(v.total_materials_actual) || 0
          const lab = parseFloat(v.total_labor_burdened) || 0
          const sub = parseFloat(v.total_subs_actual) || 0
          const other = parseFloat(v.other_direct_costs) || 0
          return cv - (mat + lab + sub + other)
        },
        gross_margin_pct: (v) => {
          const cv = parseFloat(v.summary_contract_value) || 0
          if (cv === 0) return null
          const mat = parseFloat(v.total_materials_actual) || 0
          const lab = parseFloat(v.total_labor_burdened) || 0
          const sub = parseFloat(v.total_subs_actual) || 0
          const other = parseFloat(v.other_direct_costs) || 0
          return ((cv - (mat + lab + sub + other)) / cv) * 100
        },
      },
      results: [
        { id: 'total_job_cost', label: 'Total Job Cost', format: 'currency', benchmark: null },
        { id: 'gross_profit', label: 'Gross Profit on This Job', format: 'currency', benchmark: null },
        { id: 'gross_margin_pct', label: 'Gross Margin %', format: 'percent', benchmark: { low: 25, high: 40, label: 'Renovation: 30-40% target. New construction: 20-30%. Service/repair: 40-55%. Below 20%: review immediately.' } },
      ],
    },
  },
  {
    id: 'jcw-09',
    course_id: 'job-costing-worksheet',
    title: 'The Five Margin Killers',
    lesson_type: 'reading',
    position: 9,
    content: {
      body: `## The same five problems show up on every blown job.

After working with enough contractors, the margin killers are predictable. Here they are, in order of frequency:

**1. Scope creep with no change order**

The customer asks you to do something extra. You do it. You do not bill for it. A $300 favor happens three times a job. That is $900 gone per job, $72,000 gone across 80 jobs in a year.

Fix: Nothing gets done without a written change order. Period. Your crew knows this. Your customer knows this before the job starts.

**2. Labor running long**

You estimated 3 days. The job took 4.5. Weather, a slow crew, an unforeseen issue. Most contractors absorb this silently.

Fix: Track actual vs estimated hours on every job. When you see a pattern (certain job types always run long, certain crew members are consistently slow), you can price it in or address it.

**3. Materials not returned**

Materials not returned is cash sitting on job sites or in trucks. If your crew is leaving $250 in unused materials per job and you do 80 jobs a year, that is $20,000.

**4. Callbacks**

A callback is a warranty call or a customer complaint that requires you to send a crew back. Average callbacks cost $400-$1,200 each. If you have 4 callbacks a month, that is $19,200-$57,600 a year in untracked cost.

Fix: Track every callback. Log the job, the reason, the cost. Usually 80% of callbacks come from 20% of job types or installation mistakes.

**5. Underpriced change orders**

You do price the change order, but you underprice it because you feel awkward. You charge $400 for something that cost you $380 in materials and labor. You covered cost but made nothing.

Fix: Change orders are jobs. Price them with full margin. The customer already said yes to working with you.`,
      callout: 'Run through this list on your last 5 jobs. How many times did each of these happen? Multiply by your job volume and you will find where your margin went.',
    },
  },
  {
    id: 'jcw-10',
    course_id: 'job-costing-worksheet',
    title: 'Job Type Comparison',
    lesson_type: 'form',
    position: 10,
    content: {
      intro: 'Compare margins across your different job types to find where you actually make money.',
      fields: [
        { id: 'job_type_a_name', label: 'Job Type A Name', type: 'textarea', placeholder: 'e.g. Residential roof replacement', hint: 'Describe the job type you do most often' },
        { id: 'avg_revenue_a', label: 'Job Type A: Average Contract Value', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'avg_margin_a', label: 'Job Type A: Average Gross Margin', type: 'number', placeholder: '0', suffix: '%', hint: 'Based on actual job cost data, not your bid margin' },
        { id: 'job_type_b_name', label: 'Job Type B Name', type: 'textarea', placeholder: 'e.g. Commercial flat roof' },
        { id: 'avg_revenue_b', label: 'Job Type B: Average Contract Value', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'avg_margin_b', label: 'Job Type B: Average Gross Margin', type: 'number', placeholder: '0', suffix: '%' },
        { id: 'job_type_c_name', label: 'Job Type C Name (optional)', type: 'textarea', placeholder: 'e.g. Emergency repair / service call' },
        { id: 'avg_revenue_c', label: 'Job Type C: Average Contract Value', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'avg_margin_c', label: 'Job Type C: Average Gross Margin', type: 'number', placeholder: '0', suffix: '%' },
      ],
      formulas: {
        profit_per_job_a: (v) => {
          const r = parseFloat(v.avg_revenue_a) || 0
          const m = parseFloat(v.avg_margin_a) || 0
          return r * (m / 100)
        },
        profit_per_job_b: (v) => {
          const r = parseFloat(v.avg_revenue_b) || 0
          const m = parseFloat(v.avg_margin_b) || 0
          return r * (m / 100)
        },
        profit_per_job_c: (v) => {
          const r = parseFloat(v.avg_revenue_c) || 0
          const m = parseFloat(v.avg_margin_c) || 0
          return r * (m / 100)
        },
      },
      results: [
        { id: 'profit_per_job_a', label: 'Gross Profit Per Job: Type A', format: 'currency', benchmark: null },
        { id: 'profit_per_job_b', label: 'Gross Profit Per Job: Type B', format: 'currency', benchmark: null },
        { id: 'profit_per_job_c', label: 'Gross Profit Per Job: Type C', format: 'currency', benchmark: null },
      ],
    },
  },
  {
    id: 'jcw-11',
    course_id: 'job-costing-worksheet',
    title: 'Building Your Monthly Tracker',
    lesson_type: 'reading',
    position: 11,
    content: {
      body: `## One page. Every job. Every month.

The monthly job cost tracker is a simple spreadsheet or sheet of paper. One row per job. Columns: Job name, Contract value, Materials actual, Labor actual, Subs actual, Total cost, Gross profit, Gross margin %.

You fill this in when a job closes. Takes 10 minutes if your invoices are organized.

At the end of the month, you sum the columns. You know:
- Total revenue this month
- Total direct costs
- Total gross profit
- Blended gross margin for the month

If your blended margin is below your target, you look at the individual jobs to find where it went.

## What to do with the data

**Review at month end (15 minutes):**

1. Sort jobs by margin, lowest to highest.
2. Look at the bottom 3 jobs. What happened? Materials? Labor? Scope creep?
3. Look at the top 3 jobs. What went right? Can you replicate it?

**Review at quarter end (30 minutes):**

1. Calculate average margin by job type.
2. Identify your highest-margin job type. Are you selling enough of it?
3. Identify your lowest-margin job type. Should you raise prices, improve efficiency, or stop doing it?

## The 90-day sprint

Pick one thing to fix this quarter. Just one. Examples:

- Implement a materials return policy. Target: reduce materials overrun from 8% to 3%.
- Start tracking labor hours on every job. Target: identify which job type runs most over on labor.
- Add a change order requirement for all scope additions. Target: capture 80% of changes that currently go unbilled.

One thing. 90 days. Measure it.`,
      callout: 'The contractors who get this right do not have complicated systems. They have consistent systems. Simple enough that it actually gets done every month.',
    },
  },
  {
    id: 'jcw-12',
    course_id: 'job-costing-worksheet',
    title: 'Knowledge Check',
    lesson_type: 'quiz',
    position: 12,
    content: {
      questions: [
        {
          question: 'A contractor pays workers $24/hour base. Their burden multiplier is 1.35. What is the actual cost per labor hour?',
          options: ['$24.00', '$27.60', '$32.40', '$35.10'],
          correct: 2,
          explanation: '$24 x 1.35 = $32.40. Burden includes payroll taxes, workers comp, and benefits. Using base wage only understates your true labor cost.',
        },
        {
          question: 'A renovation job has a contract value of $18,000 and total actual costs of $13,500. What is the gross margin?',
          options: ['18%', '25%', '30%', '33%'],
          correct: 1,
          explanation: 'Gross profit = $18,000 - $13,500 = $4,500. Gross margin = $4,500 / $18,000 = 25%. For renovation, the target is 30-40%, so this job is below benchmark.',
        },
        {
          question: 'Your monthly overhead is $18,000 and your average monthly revenue is $90,000. What is your overhead rate?',
          options: ['15%', '20%', '25%', '30%'],
          correct: 1,
          explanation: '$18,000 / $90,000 = 20%. This falls within the 15-25% target range.',
        },
        {
          question: 'What is the most common reason labor costs run over budget?',
          options: ['Workers are overpaid', 'Burden rate is too high', 'Hours are not tracked per job so overruns go undetected', 'Equipment costs are included in labor'],
          correct: 2,
          explanation: 'When you do not track actual hours per job, you cannot identify which jobs consistently run long. The problem repeats because you never have the data to fix it.',
        },
        {
          question: 'A crew does 80 jobs per year. On average, $250 in materials goes unreturned per job. What is the annual cost?',
          options: ['$10,000', '$15,000', '$20,000', '$25,000'],
          correct: 2,
          explanation: '80 jobs x $250 = $20,000/year. This is money that should come back as margin but instead sits in trucks or on job sites.',
        },
        {
          question: 'Which job type typically carries the highest gross margin target?',
          options: ['New construction', 'Renovation / remodeling', 'Service and repair', 'Commercial projects'],
          correct: 2,
          explanation: 'Service and repair targets 40-55% gross margin. Jobs are smaller, faster to complete, and customers have high urgency. New construction typically runs 20-30% due to competitive bidding.',
        },
      ],
    },
  },
  {
    id: 'jcw-13',
    course_id: 'job-costing-worksheet',
    title: 'Your Job Costing Action Plan',
    lesson_type: 'summary',
    position: 13,
    content: {
      next_steps: [
        'Pull invoices from your last 3 completed jobs and fill in the job cost worksheet with actual material, labor, and sub costs. Compare to your original estimates.',
        "Calculate your burden multiplier using last year's payroll records: total payroll cost divided by total base wages. Use this number in every future estimate.",
        'Set up a simple monthly tracker: one row per job, columns for contract value, materials actual, labor actual, subs actual, gross profit, and margin %.',
        'Identify your one margin killer from the five covered in lesson 9. Build a 30-day fix: a written policy, a tracking sheet, or a pricing adjustment.',
        'Review job costs monthly. Sort by margin. Spend 15 minutes looking at what your lowest-margin jobs have in common.',
      ],
    },
  },
]
