-- =============================================================================
-- Migration: 014_first_hire_blueprint_lessons.sql
-- Source PDF: SLO-First-Hire-Blueprint.pdf (20 pages)
-- Pillar: crew
-- Lesson count: 10
-- =============================================================================
-- SCHEMA ASSUMPTIONS (Jared: verify before running):
--   1. Extension uuid-ossp is already enabled (uuid_generate_v4() is available).
--   2. Table "lessons" exists with columns: id, slug, title, description,
--      pillar_key, position, duration_minutes, created_at.
--   3. Table "lesson_steps" exists with columns: id, lesson_id, position,
--      step_type, content (jsonb), created_at.
--   4. lessons.slug has a UNIQUE constraint.
--   5. lesson_steps.lesson_id references lessons(id) ON DELETE CASCADE.
--   6. If a lessons row with the same slug already exists, this will fail.
--      Wrap in a DO $$ block or add ON CONFLICT DO NOTHING if idempotency needed.
-- =============================================================================


-- ----------------------------------------------------------------------------
-- LESSON 1: Why Bad Hires Happen
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'fhb-01-why-bad-hires-happen',
  'Why Bad Hires Happen',
  'Most first hires fail before the interview starts. The owner has not written down what the job is, what success looks like, or who actually fits. This lesson covers the four mistakes that cause bad hires and how this blueprint prevents them.',
  'crew',
  1,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Wrong-Person Tax",
  "body": "Most first hires fail before the interview ever starts. The owner has not written down what the job actually is. They have not defined what success looks like in 30 days. They do not know what kind of person fits the business. Then they hire fast because they are desperate, and spend the next six months managing someone they should never have hired.\n\nThe cost is not just the salary. The wrong hire costs 1.5 to 3 times that person''s annual salary when you add recruiting costs, training time, lost productivity while they were underperforming, and the damage they did on the way out. A $45,000-per-year field hire who does not work out costs you between $67,500 and $135,000. That is the wrong-person tax.\n\n**The four hiring mistakes that kill small businesses:**\n\n**1. Hiring the first person who shows up.**\nUrgency-driven hiring always produces bad results. When you are desperate, you rationalize red flags. The candidate who is available immediately when you are burning is almost never the right person.\n\n**2. No written job description.**\nExpectations that exist only in the owner''s head cannot be communicated, measured, or held to. If you cannot write down what success looks like, you cannot hire for it.\n\n**3. Skipping reference checks because you liked the interview.**\nInterview performance is not a predictor of job performance. References are. The pause before a former supervisor answers ''would you rehire them'' tells you everything.\n\n**4. No onboarding plan.**\nMost new hires quit in the first 30 days because nobody made them feel like they belonged or explained what was expected. They were thrown in and told to figure it out. Then the owner blames the hire.",
  "key_takeaway": "A bad hire costs 1.5 to 3x annual salary. Slowing down the process by two weeks to do it right is always cheaper than the wrong-person tax."
}'::jsonb
FROM lessons WHERE slug = 'fhb-01-why-bad-hires-happen';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'summary', '{
  "title": "The Problem Is Clear",
  "highlights": [
    "Bad hires happen because of broken process, not bad luck. The four mistakes are all preventable.",
    "The wrong-person tax on a $45,000 hire can exceed $135,000 when you count all the costs.",
    "This blueprint is a six-step system that eliminates each of the four mistakes in order."
  ],
  "next_steps": [
    "Think about your last hire that did not work out. Which of the four mistakes did you make?",
    "Commit to following all six steps in sequence before your next hire, even if it adds two weeks to the process.",
    "Move to Lesson 2 to start with Role Clarity, where 80% of bad hires are prevented."
  ]
}'::jsonb
FROM lessons WHERE slug = 'fhb-01-why-bad-hires-happen';


