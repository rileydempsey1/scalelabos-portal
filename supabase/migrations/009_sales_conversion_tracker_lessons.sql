-- ============================================================
-- Migration: 009_sales_conversion_tracker_lessons.sql
-- Lesson count: 10 lessons
-- Pillar: mirror
-- PDF source: SLO-Sales-Conversion-Tracker.pdf
--
-- Schema assumptions for Jared to verify before running:
--   1. uuid-ossp extension is already enabled (uuid_generate_v4() is available).
--   2. lessons table exists with columns: id, slug, title, description,
--      pillar_key, position, duration_minutes, created_at.
--   3. lesson_steps table exists with columns: id, lesson_id, position,
--      step_type, content (jsonb), created_at.
--   4. No unique-slug conflicts with existing lessons rows.
--   5. pillar_key 'mirror' is an accepted value (no enum constraint blocking it).
-- ============================================================

-- ── Lesson 1 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'sct-01-what-is-a-conversion-leak',
  'What Is a Conversion Leak',
  'Most contractors think they lose deals on price. They lose them at specific, measurable process failures earlier in the funnel.',
  'mirror',
  1,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Where Revenue Actually Disappears",
  "body": "Most contractors believe they are losing deals because of price. They are wrong.\n\nThe majority of revenue lost in a roofing or restoration sales operation disappears at specific, identifiable process failures that have nothing to do with your contract numbers.\n\nA **conversion leak** is any point in your sales pipeline where qualified opportunities quietly exit the funnel without a clear decision being made. These leaks are invisible if you only track your final close rate. They become obvious the moment you start measuring every stage.\n\n**Why this compounds fast:**\n\nIf your team generates 100 leads per month and your overall close rate is 15%, you close 15 deals. But if your appointment-set rate improved from 50% to 70%, and your inspection-to-proposal rate went from 60% to 85%, the compounding effect of fixing just those two stages can more than double your closed revenue without generating a single additional lead.\n\n**The 6 stages every roofing sale passes through:**\n- Stage 1: Lead Generation. How prospects find you or how you find them.\n- Stage 2: First Contact. The window between lead and booked appointment.\n- Stage 3: Inspection and Assessment. What happens on-site determines proposal quality.\n- Stage 4: The Proposal. How you present determines whether they decide.\n- Stage 5: The Close. Commitment won or lost on process.\n- Stage 6: Follow-Up and Referrals. The revenue most companies leave on the table permanently.\n\nEach stage has its own conversion rate, its own failure modes, and its own set of fixes.",
  "key_takeaway": "Your overall close rate hides the leaks. Measuring every stage is what shows you where the money is actually going."
}'::jsonb
FROM lessons WHERE slug = 'sct-01-what-is-a-conversion-leak';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'summary', '{
  "title": "Conversion Leaks: The Core Idea",
  "highlights": [
    "A low close rate is almost never a price problem. It is a process problem at one or more specific funnel stages.",
    "Fixing two stages simultaneously creates a compounding effect. A 20-point improvement across two stages can double closed revenue on the same lead volume.",
    "The fix starts with measurement. You cannot close a leak you cannot see."
  ],
  "next_steps": [
    "Write down your current overall close rate from last month.",
    "Identify whether you are tracking conversion at every stage or only tracking final closed deals.",
    "Commit to filling in a stage-by-stage tracker for the next 30 days before making any other changes."
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-01-what-is-a-conversion-leak';

-- ── Lesson 2 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'sct-02-the-6-stage-funnel-map',
  'The 6-Stage Funnel Map',
  'A clear-eyed look at every stage in the roofing sales process: what good looks like, and the most common reasons companies fail at each one.',
  'mirror',
  2,
  9
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "What Each Stage Demands from Your Operation",
  "body": "Every roofing and restoration sale moves through six distinct stages. Here is what good looks like at each one, and where most operations break down.\n\n**Stage 1: Lead Generation**\nGood: Multiple sources active, consistent volume each month, tracked cost per lead by channel.\nFailure: Single source dependency, no lead quality scoring, chasing any address without qualification.\n\n**Stage 2: First Contact**\nGood: Contact within 24 hours, appointment set rate above 60%, confirmation sent, low no-show rate.\nFailure: Slow follow-up, no confirmation process, no-show rate above 20%, no scripts for objections.\n\n**Stage 3: Inspection**\nGood: Thorough documentation, damage framed in homeowner language, proposal written from every inspection.\nFailure: Incomplete documentation, rep decides for the homeowner that damage is not worth pursuing, no photo evidence.\n\n**Stage 4: Proposal**\nGood: In-person presentation, clear scope, options not ultimatums, decision conversation happens on-site.\nFailure: Emailing proposals and waiting, no follow-up timing, overwhelming the homeowner with technical language.\n\n**Stage 5: The Close**\nGood: Close rate above 35%, clear objection-handling process, decision made in the meeting, not days later.\nFailure: Leaving without a decision, no close language prepared, price given before value is established.\n\n**Stage 6: Follow-Up and Referrals**\nGood: Referral asked on every job, 2 or more referrals per closed job, referral close rate tracked separately.\nFailure: No referral ask, no system, relying on goodwill instead of process. This is where most companies lose their growth multiplier.",
  "key_takeaway": "Each stage has a predictable failure mode. Knowing the failure mode in advance lets you build a process to prevent it."
}'::jsonb
FROM lessons WHERE slug = 'sct-02-the-6-stage-funnel-map';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Stage Benchmarks: Where Do You Stand?",
  "description": "Rate your current operation at each stage. Use your actual last-30-days numbers where you have them. Estimate where you do not.",
  "fields": [
    {"label": "Lead-to-Appointment Rate", "key": "lead_to_appt_pct", "type": "number", "prefix": "", "suffix": "%", "hint": "Appointments booked divided by leads generated times 100."},
    {"label": "Appointment-to-Inspection Rate", "key": "appt_to_inspection_pct", "type": "number", "prefix": "", "suffix": "%", "hint": "Inspections completed divided by appointments booked times 100."},
    {"label": "Inspection-to-Proposal Rate", "key": "inspection_to_proposal_pct", "type": "number", "prefix": "", "suffix": "%", "hint": "Proposals written divided by inspections completed times 100."},
    {"label": "Proposal Presentation Rate", "key": "proposal_to_presentation_pct", "type": "number", "prefix": "", "suffix": "%", "hint": "Proposals presented in person divided by proposals written times 100."},
    {"label": "Presentation-to-Close Rate", "key": "presentation_to_close_pct", "type": "number", "prefix": "", "suffix": "%", "hint": "Deals closed divided by proposals presented in person times 100."},
    {"label": "Referral Ask Rate", "key": "referral_ask_pct", "type": "number", "prefix": "", "suffix": "%", "hint": "Jobs where you directly asked for a referral divided by total closed jobs times 100."}
  ],
  "results": [
    {"label": "Overall Funnel Efficiency", "key": "funnel_efficiency", "formula": "lead_to_appt_pct / 100 * appt_to_inspection_pct / 100 * inspection_to_proposal_pct / 100 * presentation_to_close_pct / 100 * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 15% overall minimum. Top operators reach 25-35%."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-02-the-6-stage-funnel-map';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Your Funnel at a Glance",
  "highlights": [
    "The stage with the biggest gap below benchmark is your Priority 1 fix. Everything else waits.",
    "A referral ask rate below 80% is one of the most common and most fixable revenue leaks in a roofing operation.",
    "Your overall funnel efficiency is the product of every stage rate multiplied together. Improving one stage improves every stage that follows it."
  ],
  "next_steps": [
    "Identify your single lowest-performing stage compared to benchmark.",
    "Write down the specific failure mode at that stage from this lesson.",
    "Assign one person ownership of tracking that stage number weekly for the next 30 days."
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-02-the-6-stage-funnel-map';

-- ── Lesson 3 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'sct-03-stage-1-lead-generation',
  'Stage 1: Lead Generation',
  'Volume matters, but lead quality matters more. Track every source separately and know your real cost per lead.',
  'mirror',
  3,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Lead Source Quality and the Cost Blind Spot",
  "body": "Lead generation is the foundation of your entire funnel. Most roofing and restoration companies rely on one or two lead sources and have no idea what each lead actually costs them in time and money. That blind spot is expensive.\n\n**What each source tells you:**\n\n- **Door knock leads:** Highest volume, lower qualification. Score based on damage visibility and homeowner engagement at the door.\n- **Referral leads:** Highest quality. Referrals close at 2x to 3x the rate of cold leads. If you are not tracking these separately, you are missing your best signal.\n- **Digital leads:** Measure cost-per-lead carefully. Traffic volume means nothing without appointment conversion. A $40 click that converts at 2% is not a good lead. A $90 click that converts at 12% is.\n- **Storm leads:** Timing-dependent. Track separately from your evergreen sources.\n\n**What good looks like at Stage 1:**\n- At least three active lead sources running simultaneously.\n- Referrals representing 20% or more of monthly lead volume.\n- Cost per lead tracked by source, not averaged across all sources.\n- Lead quality scored before an inspector slot is committed.\n\n**The failure mode:** If referrals are under 10% of your volume, your post-close process needs immediate attention. Referrals do not happen by accident. They happen because someone asked.",
  "key_takeaway": "A healthy operation never depends on a single lead source, and every source has a tracked cost per lead and a tracked close rate."
}'::jsonb
FROM lessons WHERE slug = 'sct-03-stage-1-lead-generation';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Monthly Lead Source Tracker",
  "description": "Enter your lead volume and estimated cost by source for the current month. This gives you a cost-per-lead by channel so you can see which sources are worth protecting and which are not.",
  "fields": [
    {"label": "Total Leads This Month", "key": "total_leads", "type": "number", "prefix": "", "suffix": "", "hint": "All lead sources combined."},
    {"label": "Leads from Door Knocking", "key": "door_knock_leads", "type": "number", "prefix": "", "suffix": "", "hint": "Count only leads where an appointment was attempted."},
    {"label": "Leads from Referrals", "key": "referral_leads", "type": "number", "prefix": "", "suffix": "", "hint": "Leads that came directly from a previous customer introduction."},
    {"label": "Leads from Digital (web, social, ads)", "key": "digital_leads", "type": "number", "prefix": "", "suffix": "", "hint": "Any lead sourced through an online channel."},
    {"label": "Leads from Storm Chasing / Canvassing", "key": "storm_leads", "type": "number", "prefix": "", "suffix": "", "hint": "Event-driven leads from storm activity or active canvassing campaigns."},
    {"label": "Total Digital Ad Spend This Month", "key": "digital_spend", "type": "number", "prefix": "$", "suffix": "", "hint": "All spend on paid digital channels for the month."},
    {"label": "Door Knock Labor Cost This Month", "key": "door_knock_cost", "type": "number", "prefix": "$", "suffix": "", "hint": "Canvasser pay plus mileage attributable to door knocking."}
  ],
  "results": [
    {"label": "Referral Lead Percentage", "key": "referral_pct", "formula": "referral_leads / total_leads * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 20% or higher. Below 10% means your post-close referral ask process is broken."},
    {"label": "Digital Cost Per Lead", "key": "digital_cpl", "formula": "digital_spend / digital_leads", "prefix": "$", "suffix": "", "benchmark": "Benchmark varies by market. Track this monthly and watch the trend, not just the number."},
    {"label": "Door Knock Cost Per Lead", "key": "dk_cpl", "formula": "door_knock_cost / door_knock_leads", "prefix": "$", "suffix": "", "benchmark": "Compare to your digital CPL. Neither is better by default. Close rate by source determines true cost per deal."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-03-stage-1-lead-generation';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Stage 1 Takeaways",
  "highlights": [
    "Referral leads close at 2x to 3x the rate of cold leads. If you are not tracking them separately, you cannot see your best-performing channel.",
    "Single source dependency is a business risk. If one source dries up, your pipeline does too.",
    "Lead quality scoring before you commit an inspector slot protects your most limited resource: field time."
  ],
  "next_steps": [
    "Pull last month''s leads and categorize every one by source.",
    "Calculate your referral percentage. If it is below 20%, add a referral ask process to every job close.",
    "Set up a simple spreadsheet with one row per source showing volume, estimated cost, and eventual close rate."
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-03-stage-1-lead-generation';

-- ── Lesson 4 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'sct-04-stage-2-first-contact',
  'Stage 2: First Contact and No-Show Prevention',
  'Speed-to-contact and appointment confirmation are the two highest-leverage changes most roofing operations can make right now.',
  'mirror',
  4,
  10
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Contact Window and Why It Closes Fast",
  "body": "The window between lead and booked appointment is one of the highest-leverage points in your entire sales process. Research across service industries consistently shows that contact within the first hour dramatically outperforms contact after 24 hours. In roofing, where homeowners are often stressed and shopping multiple contractors, speed is a direct competitive advantage.\n\n**The 3-Touch Follow-Up Sequence:**\n\n**Touch 1: Call within 2 hours of lead receipt** (during business hours). If received after 6pm, call before 9am the next morning. Leave a voicemail: specific, short, action-oriented.\n\n**Touch 2: Text within 2 hours of missed call.** Not a paragraph. One or two sentences. Include your name and company. A text that takes 10 seconds to read gets responded to. A text that looks like an email does not.\n\n**Touch 3: Day 2 call if no response.** One more call. If no answer, one final text: \"Reaching out one last time about your roof. Happy to get out and take a look at no charge. Just reply here or call [number].\" After this, move the lead to inactive. Do not keep chasing.\n\n**No-Show Prevention:**\nA booked appointment that does not happen is a complete waste of inspector time. One day-before confirmation call or text cuts the no-show rate by 30-50% in most operations.\n- 24 hours before: Send a confirmation with rep name, time, address, and a direct number.\n- 1 hour before: Brief text. \"Heading your way at [time]. See you shortly.\" This keeps the appointment top of mind and gives the homeowner an easy way to reschedule rather than just not answering the door.\n\n**Industry benchmarks:**\n- Appointment set rate: 65-75% of contacted leads.\n- No-show rate: Below 12%.\n- Both are achievable with a documented, consistent contact process.",
  "key_takeaway": "If your top no-show reason is ''found another contractor,'' your speed-to-contact is the problem, not the homeowner."
}'::jsonb
FROM lessons WHERE slug = 'sct-04-stage-2-first-contact';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Stage 2 Monthly Contact Tracker",
  "description": "Enter your Stage 2 numbers for the current month. These inputs reveal whether your contact process is winning or losing appointments before the inspection ever happens.",
  "fields": [
    {"label": "Total Leads Requiring Outbound Contact", "key": "total_contact_leads", "type": "number", "prefix": "", "suffix": "", "hint": "All leads that required you to initiate contact."},
    {"label": "Leads Contacted Within 24 Hours", "key": "contacted_24h", "type": "number", "prefix": "", "suffix": "", "hint": "Count only leads where first contact was made within 24 hours of receipt."},
    {"label": "Appointments Set", "key": "appts_set", "type": "number", "prefix": "", "suffix": "", "hint": "Total appointments booked this month from all lead contact attempts."},
    {"label": "No-Shows This Month", "key": "no_shows", "type": "number", "prefix": "", "suffix": "", "hint": "Appointments that did not result in an inspection due to homeowner absence or cancellation."},
    {"label": "Appointments With Day-Before Confirmation Sent", "key": "confirmed_appts", "type": "number", "prefix": "", "suffix": "", "hint": "Count appointments where a confirmation was sent 24 hours prior."}
  ],
  "results": [
    {"label": "Appointment Set Rate", "key": "appt_set_rate", "formula": "appts_set / total_contact_leads * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 65-75%. Below 50% means either lead quality or contact process is broken."},
    {"label": "No-Show Rate", "key": "no_show_rate", "formula": "no_shows / appts_set * 100", "prefix": "", "suffix": "%", "benchmark": "Target: Below 12%. Above 20% almost always means your confirmation process is missing."},
    {"label": "24-Hour Contact Rate", "key": "contact_24h_rate", "formula": "contacted_24h / total_contact_leads * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 90% or higher. Every hour of delay reduces appointment rate."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-04-stage-2-first-contact';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Stage 2 Fixes",
  "highlights": [
    "Speed to contact is a competitive advantage. The contractor who calls first wins the appointment more often than the contractor with the better pitch.",
    "The confirmation process is not optional. A single call or text the day before cuts no-shows by 30-50%. That is inspector time directly recovered.",
    "Three touches maximum on an unresponsive lead. More than that wastes time that should go to active leads."
  ],
  "next_steps": [
    "Document your current first contact standard in writing: who is responsible, what the timing is, and what the script says.",
    "Add a 24-hour appointment confirmation step to every booked appointment starting this week.",
    "Track your appointment set rate and no-show rate separately for the next 30 days."
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-04-stage-2-first-contact';

-- ── Lesson 5 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'sct-05-stage-3-inspection',
  'Stage 3: The Inspection. Where Your Sale Is Actually Won',
  'By the time you present the proposal, the homeowner has already made an emotional decision based on the inspection experience.',
  'mirror',
  5,
  11
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The BUILD Framework: Five Phases That Close at Higher Rates",
  "body": "Most reps think the close happens at the proposal. It does not. The emotional decision is made during the inspection. This stage measures how effectively your team turns site visits into proposals.\n\nThe inspection-to-proposal rate is your most important metric here. Below 70% means your reps are writing off opportunities that should become proposals. The target is 80-90%.\n\n**The BUILD Framework:**\n\n**B: Begin (first 5 minutes)**\nBefore climbing anything, introduce yourself, acknowledge their concern, and set the agenda. Ask when they first noticed the issue. Ask what their biggest concern is. Listen. Do not talk about damage yet. Your goal is to understand their situation so your findings land in the right context.\n\n**U: Uncover (systematic inspection)**\nDocument every issue. Minimum 20 photos: ridge, field, valleys, gutters, flashings, any visible interior evidence. Wide shots and close-ups. Measure and note everything. Your photos serve two purposes: they support the claim or proposal, and they become your visual close tool.\n\n**I: Identify (compile findings before speaking)**\nCome off the roof and organize your notes and photos before you say anything. Organize evidence into a logical sequence. Name what you found in plain language. \"This is granule loss from impact, which is why you are seeing the dark spots.\"\n\n**L: Lead (walk the homeowner through findings)**\nBring the homeowner to a spot where you can show them your screen. Walk through the findings with photos. Let the evidence do the talking. If you have before photos or a Google Earth view, show the undamaged state first, then current damage. The contrast tells the story better than any description.\n\n**D: Drive (transition to proposal)**\n\"Here is what needs to happen and here is what it costs.\" Never decide for the homeowner. Your job is to document, present, and propose. If there is visible damage, write the proposal. The homeowner decides what to do with it.\n\nWrite the proposal on-site whenever possible. A same-day proposal presented in person closes at significantly higher rates than one emailed 24 hours later.",
  "key_takeaway": "Every inspection with visible damage gets a written proposal. The rep''s job is not to decide whether the damage is worth pursuing. That is the homeowner''s decision."
}'::jsonb
FROM lessons WHERE slug = 'sct-05-stage-3-inspection';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Monthly Inspection Quality Tracker",
  "description": "Track your inspection stage numbers for the month. The inspection-to-proposal rate is the number most companies underestimate as a revenue driver.",
  "fields": [
    {"label": "Total Inspections Completed", "key": "total_inspections", "type": "number", "prefix": "", "suffix": "", "hint": "All site visits where a rep assessed the property."},
    {"label": "Inspections Where Damage Was Identified", "key": "damage_found", "type": "number", "prefix": "", "suffix": "", "hint": "Inspections where visible damage was documented by the rep."},
    {"label": "Proposals Written From Inspections", "key": "proposals_written", "type": "number", "prefix": "", "suffix": "", "hint": "Written proposals produced from inspections this month."},
    {"label": "Same-Day Proposals Presented On-Site", "key": "same_day_proposals", "type": "number", "prefix": "", "suffix": "", "hint": "Proposals presented to the homeowner during the inspection visit."},
    {"label": "Inspections With 20+ Photos Taken", "key": "inspections_with_photos", "type": "number", "prefix": "", "suffix": "", "hint": "Inspections where the rep documented at least 20 photos."},
    {"label": "Inspections Where Homeowner Walked Property With Rep", "key": "homeowner_walked", "type": "number", "prefix": "", "suffix": "", "hint": "Site visits where the homeowner physically walked the property alongside the rep."}
  ],
  "results": [
    {"label": "Inspection-to-Proposal Rate", "key": "inspection_to_proposal_pct", "formula": "proposals_written / total_inspections * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 80-90%. Below 70% is your single biggest revenue leak."},
    {"label": "Same-Day Proposal Rate", "key": "same_day_pct", "formula": "same_day_proposals / proposals_written * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 60% or higher. Same-day in-person proposals close at significantly higher rates than emailed proposals."},
    {"label": "Photo Documentation Rate", "key": "photo_rate", "formula": "inspections_with_photos / total_inspections * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 100%. Photos are not optional. They are your conversion tool."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-05-stage-3-inspection';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Stage 3 Fixes",
  "highlights": [
    "The highest-converting inspections involve the homeowner walking the property with the rep. If this is not happening on every visit, it is a process gap, not a personality issue.",
    "Before photos are not optional. They are your conversion tool. Every inspection needs photographic documentation before the proposal conversation begins.",
    "If your inspection-to-proposal rate is below 70%, your reps are making financial decisions for the homeowner without their input. That is both a revenue problem and an ethics problem."
  ],
  "next_steps": [
    "Add a mandatory 20-photo minimum to your inspection process and make it trackable.",
    "Train every rep on the BUILD framework. Role-play the ''Identify'' and ''Lead'' phases specifically.",
    "Pull last month''s inspection logs and count how many inspections did not produce a proposal. Investigate each one individually."
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-05-stage-3-inspection';

-- ── Lesson 6 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'sct-06-stage-4-proposal',
  'Stage 4: The Proposal That Gets a Decision',
  'A proposal emailed and never discussed is barely better than no proposal at all. In-person presentations close at 40-55%. Emailed proposals close at 20-30%.',
  'mirror',
  6,
  9
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Why Your Proposal Method Matters More Than Your Price",
  "body": "How you present determines whether the homeowner decides. The proposal stage is not about the document. It is about the conversation.\n\n**The numbers:**\n- In-person proposals close at **40-55%**.\n- Emailed proposals close at **20-30%**.\n- The gap is not about the homeowner. It is about your process.\n\nIf more than 30% of your proposals are sent by email, that is a controllable problem that is directly costing you closed deals.\n\n**What a proposal that gets a decision looks like:**\n- Presented in person, either same day as the inspection or at a dedicated follow-up meeting.\n- Scope written in plain language. No jargon. No abbreviations the homeowner cannot read.\n- Minimum 5 damage photos included in the document itself.\n- Warranty terms stated clearly. Homeowners who understand warranty coverage object less on price.\n- Timeline included. \"Install is typically scheduled within X weeks of signed contract.\"\n- Next steps written at the bottom. Do not assume the homeowner knows what signing means for the process.\n- Your direct name and number on the document. Not a main line.\n\n**Reading the pipeline:**\nTrack your total pipeline value every month. This tells you how much revenue is sitting undecided in your funnel right now. If this number grows month over month without a corresponding increase in closes, your proposal-to-decision conversion is leaking.\n\n\"Thinking about it\" after 7 days almost always means the proposal did not create enough urgency or clarity at presentation. The issue is in the presentation, not the price.",
  "key_takeaway": "If you are emailing proposals and waiting, you are cutting your close rate in half before the homeowner even reads the first line."
}'::jsonb
FROM lessons WHERE slug = 'sct-06-stage-4-proposal';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Monthly Proposal Stage Tracker",
  "description": "Break down how your proposals are being presented and where decisions are stalling. The ratio of in-person to emailed proposals is your most actionable data point here.",
  "fields": [
    {"label": "Total Proposals Sent This Month", "key": "total_proposals", "type": "number", "prefix": "", "suffix": "", "hint": "All written proposals generated this month."},
    {"label": "Proposals Presented In-Person (Same Day as Inspection)", "key": "same_day_inperson", "type": "number", "prefix": "", "suffix": "", "hint": "Proposals presented to the homeowner during the inspection visit."},
    {"label": "Proposals Presented In-Person (Separate Follow-Up)", "key": "followup_inperson", "type": "number", "prefix": "", "suffix": "", "hint": "Proposals that required a dedicated second meeting to present."},
    {"label": "Proposals Emailed Without In-Person Presentation", "key": "emailed_proposals", "type": "number", "prefix": "", "suffix": "", "hint": "Proposals sent via email with no corresponding in-person meeting."},
    {"label": "Average Proposal Value", "key": "avg_proposal_value", "type": "number", "prefix": "$", "suffix": "", "hint": "Total value of proposals divided by number of proposals."},
    {"label": "Proposals Where Homeowner Made a Decision (yes or no)", "key": "decisions_made", "type": "number", "prefix": "", "suffix": "", "hint": "Proposals that received a clear yes or no within 7 days."},
    {"label": "Proposals Still ''Thinking About It'' After 7 Days", "key": "stalled_proposals", "type": "number", "prefix": "", "suffix": "", "hint": "Open proposals with no decision after 7 days."}
  ],
  "results": [
    {"label": "In-Person Presentation Rate", "key": "inperson_rate", "formula": "(same_day_inperson + followup_inperson) / total_proposals * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 70% or higher. Below 70% means you are leaving deals on the table through process, not competition."},
    {"label": "Decision Rate Within 7 Days", "key": "decision_rate", "formula": "decisions_made / total_proposals * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 60% or higher. Low decision rate means urgency and clarity were not established at presentation."},
    {"label": "Pipeline Stall Rate", "key": "stall_rate", "formula": "stalled_proposals / total_proposals * 100", "prefix": "", "suffix": "%", "benchmark": "If above 40%, your proposal presentation process needs structural change."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-06-stage-4-proposal';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Stage 4 Fixes",
  "highlights": [
    "The 20-30 point close rate gap between emailed and in-person proposals is real and measurable in your own numbers. Stop emailing proposals to undecided homeowners.",
    "''Price'' as the top decline reason with a close rate below 30% almost always means value was not established during the inspection, not that your price is actually wrong.",
    "Total pipeline value is a real number you should know every month. Stalled proposals represent revenue that is already inside your funnel."
  ],
  "next_steps": [
    "Set a rule: no proposal is emailed without a scheduled in-person follow-up meeting booked at the time of sending.",
    "Audit your last 10 declined proposals. How many were emailed? How many had a ''thinking about it'' period longer than 7 days?",
    "Add a minimum 5-photo requirement to every written proposal document."
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-06-stage-4-proposal';

-- ── Lesson 7 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'sct-07-stage-5-the-close',
  'Stage 5: Closing Without Pressure',
  'The close is the natural conclusion of a well-run sales process. If you are leaving without decisions, you are missing the final step in the sequence.',
  'mirror',
  7,
  10
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The If-Then Close and the LOCK Objection Method",
  "body": "Top-performing roofing sales reps close 40-60% of presented proposals. The industry average sits around 25-30%. The gap is almost entirely process-driven.\n\nA low close rate almost never means your product is bad or your price is wrong. It almost always means the decision conversation was not structured to make choosing easy.\n\n**Before presenting any numbers, ask two questions:**\n1. \"What would you need to feel confident about this decision?\"\n2. \"Is there anything that would prevent you from moving forward today if the numbers make sense?\"\n\nThese questions surface objections before they become barriers and frame the entire presentation around their specific decision criteria.\n\n**The If-Then Close:**\nPresent two or three options, not one take-it-or-leave-it number.\n\nAt decision time: \"If the scope and the number make sense to you, is there a reason we could not get the paperwork done today?\" This moves the homeowner from evaluating to deciding without pressure language.\n\n**The LOCK Method for handling objections:**\n\n- **L: Listen.** Hear the full objection without interrupting. Repeat it back. This disarms defensiveness.\n- **O: Own.** Validate the concern without agreeing it is a reason not to move forward. Acknowledge the emotion, not the conclusion.\n- **C: Counter.** Address the objection with specifics: timeline facts, price comparisons, warranty proof. For price: \"Help me understand what number you had in mind. I want to make sure we are comparing the same scope.\" For competitor: \"Absolutely. What I can do is make sure you have our full written scope so you are comparing the same thing.\"\n- **K: Keep.** Close again immediately after countering. Every handled objection must be followed by a direct close attempt. \"Does that address what was holding you back? Is there a reason we could not move forward today?\"\n\n**Follow-up that works:**\nNever follow up without a reason. Instead of \"just checking in,\" use: \"I wanted to follow up because we have an opening in the schedule for next week and wanted to give you first priority before we fill it.\"",
  "key_takeaway": "Indecision as your top loss reason is a process failure. Decisions are made when options are clear, urgency is real, and the rep asks for the commitment directly."
}'::jsonb
FROM lessons WHERE slug = 'sct-07-stage-5-the-close';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Monthly Close Stage Tracker",
  "description": "Track your close stage metrics for the month. Time-to-close and reason for loss are as important as your close rate percentage.",
  "fields": [
    {"label": "Total Deals Closed", "key": "deals_closed", "type": "number", "prefix": "", "suffix": "", "hint": "Signed contracts collected this month."},
    {"label": "Proposals Presented This Month", "key": "proposals_presented", "type": "number", "prefix": "", "suffix": "", "hint": "In-person proposal presentations completed."},
    {"label": "Deals Closed Same Day as Proposal", "key": "same_day_closes", "type": "number", "prefix": "", "suffix": "", "hint": "Contracts signed during or immediately after the proposal presentation."},
    {"label": "Deals Closed Within 7 Days", "key": "week_closes", "type": "number", "prefix": "", "suffix": "", "hint": "Contracts signed within 7 days of proposal presentation."},
    {"label": "Deals That Took Longer Than 14 Days", "key": "long_closes", "type": "number", "prefix": "", "suffix": "", "hint": "Contracts that required more than 14 days from proposal to signed agreement."},
    {"label": "Deals Lost: Price Was Primary Reason", "key": "lost_price", "type": "number", "prefix": "", "suffix": "", "hint": "Declined proposals where homeowner cited price as the primary reason."},
    {"label": "Deals Lost: Indecision / Thinking About It", "key": "lost_indecision", "type": "number", "prefix": "", "suffix": "", "hint": "Deals that went cold without a clear decision being made."},
    {"label": "Average Contract Value", "key": "avg_contract_value", "type": "number", "prefix": "$", "suffix": "", "hint": "Total revenue closed divided by number of deals closed."}
  ],
  "results": [
    {"label": "Close Rate", "key": "close_rate", "formula": "deals_closed / proposals_presented * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 40%+ for top performers. Industry average is 25-30%. The gap is process, not price."},
    {"label": "Same-Day Close Rate", "key": "same_day_close_rate", "formula": "same_day_closes / deals_closed * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 30% or higher. Same-day closes are the most efficient deals in your pipeline."},
    {"label": "Total Revenue Closed", "key": "total_revenue", "formula": "deals_closed * avg_contract_value", "prefix": "$", "suffix": "", "benchmark": "Track month over month. This is your outcome metric. Everything else feeds it."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-07-stage-5-the-close';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Stage 5 Fixes",
  "highlights": [
    "Ask the two pre-presentation questions on every single deal. They surface objections before they become exit doors.",
    "The LOCK method works because it never lets a handled objection die without a close attempt. Counter and then stay quiet is how deals stall. Counter and close is how deals close.",
    "A time-to-close above 14 days on average means your proposals are not landing with urgency. The fix is in the presentation, not the follow-up."
  ],
  "next_steps": [
    "Script the two pre-presentation questions and practice them until they are natural.",
    "Role-play the LOCK method with your team using your three most common objection types.",
    "Track time-to-close for every deal this month. Calculate your average and compare to the 14-day benchmark."
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-07-stage-5-the-close';

-- ── Lesson 8 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'sct-08-stage-6-referrals',
  'Stage 6: Building a Referral System That Runs on Process',
  'Referral leads close at 2-3x the rate of cold leads and cost virtually nothing. Most companies rely on goodwill. Top operators build a system.',
  'mirror',
  8,
  9
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Referral Ask: When, How, and What to Say",
  "body": "Stage 6 is where most roofing and restoration companies lose their growth multiplier permanently. After a job closes, the average contractor moves on to the next lead. Top operators build a system that turns every closed job into one or more new opportunities.\n\n**The math:** A company that closes 20 jobs per month and generates 1.5 referrals per job has 30 warm leads in pipeline every month at zero acquisition cost. High-performance operations maintain 1.5 to 2.5 referrals per closed job. If you are below 0.5 per job, this is your single highest-ROI improvement.\n\n**When to ask:**\n\n1. **At contract signing.** Not after the job is done. The homeowner is at peak enthusiasm right at signing. \"I am really glad we could get this taken care of. Do you have any neighbors or family members who might be dealing with similar issues? We always appreciate a warm introduction.\"\n\n2. **At job completion.** The second natural ask moment. \"The crew did great work out there. Now that it is done, is there anyone you would feel comfortable introducing us to?\"\n\n**Make the ask specific, not general.**\n\"Do you know anyone\" is vague and gets vague answers. \"Do you have a neighbor on the street who you have noticed might have similar damage?\" is specific and prompts actual thinking.\n\n**Remove friction from the referral path.**\n\"If you think of someone, just text me their name and I will reach out directly. You do not have to do anything except make the introduction.\"\n\n**The review ask belongs in the same conversation.**\n\"One more thing: if you are happy with how this went, a quick Google review makes a real difference for us. I will send you a link.\" Send it within 24 hours. Make it easy with a direct link, not a general instruction to ''find us on Google.''\n\n**Referral ask rate should be 80% minimum.** Every closed job gets an ask, without exception. The rule is not flexible based on job size or customer relationship.",
  "key_takeaway": "You do not need to be a ''people person'' to get referrals. You need a script, a specific ask moment, and a habit of using both."
}'::jsonb
FROM lessons WHERE slug = 'sct-08-stage-6-referrals';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Monthly Referral and Review Tracker",
  "description": "Track your referral generation and close rate separately from your cold lead pipeline. This is the clearest picture of whether your post-close process is working.",
  "fields": [
    {"label": "Total Jobs Closed and Completed This Month", "key": "completed_jobs", "type": "number", "prefix": "", "suffix": "", "hint": "Jobs where final payment was collected and work was completed."},
    {"label": "Jobs Where Referral Was Directly Requested", "key": "referral_asks", "type": "number", "prefix": "", "suffix": "", "hint": "Jobs where you or your rep explicitly asked the homeowner for a referral."},
    {"label": "Referrals Received This Month", "key": "referrals_received", "type": "number", "prefix": "", "suffix": "", "hint": "Actual new leads received through customer referral."},
    {"label": "Referral Leads That Booked an Appointment", "key": "referral_appts", "type": "number", "prefix": "", "suffix": "", "hint": "Referral leads that converted to a scheduled inspection."},
    {"label": "Referral Leads That Closed", "key": "referral_closes", "type": "number", "prefix": "", "suffix": "", "hint": "Referral leads that resulted in a signed contract."},
    {"label": "5-Star Reviews Requested", "key": "reviews_requested", "type": "number", "prefix": "", "suffix": "", "hint": "Number of closed jobs where you sent a direct review link."},
    {"label": "5-Star Reviews Received", "key": "reviews_received", "type": "number", "prefix": "", "suffix": "", "hint": "Google or platform reviews received this month."}
  ],
  "results": [
    {"label": "Referral Ask Rate", "key": "referral_ask_rate", "formula": "referral_asks / completed_jobs * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 80% minimum. Top operators ask on every single closed job without exception."},
    {"label": "Referrals Per Closed Job", "key": "referrals_per_job", "formula": "referrals_received / completed_jobs", "prefix": "", "suffix": "", "benchmark": "Target: 1.5 to 2.5. Below 0.5 means your referral system is not working."},
    {"label": "Referral Close Rate", "key": "referral_close_rate", "formula": "referral_closes / referrals_received * 100", "prefix": "", "suffix": "%", "benchmark": "Referral close rate should be at least double your cold lead close rate. If it is not, your referral follow-up process needs work."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-08-stage-6-referrals';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Stage 6 Fixes",
  "highlights": [
    "The referral ask at contract signing, not job completion, is the highest-value moment. Peak enthusiasm is right there at the signature. Use it.",
    "Specific asks get specific answers. ''Do you know anyone'' is not a referral system. A direct question about a named neighbor or family member is.",
    "Reviews compound over time. 20 reviews per month for a year creates a market presence that no ad spend can replicate in the same timeframe."
  ],
  "next_steps": [
    "Write your referral ask script for both the signing moment and the completion moment. Practice both until they are natural.",
    "Set up a referral tracking spreadsheet with columns for referred-by, contact info, date, status, and whether it closed.",
    "Start sending a direct Google review link within 24 hours of every completed job this month."
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-08-stage-6-referrals';

-- ── Lesson 9 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'sct-09-conversion-rate-calculator',
  'The Conversion Rate Calculator',
  'Your overall funnel efficiency is the product of every stage rate multiplied together. Improving one stage improves every stage that follows it.',
  'mirror',
  9,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Compounding Math Behind Your Funnel",
  "body": "Most companies only see the final output: deals closed. The Conversion Rate Calculator shows what happens at every transition point and where the compounding loss is greatest.\n\n**The compounding formula:**\n\nYour overall funnel conversion rate is the product of every stage rate multiplied together.\n\nExample: 70% contact rate x 75% inspection rate x 85% proposal rate x 45% close rate = **20% overall conversion** on leads.\n\nImprove any single stage by 10 points and the impact ripples through every stage that follows.\n\n**What this means in revenue:**\n\nIf you generate 100 leads per month and your average contract is $18,000:\n- At 20% overall conversion: $360,000 per month\n- If you improve inspection-to-proposal by 10 points: approximately $400,000 per month\n- If you improve close rate by 10 points: approximately $432,000 per month\n- Both together: approximately $480,000 per month\n\nThat is $120,000 in additional monthly revenue from the same 100 leads, with no new marketing spend.\n\n**Finding the revenue inside your current volume:**\n\nFor each stage, multiply the number of additional deals you could close by improving to benchmark by your average contract value. That is your improvement multiplier for that stage. The stage with the highest multiplier is your priority.\n\nMost companies that complete this calculator for the first time find a six-figure annual revenue leak hiding inside their existing lead volume. The leads are already coming in. The process is not converting them.",
  "key_takeaway": "You do not need more leads. You need better conversion at the stages that are already leaking."
}'::jsonb
FROM lessons WHERE slug = 'sct-09-conversion-rate-calculator';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Full Funnel Conversion Calculator",
  "description": "Enter your current monthly numbers at each stage. The calculator shows your overall funnel efficiency and estimates the annual revenue impact of closing each gap.",
  "fields": [
    {"label": "Total Leads Generated This Month", "key": "total_leads", "type": "number", "prefix": "", "suffix": "", "hint": "All lead sources combined."},
    {"label": "Appointments Booked", "key": "appts_booked", "type": "number", "prefix": "", "suffix": "", "hint": "Total appointments scheduled from leads."},
    {"label": "Inspections Completed", "key": "inspections", "type": "number", "prefix": "", "suffix": "", "hint": "Inspections completed from booked appointments."},
    {"label": "Proposals Written", "key": "proposals_written", "type": "number", "prefix": "", "suffix": "", "hint": "Written proposals produced from inspections."},
    {"label": "Proposals Presented In-Person", "key": "proposals_presented", "type": "number", "prefix": "", "suffix": "", "hint": "Proposals actually presented face to face."},
    {"label": "Deals Closed", "key": "deals_closed", "type": "number", "prefix": "", "suffix": "", "hint": "Signed contracts collected this month."},
    {"label": "Average Contract Value", "key": "avg_contract", "type": "number", "prefix": "$", "suffix": "", "hint": "Total revenue closed divided by deals closed."}
  ],
  "results": [
    {"label": "Lead-to-Appointment Rate", "key": "l2a", "formula": "appts_booked / total_leads * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 65-75%."},
    {"label": "Appointment-to-Inspection Rate", "key": "a2i", "formula": "inspections / appts_booked * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 80-90%."},
    {"label": "Inspection-to-Proposal Rate", "key": "i2p", "formula": "proposals_written / inspections * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 80-90%. Below 70% is your biggest revenue leak."},
    {"label": "Presentation-to-Close Rate", "key": "p2c", "formula": "deals_closed / proposals_presented * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 40-55%. Industry average is 25-30%."},
    {"label": "Overall Funnel Conversion Rate", "key": "overall_conversion", "formula": "deals_closed / total_leads * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 15% minimum. Top operators reach 25-35%."},
    {"label": "Monthly Revenue Closed", "key": "monthly_revenue", "formula": "deals_closed * avg_contract", "prefix": "$", "suffix": "", "benchmark": "Track month over month."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-09-conversion-rate-calculator';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Using the Calculator to Set Priorities",
  "highlights": [
    "Calculate your overall funnel conversion rate. Then calculate what it would be if each stage improved by 10 points. The biggest revenue gain from the smallest stage improvement is your priority.",
    "Most companies find a six-figure annual revenue leak inside their existing lead volume when they run this calculator for the first time.",
    "The stage with the largest gap relative to your volume is your Priority 1 fix. The stage with the second largest gap is Sprint 2."
  ],
  "next_steps": [
    "Run this calculator with your actual last-month numbers right now.",
    "Rank your six stages from largest gap to smallest.",
    "Assign one person ownership of the Priority 1 stage fix for the next 30 days."
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-09-conversion-rate-calculator';

-- ── Lesson 10 ─────────────────────────────────────────────────
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'sct-10-the-30-day-sales-fix-sprint',
  'The 30-Day Sales Fix Sprint',
  'Pick one leak. Fix it completely. Then move to the next one. One fix fully implemented is worth more than six fixes half-done.',
  'mirror',
  10,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "A Four-Week Structure for Closing Your Biggest Leak",
  "body": "This sprint template gives you a four-week structure to address your single highest-priority conversion leak with daily discipline. The principle: one fix, fully implemented, is worth more than six fixes half-done.\n\n**Sprint setup:**\n- Name the stage. Name the current conversion rate. Name the target rate.\n- Assign one owner. That person is accountable for the process change and the result.\n- Define what ''fixed'' looks like in specific, measurable terms before you start.\n- Set the weekly check-in day and time.\n\n**Week 1: Diagnose and Document**\nPull exact numbers for this stage from the last 30 days. Interview two reps. Document the current process step by step. Identify the specific gap. Deliverable: a written description of the current process and the gap.\n\n**Week 2: Build the Fix**\nWrite the new process. Create any scripts, checklists, or tracking tools needed. Train the team on the new standard. Role-play the scenario. Deliverable: new process documented and team trained.\n\n**Week 3: Execute and Track**\nNew process live. Track every data point at this stage daily. Identify any friction or resistance. Coach in real time. Do not wait for the week-end review. Deliverable: conversion rate improving toward target.\n\n**Week 4: Lock In and Measure**\nConfirm the habit is forming, not just the behavior. Are people doing this without being reminded? Document the final conversion rate. Calculate the revenue impact. Deliverable: rate at or above target. Process owned by the team, not just the sprint owner.\n\n**After the sprint:**\nCalculate the revenue impact: (new conversion rate minus old rate) x monthly volume x average contract value x 12 = annual revenue recovered. Document the new process in your operations playbook. Identify Sprint 2. Share the result with your team. When improvement is connected to a visible outcome, the habit becomes culture.",
  "key_takeaway": "The 30-Day Sprint works because it forces you to own one thing completely before moving on. Partial fixes on six problems produce less revenue than a complete fix on one."
}'::jsonb
FROM lessons WHERE slug = 'sct-10-the-30-day-sales-fix-sprint';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Sprint Setup Worksheet",
  "description": "Define your Sprint 1 targets before you start. Clear numbers and a named owner are what separate companies that use trackers from companies that file them.",
  "fields": [
    {"label": "Sprint 1 Stage (which of the 6 stages)", "key": "sprint_stage", "type": "text", "prefix": "", "suffix": "", "hint": "Name the specific stage you are targeting first."},
    {"label": "Current Conversion Rate at This Stage", "key": "current_rate", "type": "number", "prefix": "", "suffix": "%", "hint": "Your actual rate from last month''s numbers."},
    {"label": "Target Conversion Rate at End of 30 Days", "key": "target_rate", "type": "number", "prefix": "", "suffix": "%", "hint": "Realistic target based on benchmark. Do not target benchmark in 30 days if your current rate is far below it."},
    {"label": "Monthly Volume at This Stage", "key": "monthly_volume", "type": "number", "prefix": "", "suffix": "", "hint": "How many opportunities pass through this stage each month."},
    {"label": "Average Contract Value", "key": "avg_contract", "type": "number", "prefix": "$", "suffix": "", "hint": "Use your actual average from last month."}
  ],
  "results": [
    {"label": "Additional Deals Per Month If Target Rate Achieved", "key": "additional_deals", "formula": "(target_rate - current_rate) / 100 * monthly_volume", "prefix": "", "suffix": " deals", "benchmark": "Even 0.5 additional deals per month at a high contract value is a meaningful annual revenue impact."},
    {"label": "Monthly Revenue Impact", "key": "monthly_impact", "formula": "additional_deals * avg_contract", "prefix": "$", "suffix": "", "benchmark": "This is the revenue you recover monthly by hitting your sprint target."},
    {"label": "Annual Revenue Impact", "key": "annual_impact", "formula": "monthly_impact * 12", "prefix": "$", "suffix": "", "benchmark": "This is the number you should share with your team at the start and end of the sprint."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-10-the-30-day-sales-fix-sprint';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Running Your First Sprint",
  "highlights": [
    "The biggest sprint mistake is picking two stages at once. One stage, one owner, one process change. That is the rule.",
    "Week 3 is the hardest. The new process feels clunky. Reps push back. The metric might not move immediately. Hold the standard. Week 4 is where it locks in.",
    "The revenue impact calculation at sprint end is not optional. It connects the process work to a real dollar outcome. That connection is what makes the next sprint easier to sell internally."
  ],
  "next_steps": [
    "Fill in the Sprint Setup Worksheet right now with your actual numbers. Do not wait until you have ''more data.''",
    "Identify your sprint owner and set your Week 1 check-in on the calendar before you close this lesson.",
    "Return to the ''Where Are Your Deals Dying?'' stage comparison after Sprint 1 closes to identify Sprint 2."
  ]
}'::jsonb
FROM lessons WHERE slug = 'sct-10-the-30-day-sales-fix-sprint';
