export const course = {
  id: 'lead-machine-blueprint',
  title: 'Lead Machine Blueprint',
  description: 'Build consistent lead flow from 4 sources: Google Business Profile, reviews, referrals, and paid ads.',
  category: 'Marketing',
  lesson_count: 13,
}

export const lessons = [
  {
    id: 'lmb-01',
    course_id: 'lead-machine-blueprint',
    title: 'Why Your Lead Flow Is Inconsistent',
    lesson_type: 'reading',
    position: 1,
    content: {
      body: `## Feast and famine is not a market problem. It is a system problem.

Most contractors get leads the same way: word of mouth, a slow referral network, and whatever jobs happen to come in. Some months are great. Some months are slow. The difference between the two is mostly luck.

The contractors who have consistent work in every market condition are running a system. Not luck. A system with four specific lead sources, each actively managed, each contributing predictable volume.

## The four sources

**1. Google Business Profile (GBP)**
Your free listing in Google Maps. When someone searches "roofer near me" or "HVAC repair [city]," GBP results appear above organic results and often above ads. A fully optimized profile generates 5-15 qualified leads per month at zero ad spend.

**2. Review Generation**
Reviews are not a nice-to-have. They are a conversion mechanism. A business with 4.8 stars and 80 reviews will out-convert a business with 4.2 stars and 12 reviews on every platform, every time. Reviews compound. The contractor who systematically asks for them builds an asset.

**3. Referrals**
Referrals close faster, at higher margins, with less resistance. A referred customer already trusts you before you pick up the phone. Most contractors get some referrals but have no system to generate them consistently. This course shows you how to build one.

**4. Paid Advertising**
Google Local Services Ads and Google Search Ads generate leads on demand. They cost more per lead than organic sources, but they are controllable. You can turn them up when you need volume and down when you are at capacity.

## What this course builds

By the end, you will have:
- An optimized GBP setup checklist
- A review generation process you can run on every job
- A referral system with a specific ask and follow-up sequence
- A paid advertising budget formula based on your target revenue
- A monthly dashboard to track leads from all four sources`,
      callout: 'You do not need all four sources to work perfectly on day one. You need all four started. The system compounds over 90 days.',
    },
  },
  {
    id: 'lmb-02',
    course_id: 'lead-machine-blueprint',
    title: 'Lead Generation Math',
    lesson_type: 'form',
    position: 2,
    content: {
      intro: 'Calculate how many leads you actually need each month to hit your revenue target. Most contractors skip this step and either under-invest in marketing or over-invest in the wrong channels.',
      fields: [
        { id: 'monthly_revenue_target', label: 'Monthly Revenue Target', type: 'number', placeholder: '0', prefix: '$', hint: 'What does hitting your goal look like in monthly revenue?' },
        { id: 'avg_job_value', label: 'Average Job Value', type: 'number', placeholder: '0', prefix: '$', hint: 'Your average contract size. Use your trailing 12-month average if available.' },
        { id: 'close_rate_pct', label: 'Your Close Rate on Leads', type: 'number', placeholder: '35', suffix: '%', hint: 'Out of every 10 leads you receive, how many become paying jobs? Industry avg is 25-40%.' },
        { id: 'lead_to_appointment_pct', label: 'Lead-to-Appointment Rate', type: 'number', placeholder: '60', suffix: '%', hint: 'Out of leads that contact you, what % do you actually meet with or send an estimate to?' },
      ],
      formulas: {
        jobs_needed_per_month: (v) => {
          const rev = parseFloat(v.monthly_revenue_target) || 0
          const avg = parseFloat(v.avg_job_value) || 0
          if (avg === 0) return null
          return rev / avg
        },
        leads_needed_per_month: (v) => {
          const rev = parseFloat(v.monthly_revenue_target) || 0
          const avg = parseFloat(v.avg_job_value) || 0
          const close = parseFloat(v.close_rate_pct) || 0
          if (avg === 0 || close === 0) return null
          const jobsNeeded = rev / avg
          return jobsNeeded / (close / 100)
        },
        max_cpl: (v) => {
          const avg = parseFloat(v.avg_job_value) || 0
          const close = parseFloat(v.close_rate_pct) || 0
          if (avg === 0 || close === 0) return null
          return avg * (close / 100) * 0.20
        },
      },
      results: [
        { id: 'jobs_needed_per_month', label: 'Jobs Needed Per Month', format: 'number', benchmark: null },
        { id: 'leads_needed_per_month', label: 'Leads Needed Per Month', format: 'number', benchmark: null },
        { id: 'max_cpl', label: 'Maximum Cost Per Lead You Can Afford (20% of expected job value)', format: 'currency', benchmark: { low: 0, high: 0, label: 'Do not spend more than this per lead on paid advertising. If your CPL exceeds this, your ads are not profitable.' } },
      ],
    },
  },
  {
    id: 'lmb-03',
    course_id: 'lead-machine-blueprint',
    title: 'Source 1: Google Business Profile',
    lesson_type: 'reading',
    position: 3,
    content: {
      body: `## GBP is the highest-ROI marketing asset most contractors are not using correctly.

A fully optimized Google Business Profile generates 5-15 qualified leads per month in most markets with zero ad spend. The setup takes 2-3 hours. The maintenance takes 30 minutes per week.

Most contractors have a GBP that is 40-60% complete. They claimed it, added a phone number, and moved on. That is not enough.

## The 10 optimization points

1. **Business name matches your legal or DBA name exactly.** Do not keyword-stuff it.
2. **Primary category is specific.** "Roofing contractor" not just "contractor." Select secondary categories for related services.
3. **Service area is defined.** List every city and zip code you serve. Radius is less accurate than specific areas.
4. **Hours are accurate and complete.** Include whether you offer emergency service.
5. **Phone number is a local number that rings live.** Not a tracking number that goes to voicemail.
6. **Website link is correct and loads on mobile.**
7. **Services section is filled out completely.** Every service you offer with descriptions and pricing ranges where applicable.
8. **Photos are current and high-quality.** Minimum 20 photos. Before/after job photos perform best.
9. **Business description uses the words your customers search.** Include your city name and top services naturally.
10. **You post weekly updates.** Google ranks active profiles higher. One post per week takes 5 minutes.

## The review connection

Your GBP ranking depends heavily on review volume and recency. A profile with 15 reviews updated 2 years ago ranks below a profile with 45 reviews where the most recent was last week.

This is why review generation, covered in the next lesson, is inseparable from GBP performance.

## Weekly maintenance routine

Monday morning, 20 minutes:
- Check for new reviews. Respond to all of them, positive and negative.
- Post a weekly update (a photo from a recent job, a tip, a service reminder).
- Check your "Questions and Answers" section. Answer any new questions.`,
      callout: 'Go to your GBP right now. Count your photos and check when your last post was. If you have fewer than 20 photos or have not posted in 30 days, that is your first action.',
    },
  },
  {
    id: 'lmb-04',
    course_id: 'lead-machine-blueprint',
    title: 'Source 2: Review Generation System',
    lesson_type: 'reading',
    position: 4,
    content: {
      body: `## Reviews do not happen without a system. A system runs on every job.

The contractors with 150 five-star reviews did not get lucky. They asked for reviews on every job, consistently, using the same process.

Here is the process:

## Step 1: The timing

Ask for a review within 24-48 hours of job completion. Not a week later. Not a month later. When the customer is happiest and the work is fresh.

The best moment: right after they have seen the finished work and expressed satisfaction. If a customer says "It looks great, thank you," that is the moment.

## Step 2: The ask

Keep it direct and simple:

"I am glad you are happy with the work. Reviews really help a small business like ours. If you have 2 minutes, it would mean a lot if you left us one on Google. I can text you the link right now."

Then text the link immediately. Do not make them search for it.

Your Google review link is: google.com/search?q=[your business name] plus the "leave a review" link from your GBP dashboard. Shorten it with bit.ly or a QR code.

## Step 3: The follow-up

If they did not leave a review in 48 hours, send one follow-up text:

"Hey [name], this is [your name] from [company]. Just following up on that Google review. Here is the link again if you get a chance: [link]. No pressure either way, and thanks again for your business."

One follow-up. Not three.

## Step 4: Respond to every review

Responding to reviews signals to Google that you are active and to potential customers that you care. For positive reviews: thank them and mention a specific detail from the job. For negative reviews: acknowledge the issue, take it offline, offer to make it right.

## Target

If you complete 8 jobs per month and ask for a review on each one, a 40% conversion rate gives you 3-4 new reviews per month. At that rate, you add 36-48 reviews per year.`,
      callout: 'Build your Google review link today. Test it yourself. Put it in a text message template on your phone so you can send it in 10 seconds after every job.',
    },
  },
  {
    id: 'lmb-05',
    course_id: 'lead-machine-blueprint',
    title: 'Source 3: Referral System',
    lesson_type: 'reading',
    position: 5,
    content: {
      body: `## Most referrals are accidental. A system makes them deliberate.

A referred lead closes at 50-70% versus 25-35% for cold leads. They start the conversation trusting you. The job is usually larger because the referral source vouched for your quality, not just your price.

Most contractors rely on referrals without actively generating them. The system below changes that.

## The four referral sources

**1. Past customers**
They hired you once and were happy. They know people like themselves: homeowners, business owners, property managers. One text per year asking for referrals is not pushy. It is a business relationship.

**2. Adjacent trades**
Plumbers, electricians, painters, and HVAC contractors are not competitors. They work in the same buildings you do. Build 5-10 relationships with adjacent trades in your market. You send them referrals. They send you referrals. No money changes hands.

**3. Real estate agents**
Agents need contractors they trust for inspections, repairs, and buyer requests. One good relationship with an active agent can generate 3-6 jobs per year. They want reliability and responsiveness, not the lowest price.

**4. Property managers**
Property managers maintain multiple units. One relationship = multiple jobs. They value speed and reliability over price. If you call back within the hour and do the work correctly, you are ahead of 80% of their existing contractors.

## The referral ask

After a completed job, 2 weeks later:

"Hey [name], I wanted to follow up and make sure everything with the [job type] is still looking good. If you know anyone who needs [service] work, I would love an introduction. We give priority scheduling to referrals from customers like you."

Simple. No discount offer needed. Most people are happy to refer a contractor they trust.

## Tracking referrals

Create a simple log. Source, date, job outcome. After 6 months, you will know which referral sources produce the best jobs. Double down on those.`,
      callout: 'List 10 past customers who were clearly happy with your work. Text all 10 this week. That is your referral system launch.',
    },
  },
  {
    id: 'lmb-06',
    course_id: 'lead-machine-blueprint',
    title: 'Source 4: Paid Advertising',
    lesson_type: 'reading',
    position: 6,
    content: {
      body: `## Paid ads are a volume dial, not a set-and-forget machine.

The value of paid advertising is controllability. You can increase spend when you need more jobs. You can reduce spend when you are at capacity. No other lead source gives you that level of control.

The risk is cost per lead. If you do not know your numbers, paid ads can be expensive and unprofictable fast.

## Google Local Services Ads (LSAs)

LSAs appear at the very top of Google results, above regular ads and organic listings. You pay per lead, not per click. A qualified lead from LSAs in the trades typically costs $30-$120 depending on market and service type.

Setup requirements:
- Google Business Profile verified
- Background check completed (Google requires this for some trades)
- License and insurance documentation uploaded
- Minimum 5-10 reviews to compete effectively

LSAs are the first paid channel most trades contractors should test. The pay-per-lead model reduces wasted spend.

## Google Search Ads

Search ads appear when someone searches specific keywords. You pay per click. Relevant keywords in trades markets often cost $8-$25 per click.

If your conversion rate from click to lead is 10%, and your cost per click is $15, your cost per lead is $150. Use the Max CPL you calculated in lesson 2 to decide if that is acceptable.

Search ads require more management than LSAs. If you do not have time to monitor and optimize them, hire someone who does or start with LSAs.

## The budget formula

Monthly ad budget = leads needed per month x max cost per lead

If you need 20 leads per month and your max CPL is $80, your monthly budget is $1,600.

Start with 60% of your theoretical budget in the first month. Measure your actual CPL. Adjust up or down based on results.

## What paid ads cannot fix

Paid ads bring leads. They do not close them. If your close rate is 20% and the market average is 35%, ads will give you more leads to lose. Fix your sales process first. Then scale the ads.`,
      callout: 'Calculate your current cost per lead from any paid channels you are already running. Cost per lead = total ad spend divided by number of leads generated. If you do not know this number, you cannot manage the channel.',
    },
  },
  {
    id: 'lmb-07',
    course_id: 'lead-machine-blueprint',
    title: 'Paid Advertising Budget Calculator',
    lesson_type: 'form',
    position: 7,
    content: {
      intro: 'Build your paid advertising budget based on your lead needs and acceptable cost per lead.',
      fields: [
        { id: 'leads_from_organic_monthly', label: 'Leads Per Month From Organic Sources (GBP, referrals, word of mouth)', type: 'number', placeholder: '0', hint: 'How many leads do you currently get without paying for ads?' },
        { id: 'total_leads_needed_paid', label: 'Total Leads Needed Per Month (from your lesson 2 calculation)', type: 'number', placeholder: '0' },
        { id: 'max_cpl_paid', label: 'Maximum Cost Per Lead You Can Afford', type: 'number', placeholder: '0', prefix: '$', hint: 'Your result from lesson 2: avg job value x close rate x 20%' },
        { id: 'current_cpl', label: 'Current Cost Per Lead From Paid Ads (if running any)', type: 'number', placeholder: '0', prefix: '$', hint: 'Enter 0 if not currently running paid ads' },
      ],
      formulas: {
        paid_leads_needed: (v) => {
          const total = parseFloat(v.total_leads_needed_paid) || 0
          const organic = parseFloat(v.leads_from_organic_monthly) || 0
          return Math.max(0, total - organic)
        },
        recommended_monthly_budget: (v) => {
          const total = parseFloat(v.total_leads_needed_paid) || 0
          const organic = parseFloat(v.leads_from_organic_monthly) || 0
          const maxCpl = parseFloat(v.max_cpl_paid) || 0
          const paidNeeded = Math.max(0, total - organic)
          return paidNeeded * maxCpl
        },
        starting_budget: (v) => {
          const total = parseFloat(v.total_leads_needed_paid) || 0
          const organic = parseFloat(v.leads_from_organic_monthly) || 0
          const maxCpl = parseFloat(v.max_cpl_paid) || 0
          const paidNeeded = Math.max(0, total - organic)
          return paidNeeded * maxCpl * 0.6
        },
      },
      results: [
        { id: 'paid_leads_needed', label: 'Paid Leads Needed Per Month (after organic)', format: 'number', benchmark: null },
        { id: 'recommended_monthly_budget', label: 'Full Monthly Ad Budget (at max CPL)', format: 'currency', benchmark: null },
        { id: 'starting_budget', label: 'Recommended Starting Budget (60% of full, while testing)', format: 'currency', benchmark: null },
      ],
    },
  },
  {
    id: 'lmb-08',
    course_id: 'lead-machine-blueprint',
    title: 'Lead Tracking Dashboard',
    lesson_type: 'form',
    position: 8,
    content: {
      intro: 'Set up your monthly lead tracking by source. Enter your numbers for last month or your current month if you have data.',
      fields: [
        { id: 'leads_gbp', label: 'Leads From Google Business Profile / Google Maps', type: 'number', placeholder: '0' },
        { id: 'leads_referral', label: 'Leads From Referrals (customers, trades, agents)', type: 'number', placeholder: '0' },
        { id: 'leads_paid', label: 'Leads From Paid Advertising', type: 'number', placeholder: '0' },
        { id: 'leads_other', label: 'Leads From Other Sources (social, signage, repeat customers)', type: 'number', placeholder: '0' },
        { id: 'total_jobs_won', label: 'Jobs Won This Month', type: 'number', placeholder: '0' },
        { id: 'total_monthly_revenue_lmb', label: 'Total Revenue From These Jobs', type: 'number', placeholder: '0', prefix: '$' },
        { id: 'total_ad_spend_monthly', label: 'Total Paid Advertising Spend This Month', type: 'number', placeholder: '0', prefix: '$' },
      ],
      formulas: {
        total_leads: (v) => {
          return (parseFloat(v.leads_gbp) || 0) +
            (parseFloat(v.leads_referral) || 0) +
            (parseFloat(v.leads_paid) || 0) +
            (parseFloat(v.leads_other) || 0)
        },
        overall_close_rate: (v) => {
          const total = (parseFloat(v.leads_gbp) || 0) +
            (parseFloat(v.leads_referral) || 0) +
            (parseFloat(v.leads_paid) || 0) +
            (parseFloat(v.leads_other) || 0)
          const won = parseFloat(v.total_jobs_won) || 0
          if (total === 0) return null
          return (won / total) * 100
        },
        actual_cpl_paid: (v) => {
          const spend = parseFloat(v.total_ad_spend_monthly) || 0
          const leads = parseFloat(v.leads_paid) || 0
          if (leads === 0) return null
          return spend / leads
        },
        revenue_per_lead: (v) => {
          const rev = parseFloat(v.total_monthly_revenue_lmb) || 0
          const total = (parseFloat(v.leads_gbp) || 0) +
            (parseFloat(v.leads_referral) || 0) +
            (parseFloat(v.leads_paid) || 0) +
            (parseFloat(v.leads_other) || 0)
          if (total === 0) return null
          return rev / total
        },
      },
      results: [
        { id: 'total_leads', label: 'Total Leads This Month', format: 'number', benchmark: null },
        { id: 'overall_close_rate', label: 'Overall Close Rate', format: 'percent', benchmark: { low: 25, high: 45, label: 'Below 25%: review your sales process and response time. Above 45%: strong close rate, focus on lead volume.' } },
        { id: 'actual_cpl_paid', label: 'Actual Cost Per Lead (Paid)', format: 'currency', benchmark: null },
        { id: 'revenue_per_lead', label: 'Revenue Per Lead (All Sources)', format: 'currency', benchmark: null },
      ],
    },
  },
  {
    id: 'lmb-09',
    course_id: 'lead-machine-blueprint',
    title: 'The 90-Day Build Plan',
    lesson_type: 'reading',
    position: 9,
    content: {
      body: `## You do not build four lead sources simultaneously. You build them sequentially over 90 days.

Trying to launch GBP optimization, a review system, a referral program, and paid ads in week one means you do none of them well. The 90-day plan staggers the work so each source gets real attention before moving to the next.

## Weeks 1-2: Foundation

- Audit your GBP against the 10-point checklist from lesson 3. Fix every gap.
- Add or update photos. Minimum 20, ideally 40.
- Set up your Google review link and load it into a text message template.
- Ask for reviews from your 5 most recent satisfied customers today.

## Weeks 3-4: Review system running

- Review ask is happening on every completed job.
- Respond to every existing review, positive and negative.
- Post twice per week on GBP: job photos, completed work, tips.

## Weeks 5-6: Referral system launch

- Identify your top 10 past customers and 5 adjacent trade contacts.
- Send the referral ask text to past customers.
- Schedule coffee or a phone call with 2 adjacent trade contacts this week.
- Identify 2 real estate agents to contact. Research them before reaching out.

## Weeks 7-8: Referral network building

- Follow up with anyone who did not respond to the referral ask.
- Meet with at least one adjacent trade contractor.
- Contact real estate agents with a specific value proposition: fast response, warranty work, licensed and insured.

## Weeks 9-10: Paid advertising setup

- Set up Google Local Services Ads if your GBP and reviews are in order.
- Start with the 60% budget from your calculator.
- Set a measurement date: you will review CPL and lead quality after 30 days.

## Weeks 11-12: Optimization

- Review leads from all four sources. Which source has the best CPL? The best close rate? The best job quality?
- Adjust budget allocation toward best-performing sources.
- Identify the weakest source and build a 30-day improvement plan for it.

## After 90 days

You should have: a fully optimized GBP with consistent new reviews, a referral network generating at least 3-4 leads per month, and a paid ad channel with a measured CPL. Run the lead tracking dashboard monthly.`,
      callout: 'Print the 90-day schedule. Put it on your wall. The work is not complicated. It requires consistent execution over three months.',
    },
  },
  {
    id: 'lmb-10',
    course_id: 'lead-machine-blueprint',
    title: 'Response Time and Close Rate',
    lesson_type: 'reading',
    position: 10,
    content: {
      body: `## The fastest responder wins. This is not a metaphor.

Studies across service businesses consistently show that leads contacted within 5 minutes of inquiry convert at 3-4x the rate of leads contacted after 30 minutes. After 1 hour, conversion drops by more than half. After 24 hours, the lead is likely already talking to someone else.

This is not unique to your market. It is how homeowners and business owners make decisions: they contact 2-3 contractors, the first one to call back and show up gets the job most of the time.

## What speed looks like in practice

A lead comes in at 2:15pm on a Tuesday. You call within 5 minutes. You schedule an estimate for tomorrow morning. You show up on time with a written proposal. You follow up by phone 24 hours after the estimate.

That is 80% of the sales process. Most of your competitors are calling back the next day, scheduling 4 days out, and never following up.

## Improving your close rate

If your close rate is below 30%, the problem is usually one of three things:

**1. Response time.** You are too slow. The customer has already made a decision by the time you call.

**2. Estimate quality.** You are providing a price over the phone or by text without a site visit. Customers buy from contractors who show up and explain the work.

**3. Follow-up.** You give an estimate and wait for the customer to call back. Most of them will not. One phone call 24-48 hours after the estimate asking if they have questions closes 15-20% of stalled estimates.

## The one metric to track

Track your time-to-first-contact on every new lead. The date and time the lead came in, and the date and time you first made contact. Average this monthly. Your target is under 1 hour during business hours.`,
      callout: 'Set up a lead notification on your phone so every new inquiry triggers an immediate alert. Respond within 5 minutes during business hours. This one change will improve your close rate.',
    },
  },
  {
    id: 'lmb-11',
    course_id: 'lead-machine-blueprint',
    title: 'Knowledge Check',
    lesson_type: 'quiz',
    position: 11,
    content: {
      questions: [
        {
          question: 'A contractor has an average job value of $8,500 and a close rate of 30%. What is their maximum cost per lead for paid ads?',
          options: ['$255', '$510', '$850', '$1,700'],
          correct: 1,
          explanation: 'Max CPL = avg job value x close rate x 20%. $8,500 x 0.30 x 0.20 = $510. Spending more than this per lead means paid ads are not contributing to profit.',
        },
        {
          question: 'A contractor needs $120,000 in monthly revenue, has a $6,000 average job value, and a 40% close rate. How many leads do they need per month?',
          options: ['20', '35', '50', '60'],
          correct: 2,
          explanation: 'Jobs needed: $120,000 / $6,000 = 20. Leads needed: 20 / 0.40 = 50. Close rate is the multiplier between leads and jobs.',
        },
        {
          question: 'Which of the following has the highest close rate?',
          options: ['Google Ads leads', 'GBP / Google Maps leads', 'Referral leads', 'Social media leads'],
          correct: 2,
          explanation: 'Referral leads close at 50-70% because the customer already trusts you from the referral source. Paid and GBP leads typically close at 25-40%.',
        },
        {
          question: 'How long after job completion should you ask for a Google review?',
          options: ['Same day or within 48 hours', '1 week', '1 month', 'When you send the invoice'],
          correct: 0,
          explanation: 'Ask within 24-48 hours of completion when the customer is happiest and the work is fresh. Waiting a week or more significantly reduces response rate.',
        },
        {
          question: 'A new lead comes in at 10am. You call back at 4pm. What is the likely impact?',
          options: ['No impact, customers wait for the right contractor', 'Slight reduction in close rate', 'Significant reduction in close rate, customer likely already engaged with a competitor', 'Increased close rate because you seem less desperate'],
          correct: 2,
          explanation: 'Leads contacted after 1 hour convert at less than half the rate of leads contacted within 5 minutes. After 6 hours, the customer has likely already committed to someone else.',
        },
        {
          question: 'What is the recommended starting budget for paid ads when you first launch a campaign?',
          options: ['100% of calculated budget', '80% of calculated budget', '60% of calculated budget', '40% of calculated budget'],
          correct: 2,
          explanation: 'Start at 60% of your calculated budget while measuring actual CPL. This gives you room to increase spend once you confirm the channel is performing as expected.',
        },
      ],
    },
  },
  {
    id: 'lmb-12',
    course_id: 'lead-machine-blueprint',
    title: 'Monthly Lead Scorecard',
    lesson_type: 'form',
    position: 12,
    content: {
      intro: 'Score each lead source on its current performance. Use this monthly to identify where to focus your improvement effort.',
      fields: [
        { id: 'gbp_leads_score', label: 'GBP Leads This Month', type: 'number', placeholder: '0' },
        { id: 'gbp_target', label: 'GBP Lead Target', type: 'number', placeholder: '8', hint: 'A fully optimized GBP in most markets generates 5-15 leads/month' },
        { id: 'referral_leads_score', label: 'Referral Leads This Month', type: 'number', placeholder: '0' },
        { id: 'referral_target', label: 'Referral Lead Target', type: 'number', placeholder: '5' },
        { id: 'paid_leads_score', label: 'Paid Ad Leads This Month', type: 'number', placeholder: '0' },
        { id: 'paid_target', label: 'Paid Lead Target', type: 'number', placeholder: '10' },
        { id: 'new_reviews_this_month', label: 'New Google Reviews This Month', type: 'number', placeholder: '0' },
        { id: 'review_target', label: 'Monthly Review Target', type: 'number', placeholder: '4', hint: 'Target 3-5 new reviews per month minimum' },
      ],
      formulas: {
        gbp_performance_pct: (v) => {
          const actual = parseFloat(v.gbp_leads_score) || 0
          const target = parseFloat(v.gbp_target) || 0
          if (target === 0) return null
          return (actual / target) * 100
        },
        referral_performance_pct: (v) => {
          const actual = parseFloat(v.referral_leads_score) || 0
          const target = parseFloat(v.referral_target) || 0
          if (target === 0) return null
          return (actual / target) * 100
        },
        paid_performance_pct: (v) => {
          const actual = parseFloat(v.paid_leads_score) || 0
          const target = parseFloat(v.paid_target) || 0
          if (target === 0) return null
          return (actual / target) * 100
        },
        total_leads_score: (v) => {
          return (parseFloat(v.gbp_leads_score) || 0) +
            (parseFloat(v.referral_leads_score) || 0) +
            (parseFloat(v.paid_leads_score) || 0)
        },
      },
      results: [
        { id: 'gbp_performance_pct', label: 'GBP Performance vs Target', format: 'percent', benchmark: { low: 80, high: 100, label: 'Below 80%: review your GBP optimization checklist and posting frequency.' } },
        { id: 'referral_performance_pct', label: 'Referral Performance vs Target', format: 'percent', benchmark: { low: 80, high: 100, label: 'Below 80%: increase outreach cadence to past customers and trade partners.' } },
        { id: 'paid_performance_pct', label: 'Paid Ads Performance vs Target', format: 'percent', benchmark: { low: 80, high: 100, label: 'Below 80%: review bid strategy, ad copy, and service area targeting.' } },
        { id: 'total_leads_score', label: 'Total Leads This Month (Tracked Sources)', format: 'number', benchmark: null },
      ],
    },
  },
  {
    id: 'lmb-13',
    course_id: 'lead-machine-blueprint',
    title: 'Your Lead Machine Action Plan',
    lesson_type: 'summary',
    position: 13,
    content: {
      next_steps: [
        'Complete the lead generation math in lesson 2. Know your leads needed, jobs needed, and max CPL before spending a dollar on ads.',
        'Audit your Google Business Profile against the 10-point checklist in lesson 3. Fix every gap this week. Add photos until you have at least 20.',
        'Set up your Google review link and load it into a phone text template. Ask for a review on your next 5 completed jobs.',
        'List 10 past satisfied customers and 5 adjacent trade contacts. Send the referral ask this week.',
        'Start the 90-day build plan from lesson 9. Week 1 starts with GBP and reviews. Do not skip ahead to paid ads until weeks 9-10.',
      ],
    },
  },
]