-- ----------------------------------------------------------------------------
-- LESSON 2: Role Clarity Framework
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'fhb-02-role-clarity-framework',
  'Role Clarity Framework',
  'Before writing a job post, answer six questions in writing. If you cannot answer them, you are not ready to hire. You need to define the role first. This is where 80% of bad hiring decisions are eliminated.',
  'crew',
  2,
  10
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "You Cannot Hire for a Role You Have Not Defined",
  "body": "The most important step in hiring happens before any job post is written. It is the moment you sit down and force yourself to answer, in writing, what this job actually is.\n\nMost owners skip this step. They post a generic job title on Indeed, get a pile of resumes, interview the three who seem promising, and hire the one who interviewed best. Then they wonder why the person they hired is not doing what they needed.\n\nThe answer is simple: the owner never wrote it down.\n\n**Six questions to answer before posting:**\n\n1. What is the job title on paper?\n2. What department or function does this role sit in? Production, sales, office, marketing.\n3. Who manages this person day to day? If the answer is ''me,'' build in time for that.\n4. Is this full-time or part-time? How many hours per week?\n5. What is the pay structure? Hourly, salary, or commission plus base.\n6. What is the pay range?\n\n**Three to five core responsibilities:**\nList what this person will be accountable for every week. If you list more than five, you are describing two jobs. Split them.\n\n**30-day success definition:**\nFor each responsibility, write one specific outcome this person should be able to demonstrate by day 30. Not activities. Outcomes. Not ''learning the truck'' but ''can complete a full roof inspection and report without assistance.''",
  "key_takeaway": "Set a timer for 20 minutes. Fill out the Role Definition worksheet before doing anything else. That one exercise eliminates 80% of bad hiring decisions."
}'::jsonb
FROM lessons WHERE slug = 'fhb-02-role-clarity-framework';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Role Definition Worksheet",
  "description": "Define the role in writing before you write a single word of a job post. Every field here is required. If you cannot fill it in, you are not ready to hire.",
  "fields": [
    {
      "label": "Job Title",
      "key": "job_title",
      "type": "text",
      "prefix": "",
      "suffix": "",
      "hint": "What will you call this person on paper? Be specific. ''Field Tech'' is better than ''Helper.''"
    },
    {
      "label": "Department or Function",
      "key": "department",
      "type": "text",
      "prefix": "",
      "suffix": "",
      "hint": "Production, sales, office, or marketing."
    },
    {
      "label": "Who manages this person day to day?",
      "key": "reports_to",
      "type": "text",
      "prefix": "",
      "suffix": "",
      "hint": "Name and title. If it is you, write your name."
    },
    {
      "label": "Hours per week expected",
      "key": "hours_per_week",
      "type": "number",
      "prefix": "",
      "suffix": " hrs/week",
      "hint": "Full-time is typically 40-45. Part-time is 20-30."
    },
    {
      "label": "Pay range: minimum",
      "key": "pay_min",
      "type": "number",
      "prefix": "$",
      "suffix": "",
      "hint": "The floor you will offer. Look up market rate on Indeed.com/salaries first."
    },
    {
      "label": "Pay range: maximum",
      "key": "pay_max",
      "type": "number",
      "prefix": "$",
      "suffix": "",
      "hint": "The ceiling you will offer for the right candidate."
    }
  ],
  "results": [
    {
      "label": "Annual Pay Range Spread",
      "key": "pay_spread",
      "formula": "pay_max - pay_min",
      "prefix": "$",
      "suffix": " spread",
      "benchmark": "A range of $3,000 to $8,000 is typical. If your spread is too narrow, you will lose good candidates to negotiation."
    }
  ]
}'::jsonb
FROM lessons WHERE slug = 'fhb-02-role-clarity-framework';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Role Defined",
  "highlights": [
    "If you cannot write down what success looks like at day 30, you cannot hire for the role. Define the outcome first.",
    "Three to five core responsibilities only. More than five means you are trying to hire two people at once.",
    "The role definition also becomes your interview scorecard and your 30-day review baseline."
  ],
  "next_steps": [
    "Complete every field in the Role Definition Worksheet above. Do not skip the pay range.",
    "Write down the 30-day success outcomes for each responsibility before moving on.",
    "Move to Lesson 3 to separate must-have requirements from nice-to-haves."
  ]
}'::jsonb
FROM lessons WHERE slug = 'fhb-02-role-clarity-framework';


