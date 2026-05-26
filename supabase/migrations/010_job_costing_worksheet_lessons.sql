-- ============================================================
-- Migration: 010_job_costing_worksheet_lessons.sql
-- Lesson count: 10 lessons
-- Pillar: mirror
-- PDF source: SLO-Job-Costing-Worksheet.pdf
--
-- Schema assumptions for Jared to verify before running:
--   1. uuid-ossp extension is already enabled (uuid_generate_v4() is available).
--   2. lessons table exists with columns: id, slug, title, description,
--      pillar_key, position, duration_minutes, created_at.
--   3. lesson_steps table exists with columns: id, lesson_id, position,
--      step_type, content (jsonb), created_at.
--   4. No unique-slug conflicts with existing lessons rows.
--   5. pillar_key 'mirror' is an accepted value (no enum constraint blocking it).
--   6. lesson positions 11-20 are available (this file continues after 009,
--      which used positions 1-10). Adjust if your position column is
--      scoped per-pillar rather than globally.
-- ============================================================

-- ── Lesson 1 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'jcw-01-why-job-costing-matters',
  'Why Job Costing Is a Management Tool, Not a Bookkeeping Task',
  'Most contractors leave 5 to 10 points of gross margin on the table every month. Not because they do not work hard. Because they do not track.',
  'mirror',
  11,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Difference Between Accounting and Management",
  "body": "Most contractors calculate their margin after the job closes. Every cost is already fixed. Nothing can be recovered. That is accounting.\n\nManagement means checking margin during the job, when there is still time to make decisions.\n\n**What job costing actually tells you:**\n- Did you make what you thought you would make on this job?\n- Which cost category blew up: materials, labor, subcontractors, or overhead?\n- Is your pricing model covering your actual costs, or are you subsidizing every job with your margin?\n\n**The five cost categories on every job:**\n1. Material costs (primary, secondary, hardware, consumables, debris removal)\n2. Labor costs (including burden rate, not just base wage)\n3. Subcontractor costs (quoted versus final invoice)\n4. Overhead allocation (your fixed monthly costs distributed across jobs)\n5. Gross profit (what you actually kept after all four above)\n\n**Why most contractors do not know their real margin:**\nJob costing is treated as something the bookkeeper does after the fact. By the time the worksheet is complete, the invoices are paid and the check is cashed. The numbers are a record, not a management tool.\n\n**The fix:** Check margin three times on every job: at material delivery, at 50% complete, and at job close. The first two checks are when you can still make decisions. The third is for the record.\n\n**The benchmark to know:**\n- Renovation / Remodel: 30-40% gross margin target\n- New Construction: 20-30%\n- Service / Repair: 40-55%\n- Specialty / Custom: 35-45%\n- Below 20% on any job type: investigate immediately",
  "key_takeaway": "Reviewing margin after the job closes is accounting. Reviewing it during the job is management. Only one of those can change the outcome."
}'::jsonb
FROM lessons WHERE slug = 'jcw-01-why-job-costing-matters';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'summary', '{
  "title": "Job Costing: The Core Idea",
  "highlights": [
    "Gross margin percentage is the most important number on the worksheet. It tells you what percentage of every dollar collected you actually kept after covering direct job costs and overhead.",
    "If you do not know your real margin by job type, your pricing model is a guess. And a wrong guess is not just unprofitable. It compounds month over month.",
    "The three check-in points, at material delivery, at 50% complete, and at close, are what separate reactive bookkeeping from proactive margin management."
  ],
  "next_steps": [
    "Pull the last three completed jobs and identify what your actual gross margin was on each one. Use invoices and payroll records.",
    "Identify which of the five cost categories had the largest variance between estimated and actual on those jobs.",
    "Set a 30-day goal: complete this worksheet on every job for the next 30 days and calculate gross margin at close."
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-01-why-job-costing-matters';

-- ── Lesson 2 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'jcw-02-job-information-and-setup',
  'Job Setup: Recording the Basics Before Work Begins',
  'Every cost tracked on this worksheet ties back to one job record. Build the habit of setting up the worksheet before the first nail goes in.',
  'mirror',
  12,
  5
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Job Record: What to Capture Before Day One",
  "body": "Complete your job information before work begins. Every cost tracked on the worksheet ties back to this job record. Keep a printed or digital copy on file for at least three years.\n\n**What to record at job setup:**\n- Job name and site address\n- Job type: Renovation, New Construction, Service-Repair, Commercial, or Other\n- Contract value (total bid)\n- Start date and estimated completion date\n- Production lead (who is on-site responsible)\n- Job number\n\n**Job numbering that works:**\nAssign job numbers sequentially and include the year. Example: 2026-047. This makes monthly tracking and year-over-year comparison straightforward. When you are searching for a job record 18 months from now, you will find it in under 10 seconds.\n\n**Why this matters before the job starts, not after:**\nThe job record is the anchor for every cost that follows. If the anchor is set up three weeks into the job, costs that arrived before setup either get misallocated or lost entirely. Material invoices that arrive on day two belong to this job. If the worksheet does not exist yet, those invoices go somewhere else.\n\n**The file retention rule:**\nKeep job records for at least three years. Most contractor disputes, insurance claims, and warranty issues arise within that window. A complete job record is your protection.",
  "key_takeaway": "A job record that does not exist before work starts will have gaps. Those gaps are missing data that cannot be recovered after the fact."
}'::jsonb
FROM lessons WHERE slug = 'jcw-02-job-information-and-setup';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Job Information Entry",
  "description": "Complete this for every job before the first day of work. This record is the anchor for all cost tracking that follows.",
  "fields": [
    {"label": "Contract Value (Total Bid)", "key": "contract_value", "type": "number", "prefix": "$", "suffix": "", "hint": "The total signed contract amount, including any agreed change orders at time of signing."},
    {"label": "Job Type", "key": "job_type", "type": "text", "prefix": "", "suffix": "", "hint": "Renovation, New Construction, Service-Repair, Commercial, or Other."},
    {"label": "Target Gross Margin for This Job Type", "key": "target_margin", "type": "number", "prefix": "", "suffix": "%", "hint": "Use the benchmarks from Section 07 of the worksheet. Renovation: 30-40%. Service/Repair: 40-55%. New Construction: 20-30%."},
    {"label": "Crew Size", "key": "crew_size", "type": "number", "prefix": "", "suffix": "", "hint": "Number of workers assigned to this job."},
    {"label": "Number of Production Days Scheduled", "key": "production_days", "type": "number", "prefix": "", "suffix": "", "hint": "Planned days to complete the scope of work."}
  ],
  "results": [
    {"label": "Target Gross Profit Amount", "key": "target_gp", "formula": "contract_value * target_margin / 100", "prefix": "$", "suffix": "", "benchmark": "This is the dollar amount you need to keep after all job costs to hit your margin target. Know this number before day one."},
    {"label": "Maximum Allowable Total Job Cost", "key": "max_job_cost", "formula": "contract_value - target_gp", "prefix": "$", "suffix": "", "benchmark": "If your total costs exceed this number, you are below your target margin. Track against this ceiling throughout the job."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-02-job-information-and-setup';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Job Setup Takeaways",
  "highlights": [
    "Set up the worksheet before the first delivery arrives. Not after the job closes.",
    "Calculate your target gross profit amount and maximum allowable cost at setup. Post these numbers where your production lead can see them.",
    "Sequential job numbering with the year included makes every future search instant."
  ],
  "next_steps": [
    "Create a job setup template that takes 5 minutes or less to complete. The simpler it is, the more likely it gets done on every job.",
    "Identify who is responsible for setting up the job record on every job. Assign one person. Not ''whoever gets to it.''",
    "File job records in a consistent location, digital or physical, so they are retrievable in under 60 seconds."
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-02-job-information-and-setup';

-- ── Lesson 3 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'jcw-03-material-costs',
  'Material Costs: Tracking Estimated vs. Actual',
  'Material overruns cost 3-8% of job revenue on a typical $25,000 job. That is $750 to $2,000 gone per job. The fix is a pre-job materials list built before the first call to the supplier.',
  'mirror',
  13,
  9
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Material Tracking: Why Your Estimate Is Usually Wrong",
  "body": "Material overruns are not a materials problem. They are a process problem. The fix is a pre-job materials list built before the first call to the supplier.\n\n**What to track in the materials section:**\n- Primary material (main product for the scope of work)\n- Secondary material (supporting components)\n- Hardware, fasteners, adhesives\n- Consumables: tape, caulk, wrap, sealant, etc.\n- Equipment rental if applicable\n- Debris removal and disposal\n\nFor each line item: estimated cost (from the bid), actual cost (from invoices), and variance (estimated minus actual).\n\nA positive variance means you came in under estimate. A negative variance means you overspent.\n\n**The buffer rule:**\nAlways include a material buffer for overages, cuts, and waste.\n\n- Simple / linear work: 5-8% buffer\n- Moderate complexity: 8-12%\n- High complexity: 12-18%\n- Renovation with unknown existing conditions: 10-20%\n\nThis is not a cushion. It is a calculation. Do the math and write the number down at estimate time. If your estimate does not include the buffer, your actual cost will almost always exceed it.\n\n**The six-step material overrun fix:**\n1. Build a line-item materials list before placing any order. Every item required for the scope.\n2. Apply the correct buffer for the job type based on your last three similar jobs.\n3. Place one order per job. Partial orders create partial tracking.\n4. Verify delivery against the PO on the day of delivery. Not days later. Mark shortages or substitutions on the PO copy.\n5. Track material use through the job. If the crew is using material faster than the square count suggests, find out why while the job is still running.\n6. Return unused material within the supplier''s return window. Recovered material cost is recovered margin.",
  "key_takeaway": "Mid-job discovery of a material overrun is recoverable. Post-job discovery is not. The delivery day check is your first intervention point."
}'::jsonb
FROM lessons WHERE slug = 'jcw-03-material-costs';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Material Cost Tracker",
  "description": "Enter your estimated material cost from the bid, then update with actual invoice costs as they arrive. The variance column tells you whether your takeoff process is accurate.",
  "fields": [
    {"label": "Primary Material: Estimated", "key": "primary_est", "type": "number", "prefix": "$", "suffix": "", "hint": "Main product cost from your bid takeoff."},
    {"label": "Primary Material: Actual", "key": "primary_actual", "type": "number", "prefix": "$", "suffix": "", "hint": "Actual cost from supplier invoice."},
    {"label": "Secondary Material: Estimated", "key": "secondary_est", "type": "number", "prefix": "$", "suffix": "", "hint": "Supporting components from bid."},
    {"label": "Secondary Material: Actual", "key": "secondary_actual", "type": "number", "prefix": "$", "suffix": "", "hint": "Actual invoice cost."},
    {"label": "Hardware / Fasteners / Adhesives: Estimated", "key": "hardware_est", "type": "number", "prefix": "$", "suffix": "", "hint": "From bid."},
    {"label": "Hardware / Fasteners / Adhesives: Actual", "key": "hardware_actual", "type": "number", "prefix": "$", "suffix": "", "hint": "From invoice."},
    {"label": "Consumables / Supplies: Estimated", "key": "consumables_est", "type": "number", "prefix": "$", "suffix": "", "hint": "Tape, caulk, wrap, sealant, etc."},
    {"label": "Consumables / Supplies: Actual", "key": "consumables_actual", "type": "number", "prefix": "$", "suffix": "", "hint": "From invoice."},
    {"label": "Debris Removal / Disposal: Estimated", "key": "debris_est", "type": "number", "prefix": "$", "suffix": "", "hint": "Dumpster, haul-off, disposal fees."},
    {"label": "Debris Removal / Disposal: Actual", "key": "debris_actual", "type": "number", "prefix": "$", "suffix": "", "hint": "Actual disposal cost."}
  ],
  "results": [
    {"label": "Total Estimated Material Cost", "key": "total_material_est", "formula": "primary_est + secondary_est + hardware_est + consumables_est + debris_est", "prefix": "$", "suffix": "", "benchmark": "This should match your bid material line."},
    {"label": "Total Actual Material Cost", "key": "total_material_actual", "formula": "primary_actual + secondary_actual + hardware_actual + consumables_actual + debris_actual", "prefix": "$", "suffix": "", "benchmark": "Compare to estimated. A positive variance (under) is good. A negative variance (over) needs a cause identified."},
    {"label": "Material Cost Variance", "key": "material_variance", "formula": "total_material_est - total_material_actual", "prefix": "$", "suffix": "", "benchmark": "Positive means under budget. Negative means you overspent. Any variance above 10% of total material estimate requires a documented explanation."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-03-material-costs';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Material Cost Takeaways",
  "highlights": [
    "The takeoff is the source of most material overruns. A takeoff done from memory or a quick satellite measurement without a waste factor will almost always come in under actual.",
    "One order per job, with a purchase order, is the single process change that does the most to prevent untracked material costs.",
    "After 10 completed material trackers, you will know your actual waste factor by job type. Use that number, not an industry average, in your next estimates."
  ],
  "next_steps": [
    "Build a line-item materials list template for your most common job type. Use it on the next five jobs and track variance.",
    "Set a rule: no material order without a PO. Even for small jobs.",
    "Identify which material category has the most consistent variance. That category is where your estimation process needs the most work."
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-03-material-costs';

-- ── Lesson 4 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'jcw-04-labor-costs-and-burden-rate',
  'Labor Costs: What You Actually Pay vs. What You Think You Pay',
  'Your actual labor cost is not the hourly wage. Every hour worked carries burden rate components that add 24-43% on top of base wage. Most contractors are not tracking this.',
  'mirror',
  14,
  9
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Burden Rate: Why Base Wage Is Never Your Real Labor Cost",
  "body": "Your actual labor cost is not just the hourly wage you pay. Every hour worked carries additional cost that you must account for at the job level.\n\n**Burden rate components:**\n\n| Component | Typical Range |\n|---|---|\n| FICA / Payroll Taxes (employer portion) | 7.65% |\n| Workers Compensation Insurance | 15-25% |\n| State Unemployment (SUTA) | 1-3% |\n| Benefits (if provided) | 0-8% |\n| **Total Burden Rate** | **24-43% above base wage** |\n\n**The burden rate multiplier formula:**\n\nActual Labor Cost per Hour = Base Wage x Burden Multiplier\n\nExample: $22/hr base wage x 1.30 multiplier = $28.60 actual labor cost per hour.\n\nFor most trades, the burden rate multiplier runs 1.25 to 1.40. If you are bidding labor at base wage, you are giving away 25-40% of your labor revenue before the crew starts.\n\n**How labor inefficiency costs you:**\nLabor is your most variable cost and the one you have the most direct control over. The problem is never that a crew works slowly. The problem is that no one knew how fast they needed to work until after the job was done.\n\n**Daily production target formula:**\nTotal labor budget (hours) divided by crew size divided by number of job days = hours per day available. Convert to units of work per day based on your crew''s proven rate.\n\n**The three labor management rules:**\n1. Set the daily production target before day one. Write it on the daily job sheet.\n2. At end of each shift, the production lead records actual output and compares to target.\n3. If the crew is more than 15% behind target after two full days, make a decision: add a crew member, extend the schedule, or address pace directly with the foreman. Waiting and hoping is not an option.",
  "key_takeaway": "Every hour over budget at $28/hr burdened adds $28 to your cost with no matching revenue. The fix is setting a daily production target before the crew starts, not reviewing labor hours after the job closes."
}'::jsonb
FROM lessons WHERE slug = 'jcw-04-labor-costs-and-burden-rate';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Labor Cost Calculator",
  "description": "Calculate your actual burdened labor cost for this job. Do not use base wage. Use the burden multiplier to get the number that reflects what this job actually cost you in labor.",
  "fields": [
    {"label": "Crew Size (number of workers on this job)", "key": "crew_size", "type": "number", "prefix": "", "suffix": "", "hint": "All workers who logged hours on this job."},
    {"label": "Total Hours Worked (all crew members combined)", "key": "total_hours", "type": "number", "prefix": "", "suffix": "", "hint": "Add up all time cards for all crew members from start to finish."},
    {"label": "Base Hourly Rate (average across crew)", "key": "base_hourly", "type": "number", "prefix": "$", "suffix": "", "hint": "If crew rates vary, calculate a weighted average: (worker A hours x rate + worker B hours x rate) divided by total hours."},
    {"label": "Burden Rate Multiplier", "key": "burden_multiplier", "type": "number", "prefix": "", "suffix": "x", "hint": "Typically 1.25 to 1.40 for most trades. Calculate yours: 1 + (FICA 7.65% + workers comp % + SUTA % + benefits %) / 100."},
    {"label": "Number of Production Days Scheduled", "key": "production_days", "type": "number", "prefix": "", "suffix": "", "hint": "Planned production days for this job."},
    {"label": "Units of Work Completed Per Day (actual)", "key": "actual_units_per_day", "type": "number", "prefix": "", "suffix": "", "hint": "Squares installed, linear feet completed, or equivalent measurable unit per day."},
    {"label": "Units of Work Required Per Day (budget target)", "key": "target_units_per_day", "type": "number", "prefix": "", "suffix": "", "hint": "Total scope divided by production days. This is your daily target."}
  ],
  "results": [
    {"label": "Actual Labor Cost Per Hour (Burdened)", "key": "burdened_hourly", "formula": "base_hourly * burden_multiplier", "prefix": "$", "suffix": "", "benchmark": "This is what each hour of crew time actually costs you. Use this rate in all future bids."},
    {"label": "Total Burdened Labor Cost", "key": "total_labor_cost", "formula": "total_hours * burdened_hourly", "prefix": "$", "suffix": "", "benchmark": "Compare to the labor budget in your bid. If actual exceeds estimate, identify the cause before the next similar job."},
    {"label": "Labor Efficiency Rate", "key": "labor_efficiency", "formula": "actual_units_per_day / target_units_per_day * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 90% or higher. Below 85% two days in a row means a management decision is required, not an observation."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-04-labor-costs-and-burden-rate';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Labor Cost Takeaways",
  "highlights": [
    "If your bids use base wage instead of burdened rate, you are systematically underbidding labor on every job. Fix your burden multiplier first, then reprice your next bid.",
    "The daily production target is the most direct lever you have on labor cost. If no one knows the target, no one can hit it.",
    "Track labor efficiency by crew over 90 days. Some crews consistently run under budget on certain job types. Assign accordingly."
  ],
  "next_steps": [
    "Calculate your actual burden rate multiplier using your current FICA, workers comp, SUTA, and benefits costs.",
    "Set a daily production target for your next job and post it on the job sheet before day one.",
    "Pull labor actuals from your last five jobs. Calculate the burdened cost for each. Compare to what you bid."
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-04-labor-costs-and-burden-rate';

-- ── Lesson 5 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'jcw-05-subcontractor-costs',
  'Subcontractor Costs: Quotes vs. Estimates and the Markup Rule',
  'A quote is a binding offer. An estimate is a guess. Never start a subcontractor relationship with an estimate. The difference can cost you thousands on a single job.',
  'mirror',
  15,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Managing Subcontractor Risk Before Work Begins",
  "body": "Track every subcontractor on every job. Quoted price is what was agreed before work began. Final invoice is what you actually paid. Variance shows whether you absorbed a cost overrun without knowing it.\n\n**The quote-versus-estimate distinction:**\n\nA quote is a binding offer for a defined scope at a defined price. An estimate is a non-binding approximation. If your sub presents an estimate, ask for a quote. If they will not provide one, that is information about how they intend to invoice you.\n\n**What a valid subcontractor agreement includes:**\n- Defined scope of work\n- Fixed or not-to-exceed price\n- Payment terms\n- Who provides materials\n- Liability and insurance requirements\n- A change order clause: any scope change requires written authorization before work proceeds\n\nIf you do not have a subcontractor agreement template, build one before your next sub relationship begins.\n\n**The management markup rule:**\nAdd a 10-15% management markup to every subcontractor cost in your bid.\n\n| Sub Invoice Total | Markup | Amount to Charge Customer |\n|---|---|---|\n| $10,000 | 10% | $11,000 |\n| $10,000 | 15% | $11,500 |\n\nThis markup covers your coordination time, quality oversight, and the risk you carry if the sub underperforms. Build it into the bid from day one, not after the invoice surprises you.\n\n**The overrun rule:**\nWhen a sub claims additional work was required mid-job: written authorization before the work proceeds. If the sub proceeds without authorization, document it and dispute the overage on the invoice. If a sub regularly comes in over quote, track it. Three jobs with unexplained overruns is a pattern that requires a vendor management decision.",
  "key_takeaway": "A $10,000 sub quote that comes in at $12,500 is $2,500 you absorb, often without even knowing it until weeks later. The signed quote before work begins is the only process that prevents this."
}'::jsonb
FROM lessons WHERE slug = 'jcw-05-subcontractor-costs';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Subcontractor Cost Tracker",
  "description": "Track every sub on this job from quoted price to final invoice. The variance column is where cost overruns become visible before they hit your margin.",
  "fields": [
    {"label": "Sub 1: Trade and Company Name", "key": "sub1_name", "type": "text", "prefix": "", "suffix": "", "hint": "Identify the trade and company for record-keeping."},
    {"label": "Sub 1: Quoted Price", "key": "sub1_quoted", "type": "number", "prefix": "$", "suffix": "", "hint": "The signed quote amount before work began."},
    {"label": "Sub 1: Final Invoice", "key": "sub1_invoice", "type": "number", "prefix": "$", "suffix": "", "hint": "The actual invoice amount submitted by the sub."},
    {"label": "Sub 2: Quoted Price", "key": "sub2_quoted", "type": "number", "prefix": "$", "suffix": "", "hint": "Enter 0 if no second sub on this job."},
    {"label": "Sub 2: Final Invoice", "key": "sub2_invoice", "type": "number", "prefix": "$", "suffix": "", "hint": "Enter 0 if no second sub."},
    {"label": "Sub 3: Quoted Price", "key": "sub3_quoted", "type": "number", "prefix": "$", "suffix": "", "hint": "Enter 0 if no third sub."},
    {"label": "Sub 3: Final Invoice", "key": "sub3_invoice", "type": "number", "prefix": "$", "suffix": "", "hint": "Enter 0 if no third sub."},
    {"label": "Your Management Markup Percentage", "key": "mgmt_markup_pct", "type": "number", "prefix": "", "suffix": "%", "hint": "Typically 10-15%. This should already be included in your customer price."}
  ],
  "results": [
    {"label": "Total Subcontractor Cost (Final Invoices)", "key": "total_sub_actual", "formula": "sub1_invoice + sub2_invoice + sub3_invoice", "prefix": "$", "suffix": "", "benchmark": "This is what you actually paid. Compare to total quoted."},
    {"label": "Total Subcontractor Variance (Quoted Minus Actual)", "key": "total_sub_variance", "formula": "(sub1_quoted + sub2_quoted + sub3_quoted) - total_sub_actual", "prefix": "$", "suffix": "", "benchmark": "Positive means subs came in under quote. Negative means you absorbed overruns. Any negative variance requires a documented explanation."},
    {"label": "Recommended Customer Charge for Subs (with markup)", "key": "sub_customer_charge", "formula": "total_sub_actual * (1 + mgmt_markup_pct / 100)", "prefix": "$", "suffix": "", "benchmark": "If your bid was built with quoted prices plus markup, and final invoices came in higher, you need to assess whether a change order is warranted."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-05-subcontractor-costs';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Subcontractor Cost Takeaways",
  "highlights": [
    "No sub starts work without a signed quote with a defined scope. Not an estimate. Not a verbal agreement. A signed quote.",
    "The management markup is not optional. It covers real costs: your coordination time, quality oversight, and the risk of absorbing overruns.",
    "If a sub regularly comes in over quote, that is a vendor relationship to examine, not a one-time dispute to absorb."
  ],
  "next_steps": [
    "Audit your last five sub relationships. How many had a signed quote before work began? How many came in over?",
    "Build or update your subcontractor agreement template to include a change order clause.",
    "Check that your current bids include a 10-15% management markup on all sub line items."
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-05-subcontractor-costs';

-- ── Lesson 6 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'jcw-06-overhead-allocation',
  'Overhead Allocation: The Cost Most Contractors Skip',
  'Every job must carry its share of fixed monthly overhead. If you skip this step, your gross margin is a fiction.',
  'mirror',
  16,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "How to Allocate Overhead to Every Job",
  "body": "Every job must carry its share of fixed monthly overhead. If you skip this step, your gross margin calculation is not real. It is a fiction that makes jobs look more profitable than they are.\n\n**The overhead allocation formula:**\n\n1. Monthly Overhead divided by Monthly Revenue = Overhead Rate %\n2. Overhead Rate % x This Job''s Contract Value = Overhead Allocated to This Job\n\n**Example:**\n$45,000 monthly overhead divided by $300,000 monthly revenue = 15% overhead rate. A $28,000 job should carry $4,200 in overhead allocation.\n\n**What counts as overhead:**\nAll fixed monthly costs that exist whether any jobs run or not. This includes:\n- Rent and utilities for your shop or office\n- Owner and admin salaries\n- Vehicle payments and insurance (fleet vehicles)\n- Software and subscriptions\n- Marketing and advertising spend\n- Insurance premiums (general liability, commercial auto, etc.)\n- Equipment payments\n- Phone and communication\n\n**The critical rule:**\nIf you do not have a monthly overhead number, stop and build one before completing this worksheet. Your overhead is the floor below which every job must earn. Without knowing that number, no margin calculation you make is accurate.\n\n**What the overhead rate tells you about your business:**\n- Overhead as % of Revenue below 18%: Strong\n- Overhead as % of Revenue 18-25%: Acceptable\n- Overhead as % of Revenue above 28%: Investigate. Your overhead is too high for your current revenue level.\n\nIf overhead allocation is consistently reducing your margin below target, you have two options: reduce overhead or increase revenue. The worksheet shows you exactly how much revenue you need to bring overhead into line.",
  "key_takeaway": "A job that shows 35% gross margin before overhead might show 20% after it. That 15-point difference is not the job''s fault. It is a business structure problem you can only see if you allocate overhead on every job."
}'::jsonb
FROM lessons WHERE slug = 'jcw-06-overhead-allocation';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Overhead Allocation Calculator",
  "description": "Calculate how much of your monthly overhead this specific job should carry. This number belongs in your job cost summary alongside materials, labor, and subs.",
  "fields": [
    {"label": "Total Monthly Overhead", "key": "monthly_overhead", "type": "number", "prefix": "$", "suffix": "", "hint": "All fixed monthly costs: rent, admin salaries, insurance, vehicles, software, marketing. Build this number from your actual P&L if you do not have it."},
    {"label": "Monthly Revenue Target", "key": "monthly_revenue_target", "type": "number", "prefix": "$", "suffix": "", "hint": "What you plan to close this month. Use last month''s actual if planning data is unreliable."},
    {"label": "This Job''s Contract Value", "key": "this_job_value", "type": "number", "prefix": "$", "suffix": "", "hint": "The total signed contract for this specific job."}
  ],
  "results": [
    {"label": "Overhead Rate", "key": "overhead_rate", "formula": "monthly_overhead / monthly_revenue_target * 100", "prefix": "", "suffix": "%", "benchmark": "Target: Below 18%. Acceptable: 18-25%. Above 28%: your overhead is too high for current revenue or your revenue target is too low."},
    {"label": "Overhead Allocated to This Job", "key": "job_overhead", "formula": "this_job_value * overhead_rate / 100", "prefix": "$", "suffix": "", "benchmark": "This amount must be included in your Total Job Cost. It is a real cost, not optional."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-06-overhead-allocation';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Overhead Allocation Takeaways",
  "highlights": [
    "Overhead is a real cost on every job. Skipping it does not make it disappear. It just makes your margin look better than it is until you run out of cash.",
    "If you do not have a monthly overhead number, calculating it is the most important financial task in your business right now. Everything else depends on it.",
    "The overhead rate tells you how lean or bloated your fixed cost structure is relative to your revenue. A rate above 28% means your overhead has grown faster than your revenue."
  ],
  "next_steps": [
    "Build your monthly overhead number from your last three months of bank statements or P&L. Add every fixed cost that appears regardless of job volume.",
    "Calculate your current overhead rate: monthly overhead divided by monthly revenue times 100.",
    "Add overhead allocation as a required line in your job cost summary for every job starting now."
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-06-overhead-allocation';

-- ── Lesson 7 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'jcw-07-job-cost-summary-and-gross-profit',
  'The Job Cost Summary: Your Real Gross Margin',
  'This is the page where the full picture comes together. Contract value minus all four cost categories equals gross profit. That percentage is the number that matters.',
  'mirror',
  17,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Reading Your Job Cost Summary",
  "body": "The job cost summary pulls your totals from each section into a single view. This is where you calculate gross profit and compare it to your target.\n\n**The five-line summary:**\n1. Total Material Cost (from material section)\n2. Total Labor Cost (from labor section, burdened rate)\n3. Total Subcontractor Cost (from sub section, final invoices)\n4. Overhead Allocation (from overhead section)\n5. Total Job Cost (sum of all four)\n\n**Gross profit calculation:**\nContract Value minus Total Job Cost = Gross Profit\nGross Profit divided by Contract Value times 100 = Gross Profit Percentage\n\n**What good looks like by job type:**\n\n| Job Type | Gross Margin Target | What This Means |\n|---|---|---|\n| Renovation / Remodel | 30-40% | Achievable with accurate takeoffs and tight labor management |\n| New Construction | 20-30% | Lower margin but higher volume. Overhead control and labor efficiency are critical. |\n| Service / Repair | 40-55% | Highest margin potential. Low material cost and premium billing for skilled response. |\n| Specialty / Custom | 35-45% | Strong margins when scoped and priced correctly. Underpriced custom jobs destroy margin fast. |\n| Below 20% on any type | WARNING | Investigate immediately. Business is in trouble regardless of revenue. |\n\n**The benchmark check:**\nAfter calculating gross profit percentage, ask three questions:\n1. Is this job above or below your target for this job type?\n2. Which cost category had the largest variance?\n3. Was the variance driven by a process failure or an estimating error?\n\nThe answer to question 3 determines whether you fix the process or fix the takeoff.",
  "key_takeaway": "Gross margin percentage is the most important number on this worksheet. Revenue tells you the size of the job. Margin tells you whether you should have taken it."
}'::jsonb
FROM lessons WHERE slug = 'jcw-07-job-cost-summary-and-gross-profit';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Job Cost Summary",
  "description": "Transfer your totals from each cost section. This is your complete picture for this job.",
  "fields": [
    {"label": "Contract Value (Total Revenue for This Job)", "key": "contract_value", "type": "number", "prefix": "$", "suffix": "", "hint": "Total signed contract amount including signed change orders."},
    {"label": "Total Material Cost", "key": "total_materials", "type": "number", "prefix": "$", "suffix": "", "hint": "From your material cost tracker (actual, not estimated)."},
    {"label": "Total Labor Cost (Burdened)", "key": "total_labor", "type": "number", "prefix": "$", "suffix": "", "hint": "Total hours times base wage times burden multiplier."},
    {"label": "Total Subcontractor Cost", "key": "total_subs", "type": "number", "prefix": "$", "suffix": "", "hint": "Final invoices from all subs on this job."},
    {"label": "Overhead Allocation", "key": "overhead_allocation", "type": "number", "prefix": "$", "suffix": "", "hint": "Contract value times your overhead rate percentage."},
    {"label": "Your Target Gross Margin for This Job Type", "key": "target_margin_pct", "type": "number", "prefix": "", "suffix": "%", "hint": "Renovation: 30-40%. New Construction: 20-30%. Service/Repair: 40-55%. Specialty: 35-45%."}
  ],
  "results": [
    {"label": "Total Job Cost", "key": "total_job_cost", "formula": "total_materials + total_labor + total_subs + overhead_allocation", "prefix": "$", "suffix": "", "benchmark": "All four cost categories combined. This is what you spent to deliver this job."},
    {"label": "Gross Profit (Dollar Amount)", "key": "gross_profit_dollars", "formula": "contract_value - total_job_cost", "prefix": "$", "suffix": "", "benchmark": "Positive means the job made money. Negative means you paid to do this job. Either way, you need to know why."},
    {"label": "Gross Profit Percentage", "key": "gross_profit_pct", "formula": "gross_profit_dollars / contract_value * 100", "prefix": "", "suffix": "%", "benchmark": "Compare to your target margin for this job type. Below 20% on any job type requires immediate investigation."},
    {"label": "Margin vs. Target", "key": "margin_vs_target", "formula": "gross_profit_pct - target_margin_pct", "prefix": "", "suffix": " pts", "benchmark": "Positive means you beat your target. Negative means you missed it. The sign and the magnitude both matter."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-07-job-cost-summary-and-gross-profit';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Job Cost Summary Takeaways",
  "highlights": [
    "If your gross profit percentage is below your job-type target, the next question is which cost category drove the miss: materials, labor, subs, or overhead.",
    "A job that looks profitable at revenue level can still destroy your business if the margin is wrong. Gross profit percentage, not revenue, is the number to manage.",
    "Tracking this number on 10 consecutive jobs reveals your real average margin. That number, not your bid margin, is what you actually run your business on."
  ],
  "next_steps": [
    "Calculate gross profit percentage on your last three completed jobs using actual invoices.",
    "Identify the largest variance category on each of those three jobs.",
    "Set your target gross margin for each job type you regularly do and post it where you review new bids."
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-07-job-cost-summary-and-gross-profit';

-- ── Lesson 8 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'jcw-08-margin-killers',
  'The Five Margin Killers and How to Stop Each One',
  'Five specific failure modes account for most margin losses in contracting. Each has a defined cause and a concrete fix.',
  'mirror',
  18,
  11
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Where Your Margin Goes: The Five Failure Modes",
  "body": "Five margin killers account for most of what contractors leave on the table. For each one: what it costs you, why it happens, and the fix.\n\n**1. Material Overruns**\nWhat it costs: 3-8% of job revenue on a typical $25,000 job. That is $750 to $2,000 per job.\nWhy it happens: The takeoff was done from memory or satellite measurement. No waste factor applied. Crew ordered a partial square to finish and it was never tracked against the PO.\nThe fix: Build a line-item materials list before the first delivery, apply waste factor at estimate time, and track every delivery against the PO.\n\n**2. Labor Inefficiency**\nWhat it costs: Every hour over budget at $28/hr burdened adds $28 to your cost with no matching revenue.\nWhy it happens: No daily production target was set before the crew started. The foreman does not know how many units of work per day are needed to hit the labor budget. No one checks progress until the job is done.\nThe fix: Set a daily production target before day one. Do an end-of-day production check. If the crew is tracking 20% behind, make a decision, not an observation.\n\n**3. Scope Creep Without Change Orders**\nWhat it costs: Every extra item installed but not billed is a dollar-for-dollar reduction in gross profit.\nWhy it happens: The crew found additional damage and fixed it on the spot. The homeowner asked for something extra and the field lead said yes. A change order was written but never signed and the customer disputes it.\nThe fix: Nothing gets installed without a signed change order before work begins. No exceptions.\n\n**4. Subcontractor Cost Overruns**\nWhat it costs: A $10,000 sub quote that comes in at $12,500 is $2,500 you absorb, often without knowing it until weeks later.\nWhy it happens: You accepted an estimate instead of a quote. No signed subcontractor agreement with a defined scope. The sub added charges mid-job and you were not informed until the invoice arrived.\nThe fix: Signed quote before work begins. Scope defined in writing. Any scope change requires a written change order from the sub before it is authorized.\n\n**5. Margin Not Tracked Until the End**\nWhat it costs: By the time you calculate margin at job close, every cost is fixed and nothing can be recovered.\nWhy it happens: Job costing is treated as a bookkeeping function. The worksheet gets filled out after the job is done, invoices are paid, and the check is cashed.\nThe fix: Check margin three times: after materials are delivered, at 50% complete, and at job close. The first two checks are when you can still make decisions.",
  "key_takeaway": "Every margin killer on this list is a process failure, not bad luck. Each one has a defined fix that requires a documented standard, not just a better intention."
}'::jsonb
FROM lessons WHERE slug = 'jcw-08-margin-killers';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Mid-Job Margin Check (50% Complete)",
  "description": "This check happens at 50% physical completion. If you are 50% done but have spent 65% of your budget, you have a problem you can still address. Fill this in on every job at the midpoint.",
  "fields": [
    {"label": "Materials Invoiced to Date", "key": "materials_to_date", "type": "number", "prefix": "$", "suffix": "", "hint": "All material invoices received and approved so far on this job."},
    {"label": "Labor Cost to Date (Hours Worked x Burdened Rate)", "key": "labor_to_date", "type": "number", "prefix": "$", "suffix": "", "hint": "Total hours logged to date multiplied by your burdened hourly rate."},
    {"label": "Subcontractor Invoices Received to Date", "key": "subs_to_date", "type": "number", "prefix": "$", "suffix": "", "hint": "Final invoices from any subs that have completed their scope."},
    {"label": "Total Job Budget (from your bid)", "key": "total_budget", "type": "number", "prefix": "$", "suffix": "", "hint": "The total cost budget from your original bid, including all cost categories."},
    {"label": "Physical Completion Percentage (your estimate)", "key": "pct_complete", "type": "number", "prefix": "", "suffix": "%", "hint": "Your honest estimate of how much of the scope is physically done."}
  ],
  "results": [
    {"label": "Total Cost to Date", "key": "cost_to_date", "formula": "materials_to_date + labor_to_date + subs_to_date", "prefix": "$", "suffix": "", "benchmark": "Add overhead at its proportional share if you track it mid-job."},
    {"label": "Percentage of Budget Consumed", "key": "budget_consumed_pct", "formula": "cost_to_date / total_budget * 100", "prefix": "", "suffix": "%", "benchmark": "This number should be close to your physical completion percentage. If budget consumed significantly exceeds physical completion, you are tracking to a margin miss."},
    {"label": "Budget vs. Completion Variance", "key": "budget_completion_gap", "formula": "budget_consumed_pct - pct_complete", "prefix": "", "suffix": " pts", "benchmark": "Target: within 5 points. More than 10 points over means you have a specific cost category running hot. Find it now, not at close."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-08-margin-killers';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Margin Killer Fixes",
  "highlights": [
    "Scope creep without change orders is the easiest margin killer to stop because it is entirely within your control. The rule is simple: nothing gets installed that is not on paper. The difficulty is holding the standard when a field lead says yes without one.",
    "The mid-job margin check at 50% complete is the most valuable intervention point. It is the last moment where a labor or material problem is recoverable.",
    "A change order presented to a homeowner as protection for them, not just you, gets signed. ''This protects you from surprises and protects us from misunderstandings.'' Use that framing."
  ],
  "next_steps": [
    "Establish the change order rule in writing with your team this week. Nothing installed without a signed change order. No exceptions.",
    "Schedule a mid-job margin check at 50% completion on your next three active jobs.",
    "Identify which of the five margin killers has cost you the most in the last 90 days and build one process to address it."
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-08-margin-killers';

-- ── Lesson 9 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'jcw-09-job-type-comparison',
  'Job Type Comparison: Where to Focus Your Sales Effort',
  'The job type with the highest average gross margin is where you should focus your sales effort. The data will tell you what to sell more of.',
  'mirror',
  19,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Reading Your Margin by Job Type",
  "body": "Track gross margin on every job for 90 days to identify which job types, crews, and cost categories drive your results. After 10 completed worksheets, run a pattern analysis.\n\n**What to look for:**\n\n- If material costs are consistently above estimate: your takeoffs or waste factors are wrong.\n- If labor is consistently over budget: your production targets are wrong or your crew is not being held to them.\n- If subcontractor costs keep running over: you do not have a signed quote before work begins.\n- If overhead allocation is reducing margin below target: your overhead is too high for your current revenue level.\n\n**The job type comparison table (use data from last 90 days):**\n\n| Job Type | Average Contract Value | Average Material Cost | Average Labor Cost | Average Gross Margin % |\n|---|---|---|---|---|\n| Renovation / Remodel | | | | |\n| New Construction | | | | |\n| Service / Repair | | | | |\n| Specialty / Custom | | | | |\n| Commercial | | | | |\n\n**What the comparison tells you:**\n- The job type with the highest average gross margin is where you should focus your sales effort.\n- The job type with the most variance between contract value and actual margin is where you have the biggest operational gap.\n- If service and repair has the highest margin, build your sales process to attract more of that work.\n- If renovation jobs are consistently under 20%, your pricing model needs to be rebuilt from the cost up.\n- If margin varies widely within a single job type, you have a process consistency problem, not a pricing problem.\n\n**The key insight:**\nThe most profitable contracting businesses do not necessarily do the most volume. They do the highest-margin job types at the highest volume they can execute with consistent quality. Know your margin by job type. Chase the right work.",
  "key_takeaway": "Volume is vanity. Margin is sanity. The job type comparison tells you which work is actually building your business and which is just keeping you busy."
}'::jsonb
FROM lessons WHERE slug = 'jcw-09-job-type-comparison';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Job Type Average Margin Calculator",
  "description": "Use data from completed job worksheets to calculate your average gross margin by job type. Enter averages if you have multiple jobs per type.",
  "fields": [
    {"label": "Renovation / Remodel: Average Gross Margin %", "key": "reno_margin", "type": "number", "prefix": "", "suffix": "%", "hint": "Average from your last completed renovation jobs. Enter 0 if you do not do this work."},
    {"label": "New Construction: Average Gross Margin %", "key": "newcon_margin", "type": "number", "prefix": "", "suffix": "%", "hint": "Average from your last completed new construction jobs. Enter 0 if not applicable."},
    {"label": "Service / Repair: Average Gross Margin %", "key": "service_margin", "type": "number", "prefix": "", "suffix": "%", "hint": "Average from your last completed service and repair jobs. Enter 0 if not applicable."},
    {"label": "Specialty / Custom: Average Gross Margin %", "key": "specialty_margin", "type": "number", "prefix": "", "suffix": "%", "hint": "Average from your last custom or specialty jobs. Enter 0 if not applicable."},
    {"label": "Commercial: Average Gross Margin %", "key": "commercial_margin", "type": "number", "prefix": "", "suffix": "%", "hint": "Average from your last commercial jobs. Enter 0 if not applicable."},
    {"label": "Total Jobs Completed in Last 90 Days", "key": "jobs_90_days", "type": "number", "prefix": "", "suffix": "", "hint": "All job types combined."}
  ],
  "results": [
    {"label": "Your Highest-Margin Job Type Score", "key": "highest_margin", "formula": "reno_margin > newcon_margin ? (reno_margin > service_margin ? reno_margin : service_margin) : (newcon_margin > service_margin ? newcon_margin : service_margin)", "prefix": "", "suffix": "%", "benchmark": "This is the job type to prioritize in your sales effort. The type with the highest margin is where every additional deal has the most impact on profit."},
    {"label": "Jobs Per Month (Current Rate)", "key": "monthly_job_rate", "formula": "jobs_90_days / 3", "prefix": "", "suffix": " jobs/month", "benchmark": "Baseline volume for your business at current capacity."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-09-job-type-comparison';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Job Type Analysis Takeaways",
  "highlights": [
    "If you cannot fill in this comparison table because you do not have 90 days of job cost data, that is the answer. You need to start tracking now.",
    "Wide margin variance within a single job type means your process is inconsistent, not that some jobs are just harder. Consistent processes produce consistent margins.",
    "Your highest-margin job type should inform your marketing, your sales targeting, and your crew assignment strategy."
  ],
  "next_steps": [
    "Complete this comparison table using data from your last 10 completed jobs. Use invoices and payroll records if you do not have worksheets.",
    "Identify your highest-margin job type and calculate what a 20% increase in that job type''s volume would mean in annual profit.",
    "Share the comparison with whoever handles your sales or marketing. They need to know which work to chase."
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-09-job-type-comparison';

-- ── Lesson 10 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'jcw-10-90-day-sprint-and-kpi-dashboard',
  'The 90-Day Job Costing Sprint and KPI Dashboard',
  'Five KPIs calculated at the end of every month form the financial baseline for any contracting business. Track three months side by side and your trend becomes visible.',
  'mirror',
  20,
  9
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The 90-Day On-Ramp and the Five KPIs That Matter",
  "body": "For a company that has never tracked job costs before, starting cold can feel overwhelming. The 90-day sprint gives you a structured on-ramp.\n\n**The 4-Week Launch Plan:**\n\n**Week 1:** Complete this worksheet for 3 recently finished jobs using actual invoices, payroll records, and supplier receipts. Calculate the real gross margin on each. Deliverable: 3 worksheets complete.\n\n**Week 2:** Identify the pattern. Which cost category had the largest average variance across those 3 jobs? That is your target. Deliverable: Biggest variance category identified.\n\n**Week 3:** Build one process to address the biggest variance. If it is materials, build a pre-job materials checklist. If it is labor, build a daily production target sheet. If it is subs, build a signed quote requirement into your sub onboarding. Deliverable: One process documented and assigned.\n\n**Week 4:** Track 3 in-progress jobs with this worksheet in real time. Materials: check at delivery. Labor: check daily. Subs: review quotes before authorization. Deliverable: 3 live jobs being tracked.\n\n**The 5 Monthly KPIs:**\n\n| KPI | How to Calculate |\n|---|---|\n| Average Gross Margin Per Job | Sum all job gross margins divided by number of jobs |\n| Material Cost as % of Revenue | Total material cost divided by total revenue times 100 |\n| Labor Cost as % of Revenue | Total burdened labor cost divided by total revenue times 100 |\n| Overhead as % of Total Revenue | Total monthly overhead divided by total revenue times 100 |\n| Net Profit Margin | Net profit (after owner salary and all expenses) divided by revenue times 100 |\n\n**Industry benchmark reference:**\n\n| KPI | Strong | Acceptable | Investigate |\n|---|---|---|---|\n| Average Gross Margin | 35%+ | 25-35% | Below 20% |\n| Material Cost as % Revenue | Below 30% | 30-38% | Above 40% |\n| Labor Cost as % Revenue | Below 20% | 20-28% | Above 30% |\n| Overhead as % Revenue | Below 18% | 18-25% | Above 28% |\n| Net Profit Margin | 10%+ | 5-10% | Below 5% |",
  "key_takeaway": "Track these five KPIs for three consecutive months. The trend line is more important than any single month''s number. What moved and which direction is the question that drives your next process improvement."
}'::jsonb
FROM lessons WHERE slug = 'jcw-10-90-day-sprint-and-kpi-dashboard';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Monthly KPI Dashboard",
  "description": "Calculate these five KPIs at the end of every month using your completed job worksheets. Three months of data side by side will show you your trend.",
  "fields": [
    {"label": "Total Monthly Revenue (all jobs)", "key": "monthly_revenue", "type": "number", "prefix": "$", "suffix": "", "hint": "Sum of all contract values for jobs completed and invoiced this month."},
    {"label": "Total Material Cost This Month", "key": "total_material_cost", "type": "number", "prefix": "$", "suffix": "", "hint": "Sum of all actual material costs from completed job worksheets."},
    {"label": "Total Burdened Labor Cost This Month", "key": "total_labor_cost", "type": "number", "prefix": "$", "suffix": "", "hint": "Sum of all actual burdened labor costs from completed job worksheets."},
    {"label": "Total Monthly Overhead", "key": "total_overhead", "type": "number", "prefix": "$", "suffix": "", "hint": "Your fixed monthly overhead number (same value used in overhead allocation for each job)."},
    {"label": "Number of Jobs Completed This Month", "key": "jobs_completed", "type": "number", "prefix": "", "suffix": "", "hint": "All jobs where final invoice was sent."},
    {"label": "Total Gross Profit (All Jobs Combined)", "key": "total_gross_profit", "type": "number", "prefix": "$", "suffix": "", "hint": "Sum of gross profit from all completed job worksheets."},
    {"label": "Net Profit (After Owner Salary and All Expenses)", "key": "net_profit", "type": "number", "prefix": "$", "suffix": "", "hint": "From your P&L or bookkeeper: revenue minus all expenses including your own salary."}
  ],
  "results": [
    {"label": "Average Gross Margin Per Job", "key": "avg_gross_margin", "formula": "total_gross_profit / monthly_revenue * 100", "prefix": "", "suffix": "%", "benchmark": "Strong: 35%+. Acceptable: 25-35%. Investigate: below 20%."},
    {"label": "Material Cost as % of Revenue", "key": "material_pct", "formula": "total_material_cost / monthly_revenue * 100", "prefix": "", "suffix": "%", "benchmark": "Strong: below 30%. Acceptable: 30-38%. Investigate: above 40%."},
    {"label": "Labor Cost as % of Revenue", "key": "labor_pct", "formula": "total_labor_cost / monthly_revenue * 100", "prefix": "", "suffix": "%", "benchmark": "Strong: below 20%. Acceptable: 20-28%. Investigate: above 30%."},
    {"label": "Overhead as % of Revenue", "key": "overhead_pct", "formula": "total_overhead / monthly_revenue * 100", "prefix": "", "suffix": "%", "benchmark": "Strong: below 18%. Acceptable: 18-25%. Investigate: above 28%."},
    {"label": "Net Profit Margin", "key": "net_profit_margin", "formula": "net_profit / monthly_revenue * 100", "prefix": "", "suffix": "%", "benchmark": "Strong: 10%+. Acceptable: 5-10%. Investigate: below 5%."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-10-90-day-sprint-and-kpi-dashboard';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "90-Day Sprint and KPI Dashboard Takeaways",
  "highlights": [
    "The 90-day sprint is not about perfection from day one. It is about getting three months of real data so you can see patterns. Week 1 is the hardest. The data gets easier to use after that.",
    "The five KPIs together tell a complete financial story. One KPI in isolation is not enough. A high gross margin with a high overhead rate might still produce a poor net profit margin.",
    "The monthly review questions matter as much as the numbers: Which job had the highest margin? Which had the lowest? What is the one process change that would have the biggest impact on next month''s numbers?"
  ],
  "next_steps": [
    "Complete the monthly KPI dashboard for last month using your best available data. Estimates are acceptable for the first run. Real numbers replace them as your tracking improves.",
    "Set a recurring monthly review date on your calendar for the next three months. The review should take no more than 30 minutes with a completed dashboard.",
    "After 90 days, run a pattern analysis: average gross margin by job type, highest variance cost category, and the one process improvement that would have had the most impact."
  ]
}'::jsonb
FROM lessons WHERE slug = 'jcw-10-90-day-sprint-and-kpi-dashboard';
