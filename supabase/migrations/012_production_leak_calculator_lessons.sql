-- ============================================================
-- Migration: 012_production_leak_calculator_lessons.sql
-- Pillar: leak
-- Lesson count: 12
-- PDF source: SLO-Production-Leak-Calculator.pdf (29 pages)
-- ============================================================
-- SCHEMA ASSUMPTIONS (Jared: verify before running):
--   1. uuid-ossp extension is enabled (uuid_generate_v4() used throughout)
--   2. lessons table exists with columns:
--        id uuid default uuid_generate_v4() primary key,
--        slug text unique not null,
--        title text not null,
--        description text,
--        pillar_key text not null,
--        position integer,
--        duration_minutes integer,
--        created_at timestamptz default now()
--   3. lesson_steps table exists with columns:
--        id uuid default uuid_generate_v4() primary key,
--        lesson_id uuid references lessons(id) on delete cascade,
--        position integer not null,
--        step_type text not null,
--        content jsonb not null default '{}',
--        created_at timestamptz default now()
--   4. pillar_key 'leak' must already exist in your pillars reference
--      (or no FK constraint on that column -- confirm either way)
--   5. This migration assumes 011_overhead_calculator_lessons.sql has already
--      run. No dependency between data, but position integers assume separate
--      pillar sequences. If lessons.position is globally scoped rather than
--      per-pillar, these positions may need to be offset. Confirm with Jared.
-- ============================================================