-- ----------------------------------------------------------------------------
-- LESSON 3: Candidate Requirements
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'fhb-03-candidate-requirements',
  'Candidate Requirements',
  'Separating must-haves from nice-to-haves stops you from disqualifying good candidates over the wrong things or hiring someone who looks good on paper but cannot do the job.',
  'crew',
  3,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Must-Haves, Nice-to-Haves, and Deal Breakers",
  "body": "Every requirement you add to a job post removes a qualified applicant. Most owners write job posts that read like a wish list, then wonder why only 3 people applied. The more requirements you stack, the fewer people can meet them all.\n\nThere are three categories of requirements:\n\n**Must-haves: non-negotiable.**\nThese are the requirements a candidate must meet or they cannot do the job. Valid driver''s license for a field role. Able to lift 60 pounds for a roofing position. Minimum 2 years of [trade] experience for a lead position. Write no more than 4 must-haves. If you list 10, you do not know what is actually required.\n\n**Nice-to-haves: bonus, not required.**\nThings that would help but are not blocking. OSHA 10 certification is a nice-to-have for a helper role. Spanish-speaking is a nice-to-have in some markets. If a candidate has none of your nice-to-haves but hits all your must-haves, they are still in the running.\n\n**Deal breakers: automatic disqualifiers.**\nThese remove a candidate immediately, no exceptions. Cannot pass a background check for a role that requires it. No valid driver''s license for a vehicle-operating role. Specific conviction types that are legally relevant to the work.\n\n**Where to find candidates:**\n- Indeed: All roles, especially field. Free to post. Respond to applicants within 2 hours. Speed wins.\n- Facebook Jobs and local community groups: Field, production, entry-level. Free. Ask your crew to share.\n- Crew referral: Best quality. Pay a $250 to $500 referral bonus. Your best crew knows other good workers.\n- LinkedIn: Sales, office, management only. Overkill for field labor.\n- Staffing agency: Use when desperate or for seasonal surge. 15 to 20% of salary, expensive long-term.\n\nThe best hire you will ever make comes through someone who already works for you. Tell every crew member you are hiring before you post anywhere.",
  "key_takeaway": "Four must-haves maximum. Every extra requirement is a candidate filter that may be cutting off your best applicant."
}'::jsonb
FROM lessons WHERE slug = 'fhb-03-candidate-requirements';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'summary', '{
  "title": "Requirements Clarified",
  "highlights": [
    "Must-haves are the short list. Four or fewer. Nice-to-haves are bonuses, not gates.",
    "Tell your crew you are hiring before posting anywhere. The referral bonus pays for itself on day one.",
    "Post on Thursday or Friday. Applications peak on weekends. Repost every 7 days if you have not found your candidate."
  ],
  "next_steps": [
    "Write your 4 must-haves, 3 nice-to-haves, and 3 deal breakers before writing the job post.",
    "Tell every crew member today that you are hiring and what the referral bonus is.",
    "Move to Lesson 4 to build your interview scorecard before you talk to a single candidate."
  ]
}'::jsonb
FROM lessons WHERE slug = 'fhb-03-candidate-requirements';


