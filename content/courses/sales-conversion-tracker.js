export const course = {
  id: 'sales-conversion-tracker',
  title: 'Sales Conversion Tracker',
  description: 'Find exactly where your deals are dying and fix it. 6-stage funnel analysis with live conversion math.',
  category: 'Sales',
  lesson_count: 14,
}

export const lessons = [
  // LESSON 1 — READING
  {
    id: 'sct-01',
    course_id: 'sales-conversion-tracker',
    title: 'Where Your Revenue Is Leaking',
    lesson_type: 'reading',
    position: 1,
    content: {
      body: `## Most contractors don't have a sales problem. They have a conversion problem.

You are generating leads. You are running jobs. But somewhere between the first phone call and the signed contract, money is disappearing.

The average contractor loses 40-60% of potential revenue to conversion gaps — not because their price is wrong or their work is bad, but because they have no system to track where deals die.

This course fixes that.

**What a conversion leak costs you:**

If you run 100 inspections per month with a 30% close rate, you close 30 jobs. If you fix the conversion gaps and get to 40%, you close 40 jobs — a 33% revenue increase with zero additional leads.

At an $8,500 average job, that gap is $85,000 per month in revenue you are already generating leads for but not capturing.

**The 6-Stage Sales Funnel:**

Every job you do moves through 6 stages:

1. Lead Generated — someone calls, submits a form, or gets a knock on the door
2. First Contact Made — you actually reach them and book an appointment
3. Inspection Scheduled — they commit to letting you come out
4. Proposal Presented — you deliver a number
5. Job Closed — they sign
6. Referral or Repeat — they send you another job or hire you again

Your conversion rate at each stage compounds. A 10% improvement at Stage 3 flows through every downstream stage.

**What you are going to do in this course:**

Enter your actual numbers at each stage. The calculator will show you exactly where your funnel is breaking and what fixing it is worth in revenue.`,
      callout: 'A 10 percentage point improvement in close rate on 100 monthly inspections at $8,500 average job = $85,000 more revenue per month. Same leads. Same team. Better process.',
    },
  },

  // LESSON 2 — FORM: Lead Generation
  {
    id: 'sct-02',
    course_id: 'sales-conversion-tracker',
    title: 'Stage 1: Lead Generation',
    lesson_type: 'form',
    position: 2,
    content: {
      intro: 'Enter your lead numbers from last month. Be honest — this is where your funnel math starts.',
      fields: [
        { id: 'total_leads', label: 'Total leads generated last month', type: 'number', placeholder: '0', hint: 'Count every lead: calls, forms, door knocks, referrals, walk-ins.' },
        { id: 'lead_source_referral', label: 'Leads from referrals', type: 'number', placeholder: '0' },
        { id: 'lead_source_google', label: 'Leads from Google (organic + paid)', type: 'number', placeholder: '0' },
        { id: 'lead_source_canvassing', label: 'Leads from door knocking or yard signs', type: 'number', placeholder: '0' },
        { id: 'lead_source_other', label: 'Leads from all other sources', type: 'number', placeholder: '0' },
        { id: 'avg_job_value', label: 'Average job value ($)', type: 'number', prefix: '$', placeholder: '0', hint: 'Total revenue last year divided by number of jobs completed.' },
        { id: 'monthly_revenue_target', label: 'Monthly revenue target ($)', type: 'number', prefix: '$', placeholder: '0' },
      ],
      formulas: {
        leads_needed: (v) => {
          const target = parseFloat(v.monthly_revenue_target) || 0
          const avgJob = parseFloat(v.avg_job_value) || 0
          const closeRate = 0.35
          if (!avgJob) return null
          return Math.ceil(target / avgJob / closeRate)
        },
        lead_gap: (v) => {
          const actual = parseFloat(v.total_leads) || 0
          const needed = Math.ceil((parseFloat(v.monthly_revenue_target) || 0) / (parseFloat(v.avg_job_value) || 1) / 0.35)
          return actual - needed
        },
      },
      results: [
        { id: 'leads_needed', label: 'Leads needed to hit target (at 35% close rate)', format: 'number' },
        { id: 'lead_gap', label: 'Lead gap (positive = surplus, negative = shortfall)', format: 'number' },
      ],
    },
  },

  // LESSON 3 — FORM: First Contact
  {
    id: 'sct-03',
    course_id: 'sales-conversion-tracker',
    title: 'Stage 2: First Contact Rate',
    lesson_type: 'form',
    position: 3,
    content: {
      intro: 'First contact rate measures how many of your leads you actually reach within 24 hours. Industry benchmark: 80% or higher. Most contractors hit 50-60%.',
      fields: [
        { id: 'leads_contacted', label: 'Leads successfully contacted within 24 hours', type: 'number', placeholder: '0' },
        { id: 'avg_contact_attempts', label: 'Average contact attempts before reaching them', type: 'number', placeholder: '0', hint: 'How many calls/texts does it take?' },
        { id: 'contact_method_call', label: 'Leads contacted by phone call', type: 'number', placeholder: '0' },
        { id: 'contact_method_text', label: 'Leads contacted by text/email', type: 'number', placeholder: '0' },
      ],
      formulas: {
        contact_rate: (v) => {
          const contacted = parseFloat(v.leads_contacted) || 0
          // We'll reference total_leads from a previous lesson — for now use a placeholder note
          return null
        },
      },
      results: [],
    },
  },

  // LESSON 4 — FORM: Inspection Rate
  {
    id: 'sct-04',
    course_id: 'sales-conversion-tracker',
    title: 'Stage 3: Inspection Scheduled Rate',
    lesson_type: 'form',
    position: 4,
    content: {
      intro: 'How many of your contacted leads agree to let you come out? Benchmark: 70%+. If you are below 60%, the problem is your phone script, not your price.',
      fields: [
        { id: 'inspections_scheduled', label: 'Inspections scheduled last month', type: 'number', placeholder: '0' },
        { id: 'inspections_completed', label: 'Inspections actually completed (no-shows removed)', type: 'number', placeholder: '0' },
        { id: 'no_shows', label: 'No-shows or cancellations', type: 'number', placeholder: '0' },
        { id: 'same_day_proposals', label: 'Proposals delivered same day as inspection', type: 'number', placeholder: '0', hint: 'Benchmark: 80%+ of inspections should produce a same-day proposal.' },
      ],
      formulas: {
        no_show_rate: (v) => {
          const scheduled = parseFloat(v.inspections_scheduled) || 0
          const noShows = parseFloat(v.no_shows) || 0
          if (!scheduled) return null
          return (noShows / scheduled) * 100
        },
        same_day_rate: (v) => {
          const completed = parseFloat(v.inspections_completed) || 0
          const sameDay = parseFloat(v.same_day_proposals) || 0
          if (!completed) return null
          return (sameDay / completed) * 100
        },
      },
      results: [
        { id: 'no_show_rate', label: 'No-show rate', format: 'percent', benchmark: { low: 0, high: 15, label: 'Under 15%' } },
        { id: 'same_day_rate', label: 'Same-day proposal rate', format: 'percent', benchmark: { low: 80, high: 100, label: '80% or higher' } },
      ],
    },
  },

  // LESSON 5 — FORM: Proposal and Close
  {
    id: 'sct-05',
    course_id: 'sales-conversion-tracker',
    title: 'Stage 4 and 5: Proposals and Close Rate',
    lesson_type: 'form',
    position: 5,
    content: {
      intro: 'Enter your proposal and close numbers. Your close rate — jobs closed divided by inspections run — is the single most important number in your sales system.',
      fields: [
        { id: 'proposals_sent', label: 'Proposals presented last month', type: 'number', placeholder: '0' },
        { id: 'jobs_closed', label: 'Jobs closed last month', type: 'number', placeholder: '0' },
        { id: 'avg_proposal_value', label: 'Average proposal value ($)', type: 'number', prefix: '$', placeholder: '0' },
        { id: 'lost_to_price', label: 'Proposals lost primarily to price', type: 'number', placeholder: '0' },
        { id: 'lost_to_competitor', label: 'Proposals lost to a competitor', type: 'number', placeholder: '0' },
        { id: 'lost_no_decision', label: 'Proposals with no decision yet (pending)', type: 'number', placeholder: '0' },
      ],
      formulas: {
        close_rate: (v) => {
          const proposals = parseFloat(v.proposals_sent) || 0
          const closed = parseFloat(v.jobs_closed) || 0
          if (!proposals) return null
          return (closed / proposals) * 100
        },
        revenue_captured: (v) => {
          const closed = parseFloat(v.jobs_closed) || 0
          const avg = parseFloat(v.avg_proposal_value) || 0
          return closed * avg
        },
        revenue_missed: (v) => {
          const proposals = parseFloat(v.proposals_sent) || 0
          const closed = parseFloat(v.jobs_closed) || 0
          const lost = proposals - closed - (parseFloat(v.lost_no_decision) || 0)
          const avg = parseFloat(v.avg_proposal_value) || 0
          return Math.max(0, lost * avg)
        },
      },
      results: [
        { id: 'close_rate', label: 'Your close rate', format: 'percent', benchmark: { low: 35, high: 100, label: '35% minimum, 50%+ strong' } },
        { id: 'revenue_captured', label: 'Revenue captured last month', format: 'currency' },
        { id: 'revenue_missed', label: 'Revenue missed (lost proposals)', format: 'currency' },
      ],
    },
  },

  // LESSON 6 — UPLOAD: Pipeline Data
  {
    id: 'sct-06',
    course_id: 'sales-conversion-tracker',
    title: 'Upload Your Pipeline',
    lesson_type: 'upload',
    position: 6,
    content: {
      intro: 'If you track your leads in a spreadsheet or CRM, upload it here. Your AI coach will analyze it and give you specific feedback on where your pipeline is breaking.',
      accepts: ['Excel (.xlsx)', 'CSV (.csv)', 'PDF reports'],
      optional: true,
      parsed_note: 'Your file has been parsed. Ask your coach to analyze it.',
    },
  },

  // LESSON 7 — READING: The BUILD Framework
  {
    id: 'sct-07',
    course_id: 'sales-conversion-tracker',
    title: 'The BUILD Framework: On-Site Inspection',
    lesson_type: 'reading',
    position: 7,
    content: {
      body: `## Most sales are won or lost on the inspection, not at the table.

The contractor who shows up, looks around for 20 minutes, and hands over a number loses to the one who runs a structured, professional site visit every time.

The BUILD Framework is a 5-step on-site inspection process that positions you as the expert before you ever quote a price.

**B: Begin**

The first 5 minutes are not about the job. They are about the person.

Introduce yourself. Acknowledge their concern. Set the agenda: "Here is what I am going to do today — I am going to do a thorough inspection, document everything I find, and then sit down with you and walk you through it before I leave."

Ask two questions: When did you first notice the issue? What is your biggest concern?

Listen. Do not talk about damage yet.

**U: Uncover**

Run a systematic inspection. Document every issue. Take a minimum of 20 photos: wide shots, close-ups, problem areas, and reference points.

Your photos serve two purposes: they support your proposal, and they become your close tool.

**I: Identify**

Before you speak to the homeowner, compile your notes into a clear findings list. Organize it so you can walk them through it in a logical sequence.

Translate what you found into plain language. Not technical terms — what it means for them.

**L: Lead**

Bring them to a spot where you can show them your screen or printed photos. Walk through the findings together.

Ask: "Where would be a good spot for us to look through what I found?"

Show the problem clearly. Let the evidence do the work.

**D: Drive**

Transition directly from findings to proposal.

"Here is what needs to happen and here is what it costs."

Do not leave without a number on the table. The homeowner decides what to do with it. Your job is to document, present, and propose.`,
      callout: 'The BUILD Framework closes more jobs because it turns an estimate into a consultation. You are not pitching. You are presenting findings.',
    },
  },

  // LESSON 8 — READING: The LOCK Method
  {
    id: 'sct-08',
    course_id: 'sales-conversion-tracker',
    title: 'The LOCK Method: Handling Objections',
    lesson_type: 'reading',
    position: 8,
    content: {
      body: `## Every objection is a question that has not been answered.

The average contractor loses 60-70% of proposals to objections they could have handled. Not because the price was wrong — because they did not know what to say.

The LOCK Method gives you a repeatable 4-step response to any objection.

**L: Listen**

Hear the full objection without interrupting. Most reps cut in too early.

Let them finish completely. Then repeat it back: "I hear you — that is a real concern and I want to address it directly."

This disarms the defensiveness and opens the real conversation.

**O: Own**

Validate the concern without agreeing it is a reason not to move forward.

"I completely understand why you would want to think that through. That is a reasonable place to be."

You are acknowledging the emotion, not agreeing with the conclusion. Do not skip this step — skipping it makes people feel dismissed.

**C: Counter**

Address the objection with specifics.

For price: "Help me understand what number you had in mind. I want to make sure we are comparing the same scope."

For competitor: "Absolutely. What I can do is make sure you have our full written scope so you are comparing the same thing."

For spouse: "Of course. Would it make sense to schedule a quick call this week where both of you can hear the full picture?"

Use facts, not pressure.

**K: Keep**

Close again immediately after countering. Do not counter and then go quiet.

"Does that address what was holding you back? Is there a reason we could not move forward today?"

Every handled objection must be followed by a direct close attempt. Answer the question, then ask for the commitment.`,
      callout: 'The most common reason contractors lose proposals is silence after an objection. Counter it, then ask for the business immediately.',
    },
  },

  // LESSON 9 — FORM: Conversion Calculator
  {
    id: 'sct-09',
    course_id: 'sales-conversion-tracker',
    title: 'Your Full Funnel Conversion Calculator',
    lesson_type: 'form',
    position: 9,
    content: {
      intro: 'Enter your actual monthly funnel numbers. The calculator will show you your compounding conversion rates and where the biggest revenue gap is.',
      fields: [
        { id: 'calc_leads', label: 'Total leads per month', type: 'number', placeholder: '0' },
        { id: 'calc_contacted', label: 'Leads contacted', type: 'number', placeholder: '0' },
        { id: 'calc_inspections', label: 'Inspections completed', type: 'number', placeholder: '0' },
        { id: 'calc_proposals', label: 'Proposals delivered', type: 'number', placeholder: '0' },
        { id: 'calc_closed', label: 'Jobs closed', type: 'number', placeholder: '0' },
        { id: 'calc_avg_job', label: 'Average job value ($)', type: 'number', prefix: '$', placeholder: '0' },
      ],
      formulas: {
        contact_rate: (v) => {
          const leads = parseFloat(v.calc_leads) || 0
          const contacted = parseFloat(v.calc_contacted) || 0
          if (!leads) return null
          return (contacted / leads) * 100
        },
        inspection_rate: (v) => {
          const contacted = parseFloat(v.calc_contacted) || 0
          const inspections = parseFloat(v.calc_inspections) || 0
          if (!contacted) return null
          return (inspections / contacted) * 100
        },
        proposal_rate: (v) => {
          const inspections = parseFloat(v.calc_inspections) || 0
          const proposals = parseFloat(v.calc_proposals) || 0
          if (!inspections) return null
          return (proposals / inspections) * 100
        },
        close_rate_calc: (v) => {
          const proposals = parseFloat(v.calc_proposals) || 0
          const closed = parseFloat(v.calc_closed) || 0
          if (!proposals) return null
          return (closed / proposals) * 100
        },
        monthly_revenue: (v) => {
          return (parseFloat(v.calc_closed) || 0) * (parseFloat(v.calc_avg_job) || 0)
        },
        revenue_at_40_close: (v) => {
          const proposals = parseFloat(v.calc_proposals) || 0
          const avg = parseFloat(v.calc_avg_job) || 0
          return proposals * 0.40 * avg
        },
        revenue_at_50_close: (v) => {
          const proposals = parseFloat(v.calc_proposals) || 0
          const avg = parseFloat(v.calc_avg_job) || 0
          return proposals * 0.50 * avg
        },
      },
      results: [
        { id: 'contact_rate', label: 'Lead to contact rate', format: 'percent', benchmark: { low: 80, high: 100, label: '80%+' } },
        { id: 'inspection_rate', label: 'Contact to inspection rate', format: 'percent', benchmark: { low: 70, high: 100, label: '70%+' } },
        { id: 'close_rate_calc', label: 'Proposal to close rate', format: 'percent', benchmark: { low: 35, high: 100, label: '35%+ minimum' } },
        { id: 'monthly_revenue', label: 'Current monthly revenue (from these leads)', format: 'currency' },
        { id: 'revenue_at_40_close', label: 'Revenue at 40% close rate', format: 'currency' },
        { id: 'revenue_at_50_close', label: 'Revenue at 50% close rate', format: 'currency' },
      ],
    },
  },

  // LESSON 10 — FORM: Where Are Your Deals Dying
  {
    id: 'sct-10',
    course_id: 'sales-conversion-tracker',
    title: 'Where Are Your Deals Dying?',
    lesson_type: 'form',
    position: 10,
    content: {
      intro: 'Rate your performance at each stage. 1 = broken, 5 = strong. This becomes your fix priority list.',
      fields: [
        { id: 'score_lead_quality', label: 'Lead quality (how qualified are your leads?)', type: 'select', options: [
          {value: '1', label: '1 — Almost none are real buyers'},
          {value: '2', label: '2 — Below average quality'},
          {value: '3', label: '3 — Average'},
          {value: '4', label: '4 — Mostly strong leads'},
          {value: '5', label: '5 — High quality, motivated buyers'},
        ]},
        { id: 'score_first_contact', label: 'First contact speed (do you call leads within 5 minutes?)', type: 'select', options: [
          {value: '1', label: '1 — Usually same day or later'},
          {value: '2', label: '2 — Within a few hours'},
          {value: '3', label: '3 — Within 1 hour'},
          {value: '4', label: '4 — Within 30 minutes'},
          {value: '5', label: '5 — Under 5 minutes, every time'},
        ]},
        { id: 'score_inspection_process', label: 'Inspection process (do you run the BUILD Framework every time?)', type: 'select', options: [
          {value: '1', label: '1 — No consistent process'},
          {value: '2', label: '2 — Sometimes structured'},
          {value: '3', label: '3 — Usually structured'},
          {value: '4', label: '4 — Almost always consistent'},
          {value: '5', label: '5 — Same process every single time'},
        ]},
        { id: 'score_proposal_delivery', label: 'Proposal delivery (do you present same-day in person?)', type: 'select', options: [
          {value: '1', label: '1 — Email it later, no follow-up'},
          {value: '2', label: '2 — Usually email it'},
          {value: '3', label: '3 — Sometimes present in person'},
          {value: '4', label: '4 — Usually present in person'},
          {value: '5', label: '5 — Always in person, same day'},
        ]},
        { id: 'score_objection_handling', label: 'Objection handling (do you use the LOCK Method?)', type: 'select', options: [
          {value: '1', label: '1 — No system, wing it'},
          {value: '2', label: '2 — Sometimes handle them'},
          {value: '3', label: '3 — Handle most objections'},
          {value: '4', label: '4 — Consistent responses'},
          {value: '5', label: '5 — Use LOCK every time'},
        ]},
        { id: 'score_referral_system', label: 'Referral system (do you ask every closed customer for a referral?)', type: 'select', options: [
          {value: '1', label: '1 — Never ask'},
          {value: '2', label: '2 — Occasionally ask'},
          {value: '3', label: '3 — Ask half the time'},
          {value: '4', label: '4 — Usually ask'},
          {value: '5', label: '5 — Always ask, have a script'},
        ]},
        { id: 'biggest_leak', label: 'In one sentence: where do you think most of your deals are dying?', type: 'textarea', placeholder: 'Be specific. Stage, what happens, why you think it.' },
      ],
      formulas: {
        funnel_score: (v) => {
          const scores = ['score_lead_quality','score_first_contact','score_inspection_process','score_proposal_delivery','score_objection_handling','score_referral_system']
          const total = scores.reduce((sum, key) => sum + (parseFloat(v[key]) || 0), 0)
          return Math.round((total / 30) * 100)
        },
      },
      results: [
        { id: 'funnel_score', label: 'Overall funnel health score', format: 'percent', benchmark: { low: 60, high: 80, label: '70%+ is solid' } },
      ],
    },
  },

  // LESSON 11 — READING: Referral System
  {
    id: 'sct-11',
    course_id: 'sales-conversion-tracker',
    title: 'Stage 6: Building Your Referral System',
    lesson_type: 'reading',
    position: 11,
    content: {
      body: `## The cheapest lead you will ever get is a referral from a closed job.

Referrals close at 60-80%. Cold leads close at 25-35%. Most contractors get referrals accidentally — a few happy customers who mention them to a friend. This section turns that into a system.

**When to ask:**

Ask within 24 hours of job completion, while the customer is still in the peak of satisfaction. Not a week later by email. In person or by phone, before you leave.

"Before I head out — if you know anyone else dealing with something similar, I would really appreciate the introduction. I keep my schedule full by word of mouth."

That is it. No script needed. Just ask.

**The 90-day follow-up:**

90 days after job completion, send one text: "Just checking in — everything still looking good out there? If you know anyone who could use us, we would appreciate the intro."

One message. No pressure.

**Building trade partner referrals:**

Identify 5 contractors in adjacent trades who work on the same properties you do. Set up a mutual referral arrangement.

The conversation: "Hey, I know we see the same properties. If you ever run into something that needs [your trade], I would appreciate the introduction. We do the same."

These referrals close at the highest rate of all — the introduction comes from someone the homeowner already trusts.

**Track what matters:**

Every month, count referrals received and the revenue they produced. If referrals are under 20% of your job count, you have a systematic ask problem — not a satisfaction problem.`,
      callout: 'Ask for a referral within 24 hours of every closed job. If you are not doing this, you are leaving your highest-converting lead source on the table every single day.',
    },
  },

  // LESSON 12 — FORM: 30-Day Fix Plan
  {
    id: 'sct-12',
    course_id: 'sales-conversion-tracker',
    title: 'Your 30-Day Sales Fix Plan',
    lesson_type: 'form',
    position: 12,
    content: {
      intro: 'Based on your scores from the previous lesson, build your 30-day fix plan. Pick the two lowest-scoring stages and commit to specific actions.',
      fields: [
        { id: 'fix_priority_1', label: 'Highest priority fix (lowest scoring stage)', type: 'select', options: [
          {value: 'lead_quality', label: 'Lead quality'},
          {value: 'first_contact', label: 'First contact speed'},
          {value: 'inspection_process', label: 'Inspection process'},
          {value: 'proposal_delivery', label: 'Proposal delivery'},
          {value: 'objection_handling', label: 'Objection handling'},
          {value: 'referral_system', label: 'Referral system'},
        ]},
        { id: 'fix_action_1', label: 'Specific action to fix it (what exactly are you going to do?)', type: 'textarea', placeholder: 'Be specific. Not "improve my process." Tell me exactly what you are going to do differently starting Monday.' },
        { id: 'fix_priority_2', label: 'Second priority fix', type: 'select', options: [
          {value: 'lead_quality', label: 'Lead quality'},
          {value: 'first_contact', label: 'First contact speed'},
          {value: 'inspection_process', label: 'Inspection process'},
          {value: 'proposal_delivery', label: 'Proposal delivery'},
          {value: 'objection_handling', label: 'Objection handling'},
          {value: 'referral_system', label: 'Referral system'},
        ]},
        { id: 'fix_action_2', label: 'Specific action to fix it', type: 'textarea', placeholder: 'Specific action, starting date, how you will measure it.' },
        { id: 'close_rate_target', label: 'Close rate target for next 30 days (%)', type: 'number', suffix: '%', placeholder: '0', hint: 'What is a realistic target based on where you are today?' },
        { id: 'revenue_target_30', label: 'Revenue target for next 30 days ($)', type: 'number', prefix: '$', placeholder: '0' },
      ],
      formulas: {},
      results: [],
    },
  },

  // LESSON 13 — QUIZ
  {
    id: 'sct-13',
    course_id: 'sales-conversion-tracker',
    title: 'Knowledge Check',
    lesson_type: 'quiz',
    position: 13,
    content: {
      questions: [
        {
          question: 'What does the BUILD Framework stand for?',
          options: [
            'Build, Understand, Inspect, Lead, Deliver',
            'Begin, Uncover, Identify, Lead, Drive',
            'Brief, Unpack, Investigate, List, Document',
            'Begin, Update, Inspect, List, Drive',
          ],
          correct: 1,
          explanation: 'BUILD: Begin (rapport), Uncover (inspection), Identify (compile findings), Lead (walkthrough), Drive (to proposal).',
        },
        {
          question: 'A contractor runs 100 inspections per month with a 30% close rate at $8,500 average job. If they improve to a 40% close rate, how much additional revenue do they generate?',
          options: ['$42,500', '$85,000', '$170,000', '$25,500'],
          correct: 1,
          explanation: '10 more jobs per month x $8,500 = $85,000 additional monthly revenue.',
        },
        {
          question: 'What is the first step of the LOCK Method?',
          options: ['Counter with evidence', 'Keep closing', 'Listen to the full objection without interrupting', 'Own the concern'],
          correct: 2,
          explanation: 'Listen first — let them finish completely before you respond. Most reps cut in too early.',
        },
        {
          question: 'What is the benchmark contact rate for leads?',
          options: ['50% or higher', '60% or higher', '70% or higher', '80% or higher'],
          correct: 3,
          explanation: 'Industry benchmark is 80%+. If you are below this, your lead response time is the problem.',
        },
        {
          question: 'When should you ask for a referral?',
          options: ['30 days after job completion via email', 'Within 24 hours of job completion, in person or by phone', 'Only when the customer mentions they know someone', 'At the 90-day follow-up'],
          correct: 1,
          explanation: 'Ask within 24 hours while satisfaction is at its peak. Do it in person or by phone before you leave.',
        },
        {
          question: 'In the BUILD Framework, what is the purpose of the Uncover step?',
          options: ['Building rapport with the homeowner', 'Delivering the proposal', 'Running a systematic inspection with minimum 20 photos', 'Walking the homeowner through findings'],
          correct: 2,
          explanation: 'Uncover is the inspection step: systematic documentation, minimum 20 photos, measure everything.',
        },
      ],
    },
  },

  // LESSON 14 — SUMMARY
  {
    id: 'sct-14',
    course_id: 'sales-conversion-tracker',
    title: 'Your Progress Report',
    lesson_type: 'summary',
    position: 14,
    content: {
      next_steps: [
        'Run the BUILD Framework on your next 5 inspections. Track the proposal rate.',
        'Practice the LOCK Method on your next 3 objections. Write down what happened.',
        'Ask for a referral within 24 hours of your next 10 closed jobs. Count how many you get.',
      ],
    },
  },
]
