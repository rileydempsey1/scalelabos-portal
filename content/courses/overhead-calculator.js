export const course = {
  id: 'overhead-calculator',
  title: 'Overhead Calculator',
  description: 'Map every fixed cost, calculate your overhead rate, and find your break-even number.',
  category: 'Finance',
  lesson_count: 12,
}

export const lessons = [
  {
    id: 'ohc-01',
    course_id: 'overhead-calculator',
    title: 'Overhead Is the Silent Profit Killer',
    lesson_type: 'reading',
    position: 1,
    content: {
      body: `## Most contractors know their job costs. Almost none know their overhead rate.

Overhead is everything you pay whether you do one job this month or twenty. Rent. Insurance. Office salaries. Truck payments. Software subscriptions. Your own salary.

If you do not know your overhead rate, you cannot price jobs correctly. You might be covering job costs and still losing money every month because your overhead is not being allocated to each job.

## The overhead rate formula

Overhead Rate = Monthly Overhead / Monthly Revenue x 100

If your monthly overhead is $22,000 and you average $110,000 in monthly revenue, your overhead rate is 20%.

That means for every dollar you bring in, 20 cents goes to overhead before anything else. Your gross margin needs to exceed that overhead rate or you are losing money.

## The benchmarks

- 15-25%: target range. Sustainable.
- 25-30%: watch zone. Review every cost category for cuts.
- 30-40%: red flag. You are likely underpaying yourself or not growing revenue fast enough.
- Above 40%: critical. The business model may not be viable at current revenue levels.

## What this course covers

You will map five categories of overhead costs:

1. Personnel costs (non-production employees, owner salary)
2. Facilities and equipment
3. Sales and marketing
4. Business expenses (insurance, accounting, software)
5. Owner discretionary

At the end, you will know your monthly overhead total, your overhead rate, and your break-even revenue number.`,
      callout: 'Overhead rate only tells you part of the story. The other part is your gross margin. If gross margin exceeds overhead rate, you are making money. If it does not, you are not.',
    },
  },
  {
    id: 'ohc-02',
    course_id: 'overhead-calculator',
    title: 'Personnel Costs',
    lesson_type: 'form',
    position: 2,
    content: {
      intro: 'Enter all non-production labor costs. Do not include field crew wages here — those are direct job costs. Include office staff, estimators, project managers, and owner salary.',
      fields: [
        { id: 'owner_salary_monthly', label: 'Owner Monthly Salary (what you actually pay yourself)', type: 'number', placeholder: '0', prefix: '$', hint: 'If you pay yourself nothing, enter a market rate for your role. $6,000-$12,000/mo is typical.' },
        { id: 'admin_wages_monthly', label: 'Admin / Office Staff Monthly Wages', type: 'number', placeholder: '0', prefix: '$', hint: 'Include all non-field employees: bookkeeper, estimator, project manager, office manager' },
        { id: 'personnel_burden_pct', label: 'Payroll Burden Rate for Office Staff', type: 'number', placeholder: '20', suffix: '%', hint: 'Include payroll taxes, health insurance, PTO. Typical range: 18-25% on top of wages.' },
        { id: 'other_personnel', label: 'Other Personnel Costs (recruiting, training, etc.)', type: 'number', placeholder: '0', prefix: '$' },
      ],
      formulas: {
        total_personnel_overhead: (v) => {
          const owner = parseFloat(v.owner_salary_monthly) || 0
          const admin = parseFloat(v.admin_wages_monthly) || 0
          const burden = parseFloat(v.personnel_burden_pct) || 0
          const other = parseFloat(v.other_personnel) || 0
          return owner + (admin * (1 + burden / 100)) + other
        },
      },
      results: [
        { id: 'total_personnel_overhead', label: 'Total Monthly Personnel Overhead', format: 'currency', benchmark: null },
      ],
    },
  },
  {
    id: 'ohc-03',
    course_id: 'overhead-calculator',
    title: 'Facilities and Equipment',
    lesson_type: 'form',
    position: 3,
    content: {
      intro: 'Enter all costs for your physical space, vehicles, and equipment not tied to specific jobs.',
      fields: [
        { id: 'rent_monthly', label: 'Office / Shop / Yard Rent or Mortgage Payment', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'utilities_monthly', label: 'Utilities (electric, gas, water, internet, phone)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'vehicle_payments_monthly', label: 'Vehicle Loan Payments (company vehicles)', type: 'number', placeholder: '0', prefix: '$', hint: 'Only non-job-specific vehicles. Field trucks that go to job sites are often treated as direct cost.' },
        { id: 'vehicle_insurance_monthly', label: 'Vehicle Insurance (monthly)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'equipment_payments_monthly', label: 'Equipment Loan Payments / Leases', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'maintenance_monthly', label: 'Vehicle and Equipment Maintenance (avg monthly)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'fuel_overhead_monthly', label: 'Fuel for Non-Job Vehicles (service trucks, owner vehicle)', type: 'number', placeholder: '0', prefix: '$' },
      ],
      formulas: {
        total_facilities_equipment: (v) => {
          return (parseFloat(v.rent_monthly) || 0) +
            (parseFloat(v.utilities_monthly) || 0) +
            (parseFloat(v.vehicle_payments_monthly) || 0) +
            (parseFloat(v.vehicle_insurance_monthly) || 0) +
            (parseFloat(v.equipment_payments_monthly) || 0) +
            (parseFloat(v.maintenance_monthly) || 0) +
            (parseFloat(v.fuel_overhead_monthly) || 0)
        },
      },
      results: [
        { id: 'total_facilities_equipment', label: 'Total Monthly Facilities and Equipment Overhead', format: 'currency', benchmark: null },
      ],
    },
  },
  {
    id: 'ohc-04',
    course_id: 'overhead-calculator',
    title: 'Sales and Marketing Costs',
    lesson_type: 'form',
    position: 4,
    content: {
      intro: 'Enter all sales and marketing costs that are fixed or recurring. Variable costs tied to specific campaigns can be included as monthly averages.',
      fields: [
        { id: 'advertising_monthly', label: 'Paid Advertising (Google, Meta, direct mail, etc.)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'crm_software_monthly', label: 'CRM and Estimating Software', type: 'number', placeholder: '0', prefix: '$', hint: 'ServiceTitan, Jobber, HubSpot, etc.' },
        { id: 'sales_commissions_monthly', label: 'Sales Rep Commissions (average monthly)', type: 'number', placeholder: '0', prefix: '$', hint: 'If commissions vary, enter a 3-month average' },
        { id: 'marketing_other_monthly', label: 'Other Marketing (yard signs, uniforms, vehicle wraps amortized)', type: 'number', placeholder: '0', prefix: '$' },
      ],
      formulas: {
        total_sales_marketing: (v) => {
          return (parseFloat(v.advertising_monthly) || 0) +
            (parseFloat(v.crm_software_monthly) || 0) +
            (parseFloat(v.sales_commissions_monthly) || 0) +
            (parseFloat(v.marketing_other_monthly) || 0)
        },
      },
      results: [
        { id: 'total_sales_marketing', label: 'Total Monthly Sales and Marketing Overhead', format: 'currency', benchmark: null },
      ],
    },
  },
  {
    id: 'ohc-05',
    course_id: 'overhead-calculator',
    title: 'Business Expenses',
    lesson_type: 'form',
    position: 5,
    content: {
      intro: 'These are the professional and administrative costs of running a business: insurance, accounting, legal, and software.',
      fields: [
        { id: 'general_liability_monthly', label: 'General Liability Insurance (monthly)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'workers_comp_monthly', label: 'Workers Compensation Insurance (monthly average)', type: 'number', placeholder: '0', prefix: '$', hint: 'If billed annually, divide by 12' },
        { id: 'accounting_monthly', label: 'Accounting / Bookkeeping / CPA', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'legal_monthly', label: 'Legal Fees (monthly average)', type: 'number', placeholder: '0', prefix: '$', hint: 'Contracts, disputes, business attorney. Divide annual retainer by 12.' },
        { id: 'software_monthly', label: 'Software Subscriptions (project mgmt, scheduling, accounting)', type: 'number', placeholder: '0', prefix: '$', hint: 'QuickBooks, Microsoft 365, Slack, etc.' },
        { id: 'licenses_permits_monthly', label: 'Licenses, Permits, and Dues (monthly average)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'bank_fees_monthly', label: 'Bank Fees, Credit Card Processing Fees', type: 'number', placeholder: '0', prefix: '$' },
      ],
      formulas: {
        total_business_expenses: (v) => {
          return (parseFloat(v.general_liability_monthly) || 0) +
            (parseFloat(v.workers_comp_monthly) || 0) +
            (parseFloat(v.accounting_monthly) || 0) +
            (parseFloat(v.legal_monthly) || 0) +
            (parseFloat(v.software_monthly) || 0) +
            (parseFloat(v.licenses_permits_monthly) || 0) +
            (parseFloat(v.bank_fees_monthly) || 0)
        },
      },
      results: [
        { id: 'total_business_expenses', label: 'Total Monthly Business Expenses', format: 'currency', benchmark: null },
      ],
    },
  },
  {
    id: 'ohc-06',
    course_id: 'overhead-calculator',
    title: 'Owner Discretionary and Total Overhead',
    lesson_type: 'form',
    position: 6,
    content: {
      intro: 'Enter owner discretionary costs and your revenue to calculate your total overhead rate.',
      fields: [
        { id: 'owner_vehicle_monthly', label: 'Owner Vehicle (personal use allocation)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'owner_phone_monthly', label: 'Owner Phone and Technology', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'owner_travel_monthly', label: 'Travel, Meals, Entertainment (business portion, monthly avg)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'other_discretionary', label: 'Other Owner / Discretionary Costs', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'personnel_subtotal', label: 'Personnel Overhead (from lesson 2)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'facilities_subtotal', label: 'Facilities and Equipment (from lesson 3)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'sales_marketing_subtotal', label: 'Sales and Marketing (from lesson 4)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'business_expenses_subtotal', label: 'Business Expenses (from lesson 5)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'monthly_revenue_ohc', label: 'Average Monthly Revenue', type: 'number', placeholder: '0', prefix: '$', hint: 'Use your trailing 3-month average' },
      ],
      formulas: {
        total_monthly_overhead: (v) => {
          const disc = (parseFloat(v.owner_vehicle_monthly) || 0) +
            (parseFloat(v.owner_phone_monthly) || 0) +
            (parseFloat(v.owner_travel_monthly) || 0) +
            (parseFloat(v.other_discretionary) || 0)
          return disc +
            (parseFloat(v.personnel_subtotal) || 0) +
            (parseFloat(v.facilities_subtotal) || 0) +
            (parseFloat(v.sales_marketing_subtotal) || 0) +
            (parseFloat(v.business_expenses_subtotal) || 0)
        },
        overhead_rate_pct: (v) => {
          const rev = parseFloat(v.monthly_revenue_ohc) || 0
          if (rev === 0) return null
          const disc = (parseFloat(v.owner_vehicle_monthly) || 0) +
            (parseFloat(v.owner_phone_monthly) || 0) +
            (parseFloat(v.owner_travel_monthly) || 0) +
            (parseFloat(v.other_discretionary) || 0)
          const total = disc +
            (parseFloat(v.personnel_subtotal) || 0) +
            (parseFloat(v.facilities_subtotal) || 0) +
            (parseFloat(v.sales_marketing_subtotal) || 0) +
            (parseFloat(v.business_expenses_subtotal) || 0)
          return (total / rev) * 100
        },
      },
      results: [
        { id: 'total_monthly_overhead', label: 'Total Monthly Overhead', format: 'currency', benchmark: null },
        { id: 'overhead_rate_pct', label: 'Overhead Rate', format: 'percent', benchmark: { low: 15, high: 25, label: 'Target: 15-25%. Watch: 25-30%. Red flag: 30-40%. Critical: above 40%.' } },
      ],
    },
  },
  {
    id: 'ohc-07',
    course_id: 'overhead-calculator',
    title: 'Break-Even and Operator Output Score',
    lesson_type: 'form',
    position: 7,
    content: {
      intro: 'Calculate how much revenue you need to break even, and your revenue per employee.',
      fields: [
        { id: 'total_overhead_breakeven', label: 'Total Monthly Overhead', type: 'number', placeholder: '0', prefix: '$', hint: 'Enter your result from lesson 6' },
        { id: 'avg_job_gross_profit', label: 'Average Gross Profit Per Job', type: 'number', placeholder: '0', prefix: '$', hint: 'Average contract value x your gross margin %. Use your actual margin, not your bid margin.' },
        { id: 'total_employees_ftes', label: 'Total Full-Time Equivalent Employees', type: 'number', placeholder: '0', hint: 'Include owner, office staff, and all field workers. A half-time worker = 0.5 FTEs.' },
        { id: 'annual_revenue_ohc', label: 'Annual Revenue (trailing 12 months)', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'cash_reserve_months', label: 'How Many Months of Operating Expenses Do You Have in Cash?', type: 'number', placeholder: '0', hint: 'Check your bank balance today and divide by monthly overhead' },
      ],
      formulas: {
        monthly_breakeven_revenue: (v) => {
          const overhead = parseFloat(v.total_overhead_breakeven) || 0
          const gp = parseFloat(v.avg_job_gross_profit) || 0
          if (gp === 0) return null
          // break-even in revenue = overhead / gross margin rate
          // but we can compute it from overhead / (gp/avg_contract_value) — simpler to just return overhead / 0.3 as approximation
          // Actually: break-even jobs = overhead / avg gross profit per job
          // break-even revenue ≈ break-even jobs * avg contract value — but we don't have avg contract value
          // Return break-even jobs count as a proxy
          return overhead / gp
        },
        operator_output_score: (v) => {
          const rev = parseFloat(v.annual_revenue_ohc) || 0
          const ftes = parseFloat(v.total_employees_ftes) || 0
          if (ftes === 0) return null
          return rev / ftes
        },
        sustainability_reserve: (v) => {
          const overhead = parseFloat(v.total_overhead_breakeven) || 0
          const months = parseFloat(v.cash_reserve_months) || 0
          return overhead * months
        },
      },
      results: [
        { id: 'monthly_breakeven_revenue', label: 'Break-Even Jobs Per Month (overhead covered at avg GP per job)', format: 'number', benchmark: null },
        { id: 'operator_output_score', label: 'Revenue Per Employee (Operator Output Score)', format: 'currency', benchmark: { low: 150000, high: 500000, label: 'Below $150K/employee: likely unprofitable. $250K-$500K: healthy. Above $500K: high-efficiency operation.' } },
        { id: 'sustainability_reserve', label: 'Current Cash Reserve Value', format: 'currency', benchmark: { low: 0, high: 0, label: 'Target: 3 months of operating expenses in cash. That is your sustainability floor.' } },
      ],
    },
  },
  {
    id: 'ohc-08',
    course_id: 'overhead-calculator',
    title: 'Reading Your Overhead Rate',
    lesson_type: 'reading',
    position: 8,
    content: {
      body: `## Your overhead rate tells you the minimum gross margin you need to survive.

If your overhead rate is 22%, you need a gross margin above 22% just to break even before owner profit. In practice, you need your gross margin to be overhead rate plus your target net profit margin.

Example: Overhead rate = 22%. Target net profit = 10%. Required gross margin = 32%.

If your jobs are averaging 28% gross margin, you are technically profitable but only making 6% net. On $1M in revenue, that is $60,000 in net profit. Is that enough to compensate you for the risk and effort of running the business?

## What high overhead actually means

High overhead is almost always one of three things:

**1. Revenue has dropped but overhead has not.**

The team you built to support $2M in revenue is now running $1.3M. Overhead rate went from 20% to 31% with no change in spending.

Fix: Revenue is the fastest solution. Cut only if revenue recovery is not realistic in 90 days.

**2. Owner salary is too high relative to revenue.**

An owner paying himself $200,000/year on $800,000 in revenue has a 25% overhead component from that alone.

Fix: Phase the salary to revenue. Set a target where owner salary is no more than 10-15% of revenue.

**3. Fixed costs were added anticipating growth that did not come.**

New office space, new vehicles, new hires all before the revenue to support them.

Fix: Review every fixed cost. Anything non-essential that was added in the last 18 months is a candidate for renegotiation or elimination.

## The cash reserve requirement

The sustainability ratio is 3x monthly operating expenses in accessible cash. Not receivables. Not equipment value. Cash in the bank.

If your monthly overhead is $18,000, you need $54,000 in cash reserve. This covers slow months, payment delays, and unexpected costs without putting you in a position where you are taking bad jobs just to make payroll.`,
      callout: 'Run your overhead rate every quarter. It changes as revenue fluctuates. The number you calculated today may be 5 points different in 90 days if revenue shifts.',
    },
  },
  {
    id: 'ohc-09',
    course_id: 'overhead-calculator',
    title: 'Overhead Reduction Priorities',
    lesson_type: 'reading',
    position: 9,
    content: {
      body: `## Not all overhead cuts are equal.

When your overhead rate is too high, the instinct is to cut everything. The better approach is to cut strategically: start with costs that have no revenue correlation, and protect costs that drive growth.

## Category 1: Cut first

These costs typically do not generate revenue and are easiest to reduce without impact:

- Subscriptions you are not actively using (audit your bank statement, anything under $200/month that you do not remember using this week)
- Office space that is larger than needed
- Owner discretionary items that are lifestyle costs dressed as business expenses
- Vehicles not being used for revenue-generating work

## Category 2: Cut carefully

These costs have revenue implications. Cut only after understanding the impact:

- Marketing spend. Know your cost per lead before cutting. Cutting $2,000/month in ads that generate $40,000 in jobs is a bad trade.
- Sales rep costs. If they are generating margin above their comp, they are profitable.
- Software that runs operations. Cutting Jobber or ServiceTitan to save $200/month is not worth the operational degradation.

## Category 3: Do not cut

- Your own salary. If you are underpaying yourself, it shows up as phantom profit. You will burn out or leave the business.
- Accounting and legal. A $500/month bookkeeper who catches a $5,000 mistake quarterly is free.
- Workers comp and general liability. Non-negotiable.

## The smarter play: grow revenue faster than overhead

A 10% revenue increase with flat overhead moves your overhead rate more than almost any cost-cutting exercise. If you are at $90,000/month revenue and $18,000 in overhead (20% rate), getting to $100,000/month drops the rate to 18% without cutting anything.

Before you cut, ask: what would it take to add $10,000/month in revenue?`,
      callout: 'Make a list of every overhead cost. Mark each one: essential, important, or discretionary. Any discretionary cost above $100/month is a candidate for review.',
    },
  },
  {
    id: 'ohc-10',
    course_id: 'overhead-calculator',
    title: 'Annual Overhead Budget',
    lesson_type: 'form',
    position: 10,
    content: {
      intro: 'Project your overhead for the next 12 months and set a revenue target to hit your overhead rate goal.',
      fields: [
        { id: 'current_monthly_overhead', label: 'Current Monthly Overhead', type: 'number', placeholder: '0', prefix: '$', hint: 'Your result from lesson 6' },
        { id: 'planned_overhead_changes', label: 'Planned Monthly Overhead Changes (positive = increase, negative = cuts)', type: 'number', placeholder: '0', prefix: '$', hint: 'e.g. $1,500 for new hire minus $400 in cuts = +$1,100' },
        { id: 'target_overhead_rate', label: 'Target Overhead Rate', type: 'number', placeholder: '20', suffix: '%', hint: 'What overhead rate are you aiming for? Suggest 20-22% as a starting target.' },
        { id: 'current_annual_revenue', label: 'Current Annual Revenue Run Rate', type: 'number', placeholder: '0', prefix: '$', hint: 'Monthly revenue x 12' },
      ],
      formulas: {
        projected_annual_overhead: (v) => {
          const current = parseFloat(v.current_monthly_overhead) || 0
          const changes = parseFloat(v.planned_overhead_changes) || 0
          return (current + changes) * 12
        },
        required_annual_revenue: (v) => {
          const current = parseFloat(v.current_monthly_overhead) || 0
          const changes = parseFloat(v.planned_overhead_changes) || 0
          const target = parseFloat(v.target_overhead_rate) || 0
          if (target === 0) return null
          const annualOverhead = (current + changes) * 12
          return annualOverhead / (target / 100)
        },
        revenue_gap: (v) => {
          const current = parseFloat(v.current_monthly_overhead) || 0
          const changes = parseFloat(v.planned_overhead_changes) || 0
          const target = parseFloat(v.target_overhead_rate) || 0
          const currentRev = parseFloat(v.current_annual_revenue) || 0
          if (target === 0) return null
          const annualOverhead = (current + changes) * 12
          const required = annualOverhead / (target / 100)
          return required - currentRev
        },
      },
      results: [
        { id: 'projected_annual_overhead', label: 'Projected Annual Overhead', format: 'currency', benchmark: null },
        { id: 'required_annual_revenue', label: 'Revenue Required to Hit Overhead Rate Target', format: 'currency', benchmark: null },
        { id: 'revenue_gap', label: 'Revenue Gap (negative = you need more revenue)', format: 'currency', benchmark: null },
      ],
    },
  },
  {
    id: 'ohc-11',
    course_id: 'overhead-calculator',
    title: 'Knowledge Check',
    lesson_type: 'quiz',
    position: 11,
    content: {
      questions: [
        {
          question: 'A contractor has $22,000 in monthly overhead and $110,000 in average monthly revenue. What is their overhead rate?',
          options: ['18%', '20%', '22%', '25%'],
          correct: 1,
          explanation: '$22,000 / $110,000 = 20%. This falls in the 15-25% target range.',
        },
        {
          question: 'Revenue per employee is $140,000. What does this signal?',
          options: ['High-efficiency operation', 'Healthy range', 'Likely unprofitable per employee', 'Overhead rate is too low'],
          correct: 2,
          explanation: 'Below $150,000 revenue per employee is a warning sign of likely unprofitability. Healthy range is $250,000-$500,000. Investigate labor costs and crew productivity.',
        },
        {
          question: 'A contractor has $18,000/month in overhead. What is the minimum cash reserve they should maintain?',
          options: ['$18,000', '$36,000', '$54,000', '$72,000'],
          correct: 2,
          explanation: 'The sustainability ratio is 3x monthly operating expenses. $18,000 x 3 = $54,000. This covers slow months and payment delays without forcing bad job decisions.',
        },
        {
          question: 'Your revenue drops from $120,000/month to $90,000/month but overhead stays at $24,000. What happens to your overhead rate?',
          options: ['It stays at 20%', 'It drops to 20%', 'It rises to 20%', 'It rises to 26.7%'],
          correct: 3,
          explanation: '$24,000 / $90,000 = 26.7%. When revenue drops with fixed overhead, the overhead rate rises. This is why revenue growth is often the faster path to improving overhead rate than cost cutting.',
        },
        {
          question: 'Which of these is classified as a direct job cost, NOT overhead?',
          options: ['Owner salary', 'Field crew wages', 'General liability insurance', 'Accounting fees'],
          correct: 1,
          explanation: 'Field crew wages are direct job costs because they are tied directly to production. Owner salary, insurance, and accounting are overhead costs that exist regardless of job volume.',
        },
        {
          question: 'A contractor targets 10% net profit with a 24% overhead rate. What minimum gross margin do they need?',
          options: ['10%', '24%', '34%', '40%'],
          correct: 2,
          explanation: 'Required gross margin = overhead rate + target net profit = 24% + 10% = 34%. Gross margin must cover both overhead and the profit you want to keep.',
        },
      ],
    },
  },
  {
    id: 'ohc-12',
    course_id: 'overhead-calculator',
    title: 'Your Overhead Action Plan',
    lesson_type: 'summary',
    position: 12,
    content: {
      next_steps: [
        'Complete all five overhead worksheets (personnel, facilities, sales/marketing, business expenses, owner discretionary) with actual current costs. Do not estimate. Pull your bank statements and invoices.',
        'Calculate your overhead rate using the formula: total monthly overhead divided by average monthly revenue x 100. Compare to the 15-25% target.',
        'Calculate your revenue per employee (annual revenue divided by total FTEs). If below $150,000, identify the staffing or revenue gap.',
        'Audit every monthly subscription under $500. Categorize each as essential, important, or discretionary. Eliminate or pause all discretionary items.',
        'Build a 3-month cash reserve target based on your monthly overhead x 3. Set a date to reach it and an automatic transfer amount to get there.',
      ],
    },
  },
]