-- ----------------------------------------------------------------------------
-- LESSON 4: Interview Scorecard
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'fhb-04-interview-scorecard',
  'Interview Scorecard',
  'Run every candidate through the same seven questions and score each answer 1 to 5. Do not hire anyone who scores below a 3 on a must-have category. The scorecard removes gut-feel hiring.',
  'crew',
  4,
  9
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Seven Questions That Tell You Everything",
  "body": "Most bad hires happen because the interviewer liked the candidate. The interview was smooth. The person was confident. They gave good answers to every question. And then day 14 hit and you realized you hired someone who interviews well, not someone who works well.\n\nThe scorecard fixes this. You run every candidate through the same seven questions and score each answer from 1 to 5. Anyone who scores below a 3 on a must-have category is out, regardless of how much you liked them.\n\n**The seven categories and questions:**\n\n**1. Reliability:** ''Tell me about a time you had to show up when it was hard. What did you do?''\nYou are listening for specifics. Vague answers about ''always being there'' are not answers. A specific story about showing up during a family emergency or after a difficult week is an answer.\n\n**2. Coachability:** ''What is something a manager taught you that changed how you work?''\nSomeone who cannot name a single thing they learned from a manager cannot be developed.\n\n**3. Work Ethic:** ''Walk me through your busiest week at your last job. How did you handle it?''\nYou want to hear what busy means to them. If their definition of a hard week would be your average Tuesday, take note.\n\n**4. Culture Fit:** ''What kind of environment brings out your best? What kills your energy?''\nListen for incompatibilities with how your business actually runs.\n\n**5. Role Fit:** ''Describe a day at work where you felt like you were exactly in your element.''\nThe answer tells you what they are built for. It should match the role you are filling.\n\n**6. Red Flag Check:** ''Why did you leave your last two jobs?''\nListen for blame and victim mindset. Someone who blames every previous employer for their problems will eventually blame you too.\n\n**7. Ownership:** ''Tell me about a mistake you made at work. What happened and what did you do?''\nSomeone who cannot name a mistake either lacks self-awareness or is lying to you.",
  "key_takeaway": "Score every candidate the same way on the same questions. Do not hire anyone below a 3 on a must-have. The scorecard removes the gut-feel bias that produces bad hires."
}'::jsonb
FROM lessons WHERE slug = 'fhb-04-interview-scorecard';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Candidate Interview Scorecard",
  "description": "Score this candidate on each category after the interview. 1 = weak, 3 = acceptable, 5 = strong. Do not hire anyone below a 3 in Reliability or Role Fit for a field position.",
  "fields": [
    {
      "label": "Reliability score (1-5)",
      "key": "score_reliability",
      "type": "number",
      "prefix": "",
      "suffix": "/5",
      "hint": "Did they give a specific story about showing up when it was hard? Vague answers score 1-2."
    },
    {
      "label": "Coachability score (1-5)",
      "key": "score_coachability",
      "type": "number",
      "prefix": "",
      "suffix": "/5",
      "hint": "Could they name something a manager taught them that changed how they work?"
    },
    {
      "label": "Work Ethic score (1-5)",
      "key": "score_work_ethic",
      "type": "number",
      "prefix": "",
      "suffix": "/5",
      "hint": "Does their definition of a hard week match the actual demands of this job?"
    },
    {
      "label": "Culture Fit score (1-5)",
      "key": "score_culture",
      "type": "number",
      "prefix": "",
      "suffix": "/5",
      "hint": "Is there any visible incompatibility with how your business actually runs?"
    },
    {
      "label": "Role Fit score (1-5)",
      "key": "score_role_fit",
      "type": "number",
      "prefix": "",
      "suffix": "/5",
      "hint": "Does their ''in my element'' story match what this job actually requires?"
    },
    {
      "label": "Red Flag Check score (1-5)",
      "key": "score_red_flags",
      "type": "number",
      "prefix": "",
      "suffix": "/5",
      "hint": "Did they blame former employers? Victim mindset answers score 1-2."
    },
    {
      "label": "Ownership score (1-5)",
      "key": "score_ownership",
      "type": "number",
      "prefix": "",
      "suffix": "/5",
      "hint": "Could they name a real mistake and describe what they did about it?"
    }
  ],
  "results": [
    {
      "label": "Total Interview Score",
      "key": "total_score",
      "formula": "score_reliability + score_coachability + score_work_ethic + score_culture + score_role_fit + score_red_flags + score_ownership",
      "prefix": "",
      "suffix": "/35",
      "benchmark": "Strong Yes: 28-35. Maybe: 20-27. No: below 20. Do not hire a Maybe for a field role unless you have no other candidates and you know which gaps you are accepting."
    }
  ]
}'::jsonb
FROM lessons WHERE slug = 'fhb-04-interview-scorecard';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Candidate Scored",
  "highlights": [
    "The scorecard exists so you do not hire someone because you liked them in a 45-minute conversation.",
    "Below a 3 on Reliability or Role Fit is a hard no, regardless of total score.",
    "A Strong Yes (28 to 35) still goes through reference checks. The interview is not the final word."
  ],
  "next_steps": [
    "Print or save the scorecard before your next interview. Fill it in during the conversation, not after.",
    "If two candidates score within 5 points of each other, check references on both before deciding.",
    "Move to Lesson 5 to learn how to run reference checks that actually surface the truth."
  ]
}'::jsonb
FROM lessons WHERE slug = 'fhb-04-interview-scorecard';


-- ----------------------------------------------------------------------------
-- LESSON 5: Reference Checks
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'fhb-05-reference-checks',
  'Reference Checks',
  'Call at least two references. Do not skip this step. What a reference hesitates on tells you as much as what they say. The pause before ''would you rehire them'' is an answer.',
  'crew',
  5,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Seven Reference Questions That Tell You the Truth",
  "body": "Most owners skip reference checks because they liked the interview. That is exactly backwards. The interview is where candidates show you their best self. References show you what they are actually like to manage.\n\nCall at least two references. Former supervisors are preferred. Colleagues are a second choice. Personal references are nearly useless.\n\n**Seven questions to ask every reference:**\n\n1. ''How long did you work with [candidate] and in what capacity?'' Establish context and credibility.\n\n2. ''What was [candidate] responsible for in that role?'' Cross-check what the candidate told you.\n\n3. ''How would you describe their reliability and follow-through?'' Listen for specific language. ''Very reliable'' with no story is a polite non-answer.\n\n4. ''What did they do exceptionally well?'' The energy in this answer tells you what the candidate was built for.\n\n5. ''Where did they struggle or need the most support?'' If the reference says ''I honestly cannot think of anything,'' that is a rehearsed non-answer. Ask: ''Think back to their toughest period. What was happening?''\n\n6. ''Would you rehire them if you had the chance? Why or why not?'' The most important question. If there is a pause before yes, treat that pause as a no. Hesitation is an answer.\n\n7. ''Is there anything I should know that would help me manage them well?'' Open-ended. Some references will use this to tell you what they could not say to the earlier questions.\n\n**What to listen for:**\nSpeed of answers. Pauses on the rehire question. Qualifiers like ''as long as you manage him closely'' or ''she needs clear direction.'' These are warnings wrapped in professional language.",
  "key_takeaway": "The pause before a reference answers the rehire question tells you more than any yes or no. Hesitation is a no."
}'::jsonb
FROM lessons WHERE slug = 'fhb-05-reference-checks';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'summary', '{
  "title": "References Checked",
  "highlights": [
    "Two references minimum, both former supervisors if possible. Personal references tell you nothing useful.",
    "The rehire question is the most important one. A pause is an answer.",
    "Qualifiers like ''needs close management'' or ''does best with clear structure'' are warnings in professional language."
  ],
  "next_steps": [
    "Call references before making any offer. Do not skip this step because you like the candidate.",
    "If both references pause on the rehire question, do not hire that person regardless of interview score.",
    "Move to Lesson 6 to learn how to make a fast, professional offer."
  ]
}'::jsonb
FROM lessons WHERE slug = 'fhb-05-reference-checks';