-- ============================================================
-- LESSON 1: What a Production Leak Is
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'plc-01-what-is-a-production-leak',
  'What a Production Leak Is and Why You Have One',
  'A production leak is money that leaves your business between the time a job is sold and the time it is paid. It does not show up on an invoice. This lesson explains what it is and how to use the calculator.',
  'leak',
  1,
  6
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Money That Disappears Without a Line Item",
  "body": "A production leak is money that leaves your business between the time a job is sold and the time it is paid.\n\nIt does not show up on an invoice because it never gets billed. It does not show up on a P&L as a line item because it looks like the normal cost of doing business. But it is real money. For most roofing and restoration contractors doing $1.5M-$4M, it adds up to more than they would believe.\n\nMost contractors who complete this calculator find between **$40,000 and $180,000 in annual production leaks.** Whatever your number is: it is fixable.\n\n**The seven leaks in this calculator are the most common ones in the field:**\n\n1. Materials Not Returned\n2. Jobs Running Longer Than Estimated\n3. No Materials / Wrong Materials Delay\n4. Paying List Price on Materials\n5. Missed Change Orders\n6. Material Overorders\n7. Callbacks\n\nThese are not exotic problems. They happen on almost every job, at almost every company, because no one built a system to stop them.\n\n**How to use this calculator:**\n- Go through each of the seven leak categories in order\n- Fill in your actual numbers. Be honest. The result only helps if it is real.\n- Each category calculates to an annual leak dollar amount\n- At the end, identify your top 3 leaks. Those become your priority fix list.\n- Fix the first priority completely before moving to the second. One thing done all the way beats three things started.",
  "key_takeaway": "Production leaks are recoverable margin. Every dollar in your total is money that belongs to your business but is currently walking out the door."
}'::jsonb
FROM lessons WHERE slug = 'plc-01-what-is-a-production-leak';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'summary', '{
  "title": "Before You Start Calculating",
  "highlights": [
    "Production leaks are margin that leaves without showing on an invoice or P&L line.",
    "Most contractors find $40,000-$180,000 in annual leaks when they run through all seven categories.",
    "Every leak in this calculator is fixable. None of them require software or major capital investment.",
    "Fix one priority completely before starting the next. Partial fixes on multiple leaks produce less than a full fix on one."
  ],
  "next_steps": [
    "Pull your job data for the last 90 days before starting Lesson 2.",
    "Note your average jobs per month and average job value. You will need these numbers throughout.",
    "Move to Lesson 2: Leak 1 - Materials Not Returned."
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-01-what-is-a-production-leak';


-- ============================================================
-- LESSON 2: Leak 1 - Materials Not Returned
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'plc-02-materials-not-returned',
  'Leak 1: Materials Not Returned',
  'Leftover shingles, unopened underlayment, and unused materials sitting in a yard instead of going back to the supplier as a credit. Calculate your annual leak and learn the fix.',
  'leak',
  2,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "What It Is and Why It Keeps Happening",
  "body": "**What it is:** Leftover materials from a completed job that never make it back to the supplier for credit. Partial squares of shingles, unopened bundles, unused underlayment: sitting in a yard or on a truck instead of returning as a credit.\n\n**Why it keeps happening:** There is no one assigned to check the truck and job site at closeout. No return process exists. The crew moves to the next job and the materials go wherever they go.\n\nThis leak is entirely preventable. The fix does not require software. It requires a single form and one clear policy.\n\n**The Fix: Mandatory Job Closeout Checklist**\n\nCreate a one-page Job Closeout Checklist that assigns the foreman responsibility for returning all unused materials within 24 hours of job completion. No crew moves to the next job until the checklist is signed.\n\n**The system to build:**\n- Job Closeout Checklist: one page, paper or digital, includes a materials section\n- Material Return Log: tracks what was returned, what was discarded, and credit amount\n- Policy: materials must be returned within 24 hours or logged as non-returnable waste\n- Supplier relationship: confirmed return credit process in writing with your primary supplier\n\n**Implementation timeline:** 7-10 days to build and launch. Day 1 action: create a one-page Job Closeout Checklist, print 20 copies, put them in every crew truck by end of week.\n\n**What done looks like:**\n- Every completed job has a signed closeout checklist on file\n- Supplier credits appear as a line item on your monthly invoice\n- Foreman knows exactly what is returnable vs. non-returnable before leaving every job",
  "key_takeaway": "No return process means materials pile up in your yard and the credit stays with your supplier. A one-page checklist with a 24-hour return policy fixes this in 7-10 days."
}'::jsonb
FROM lessons WHERE slug = 'plc-02-materials-not-returned';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Leak 1: Materials Not Returned - Annual Calculation",
  "description": "Enter your actual numbers to calculate how much this leak costs you per year. Be honest. The result only helps if it reflects reality.",
  "fields": [
    {"label": "Jobs Completed Per Month", "key": "jobs_per_month", "type": "number", "prefix": "", "suffix": " jobs", "hint": "Your actual average monthly job completions from the last 90 days."},
    {"label": "Percentage of Jobs with Unreturned Materials", "key": "pct_with_issue", "type": "number", "prefix": "", "suffix": "%", "hint": "Estimate honestly. If you have no closeout process, this is often 40-70%."},
    {"label": "Average Value of Unreturned Materials Per Job", "key": "avg_value_per_job", "type": "number", "prefix": "$", "suffix": "", "hint": "Think about partial bundles, leftover underlayment, unused ice shield. $150-$400 is common."}
  ],
  "results": [
    {"label": "Annual Leak: Materials Not Returned", "key": "leak1_annual", "formula": "jobs_per_month * 12 * (pct_with_issue / 100) * avg_value_per_job", "prefix": "$", "suffix": "", "benchmark": "Record this number. Transfer it to the summary in Lesson 9."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-02-materials-not-returned';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Leak 1 Calculated",
  "highlights": [
    "This leak is 100% recoverable. The materials exist. The credit system exists. You just need the process.",
    "The fix is a one-page Job Closeout Checklist and a 24-hour return policy. No software required.",
    "Implementation timeline: 7-10 days. Day 1: create the checklist and put copies in every crew truck."
  ],
  "next_steps": [
    "Write down your Leak 1 annual total. You will transfer it to the summary in Lesson 9.",
    "Move to Lesson 3: Leak 2 - Jobs Running Longer Than Estimated."
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-02-materials-not-returned';


-- ============================================================
-- LESSON 3: Leak 2 - Jobs Running Longer Than Estimated
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'plc-03-jobs-running-long',
  'Leak 2: Jobs Running Longer Than Estimated',
  'Every extra day a crew spends on a job beyond the estimate is unbilled labor charged directly against your margin. If you estimated two days and it took three, that extra day came out of your profit.',
  'leak',
  3,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Silent Margin Drain",
  "body": "**What it is:** Every day a crew is on a job longer than the estimate is unbilled labor charged directly against your margin. If you estimated two days and it took three, that extra day came out of your profit, not the customer pocket.\n\n**Why it keeps happening:** Inaccurate estimating, material delays, scope creep with no change order, no per-job production target communicated to the crew, and no accountability when jobs run long.\n\n**The Fix: Per Job Production Target System**\n\nBuild a production target system where every crew receives a per-job production target before they start, and the foreman reports actual vs. estimated progress by end of each day. Any job running more than 10% over estimate triggers an automatic post-job review.\n\n**The system to build:**\n- Per Job Production Target Sheet: estimated completion divided by number of days = daily target\n- End-of-day check-in: foreman texts or calls \"Day X of Y: on track / off track\" by 4pm\n- Job Cost Report: captures estimated vs. actual labor hours per job\n- Post-job debrief process: any job 10%+ over estimate gets a 15-minute debrief\n- Estimating review: monthly review of your top 5 jobs that ran long\n\n**What done looks like:**\n- Foreman knows the per-job production target before the crew starts work each day\n- End-of-day check-ins happen on every active job\n- Estimating accuracy improves by at least 10% within 60 days of implementation\n\n**Day 1 action:** Pull your last 5 jobs. Calculate the average variance between estimated days and actual days. Write the number down.",
  "key_takeaway": "A foreman who does not know the production target cannot hit it. Communicate the target before the job starts, not after it runs long."
}'::jsonb
FROM lessons WHERE slug = 'plc-03-jobs-running-long';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Leak 2: Jobs Running Long - Annual Calculation",
  "description": "Enter your job duration data to calculate the annual cost of jobs running over estimate.",
  "fields": [
    {"label": "Average Estimated Job Duration (days)", "key": "estimated_days", "type": "number", "prefix": "", "suffix": " days", "hint": "Your typical job estimate in crew days."},
    {"label": "Average Actual Job Duration (days)", "key": "actual_days", "type": "number", "prefix": "", "suffix": " days", "hint": "Pull your last 10 completed jobs and calculate the real average."},
    {"label": "Fully Loaded Crew Cost Per Day (wages + fuel)", "key": "crew_cost_per_day", "type": "number", "prefix": "$", "suffix": "", "hint": "Total daily cost for a crew: wages, payroll taxes, fuel, and vehicle costs. Common range: $800-$2,000/day."},
    {"label": "Jobs Completed Per Year", "key": "jobs_per_year", "type": "number", "prefix": "", "suffix": " jobs", "hint": "Your annual job count. Monthly average x 12."}
  ],
  "results": [
    {"label": "Extra Days Per Job (actual minus estimated)", "key": "extra_days", "formula": "actual_days - estimated_days", "prefix": "", "suffix": " days", "benchmark": "Even 0.5 extra days per job at 200 jobs/year is 100 crew days of unbilled labor annually."},
    {"label": "Annual Leak: Jobs Running Long", "key": "leak2_annual", "formula": "extra_days * crew_cost_per_day * jobs_per_year", "prefix": "$", "suffix": "", "benchmark": "Record this number. Transfer it to the summary in Lesson 9."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-03-jobs-running-long';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Leak 2 Calculated",
  "highlights": [
    "The fix is a per-job production target communicated to the foreman before the job starts.",
    "End-of-day check-ins (on track or off track) catch overruns on day 2, not day 4.",
    "Implementation: 5-7 days to build. 30 days to see measurable improvement in job durations."
  ],
  "next_steps": [
    "Write down your Leak 2 annual total.",
    "Move to Lesson 4: Leak 3 - No Materials / Wrong Materials Delay."
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-03-jobs-running-long';


-- ============================================================
-- LESSON 4: Leak 3 - No Materials / Wrong Materials Delay
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'plc-04-materials-delay',
  'Leak 3: No Materials / Wrong Materials Delay',
  'A crew that arrives on-site and cannot work because materials have not been delivered costs you idle labor plus the ripple of delayed job completion. Calculate your annual idle time cost.',
  'leak',
  4,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Idle Crews Are the Most Expensive Thing in Your Business",
  "body": "**What it is:** Crew arrives on-site and cannot work because materials have not been delivered, the wrong materials were delivered, or materials are incomplete. A 4-person crew standing around for 2 hours costs you their labor plus the ripple of delayed job completion.\n\n**Why it keeps happening:** No materials checklist before jobs are scheduled. No confirmation step between sales and production handoff. Materials were ordered but delivery was not confirmed.\n\n**The Fix: Materials Confirmation Checkpoint**\n\nCreate a Materials Confirmation Checkpoint that verifies delivery before any crew is dispatched. The rule is simple: no confirmation, crew does not go. If materials are not confirmed by 7am, the crew is redeployed to a different job.\n\n**The system to build:**\n- Materials Confirmation Checklist: part of every job scheduling workflow\n- Dispatcher rule: materials confirmed 24 hours before job start, verified again morning-of\n- Supplier delivery window: written agreement with each supplier on confirmation process\n- Idle Time Log: tracks every incident, cause, hours lost, and dollar cost\n- Redeployment protocol: what the crew does if they arrive to an unready site\n\n**Implementation timeline:** 3-5 days. Day 1 action: call your top 2 material suppliers and ask: \"What is your process for confirming delivery the morning of a job?\"\n\n**What done looks like:**\n- Zero instances of crew arriving to a job site with no materials present\n- Every job has a materials confirmation timestamp before crew dispatch\n- Idle Time Log shows zero entries per month within 30 days of implementation",
  "key_takeaway": "No confirmation step means you are dispatching crews on faith. A single rule, materials confirmed or crew does not go, eliminates this leak in under a week."
}'::jsonb
FROM lessons WHERE slug = 'plc-04-materials-delay';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Leak 3: Materials Delay - Annual Calculation",
  "description": "Calculate the annual cost of crew idle time from materials delivery failures.",
  "fields": [
    {"label": "Times Per Month Crew Arrives With No Materials", "key": "incidents_per_month", "type": "number", "prefix": "", "suffix": " incidents", "hint": "How many times per month does a crew show up and cannot start due to materials? Be honest."},
    {"label": "Hours of Idle Crew Time Per Incident", "key": "idle_hours", "type": "number", "prefix": "", "suffix": " hours", "hint": "How many crew-hours are wasted per incident? Average across all crew members present."},
    {"label": "Fully Loaded Crew Cost Per Hour", "key": "crew_cost_per_hour", "type": "number", "prefix": "$", "suffix": "", "hint": "Total hourly cost per crew member including wages, taxes, and benefits. Typical range: $25-$50/hour per person."}
  ],
  "results": [
    {"label": "Annual Leak: Materials Delay", "key": "leak3_annual", "formula": "incidents_per_month * 12 * idle_hours * crew_cost_per_hour", "prefix": "$", "suffix": "", "benchmark": "This number does not include the cost of delayed job completion or rescheduling. The true cost is higher."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-04-materials-delay';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Leak 3 Calculated",
  "highlights": [
    "The fix is a single rule: no materials confirmation, crew does not dispatch.",
    "Call your top 2 suppliers today and establish a morning confirmation process. This takes one phone call.",
    "Start an Idle Time Log immediately. The act of tracking it usually reduces incidents within two weeks."
  ],
  "next_steps": [
    "Write down your Leak 3 annual total.",
    "Move to Lesson 5: Leak 4 - Paying List Price on Materials."
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-04-materials-delay';


-- ============================================================
-- LESSON 5: Leak 4 - Paying List Price on Materials
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'plc-05-list-price-materials',
  'Leak 4: Paying List Price on Materials',
  'The difference between what you pay today and what you could pay with a real vendor relationship and consistent volume. Most roofing contractors have never formally negotiated with their primary supplier.',
  'leak',
  5,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Negotiation You Have Not Had",
  "body": "**What it is:** The difference between what you pay for materials today and what you could pay with a real vendor relationship and consistent volume. Most roofing contractors have never formally negotiated with their primary supplier.\n\n**Why it keeps happening:** Orders are placed job by job with no volume commitment. No one has sat down with the rep and asked. The relationship is transactional: they send an invoice, you pay it.\n\nMost suppliers will move 5-12% on pricing when asked directly with purchase history in hand.\n\n**The Fix: One Formal Negotiation Conversation**\n\nHave one formal negotiation conversation with your primary supplier. Come prepared with 12 months of purchase history and ask for a volume discount, early payment terms, and a free delivery threshold. Most suppliers will move 5-12% when asked directly.\n\n**The implementation steps:**\n1. Pull your last 12 months of materials purchases. Calculate your total annual spend per supplier.\n2. Get quotes from 2 competing suppliers for your top 5 material categories.\n3. Call your primary supplier rep and request a 20-minute phone call this week.\n4. Open with your purchase history: \"We spent $[X] with you last year. What can we do on price with that kind of volume?\"\n5. Ask specifically for: (1) volume discount, (2) early payment discount, (3) free delivery threshold.\n6. If they hesitate, mention your competitor quotes. You do not have to switch. Just let them know you have options.\n7. Document the new pricing in writing.\n8. Update your material cost assumptions in your estimating template immediately.\n\n**Timeline:** 10-14 days. The conversation itself can happen in 24 hours.\n\n**What done looks like:**\n- Documented discount percentage with primary supplier: at least 5%, ideally 8-12%\n- Updated material cost assumptions in your estimating template",
  "key_takeaway": "You are already spending the money. You just have not asked for a better rate. One phone call with 12 months of purchase history in hand typically moves 5-12% on pricing."
}'::jsonb
FROM lessons WHERE slug = 'plc-05-list-price-materials';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Leak 4: List Price on Materials - Annual Calculation",
  "description": "Calculate the annual savings available from negotiating with your primary supplier.",
  "fields": [
    {"label": "Current Monthly Materials Spend", "key": "monthly_materials_spend", "type": "number", "prefix": "$", "suffix": "", "hint": "Your average monthly spend on all roofing materials with your primary supplier."},
    {"label": "Conservative Negotiated Discount", "key": "negotiated_discount_pct", "type": "number", "prefix": "", "suffix": "%", "hint": "Be conservative. Use 5% if you have not negotiated before. The actual range is typically 5-12%."}
  ],
  "results": [
    {"label": "Annual Leak: List Price on Materials", "key": "leak4_annual", "formula": "monthly_materials_spend * 12 * (negotiated_discount_pct / 100)", "prefix": "$", "suffix": "", "benchmark": "At $50K/month in materials spend and a 7% discount, that is $42,000/year. This is one phone call."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-05-list-price-materials';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Leak 4 Calculated",
  "highlights": [
    "This is the highest-ROI action in the entire calculator. One phone call with purchase history in hand can recover tens of thousands per year.",
    "Most suppliers will move 5-12% on pricing when asked with volume history in hand.",
    "Document the new rate in writing and update your estimating template the same day."
  ],
  "next_steps": [
    "Write down your Leak 4 annual total.",
    "Pull your last 12 months of materials spend from your accounting software today.",
    "Move to Lesson 6: Leak 5 - Missed Change Orders."
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-05-list-price-materials';


-- ============================================================
-- LESSON 6: Leak 5 - Missed Change Orders
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'plc-06-missed-change-orders',
  'Leak 5: Missed Change Orders',
  'Scope changes that happen on the job that never get billed. Rotted deck boards, extra ice shield, unexpected disposal costs. All real work. None of it billed.',
  'leak',
  6,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Every Unbilled Extra Is a Direct Margin Hit",
  "body": "**What it is:** Scope changes that happen on the job that never get billed. A rotted deck board that gets replaced. Extra ice and water shield added. An unexpected layer of old roofing that required additional disposal. All real costs. None of them billed.\n\n**Why it keeps happening:** No change order form. No culture of capturing extras. The owner says \"we will just take care of it\" without understanding what that costs over 200 jobs a year.\n\n**The Fix: Zero-Tolerance Change Order Culture**\n\nBuild a zero-tolerance change order culture. Any scope addition, no matter how small, is documented and customer-approved before work begins. Crew does not touch it until there is a signature.\n\n**The system to build:**\n- Change Order Form: one page, description, materials, labor, total, customer signature line\n- Crew rule: nothing gets added without a signed change order\n- Customer communication script: how to present a change order professionally on the job\n- Pre-priced extras list: your 10 most common additions already priced and ready to quote\n- Change Order Tracker: part of your job folder, reviewed monthly\n\n**Implementation steps:**\n1. List the 5 most common scope additions you see on jobs: deck boards, disposal, ice shield, etc.\n2. Create a one-page Change Order Form with description, materials cost, labor cost, total, and customer signature.\n3. Set the policy: work does not start on any addition until the form is signed.\n4. Train your crew: when they find something outside scope, they call the office or foreman immediately. They do not start the work.\n5. Script the customer conversation: \"We found something not in the original scope. Before we address it, I need your written approval.\"\n6. Pre-price your 10 most common additions so you can quote immediately on the job.\n\n**Timeline:** 5-7 days to build and launch. Day 1: create a one-page Change Order Form, add it to every active job folder, brief your crew at tomorrow morning meeting.\n\n**What done looks like:**\n- Every scope addition has a signed change order before work begins\n- Crew knows exactly what triggers a change order call\n- Change order revenue appears as a tracked line item in your monthly job report",
  "key_takeaway": "Every unbilled change order is a direct deduction from your gross profit on that job. The fix is a one-page form and one clear rule: no signature, no work."
}'::jsonb
FROM lessons WHERE slug = 'plc-06-missed-change-orders';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Leak 5: Missed Change Orders - Annual Calculation",
  "description": "Calculate the annual cost of scope additions that leave the job without a bill.",
  "fields": [
    {"label": "Jobs Per Month With Unbilled Scope Changes", "key": "jobs_with_changes", "type": "number", "prefix": "", "suffix": " jobs", "hint": "How many jobs per month typically have something extra done that does not get billed?"},
    {"label": "Average Value of Unbilled Change Per Job", "key": "avg_change_value", "type": "number", "prefix": "$", "suffix": "", "hint": "Think about deck boards ($150-$400), extra disposal ($200-$600), ice shield additions ($300-$800). What is your average?"}
  ],
  "results": [
    {"label": "Annual Leak: Missed Change Orders", "key": "leak5_annual", "formula": "jobs_with_changes * 12 * avg_change_value", "prefix": "$", "suffix": "", "benchmark": "At 4 jobs/month with $300 in unbilled extras, that is $14,400/year. At $600/job it is $28,800."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-06-missed-change-orders';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Leak 5 Calculated",
  "highlights": [
    "The fix is a one-page Change Order Form and one rule: no signature, no work.",
    "Pre-pricing your 10 most common additions lets your foreman quote on the spot without calling back to the office.",
    "Track change order revenue monthly. It becomes a KPI that tells you whether the system is working."
  ],
  "next_steps": [
    "Write down your Leak 5 annual total.",
    "Move to Lesson 7: Leak 6 - Material Overorders."
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-06-missed-change-orders';


-- ============================================================
-- LESSON 7: Leak 6 - Material Overorders
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'plc-07-material-overorders',
  'Leak 6: Material Overorders',
  'Materials ordered beyond what the job requires that are not returned. Estimates are padded for safety, which is fine, but only if the overage comes back. If it does not come back, it becomes waste.',
  'leak',
  7,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Buffer That Stays on the Truck",
  "body": "**What it is:** Materials ordered beyond what the job requires that are not returnable, or simply not returned. Estimates are padded for safety, which is reasonable, but only if the overage comes back. If it does not come back, it becomes waste.\n\n**Why it keeps happening:** No closeout process to capture and return surplus. Crews do not separate returnable from non-returnable. The habit of just throwing it all away or leaving it becomes the default.\n\n**The Fix: Material Quantity Calculator with a Return Policy**\n\nBuild a material quantity calculator for your most common job types that produces exact order quantities with a defined buffer. Establish a policy that all unused returnable materials must be returned within 48 hours of job completion.\n\n**The system to build:**\n- Material Quantity Calculator: a simple spreadsheet, enter job size, get exact quantities\n- Standard buffer policy: 10% overage is acceptable only if the buffer is returned\n- Returnable vs. Non-Returnable Reference Sheet: so crews know what goes back and what stays\n- Closeout requirement: unused materials listed on the closeout checklist before crew departs\n- Return authorization: written agreement with your supplier for return credits\n\n**Implementation steps:**\n1. Pull your 3 most recent jobs. Compare what was ordered to what was actually used.\n2. List your 5 most common job types and document the exact material quantities needed per unit.\n3. Build a spreadsheet calculator: enter job square footage, calculator outputs exact materials list.\n4. Set the buffer rule: 10% overage is acceptable, but all unused buffer must be returned.\n5. Create a Returnable Materials Reference Sheet so your crew knows what can go back and what cannot.\n6. Add a materials listing step to your Job Closeout Checklist.\n\n**What done looks like:**\n- Material orders are within 5-10% of actual job requirements on average\n- Surplus returnable materials are returned within 48 hours of job completion\n- Monthly supplier credit for returned materials appears consistently on your invoice",
  "key_takeaway": "Padding estimates is not the problem. Keeping the padding without returning it is. A 10% buffer is fine if it comes back. A 10% buffer that stays on the truck is waste."
}'::jsonb
FROM lessons WHERE slug = 'plc-07-material-overorders';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Leak 6: Material Overorders - Annual Calculation",
  "description": "Calculate the annual cost of materials ordered beyond job requirements that are not returned.",
  "fields": [
    {"label": "Jobs Per Month With Significant Material Waste", "key": "jobs_with_waste", "type": "number", "prefix": "", "suffix": " jobs", "hint": "How many jobs per month result in materials being discarded or left unreturned?"},
    {"label": "Average Wasted or Non-Returned Material Cost Per Job", "key": "avg_waste_per_job", "type": "number", "prefix": "$", "suffix": "", "hint": "Dollar value of materials ordered but not used and not returned per job. Common range: $200-$700."}
  ],
  "results": [
    {"label": "Annual Leak: Material Overorders", "key": "leak6_annual", "formula": "jobs_with_waste * 12 * avg_waste_per_job", "prefix": "$", "suffix": "", "benchmark": "This leak compounds with Leak 1 (unreturned materials). Combined, material management leaks often total $20,000-$60,000/year."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-07-material-overorders';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Leak 6 Calculated",
  "highlights": [
    "The fix is a material quantity calculator and a 48-hour return policy.",
    "Building the calculator takes 7-10 days. The return policy can be implemented immediately.",
    "Combined with Leak 1 (unreturned materials), fixing both material leaks is often worth $20,000-$60,000/year."
  ],
  "next_steps": [
    "Write down your Leak 6 annual total.",
    "Move to Lesson 8: Leak 7 - Callbacks."
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-07-material-overorders';


-- ============================================================
-- LESSON 8: Leak 7 - Callbacks
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'plc-08-callbacks',
  'Leak 7: Callbacks',
  'Returning to a completed job because something was not finished correctly. Every callback is unbilled crew time, unbilled fuel, and a scheduling disruption that delays a paying job.',
  'leak',
  8,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The True Cost of Going Back",
  "body": "**What it is:** Returning to a completed job because something was not finished correctly or the customer identified a problem after the crew left. Every callback is unbilled crew time, unbilled fuel, and a scheduling disruption that delays a paying job.\n\n**Why it keeps happening:** No closeout checklist. No quality check before the crew leaves the site. Problems that should have been caught on-site get discovered by the homeowner the next day.\n\n**The Fix: Mandatory Job Closeout Quality Check**\n\nImplement a mandatory job closeout quality check where the foreman completes a written checklist and conducts a customer walkthrough before the crew leaves the site. Every callback gets logged and reviewed in your weekly meeting.\n\n**The system to build:**\n- Job Closeout Quality Checklist: specific to each job type, signed by foreman before departure\n- Customer Walkthrough Protocol: foreman walks the customer through the completed work before leaving\n- Callback Log: every callback documented with cause, hours spent, cost, and crew responsible\n- Weekly callback review: standing agenda item in every weekly team meeting\n- Callback threshold policy: crew with callback rates above a set percentage gets a second quality check step added\n\n**Implementation steps:**\n1. List the 10 most common callback reasons from your last 12 months.\n2. Build a Job Closeout Quality Checklist that checks every one of those common failure points.\n3. Set the rule: no crew departs until the foreman has signed the quality checklist.\n4. Build a Customer Walkthrough Protocol: foreman walks the customer through the completed work before leaving.\n5. Create a Callback Log spreadsheet: cause, date, crew, hours spent, total cost.\n6. Add callback review as a standing item in your weekly team meeting.\n7. Set a callback rate KPI: no more than 2% of jobs result in a callback.\n\n**Timeline:** 5-7 days to build and deploy. 30 days to see measurable impact. Day 1 action: write down your last 5 callbacks, what caused each one, and whether there is a pattern. That pattern is your first checklist item.\n\n**What done looks like:**\n- Callback Log shows a declining trend month over month for 90 consecutive days\n- Every job has a signed closeout quality checklist on file\n- Customer walkthrough happens on 100% of residential jobs",
  "key_takeaway": "The foreman who does the customer walkthrough catches 80% of what would have become a callback. That 10-minute conversation on-site prevents a half-day trip back."
}'::jsonb
FROM lessons WHERE slug = 'plc-08-callbacks';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Leak 7: Callbacks - Annual Calculation",
  "description": "Calculate the annual cost of returning to completed jobs for quality issues.",
  "fields": [
    {"label": "Callbacks Per Month Requiring a Crew Return", "key": "callbacks_per_month", "type": "number", "prefix": "", "suffix": " callbacks", "hint": "How many times per month does a crew have to return to a completed job for any reason?"},
    {"label": "Fully Loaded Cost Per Callback (labor + fuel + materials)", "key": "cost_per_callback", "type": "number", "prefix": "$", "suffix": "", "hint": "Include: crew labor hours, fuel for the trip, any materials used. Common range: $300-$900 per callback."}
  ],
  "results": [
    {"label": "Annual Leak: Callbacks", "key": "leak7_annual", "formula": "callbacks_per_month * 12 * cost_per_callback", "prefix": "$", "suffix": "", "benchmark": "This does not include the cost of scheduling disruption to other paying jobs. The true cost is 20-30% higher than the direct cost."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-08-callbacks';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Leak 7 Calculated",
  "highlights": [
    "A 10-minute customer walkthrough before the crew leaves prevents most callbacks.",
    "The Callback Log is as important as the checklist. Tracking causes reveals patterns that the checklist can then target.",
    "Tie foreman recognition or bonus structure to callback rate improvement. Accountability drives behavior."
  ],
  "next_steps": [
    "Write down your Leak 7 annual total.",
    "Move to Lesson 9: Your Total Annual Production Leak and Priority Fix List."
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-08-callbacks';


-- ============================================================
-- LESSON 9: Total Annual Production Leak and Priority Fix List
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'plc-09-total-leak-summary',
  'Your Total Annual Production Leak',
  'Add up all seven leaks, identify your top three priorities by dollar amount, and build your priority fix list. Fix the biggest one first, completely, before touching the second.',
  'leak',
  9,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Number That Belongs to Your Business",
  "body": "The number at the end of this calculator is not a judgment. It is a starting point. Every dollar in that total is recoverable: it is margin that belongs to your business but is currently walking out the door.\n\nYou do not have to fix all seven at once. Fix the biggest one. Fully. Then move to the second.\n\n**The priority fix list process:**\n\n1. Transfer your annual total from each leak category to the summary.\n2. Rank them by dollar amount. The highest dollar leak is Priority 1.\n3. For your top three leaks, note the Fix Guide lesson for each (Lessons 10-11 in this series).\n4. Write down the First Action for Priority 1 from its Fix Guide.\n5. Do that action today.\n\n**The 30-day sprint structure for Priority 1:**\n- Day 1: Complete the Day 1 Action from your Fix Guide\n- Day 2: Build the form, checklist, or tool required\n- Day 3: Review with your operations manager or key team member\n- Day 4: Finalize the tool. Print copies or set up digital version.\n- Day 5: Brief your crew at morning meeting\n- Days 6-7: Deploy on the next 2 jobs. Observe. Take notes on what does not work yet.\n- Week 2: Fix the gaps. Spot-check every job.\n- Week 3: The system should run without reminders. Track the first data points.\n- Week 4: Calculate the monthly impact. Compare to your baseline estimate. Report to your team.\n- Day 31+: Begin Fix Guide for Priority 2. Do not start until Priority 1 is producing measurable results.\n\nFix the first priority completely before moving to the second. One thing done all the way beats three things started.",
  "key_takeaway": "Rank your leaks by dollar amount. Fix them in order. One complete fix producing results is worth more than three partial fixes in progress simultaneously."
}'::jsonb
FROM lessons WHERE slug = 'plc-09-total-leak-summary';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Total Annual Production Leak Summary",
  "description": "Transfer your annual total from each of the seven leak calculations. Your total is your baseline. Every fix reduces this number.",
  "fields": [
    {"label": "Leak 1: Materials Not Returned (annual)", "key": "leak1_total", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy from Lesson 2 calculation."},
    {"label": "Leak 2: Jobs Running Longer Than Estimated (annual)", "key": "leak2_total", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy from Lesson 3 calculation."},
    {"label": "Leak 3: No Materials / Wrong Materials Delay (annual)", "key": "leak3_total", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy from Lesson 4 calculation."},
    {"label": "Leak 4: Paying List Price on Materials (annual)", "key": "leak4_total", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy from Lesson 5 calculation."},
    {"label": "Leak 5: Missed Change Orders (annual)", "key": "leak5_total", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy from Lesson 6 calculation."},
    {"label": "Leak 6: Material Overorders (annual)", "key": "leak6_total", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy from Lesson 7 calculation."},
    {"label": "Leak 7: Callbacks (annual)", "key": "leak7_total", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy from Lesson 8 calculation."}
  ],
  "results": [
    {"label": "Total Annual Production Leak", "key": "total_annual_leak", "formula": "leak1_total + leak2_total + leak3_total + leak4_total + leak5_total + leak6_total + leak7_total", "prefix": "$", "suffix": "", "benchmark": "Most contractors doing $1.5M-$4M find $40,000-$180,000 here. This is recoverable margin."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-09-total-leak-summary';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Your Priority Fix List",
  "highlights": [
    "Rank your seven leaks by dollar amount. The highest dollar leak is Priority 1.",
    "Fix Priority 1 completely before starting Priority 2. One thing done beats three things started.",
    "Most operators can close their top 3 leaks within 90 days using the Fix Guide system."
  ],
  "next_steps": [
    "Write your Priority 1 leak name and dollar amount on a whiteboard where your team can see it.",
    "Complete the Day 1 Action from your Priority 1 Fix Guide today.",
    "Move to Lesson 10 to review the Fix Guide framework and the Trip Charge Floor calculation."
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-09-total-leak-summary';


-- ============================================================
-- LESSON 10: The Trip Charge Floor
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'plc-10-trip-charge-floor',
  'The Trip Charge Floor',
  'Every job should carry a minimum trip charge. No job goes out the door without covering the cost of showing up. Calculate your floor and check if your smallest jobs are hitting it.',
  'leak',
  10,
  6
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "No Job Goes Out the Door Without Covering Show-Up Cost",
  "body": "Every job should carry a minimum trip charge. No job goes out the door without covering the cost of showing up. The floor is $150-$200 for any service call or small job.\n\nCalculate your trip charge floor: (Drive time in hours x labor rate per hour) + fuel cost + minimum overhead allocation.\n\nIf your smallest jobs are not hitting that floor, raise your minimum.\n\n**The four components:**\n\n1. **Drive Time Cost:** Hours driving to and from the job multiplied by your labor rate per hour. If a technician drives 45 minutes each way at $35/hour, that is $52.50 in drive time cost before work starts.\n\n2. **Fuel:** Actual fuel cost for the round trip based on miles and fuel efficiency of the vehicle.\n\n3. **Overhead Allocation:** A portion of your daily overhead allocated to every job that goes out. If your daily overhead is $1,200 and you run 4 jobs per day, each job carries $300 in overhead allocation at minimum.\n\n4. **Your Trip Charge Floor:** The sum of the above three. Any job priced below this number costs you money the moment you send a truck.\n\n**The benchmark:** Most roofing and restoration service calls require a minimum floor of $150-$250 to cover show-up costs. Service and repair work carries minimum margins of 50-65% because the mobilization cost is high relative to job size.",
  "key_takeaway": "Every small job that goes out the door below your trip charge floor is subsidized by your profitable jobs. Price the floor in and hold it."
}'::jsonb
FROM lessons WHERE slug = 'plc-10-trip-charge-floor';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Trip Charge Floor Calculator",
  "description": "Calculate the minimum charge that covers the cost of showing up on any job.",
  "fields": [
    {"label": "Average Drive Time to Job Site (hours round trip)", "key": "drive_time_hours", "type": "number", "prefix": "", "suffix": " hours", "hint": "Average round-trip drive time for your typical service call or small job."},
    {"label": "Labor Rate Per Hour (fully loaded)", "key": "labor_rate", "type": "number", "prefix": "$", "suffix": "/hr", "hint": "Fully loaded hourly labor cost including wages, taxes, and benefits."},
    {"label": "Fuel Cost Per Round Trip", "key": "fuel_cost", "type": "number", "prefix": "$", "suffix": "", "hint": "Estimated fuel cost for the average round trip to a job site."},
    {"label": "Minimum Overhead Allocation Per Job", "key": "overhead_allocation", "type": "number", "prefix": "$", "suffix": "", "hint": "Daily overhead divided by average jobs per day. From Lesson 7 of the Overhead Calculator."},
    {"label": "Current Minimum Charge", "key": "current_minimum", "type": "number", "prefix": "$", "suffix": "", "hint": "What do you charge today as a minimum for a service call or small job?"}
  ],
  "results": [
    {"label": "Drive Time Cost", "key": "drive_time_cost", "formula": "drive_time_hours * labor_rate", "prefix": "$", "suffix": "", "benchmark": "This is the cost before any work starts."},
    {"label": "Your Trip Charge Floor", "key": "trip_charge_floor", "formula": "drive_time_cost + fuel_cost + overhead_allocation", "prefix": "$", "suffix": "", "benchmark": "Industry benchmark: $150-$250 for most residential service calls."},
    {"label": "Gap (floor minus current minimum)", "key": "trip_charge_gap", "formula": "trip_charge_floor - current_minimum", "prefix": "$", "suffix": "", "benchmark": "If positive, every small job you send out below floor is a guaranteed loss."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-10-trip-charge-floor';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Trip Charge Floor Calculated",
  "highlights": [
    "If your current minimum is below the floor, every small job you send out below that number loses money before work starts.",
    "Service and repair work should carry 50-65% gross margin because mobilization costs are high relative to job size.",
    "Raise your minimum charge to the floor. Most customers expect it. The ones who leave over a legitimate minimum charge were not worth serving."
  ],
  "next_steps": [
    "Update your minimum service call charge in your estimating system to match the floor.",
    "Move to Lesson 11 for the Fix Guide overview and the 30-Day Sprint Plan."
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-10-trip-charge-floor';


-- ============================================================
-- LESSON 11: The Fix Guide Framework
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'plc-11-fix-guide-framework',
  'The Fix Guide Framework: How to Close a Leak Permanently',
  'Every Fix Guide in this series follows the same structure. This lesson explains the framework so you can execute any fix in under two weeks.',
  'leak',
  11,
  6
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Structure That Turns a Problem Into a Closed System",
  "body": "Every Fix Guide in this calculator follows the same five-part structure:\n\n**1. The Fix.** A plain-language description of the system or process that closes this leak permanently. Not a suggestion. A specific system with specific parts.\n\n**2. The System to Build.** The specific tools, forms, and processes you need to create. None of these require software. They are typically one-page forms, checklists, and clear policies.\n\n**3. Implementation Steps.** Numbered steps to go from zero to operational. Designed to be completed in under 2 weeks.\n\n**4. What Done Looks Like.** Three measurable outcomes that tell you the fix is working. Not feelings. Measurable outcomes you can verify.\n\n**5. Day 1 Action.** The one specific thing you do tomorrow to start closing this leak.\n\n**The principle behind all seven fixes:**\n\nNone of the seven leaks exist because operators are careless or unqualified. They exist because no system was built to prevent them. A skilled crew without a closeout checklist will leave materials on-site every time. The same skilled crew with a checklist and a 24-hour return policy will return materials on 95% of jobs.\n\nThe system is the fix. Not motivation. Not reminders. A system that makes the right behavior the default behavior.\n\n**Work your Priority Fix List in order.** Do not start Fix Guide 2 until Fix Guide 1 is fully implemented and producing results. Three months of consistent focus on your top three leaks will recover more margin than a year of scattered efforts across all seven.",
  "key_takeaway": "The system is the fix. Build the process that makes the correct behavior the default, not the exception."
}'::jsonb
FROM lessons WHERE slug = 'plc-11-fix-guide-framework';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'summary', '{
  "title": "Fix Guide Framework Complete",
  "highlights": [
    "Every fix follows five steps: The Fix, The System to Build, Implementation Steps, What Done Looks Like, Day 1 Action.",
    "None of the fixes require software. They require one-page forms, clear policies, and accountability.",
    "Work the Priority Fix List in order. Do not start Fix 2 until Fix 1 is fully operational and producing results."
  ],
  "next_steps": [
    "Confirm your Priority 1 leak from Lesson 9.",
    "Go to the corresponding Fix Guide lesson (2-8) and complete the Day 1 Action today.",
    "Move to Lesson 12: The 30-Day Sprint Plan."
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-11-fix-guide-framework';


-- ============================================================
-- LESSON 12: The 30-Day Sprint Plan and Results Tracking
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'plc-12-30-day-sprint-plan',
  'The 30-Day Sprint Plan',
  'A day-by-day implementation plan to close your Priority 1 leak in 30 days. Fixing one leak completely is worth more than starting three at once.',
  'leak',
  12,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Only Rule: Finish Before You Start the Next One",
  "body": "Use this plan to build your 30-day implementation sprint around your Priority 1 leak. Fixing one leak completely is worth more than starting three at once.\n\n**Week 1: Build the System**\n- Day 1: Complete your Day 1 Action from your Fix Guide. Do it today.\n- Day 2: Build the form, checklist, or tool required. Keep it one page.\n- Day 3: Review with your operations manager or key team member. Get input.\n- Day 4: Finalize the form. Print copies. Add to job folders or crew trucks.\n- Day 5: Brief your crew at morning meeting. Walk through the new process step by step.\n- Days 6-7: Deploy on the next 2 jobs. Observe. Take notes on what does not work yet.\n\n**Week 2: Fix the Gaps**\n- Fix the gaps from Week 1.\n- Spot-check every job.\n- Correct any crew member who skips a step.\n\n**Week 3: Confirm the System Is Running**\n- The system should now be running without reminders.\n- Track the first real data points.\n\n**Week 4: Measure and Report**\n- Calculate the monthly impact.\n- Compare to your baseline leak estimate from Lesson 9.\n- Report the number to your team.\n\n**Day 31 and Beyond:**\n- Begin Fix Guide for Priority 2.\n- Do not start until Priority 1 is producing measurable, documented results.\n\n**Track your results every month.** At the end of each month, record: number of leak incidents, estimated monthly savings compared to baseline, and notes. Share it with your team. Visibility creates accountability.",
  "key_takeaway": "30 days is enough to build, launch, and verify one fix. Do not start the next one until this month is complete and producing results."
}'::jsonb
FROM lessons WHERE slug = 'plc-12-30-day-sprint-plan';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "30-Day Sprint Tracker",
  "description": "Track your monthly progress on closing your priority leaks. Fill this in at the end of each month and share it with your team.",
  "fields": [
    {"label": "Priority Leak Being Fixed This Month", "key": "priority_leak_name", "type": "text", "prefix": "", "suffix": "", "hint": "Name the leak you are working on this 30-day sprint."},
    {"label": "Annual Leak Value (from Lesson 9)", "key": "annual_leak_value", "type": "number", "prefix": "$", "suffix": "", "hint": "The annual dollar value of this leak from your summary calculation."},
    {"label": "Month 1: Leak Incidents Recorded", "key": "month1_incidents", "type": "number", "prefix": "", "suffix": " incidents", "hint": "How many times did the leak occur this month?"},
    {"label": "Month 1: Estimated Monthly Savings", "key": "month1_savings", "type": "number", "prefix": "$", "suffix": "", "hint": "Estimated dollars recovered compared to pre-fix baseline."},
    {"label": "Month 2: Leak Incidents Recorded", "key": "month2_incidents", "type": "number", "prefix": "", "suffix": " incidents", "hint": "How many times did the leak occur this month?"},
    {"label": "Month 2: Estimated Monthly Savings", "key": "month2_savings", "type": "number", "prefix": "$", "suffix": "", "hint": "Estimated dollars recovered compared to pre-fix baseline."},
    {"label": "Month 3: Leak Incidents Recorded", "key": "month3_incidents", "type": "number", "prefix": "", "suffix": " incidents", "hint": "How many times did the leak occur this month?"},
    {"label": "Month 3: Estimated Monthly Savings", "key": "month3_savings", "type": "number", "prefix": "$", "suffix": "", "hint": "Estimated dollars recovered compared to pre-fix baseline."}
  ],
  "results": [
    {"label": "3-Month Total Savings", "key": "three_month_savings", "formula": "month1_savings + month2_savings + month3_savings", "prefix": "$", "suffix": "", "benchmark": "A fully implemented fix should recover 60-80% of the annual leak value within 90 days of implementation."},
    {"label": "Monthly Savings Run Rate", "key": "monthly_run_rate", "formula": "(month1_savings + month2_savings + month3_savings) / 3", "prefix": "$", "suffix": "/month", "benchmark": "Annualize this to confirm the fix is closing the leak at the projected rate."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-12-30-day-sprint-plan';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "You Have Everything You Need",
  "highlights": [
    "Your total annual production leak is the baseline. Every fix reduces it. Track monthly savings against that baseline.",
    "The 30-day sprint structure works for every leak in the calculator. Build, launch, verify, then move to the next.",
    "Most operators close $40,000-$100,000 in annual leaks within their first 90 days of focused implementation.",
    "A funded reserve (from the Overhead Calculator) plus closed production leaks is the combination that changes how a roofing business operates."
  ],
  "next_steps": [
    "Complete your Day 1 Action for Priority 1 today. Not tomorrow.",
    "Schedule Week 1 tasks into your calendar as real appointments.",
    "Return to the Total Leak Summary in Lesson 9 at the end of each month and update the numbers."
  ]
}'::jsonb
FROM lessons WHERE slug = 'plc-12-30-day-sprint-plan';
