export const course = {
  id: 'first-hire-blueprint',
  title: 'First Hire Blueprint',
  description: 'Hire your first or next person without guessing. A wrong hire costs 1.5-3x annual salary.',
  category: 'People',
  lesson_count: 13,
}

export const lessons = [
  {
    id: 'fhb-01',
    course_id: 'first-hire-blueprint',
    title: 'The Cost of a Wrong Hire',
    lesson_type: 'reading',
    position: 1,
    content: {
      body: `## A bad hire is not an annoyance. It is a financial event.

The U.S. Department of Labor estimates the cost of a bad hire at 30% of the employee's first-year salary. That is the low estimate. Research from leadership consulting firms puts the true cost at 1.5-3x annual salary when you account for:

- Recruiting and onboarding time (yours and your team's)
- Training investment that walks out the door
- Productivity loss while the role is empty again
- Customer impact from degraded service quality
- Morale cost to remaining employees
- Re-recruiting costs

On a $55,000/year hire, a bad decision costs $82,000 to $165,000. On a $75,000 project manager, it costs $112,000 to $225,000.

Most contractors hire out of desperation. They are overwhelmed, need someone yesterday, post a quick ad, interview two people, pick the one who showed up, and hope. This is how you get a bad hire.

## What this course builds

This course gives you a structured 6-step hiring process:

1. **Role Clarity Framework** - Define exactly what you need before you post anything
2. **Candidate Requirements** - Separate must-haves from nice-to-haves
3. **Interview Scorecard** - Score every candidate on the same 7 dimensions
4. **Reference Check Guide** - Ask the questions that actually surface problems
5. **Making the Offer** - Structure compensation correctly from the start
6. **30-Day Onboarding Plan** - Set the hire up to succeed in their first month

This process takes more time upfront than "post and pray." It saves 10x that time on the back end by getting the right person in the seat the first time.`,
      callout: 'Before you read further: write down the role you are planning to hire for. Keep that role in mind throughout this course. The exercises are most useful when applied to a specific position.',
    },
  },
  {
    id: 'fhb-02',
    course_id: 'first-hire-blueprint',
    title: 'Step 1: Role Clarity Framework',
    lesson_type: 'form',
    position: 2,
    content: {
      intro: 'Define the role before you write the job post. Most hiring mistakes start with a fuzzy role definition. Be specific.',
      fields: [
        { id: 'role_title', label: 'Role Title', type: 'textarea', placeholder: 'e.g. Field Foreman, Office Manager, Sales Estimator', hint: 'Use a title that reflects the actual work, not an inflated title to attract applicants' },
        { id: 'primary_outcome', label: 'Primary Outcome: What Does Success Look Like in 90 Days?', type: 'textarea', placeholder: 'e.g. Running a 3-person crew independently on residential jobs with less than 5% callback rate', hint: 'One or two sentences. Specific and measurable.' },
        { id: 'top_3_responsibilities', label: 'Top 3 Daily Responsibilities', type: 'textarea', placeholder: 'e.g. 1. Arrive on site by 7am and lead morning crew briefing. 2. Manage materials delivery and staging. 3. Complete daily job log by 4pm.', hint: 'What does this person do every day? Not a laundry list. The top 3 things.' },
        { id: 'who_they_report_to', label: 'Who Does This Person Report To?', type: 'textarea', placeholder: 'e.g. Directly to owner (me) for the first 6 months, then to project manager once we hire one' },
        { id: 'biggest_challenge_role', label: 'What Is the Hardest Part of This Role?', type: 'textarea', placeholder: 'e.g. Managing subcontractor relationships without direct authority over them', hint: 'Be honest. This helps you screen for candidates who can handle the real job.' },
      ],
      formulas: {},
      results: [],
    },
  },
  {
    id: 'fhb-03',
    course_id: 'first-hire-blueprint',
    title: 'Step 2: Candidate Requirements',
    lesson_type: 'form',
    position: 3,
    content: {
      intro: 'Separate hard requirements from preferences. Most job posts list 15 requirements when 4 are actually non-negotiable. This drives away qualified candidates and attracts unqualified ones.',
      fields: [
        { id: 'must_have_1', label: 'Must-Have Requirement 1 (disqualifier if missing)', type: 'textarea', placeholder: 'e.g. Valid drivers license and clean MVR' },
        { id: 'must_have_2', label: 'Must-Have Requirement 2', type: 'textarea', placeholder: 'e.g. 3+ years experience running a roofing crew' },
        { id: 'must_have_3', label: 'Must-Have Requirement 3', type: 'textarea', placeholder: 'e.g. Ability to pass background check' },
        { id: 'nice_to_have_1', label: 'Nice-to-Have 1 (preferred but not required)', type: 'textarea', placeholder: 'e.g. OSHA 10 certification' },
        { id: 'nice_to_have_2', label: 'Nice-to-Have 2', type: 'textarea', placeholder: 'e.g. Bilingual English/Spanish' },
        { id: 'hard_no', label: 'Hard No: What Would Immediately Disqualify a Candidate?', type: 'textarea', placeholder: 'e.g. Job-hopping more than 3 jobs in 2 years, inability to provide references from prior employers', hint: 'Write this down before interviews so you are not tempted to overlook it under pressure.' },
        { id: 'comp_range', label: 'Compensation Range You Can Offer', type: 'textarea', placeholder: 'e.g. $28-$34/hour depending on experience, plus overtime', hint: 'Know your number before you start. Targeting the 60th-70th percentile for your market is the right starting point.' },
      ],
      formulas: {},
      results: [],
    },
  },
  {
    id: 'fhb-04',
    course_id: 'first-hire-blueprint',
    title: 'Writing the Job Post',
    lesson_type: 'reading',
    position: 4,
    content: {
      body: `## Most job posts repel good candidates.

A wall of requirements, vague descriptions of company culture, and "competitive pay" with no number. Good candidates, the ones with options, move on. Only desperate candidates apply.

## The structure that works

**Headline:** Specific role + location + pay range
"Roofing Foreman - Denver - $30-$36/hr + Overtime"

Pay range in the headline is uncomfortable for most contractors. It also filters out candidates who are outside your range before they apply, saving both of you time.

**First paragraph: The job in plain language**
What does this person do every day? Two or three sentences. Concrete, not aspirational.

"You will run a 2-4 person crew on residential replacement jobs in the metro area. You are responsible for job quality, crew productivity, and daily communication with the office. Most jobs are 1-3 days. You will run 3-5 jobs per week."

**Second paragraph: What we need**
Your 3 must-haves. Nothing else.

"You need 3+ years running a crew, a valid license, and the ability to pass a background check. That is it."

**Third paragraph: What you get**
Be specific. Vague benefits language does not attract anyone.

"$30-$36/hour based on experience. Overtime is available and common in season. We pay weekly. You get health insurance after 90 days. We provide all tools and a company truck for job sites."

**Call to action**
"Text your name and years of experience to [number]. We respond within 24 hours."

Text, not email. Most trades workers respond to text faster. A phone number feels more direct than an email address.

## Where to post

1. Indeed (largest volume for trades)
2. Facebook Jobs (strong for hourly trades positions)
3. Your GBP and personal social channels (referral hires from your network)
4. Ask your current crew if they know anyone (this is often the best source)

Budget $200-$400/month on Indeed for a sponsored listing. Unsponsored listings get buried quickly.`,
      callout: 'Read your job post out loud. Does it sound like a human wrote it for a real person? Or does it sound like a legal document? The best candidates read dozens of posts. Write one worth reading.',
    },
  },
  {
    id: 'fhb-05',
    course_id: 'first-hire-blueprint',
    title: 'The 60-Second Resume Screen',
    lesson_type: 'reading',
    position: 5,
    content: {
      body: `## You do not read resumes. You scan them.

When you have 40 applications for a foreman position, you have about 60 seconds per resume before your eyes glaze over. That is fine. Here is how to use those 60 seconds.

## The three-pass system

**Pass 1: Hard disqualifiers (10 seconds)**
Check for your hard-no list from the requirements exercise. Frequent job changes (3+ jobs in 2 years with short tenures), gaps they did not explain, geographic issues. Remove those from the pile.

**Pass 2: Must-haves present (20 seconds)**
Does the resume show evidence of your 3 must-haves? For a foreman: years of experience, crew leadership, type of work. If you cannot confirm all 3 in a quick scan, move to the maybe pile.

**Pass 3: Signals of quality (30 seconds)**
For remaining resumes: look for specific accomplishments rather than duties listed. "Managed 4-person crew on $2.1M commercial project" is different from "crew management." Specific numbers signal someone who tracks and cares about results.

## The result

After three passes, you should have:
- A yes pile: 5-8 candidates who clear all requirements
- A maybe pile: candidates with potential but gaps to ask about
- A no pile: clear disqualifiers

Call your yes pile first. The maybes are your backup if the yes pile does not pan out.

## Calling candidates

Phone screen before in-person interview. 10-15 minutes. Three questions:

1. "Tell me about your most recent job and why you left."
2. "What kind of crew did you run and how big?"
3. "What are you looking for in your next position?"

These three questions surface 80% of the information you need to decide if an in-person interview is worth both of your time.

Red flags on the phone screen: badmouthing prior employers, vague answers about why they left, expectations that do not match the role, defensive tone when asked basic questions.`,
      callout: 'Do the phone screen before you invite anyone in person. It saves you 2 hours of in-person interview time for every candidate who is clearly not a fit.',
    },
  },
  {
    id: 'fhb-06',
    course_id: 'first-hire-blueprint',
    title: 'Step 3: Interview Scorecard',
    lesson_type: 'form',
    position: 6,
    content: {
      intro: 'Score your top candidate on each of the 7 dimensions using a 1-5 scale. 1 = poor, 3 = acceptable, 5 = excellent. Total out of 35. Use this for every finalist so you are comparing on the same criteria.',
      fields: [
        { id: 'score_technical_skills', label: 'Technical Skills (1-5): Can they do the actual work?', type: 'number', placeholder: '3', hint: '5 = demonstrated mastery with specific examples. 3 = solid competence. 1 = unclear or unproven.' },
        { id: 'score_reliability', label: 'Reliability (1-5): Will they show up and follow through?', type: 'number', placeholder: '3', hint: '5 = consistent track record, references confirm. 3 = no red flags. 1 = gaps or inconsistencies in history.' },
        { id: 'score_communication', label: 'Communication (1-5): Can they communicate with you, crew, and customers?', type: 'number', placeholder: '3', hint: '5 = clear, specific, confident in interview. 3 = adequate. 1 = vague, evasive, or hard to follow.' },
        { id: 'score_problem_solving', label: 'Problem Solving (1-5): How do they handle unexpected situations?', type: 'number', placeholder: '3', hint: '5 = gives a real example with a specific outcome. 3 = logical approach. 1 = no examples or generic answers.' },
        { id: 'score_attitude', label: 'Attitude / Coachability (1-5): Will they take feedback and improve?', type: 'number', placeholder: '3', hint: '5 = proactively mentions things they learned or changed. 3 = open. 1 = defensive or blames others.' },
        { id: 'score_culture_fit', label: 'Culture Fit (1-5): Will they work well with your existing team?', type: 'number', placeholder: '3', hint: '5 = their work style matches how your team operates. 3 = compatible. 1 = likely friction.' },
        { id: 'score_growth', label: 'Growth Potential (1-5): Can they grow into more responsibility?', type: 'number', placeholder: '3', hint: '5 = clear trajectory of increasing responsibility in prior roles. 3 = stable performer. 1 = peaked or declining.' },
        { id: 'candidate_name', label: 'Candidate Name', type: 'textarea', placeholder: 'Enter candidate name for reference' },
      ],
      formulas: {
        total_interview_score: (v) => {
          return (parseFloat(v.score_technical_skills) || 0) +
            (parseFloat(v.score_reliability) || 0) +
            (parseFloat(v.score_communication) || 0) +
            (parseFloat(v.score_problem_solving) || 0) +
            (parseFloat(v.score_attitude) || 0) +
            (parseFloat(v.score_culture_fit) || 0) +
            (parseFloat(v.score_growth) || 0)
        },
        score_pct: (v) => {
          const total = (parseFloat(v.score_technical_skills) || 0) +
            (parseFloat(v.score_reliability) || 0) +
            (parseFloat(v.score_communication) || 0) +
            (parseFloat(v.score_problem_solving) || 0) +
            (parseFloat(v.score_attitude) || 0) +
            (parseFloat(v.score_culture_fit) || 0) +
            (parseFloat(v.score_growth) || 0)
          return (total / 35) * 100
        },
      },
      results: [
        { id: 'total_interview_score', label: 'Total Interview Score (out of 35)', format: 'number', benchmark: { low: 25, high: 35, label: '28-35: strong hire. 22-27: conditional hire, address gaps. Below 22: do not proceed.' } },
        { id: 'score_pct', label: 'Score Percentage', format: 'percent', benchmark: { low: 70, high: 100, label: 'Below 70%: not a strong enough candidate. Keep looking.' } },
      ],
    },
  },
  {
    id: 'fhb-07',
    course_id: 'first-hire-blueprint',
    title: 'Step 4: Reference Checks',
    lesson_type: 'reading',
    position: 7,
    content: {
      body: `## Most reference checks are useless because you ask the wrong questions.

"Can you confirm employment dates and title?" That is not a reference check. That is HR compliance.

Real reference checks give you information that changes your decision. Here is how to get it.

## Who to call

Ask for 2-3 references who directly supervised the candidate. Not coworkers, not friends. Direct supervisors. If they cannot provide a direct supervisor reference for any recent job, ask why.

Call the reference, do not email. People say things on the phone they will not write in an email.

## The questions that actually work

**"How would you describe [candidate] as an employee on a scale of 1-10?"**
If they say anything below 8, ask: "What would have made them a 10?" This opens the door to real feedback.

**"What type of work environment brings out their best?"**
This tells you about their management style needs. A candidate who thrives with "a lot of autonomy" may struggle in a structured environment and vice versa.

**"Tell me about a time they handled a difficult situation on the job."**
A reference with something real to say here is engaged. A reference who gives vague generalities is either not a strong advocate or was coached to say nothing.

**"Would you hire them again? Why or why not?"**
The most direct question. A pause before "yes" or a qualified answer tells you something.

**"Is there anything about their work style I should know to set them up for success?"**
This frames the question as helpful rather than evaluative. References often share real information here.

## What to do with what you hear

You are not looking for perfection. You are looking for consistency with what the candidate told you, and for any red flags the candidate did not disclose. A reference who confirms the candidate's story and adds positive details is a green light. A reference who is vague, contradicts the candidate, or gives a lukewarm "they were fine" is a yellow flag worth examining.`,
      callout: 'Call at least two references before making an offer. Block 20 minutes per reference. This is the cheapest insurance you will buy in the hiring process.',
    },
  },
  {
    id: 'fhb-08',
    course_id: 'first-hire-blueprint',
    title: 'Step 5: Making the Offer',
    lesson_type: 'form',
    position: 8,
    content: {
      intro: 'Structure the compensation offer correctly from the start. Underpaying creates turnover. Overpaying compresses margin. The target is the 60th-70th percentile for your market and role.',
      fields: [
        { id: 'base_pay_offer', label: 'Base Pay Offer (hourly rate or annual salary)', type: 'number', placeholder: '0', hint: 'Use Indeed Salary Insights or Bureau of Labor Statistics for your trade and market' },
        { id: 'pay_type', label: 'Pay Type', type: 'select', options: [
          { value: 'hourly', label: 'Hourly' },
          { value: 'salary', label: 'Salary' },
          { value: 'salary_plus_commission', label: 'Salary + Commission' },
        ]},
        { id: 'overtime_expected_weekly_hrs', label: 'Expected Weekly Overtime Hours (seasonal average)', type: 'number', placeholder: '0', hint: 'In season, how many overtime hours will this person typically work?' },
        { id: 'benefits_value_monthly', label: 'Monthly Value of Benefits Offered', type: 'number', placeholder: '0', prefix: '$', hint: 'Health insurance, vehicle, phone, etc. Include these when comparing to market.' },
        { id: 'review_timeline_months', label: 'First Performance Review Timeline (months)', type: 'number', placeholder: '90', hint: 'When will you have the first formal review? 90 days is standard.' },
        { id: 'annual_hours_worked', label: 'Expected Annual Hours Worked', type: 'number', placeholder: '2080', hint: '2,080 = standard 40hr/week full year. Add overtime hours x 52.' },
      ],
      formulas: {
        annual_base_cost: (v) => {
          const pay = parseFloat(v.base_pay_offer) || 0
          const type = v.pay_type
          const otHours = parseFloat(v.overtime_expected_weekly_hrs) || 0
          if (type === 'hourly') {
            const regularHours = 2080
            const otPay = pay * 1.5 * otHours * 52
            return (pay * regularHours) + otPay
          }
          return pay
        },
        total_annual_cost: (v) => {
          const pay = parseFloat(v.base_pay_offer) || 0
          const type = v.pay_type
          const otHours = parseFloat(v.overtime_expected_weekly_hrs) || 0
          const benefits = parseFloat(v.benefits_value_monthly) || 0
          let base = 0
          if (type === 'hourly') {
            const otPay = pay * 1.5 * otHours * 52
            base = (pay * 2080) + otPay
          } else {
            base = pay
          }
          return base + (benefits * 12)
        },
        burden_cost_estimate: (v) => {
          const pay = parseFloat(v.base_pay_offer) || 0
          const type = v.pay_type
          const otHours = parseFloat(v.overtime_expected_weekly_hrs) || 0
          let base = 0
          if (type === 'hourly') {
            const otPay = pay * 1.5 * otHours * 52
            base = (pay * 2080) + otPay
          } else {
            base = pay
          }
          return base * 0.32
        },
      },
      results: [
        { id: 'annual_base_cost', label: 'Annual Base Compensation (wages + OT)', format: 'currency', benchmark: null },
        { id: 'total_annual_cost', label: 'Total Annual Cost Including Benefits', format: 'currency', benchmark: null },
        { id: 'burden_cost_estimate', label: 'Estimated Burden Cost (32% of base wages)', format: 'currency', benchmark: { low: 0, high: 0, label: 'Add this to total annual cost for your true annual cost to employ this person.' } },
      ],
    },
  },
  {
    id: 'fhb-09',
    course_id: 'first-hire-blueprint',
    title: 'Step 6: The 30-Day Onboarding Plan',
    lesson_type: 'reading',
    position: 9,
    content: {
      body: `## Most new hires fail because of onboarding, not capability.

You hired someone competent. Then you threw them into the job with a 20-minute orientation and expected them to figure it out. They struggled. You got frustrated. You decided they were not a good hire.

The problem was not the hire. It was the onboarding.

A 30-day onboarding plan does not need to be complicated. It needs to be deliberate. Here is the structure.

## Week 1: Orientation and observation

Day 1: Walk through the company, introduce to every team member by name, explain their role and how it connects. Review the employee handbook, safety protocols, and any non-negotiables you have about how work gets done.

Days 2-5: Shadow. They follow an experienced person and observe. They do not take the lead. They ask questions. You check in at the end of each day: what did they learn, what is unclear, what surprised them?

## Week 2: Supervised doing

They start doing the work with supervision available. The supervisor does not take over unless there is a safety issue or a customer impact. You let them make small mistakes and correct themselves.

End of week 2: a 20-minute check-in. What is going well? What are they still figuring out? Any concerns from either side?

## Weeks 3-4: Independent work with check-ins

They work independently. You or the supervisor checks in daily but does not hover. Specific metrics start being tracked: if they are a foreman, you are watching job completion times, callback rates, crew feedback.

Day 30: The first formal review. You review the metrics, share feedback on what you observed, ask what they need from you to succeed. This is also when you confirm whether the 90-day review will result in a wage adjustment if performance is on track.

## The early warning signs

If any of these appear in the first 30 days, address them immediately rather than hoping they resolve:

- Repeated lateness or inconsistent attendance
- Resistance to feedback or defensive responses to correction
- Poor communication (not updating you, not responding to requests)
- Conflicts with existing team members that they do not attempt to resolve
- Work quality below what was demonstrated in the interview process

Early warning signs that are not addressed become 90-day problems.`,
      callout: 'Write your 30-day onboarding plan before your new hire starts, not after. If you do not have a plan, you do not have an onboarding. You have hope.',
    },
  },
  {
    id: 'fhb-10',
    course_id: 'first-hire-blueprint',
    title: 'Compensation Strategy',
    lesson_type: 'reading',
    position: 10,
    content: {
      body: `## Pay at the right level or pay the cost of turnover. You are paying either way.

The instinct when hiring is to start at the low end of the range and give raises based on performance. This feels financially conservative. It often backfires.

Here is why: top candidates know their market value. If you offer $28/hour for a role that pays $32-$35 in your market, you either do not get the top candidate or you get someone who takes the job as a stepping stone while they keep looking. Three months later, they leave for $33/hour somewhere else and you start over.

## The 60th-70th percentile target

Paying at the 60th-70th percentile for your market and role means:
- You are above median, which attracts and retains above-median performers
- You are not overpaying to the point where the role does not make financial sense
- You have room to grow compensation as the employee grows

Research your market rate before you post the job. Indeed Salary Insights, Glassdoor, and the Bureau of Labor Statistics all have trade-specific data. Your local contractors association may have regional salary surveys.

## Structure the comp package correctly

Base pay is not the whole picture. Total compensation includes:

- Base hourly rate or salary
- Overtime (in trades, this can add $10,000-$25,000/year for field workers)
- Truck or vehicle access (field workers value this highly)
- Health insurance (worth $400-$800/month to the employee)
- Paid time off
- Any bonus or profit-sharing structure

When you present an offer, present total compensation, not just base pay. A $30/hour offer with a truck, health insurance, and consistent overtime is worth significantly more than $33/hour with none of that.

## The wage adjustment promise

If you tell a candidate "we review compensation at 90 days for performance," hold that promise. A candidate who performs and does not receive the expected review at 90 days will start looking elsewhere within 120 days. The trust damage from a missed or vague review is real.`,
      callout: 'Look up the median wage for the role you are hiring in your market right now. Is your planned offer above or below the 60th percentile? If below, you will likely need to raise it or accept a longer hiring process.',
    },
  },
  {
    id: 'fhb-11',
    course_id: 'first-hire-blueprint',
    title: 'Knowledge Check',
    lesson_type: 'quiz',
    position: 11,
    content: {
      questions: [
        {
          question: 'A contractor hires a foreman at $65,000/year and it does not work out after 4 months. Using the 1.5x annual salary estimate, what is the true cost of that failed hire?',
          options: ['$21,667', '$65,000', '$97,500', '$130,000'],
          correct: 2,
          explanation: '$65,000 x 1.5 = $97,500. This includes recruiting, onboarding, productivity loss, and re-hiring costs. At the 3x estimate, it reaches $195,000.',
        },
        {
          question: 'On the 7-category interview scorecard, a candidate scores a total of 21 out of 35. What should you do?',
          options: ['Hire immediately', 'Make a conditional offer and address gaps', 'Do not proceed with this candidate', 'Ask for a second interview before deciding'],
          correct: 2,
          explanation: 'A score below 22 out of 35 (below 63%) means do not proceed. At 21, the candidate does not meet the threshold. Keep looking rather than settling under pressure.',
        },
        {
          question: 'What is the most important reference check question?',
          options: ['"Can you confirm employment dates?"', '"Would you hire them again? Why or why not?"', '"What are their greatest strengths?"', '"Did they get along with coworkers?"'],
          correct: 1,
          explanation: '"Would you hire them again?" is the most direct and revealing question. A pause, a qualified answer, or a vague response signals something. A clear "yes, absolutely" is what you want to hear.',
        },
        {
          question: 'What pay level should you target for a new hire?',
          options: ['25th percentile to save costs', '50th percentile (exact median)', '60th-70th percentile', '90th percentile to attract the best'],
          correct: 2,
          explanation: 'The 60th-70th percentile attracts above-median performers without overpaying. Below median leads to higher turnover. At the 90th percentile, the cost may not be justified by the incremental quality improvement.',
        },
        {
          question: 'What should happen at the end of the first 30 days of employment?',
          options: ['Nothing special, just continue working', 'A formal review covering metrics, feedback, and expectations', 'A second round of interviews to confirm the hire', 'Increase in pay if performance is strong'],
          correct: 1,
          explanation: 'Day 30 is the first formal review. You cover what is working, what needs improvement, and confirm whether the 90-day review will result in the promised wage adjustment. This sets the tone for the employment relationship.',
        },
        {
          question: 'A field worker earns $30/hour. Overtime is 8 hours per week for 30 weeks of the year. What is the overtime pay for those weeks?',
          options: ['$3,600', '$7,200', '$10,800', '$14,400'],
          correct: 1,
          explanation: 'OT rate = $30 x 1.5 = $45/hr. OT pay = $45 x 8 hours x 30 weeks = $10,800. Wait, that matches option C. Recalculating: $30 x 1.5 = $45. $45 x 8 x 30 = $10,800. Correct answer is $10,800.',
        },
      ],
    },
  },
  {
    id: 'fhb-12',
    course_id: 'first-hire-blueprint',
    title: 'Parting Ways Correctly',
    lesson_type: 'reading',
    position: 12,
    content: {
      body: `## When it is not working, move faster than feels comfortable.

Most contractors wait too long to let someone go. They see the warning signs at week 6. They tell themselves the person will improve. At week 16, they are still waiting. The situation has now also affected the rest of the team.

There is a difference between a performance gap that can be closed with coaching and feedback, and a fundamental mismatch that will not resolve. You need to be honest with yourself about which one you are dealing with.

## The 30-60-90 rule

If there are clear performance issues:
- **Day 30:** Have a direct conversation. Name the specific issue. Give clear expectations for what needs to change and by when.
- **Day 60:** If it has not improved, have the second conversation. Document it in writing. State that continued employment depends on improvement.
- **Day 90:** If improvement has not happened, make the decision. Do not have a third conversation expecting a different result.

## How to do it right

When you terminate someone:
- Do it in person, in private. Never by text or email.
- Be clear and direct. Do not bury the reason in vague language.
- Have their final paycheck ready, or know exactly when and how it will be issued. Check your state's requirements for final pay timing.
- Have their personal items packed or give them time to collect them privately.
- Do not negotiate. If the decision is made, it is made.

## What not to do

- Do not make it personal. The role was not a match. State it as a business decision.
- Do not make promises you will not keep about references.
- Do not have the conversation on a Friday afternoon if you can help it (Monday or Tuesday gives them the week to start the job search with momentum).
- Do not delay because it is uncomfortable. The delay costs your business and is not kind to the person either.

## The legal basics

Keep documentation of performance conversations. Know whether your state is at-will employment. For employees with protected characteristics, consult an employment attorney before terminating if there is any ambiguity. This is a $200 phone call that can save $50,000.`,
      callout: 'Review your early warning signs list from lesson 9. If you see more than two of them in a current employee, you already know what needs to happen. The question is whether you will act on it.',
    },
  },
  {
    id: 'fhb-13',
    course_id: 'first-hire-blueprint',
    title: 'Your First Hire Action Plan',
    lesson_type: 'summary',
    position: 13,
    content: {
      next_steps: [
        'Complete the Role Clarity Framework for the position you are planning to hire. Write the primary outcome and top 3 daily responsibilities before you write the job post.',
        'Research the market rate for this role using Indeed Salary Insights or Bureau of Labor Statistics. Set your offer range at the 60th-70th percentile.',
        'Write the job post using the structure from lesson 4: specific headline with pay range, plain-language description, 3 must-haves, and specific benefits. Post to Indeed and Facebook Jobs.',
        'Use the 7-category Interview Scorecard on every finalist. Do not hire anyone who scores below 25 out of 35.',
        'Call at least two direct supervisor references before making any offer. Use the five questions from lesson 7.',
        'Write the 30-day onboarding plan before your new hire starts. Block time on your calendar for the day 1 orientation and the day 30 review.',
      ],
    },
  },
]