-- ----------------------------------------------------------------------------
-- LESSON 6: Making the Offer
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'fhb-06-making-the-offer',
  'Making the Offer',
  'Move fast. Good candidates have options. A verbal offer followed by a written offer letter the same day closes the gap between handshake and hire. Most small businesses lose good candidates in this window.',
  'crew',
  6,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Speed and Clarity Win Good Candidates",
  "body": "Good candidates are not waiting around. They are talking to two or three employers at the same time. The company that moves from interview to written offer fastest wins. Most small businesses lose candidates in the gap between decision and paperwork.\n\n**The process:**\n\n**Step 1: Verbal offer the same day as the final interview.**\nCall the candidate personally. Do not email a verbal offer.\n\nScript: ''[Name], I wanted to call you personally. We want to offer you the [job title] position. The pay is [amount], and we would like you to start [date]. Do you have any questions before we send the paperwork?''\n\nGive them time to ask questions. Then confirm the start date.\n\n**Step 2: Written offer letter within 24 hours.**\nThe offer letter must include: job title and department, pay rate (hourly, salary, or commission), pay schedule (weekly or bi-weekly), start date, full-time or part-time hours, who they report to, any contingencies such as background check, and a deadline to accept (24 to 48 hours).\n\nDo not send a letter that is missing the pay schedule or start date. Incomplete paperwork signals a disorganized company.\n\n**Step 3: Pre-start communication.**\n- Day minus 7: Send the offer letter. Confirm start date, time, location, dress code.\n- Day minus 3: Text or call: ''We are excited to have you start on [day]. Any questions?''\n- Day minus 1: Send first-day instructions: where to park, who to ask for, what to bring.\n\nThe pre-start communication is not extra effort. It is the difference between a candidate who shows up confident on day one and a candidate who shows up anxious and already second-guessing the decision.",
  "key_takeaway": "Verbal offer the same day as the final interview. Written letter within 24 hours. Pre-start texts at day minus 3 and day minus 1. Speed closes candidates."
}'::jsonb
FROM lessons WHERE slug = 'fhb-06-making-the-offer';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'summary', '{
  "title": "Offer Process Set",
  "highlights": [
    "Every day between final interview and written offer is a day the candidate is still talking to your competitors.",
    "The offer letter must include pay rate, pay schedule, start date, hours, and reporting structure. Missing fields signal disorganization.",
    "Pre-start communication at day minus 3 and day minus 1 reduces first-day no-shows significantly."
  ],
  "next_steps": [
    "Create your offer letter template today. Include all required fields. Save it so you can fill it in within 2 hours of making a verbal offer.",
    "Write your verbal offer script and save it in your phone. You should be able to make the call within 5 minutes of deciding.",
    "Move to Lesson 7 to build the 30-day onboarding plan that keeps the person you hired."
  ]
}'::jsonb
FROM lessons WHERE slug = 'fhb-06-making-the-offer';


-- ----------------------------------------------------------------------------
-- LESSON 7: 30-Day Onboarding Plan
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'fhb-07-30-day-onboarding',
  '30-Day Onboarding Plan',
  'Most new hires quit in the first 30 days because nobody made them feel like they belonged or knew what was expected. This lesson gives you a four-week plan that prevents that.',
  'crew',
  7,
  10
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The First 30 Days Are Not Orientation. They Are the Job.",
  "body": "A new hire forms their opinion of your company in the first two weeks. If those weeks are disorganized, they assume the whole company is disorganized. If nobody greets them on day one, they feel like an afterthought. If there is no one to answer their questions, they stop asking and start making mistakes quietly.\n\nMost new hires who quit in the first 30 days do not quit because the job was bad. They quit because the company made them feel like they hired into chaos.\n\n**Four-week plan:**\n\n**Week 1 (Days 1 to 5) - Owner or Manager:**\nOffice or site tour. Introduction to the full team. Review the written job description together. Payroll and paperwork setup. Safety and policy overview. End-of-week one-on-one check-in: ''What is going well? What is confusing?''\n\n**Week 2 (Days 6 to 10) - Assigned Mentor:**\nShadow an experienced team member. Learn core tools and systems. Ask questions daily. Review the SOPs that apply to this role. End-of-week check-in.\n\n**Week 3 (Days 11 to 15) - Manager:**\nBegin real tasks with oversight. Daily debrief with manager. Identify any training gaps that appeared. Confirm the 30-day success metrics are fully understood by the new hire.\n\n**Week 4 (Days 16 to 30) - Manager:**\nPerforming independently. Manager checks in twice per week. 30-day review meeting at the end of the month.\n\n**30-day check-in questions:**\n- What is going well so far?\n- Where do you feel uncertain or undertrained?\n- What would make your job easier right now?\n- Are you getting what you need from your manager?\n- Are you clear on what success looks like in your role?\n\nLet them answer first. Do not lead the witness.",
  "key_takeaway": "A disorganized first week teaches the new hire that your company is disorganized. The onboarding plan is the first signal of how the business runs."
}'::jsonb
FROM lessons WHERE slug = 'fhb-07-30-day-onboarding';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'summary', '{
  "title": "Onboarding Plan Built",
  "highlights": [
    "Week 1 is the most important. Run it yourself or assign a dedicated mentor. Do not let a new hire wander.",
    "The 30-day check-in is not a performance review. It is a two-way conversation. Listen more than you talk.",
    "Set calendar reminders for Day 7, Day 30, Day 60, and Day 90 check-ins before the new hire starts. Not after."
  ],
  "next_steps": [
    "Block Day 1 morning on your calendar for the site tour and team intro. Do not delegate this the first time.",
    "Assign a mentor from your existing crew who the new hire can shadow in Week 2.",
    "Move to Lesson 8 to learn how to write a job post that attracts the right person before the process starts."
  ]
}'::jsonb
FROM lessons WHERE slug = 'fhb-07-30-day-onboarding';


-- ----------------------------------------------------------------------------
-- LESSON 8: Writing a Job Post That Works
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'fhb-08-writing-the-job-post',
  'Writing a Job Post That Works',
  'Most job posts fail because they describe the company, not the opportunity. A good job post talks to the candidate: what they will be doing, what success looks like, and why this is worth their time.',
  'crew',
  8,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Five Sections. One Rule.",
  "body": "Most job posts read like a government form. Long lists of requirements, vague company descriptions, and ''competitive pay'' with no number attached. The candidate reads it and moves on.\n\nA job post that works talks to the candidate. It tells them what they will actually be doing, what success looks like, and why this company is worth their time. It sounds like it was written by a human who knows the job, not a template that was pasted in from 2012.\n\n**The five sections every job post needs:**\n\n**1. Hook Line**\nThe first sentence. Make it about what is in it for them, not who you are.\nExample: ''We are looking for a reliable crew lead who takes pride in their work and wants a long-term home.''\nNot: ''[Company Name] is a growing roofing company established in 2008...''\n\n**2. What You Will Do**\n3 to 5 bullet points. Specific tasks. Not ''various duties as assigned.'' What will their actual day look like? What does a Tuesday morning look like for this person?\n\n**3. What We Are Looking For**\nMust-haves only. Under 5 bullets. Every requirement you add removes a qualified applicant. If valid driver''s license is not required, do not list it.\n\n**4. What We Offer**\nPay range (always include it), schedule, benefits, and 1 to 2 things that make your company a good place to work. Hiding the pay range wastes everyone''s time including yours.\n\n**5. How to Apply**\nGive them a specific action. ''Text [number] with your name and experience'' outperforms ''submit resume online'' every time.\n\n**Four posting rules:**\n- Always include pay range. Hiding it filters out good candidates and attracts people who will leave when they hear the number.\n- Write at a 7th-grade reading level. Short sentences. No corporate language.\n- Post on Thursday or Friday. Applications peak on weekends.\n- Repost every 7 days. Algorithms favor fresh posts.",
  "key_takeaway": "Include the pay range. Always. Every requirement you add is a filter. Every line that sounds corporate drives candidates away."
}'::jsonb
FROM lessons WHERE slug = 'fhb-08-writing-the-job-post';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'summary', '{
  "title": "Job Post Framework Ready",
  "highlights": [
    "The hook line is about the candidate, not the company. Flip the first sentence and applications go up.",
    "Pay range is required. Candidates who see ''competitive pay'' with no number assume the number is low.",
    "Post Thursday or Friday. Repost every 7 days. Algorithms treat fresh posts better than old ones."
  ],
  "next_steps": [
    "Write your job post using the five-section structure. Read it out loud. If it sounds like a form, rewrite it.",
    "Post on Thursday and share it in your personal social media and local community groups.",
    "Move to Lesson 9 to learn how to screen resumes fast without missing good candidates."
  ]
}'::jsonb
FROM lessons WHERE slug = 'fhb-08-writing-the-job-post';


-- ----------------------------------------------------------------------------
-- LESSON 9: Screening Resumes and the Phone Screen
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'fhb-09-screening-resumes',
  'Screening Resumes and the Phone Screen',
  'Spend 60 seconds per resume. Eliminate the obvious nos, identify the maybes worth a 5-minute phone screen, and move the top candidates to in-person. Do not agonize over resumes.',
  'crew',
  9,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "60 Seconds Per Resume. Then Decide.",
  "body": "The goal of resume screening is not to find the perfect person. It is to eliminate obvious nos quickly and identify the maybes worth 5 minutes on the phone. You are not making a hiring decision at the resume stage.\n\n**The 60-second screen: six checks in order:**\n\n**1. Can they physically do this job?** Do they have any relevant experience at all?\n\n**2. Job hopping check.** More than 3 jobs in 3 years is a yellow flag. Not an auto-reject. Ask about it in the phone screen.\n\n**3. Gap check.** A 6-month gap is worth asking about. A 3-year gap needs explanation.\n\n**4. Specifics check.** Vague resumes with no numbers or results are a warning sign. ''Managed a team'' is not a result. ''Managed a 4-person crew completing 12 to 15 jobs per week'' is.\n\n**5. Application quality check.** Did they follow the instructions in your job post? ''Text your name and experience'' and they emailed a 3-page resume with a cover letter about their passion for roofing? That is a data point.\n\n**6. Make the call in 60 seconds.** Move forward, phone screen, or pass. Do not agonize.\n\n**The 5-minute phone screen (before the in-person interview):**\n\nUse this to eliminate candidates before you invest an hour in an in-person interview. Three questions only:\n\nQ1: ''Tell me about your last job and why you left.''\nQ2: ''What are you looking for in your next role?''\nQ3: ''What questions do you have about this position?''\n\nIf they cannot clearly answer why they left their last job, or if they speak badly about their former employer, pass. You just learned everything you need to know without investing more time.",
  "key_takeaway": "Screen resumes in batches: 30 minutes, twice a week. Never one at a time. The phone screen is your filter before the in-person. Use it."
}'::jsonb
FROM lessons WHERE slug = 'fhb-09-screening-resumes';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'summary', '{
  "title": "Screening System Built",
  "highlights": [
    "60 seconds per resume. Yellow flags go to phone screen. Red flags are a pass. You are not agonizing here.",
    "The phone screen saves an hour of in-person time for every 3 candidates it eliminates.",
    "Job hopping and employment gaps are yellow flags, not red flags. Ask about them. Let the candidate explain."
  ],
  "next_steps": [
    "Create a simple Yes / Maybe / No scoring sheet for resumes. Use it consistently.",
    "Schedule resume review in two 30-minute blocks per week, not one resume at a time.",
    "Move to Lesson 10 to learn about setting pay that actually attracts good candidates."
  ]
}'::jsonb
FROM lessons WHERE slug = 'fhb-09-screening-resumes';


-- ----------------------------------------------------------------------------
-- LESSON 10: Compensation, Early Warning Signs, and Parting Ways
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'fhb-10-pay-warnings-exits',
  'Pay, Warning Signs, and Exits',
  'Three essential pieces of the hiring system: setting pay that attracts good candidates, recognizing when a hire is not working in the first 30 days, and how to part ways professionally when it comes to that.',
  'crew',
  10,
  11
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Underpaying Is the Most Expensive Hiring Mistake",
  "body": "A $2-per-hour gap drives good candidates to your competitor and keeps you stuck with whoever is left. Underpaying is not saving money. It is a recurring filter that removes your best applicants before you ever meet them.\n\n**How to find market rate for your role:**\n\n1. Go to Indeed.com/salaries. Search for your role in your city. Note the median and the 75th percentile.\n2. Check ZipRecruiter and Glassdoor for the same search. Average the three results.\n3. Ask your suppliers or trade contacts what they are paying for similar roles.\n4. Look at competitor job posts. Many now include pay ranges.\n5. Set your offer at market rate minimum. Target the 60th to 70th percentile to attract better candidates.\n\nIf a candidate asks for 20% more than your range, do not auto-reject. Ask what is driving the number. Sometimes it is negotiable. Sometimes it reveals a skill gap you have not discovered yet.\n\n**Early warning signs in the first 30 days:**\n\nBad hires announce themselves early. Most are visible by day 14 to 21. The mistake is waiting until month 6 to act on what you knew in week 3.\n\nReliability: Late more than once in the first 2 weeks. Calls out without notice. Hard to reach.\nCoachability: Defensive when corrected. Says ''that is not how we did it at my last job.''\nEngagement: Not asking questions. Doing minimum work. No energy about the role.\nQuality: Recurring mistakes. Same errors after correction. Cutting corners.\nTeam Fit: Other crew members are complaining. Creating tension.\nTransparency: Hiding mistakes instead of reporting them. Stories do not add up.\n\nThe moment you think ''this is not working,'' document it. Write down the date, what happened, and what you said to them. Documentation is not about firing. It is about being fair to both of you.\n\n**When you have to let someone go:**\n\n1. Document everything first. Dates, incidents, prior conversations. Factual, not emotional.\n2. Know your state''s at-will employment rules and final pay timing requirements.\n3. End of the week, private space, 15 to 30 minutes. Never before a holiday or on a Monday.\n4. Keep it short: ''We have decided to end your employment, effective today. This is your final paycheck.''\n5. Do not offer hope if there is none.\n6. Have their final check ready or know your state''s timeline.\n7. Collect company property immediately. Keys, uniforms, tools, access credentials.\n8. Communicate to the team the same day: ''[Name] is no longer with the company. We wish them well.'' Nothing more.\n\n**What not to do:**\n- Do not delay once you have decided. Act within 5 business days. Every day you wait makes it harder.\n- Do not apologize excessively. It signals you are not sure of your decision.\n- Do not fire in anger. If you are emotional, wait 24 hours.",
  "key_takeaway": "Pay market rate or above. Recognize warning signs by day 21, not day 90. When you have decided to let someone go, act within 5 business days. Delay costs the whole team."
}'::jsonb
FROM lessons WHERE slug = 'fhb-10-pay-warnings-exits';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Market Rate Research",
  "description": "Look up what the market is paying for the role you are filling before setting your offer.",
  "fields": [
    {
      "label": "Indeed median salary for this role in your city",
      "key": "indeed_median",
      "type": "number",
      "prefix": "$",
      "suffix": "/yr",
      "hint": "Go to Indeed.com/salaries. Search your role and city. Write the median number."
    },
    {
      "label": "ZipRecruiter average for this role in your city",
      "key": "zip_avg",
      "type": "number",
      "prefix": "$",
      "suffix": "/yr",
      "hint": "Search ziprecruiter.com/Salaries for the same role and location."
    },
    {
      "label": "Glassdoor median for this role in your city",
      "key": "glassdoor_median",
      "type": "number",
      "prefix": "$",
      "suffix": "/yr",
      "hint": "Search glassdoor.com/Salaries for the same role and location."
    },
    {
      "label": "Your planned offer",
      "key": "planned_offer",
      "type": "number",
      "prefix": "$",
      "suffix": "/yr",
      "hint": "What you plan to offer. Should be at or above the market average."
    }
  ],
  "results": [
    {
      "label": "Market Average",
      "key": "market_avg",
      "formula": "(indeed_median + zip_avg + glassdoor_median) / 3",
      "prefix": "$",
      "suffix": "/yr",
      "benchmark": "Your offer floor. Below this number you are filtering out your best applicants before they apply."
    },
    {
      "label": "Offer vs. Market",
      "key": "offer_vs_market",
      "formula": "(planned_offer - market_avg) / market_avg * 100",
      "prefix": "",
      "suffix": "%",
      "benchmark": "Target: 0% to 20% above market. Negative numbers mean you are below market rate."
    }
  ]
}'::jsonb
FROM lessons WHERE slug = 'fhb-10-pay-warnings-exits';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "First Hire Blueprint Complete",
  "highlights": [
    "Pay at or above market rate. A $2 per hour gap below market is a permanent filter on your applicant pool.",
    "Bad hires announce themselves by day 21. Document incidents the moment they happen, not after you have decided to act.",
    "The six-step system: Role Clarity, Candidate Requirements, Interview Scorecard, Reference Checks, Offer, Onboarding. Skipping steps produces the wrong-person tax."
  ],
  "next_steps": [
    "Look up market rate for your next role on Indeed, ZipRecruiter, and Glassdoor today. Write the number down.",
    "Create a Performance Note template: one page, date, incident, conversation had, employee response. Keep one for every active employee.",
    "If you have someone who is not working and you know it, write down what has happened and what conversations you have had. You are closer to a decision than you think."
  ]
}'::jsonb
FROM lessons WHERE slug = 'fhb-10-pay-warnings-exits';
