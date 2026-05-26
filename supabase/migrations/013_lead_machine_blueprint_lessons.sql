-- =============================================================================
-- Migration: 013_lead_machine_blueprint_lessons.sql
-- Source PDF: SLO-Lead-Machine-Blueprint.pdf (15 pages)
-- Pillar: empty_chair
-- Lesson count: 8
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
-- LESSON 1: The Clarity Conversation
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'lmb-01-clarity-conversation',
  'The Clarity Conversation',
  'Before you spend a dollar on marketing, nail four numbers that tell you exactly how many leads you need and where your current ones come from.',
  'empty_chair',
  1,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Four Numbers Before You Touch Any Marketing",
  "body": "Most contractors start building lead systems before they know what they actually need. They run ads, post on social media, ask for reviews, and then wonder why nothing feels like it is working. The answer is almost always that they never defined the target.\n\nThere are four questions you answer before doing anything else:\n\n**1. What is your average job value?**\nTotal revenue last year divided by number of jobs completed. If you billed $850,000 across 100 jobs, your average job value is $8,500.\n\n**2. What is your current close rate?**\nJobs closed divided by inspections or estimates run. If you ran 200 estimates and closed 70, your close rate is 35%.\n\n**3. How many leads do you need per month?**\nFormula: Monthly revenue target divided by average job value divided by close rate.\nExample: $100,000 target / $8,500 avg job / 0.35 close rate = 34 leads needed this month.\n\n**4. Where did your last 20 jobs come from?**\nWrite down the source for each one: Google search, referral, past customer, yard sign, etc. This is the most important audit you will run. If more than 60% came from one source, you have a concentration risk. One channel drying up removes 60% of your revenue.",
  "key_takeaway": "Run the lead formula first: monthly target divided by average job value divided by close rate gives you a number to build toward, not a vibe."
}'::jsonb
FROM lessons WHERE slug = 'lmb-01-clarity-conversation';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Lead Generation Formula",
  "description": "Enter your real business numbers to calculate exactly how many leads you need to generate each month.",
  "fields": [
    {
      "label": "Monthly Revenue Target",
      "key": "monthly_revenue_target",
      "type": "number",
      "prefix": "$",
      "suffix": "",
      "hint": "What do you need to gross this month? Use your actual goal, not a wish."
    },
    {
      "label": "Average Job Value",
      "key": "avg_job_value",
      "type": "number",
      "prefix": "$",
      "suffix": "",
      "hint": "Total revenue last year divided by number of jobs completed."
    },
    {
      "label": "Current Close Rate",
      "key": "close_rate",
      "type": "number",
      "prefix": "",
      "suffix": "%",
      "hint": "Jobs closed divided by estimates or inspections run. Check your CRM or estimate log."
    }
  ],
  "results": [
    {
      "label": "Leads Needed This Month",
      "key": "leads_needed",
      "formula": "monthly_revenue_target / avg_job_value / (close_rate / 100)",
      "prefix": "",
      "suffix": " leads",
      "benchmark": "This is your hard target. Every lead source you build is pointing at this number."
    }
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-01-clarity-conversation';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Clarity Conversation Complete",
  "highlights": [
    "You now have a specific lead volume target, not a general desire to get more leads.",
    "If more than 60% of your last 20 jobs came from one source, that is a business risk you need to address before scaling.",
    "Your lead formula changes monthly as your revenue target and close rate shift. Run it at the start of every month."
  ],
  "next_steps": [
    "Write down the source for each of your last 20 jobs if you have not already.",
    "Calculate your leads needed number using the formula above.",
    "Save this number. Every lesson after this one is about hitting it."
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-01-clarity-conversation';


-- ----------------------------------------------------------------------------
-- LESSON 2: Google Business Profile Optimization
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'lmb-02-google-business-profile',
  'Google Business Profile',
  'GBP is the highest-ROI free channel for contractors. When someone searches "roofer near me," your GBP listing is what they see first. Most profiles are incomplete. Fixing yours takes a few hours and pays back indefinitely.',
  'empty_chair',
  2,
  10
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Why GBP Is Your Most Important Free Channel",
  "body": "When a homeowner types ''roofer near me'' or ''electrician in [your city],'' your Google Business Profile listing is the first thing they see. Not your website. Not your Facebook page. GBP.\n\nMost contractors have an incomplete profile. Wrong hours. No photos. Zero reviews. Then they wonder why they do not get calls from it.\n\n**What a complete profile needs:**\n- Business name matches your legal name exactly. Mismatches hurt your ranking.\n- Primary category is the most specific available. ''Roofing Contractor'' beats ''Contractor.''\n- Service area covers every zip code you actually work in.\n- Phone number reaches a live person within 2 rings. Not voicemail.\n- At minimum 10 photos: exterior shots, in-progress work, finished jobs, team photos.\n- Services listed with actual descriptions.\n- Q&A section populated with the questions customers actually ask.\n- Posts published at minimum 2 times per month.\n\n**What good looks like:**\n50+ reviews, 4.8 or higher rating, 3 or more new photos per month, 100% review response rate.\n\n**The weekly GBP routine (20 minutes total):**\n- Monday: Check for new reviews. Respond to all within 24 hours.\n- Wednesday: Post one photo from a job you completed this week.\n- Friday: Check messages and Q&A. Respond to anything that came in.\n\nThis is a maintenance routine, not a campaign. Run it every week without skipping.",
  "key_takeaway": "An incomplete GBP is a closed front door. Twenty minutes per week keeps it open and generating calls for free."
}'::jsonb
FROM lessons WHERE slug = 'lmb-02-google-business-profile';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "GBP Audit Scorecard",
  "description": "Score your current Google Business Profile against the checklist. Each item is either done or not done.",
  "fields": [
    {
      "label": "Business name matches legal name exactly",
      "key": "name_match",
      "type": "checkbox",
      "prefix": "",
      "suffix": "",
      "hint": "Log in to your GBP and compare the name to your license or entity name."
    },
    {
      "label": "Primary category is most specific available",
      "key": "primary_category",
      "type": "checkbox",
      "prefix": "",
      "suffix": "",
      "hint": "Search your trade in GBP categories. Pick the most specific one."
    },
    {
      "label": "Service area covers all zip codes you work in",
      "key": "service_area",
      "type": "checkbox",
      "prefix": "",
      "suffix": "",
      "hint": "Go to Info tab in GBP. Check every zip you actually run jobs in."
    },
    {
      "label": "Phone number reaches a live person within 2 rings",
      "key": "phone_live",
      "type": "checkbox",
      "prefix": "",
      "suffix": "",
      "hint": "Call your own number right now. If it goes to voicemail, fix it today."
    },
    {
      "label": "10 or more photos uploaded",
      "key": "photos_ten_plus",
      "type": "checkbox",
      "prefix": "",
      "suffix": "",
      "hint": "Mix of exterior, in-progress, finished work, and team photos."
    },
    {
      "label": "Services listed with descriptions",
      "key": "services_listed",
      "type": "checkbox",
      "prefix": "",
      "suffix": "",
      "hint": "Every service you offer should have its own entry with a short description."
    },
    {
      "label": "Q&A section populated",
      "key": "qa_populated",
      "type": "checkbox",
      "prefix": "",
      "suffix": "",
      "hint": "Go to the Q&A section. Add the 5 most common questions customers ask you."
    },
    {
      "label": "Posts published at least 2x per month",
      "key": "posts_current",
      "type": "checkbox",
      "prefix": "",
      "suffix": "",
      "hint": "Check your GBP Posts tab. When was the last one published?"
    },
    {
      "label": "Current review count",
      "key": "review_count",
      "type": "number",
      "prefix": "",
      "suffix": " reviews",
      "hint": "Go to your GBP listing. Count total reviews."
    },
    {
      "label": "Current average rating",
      "key": "avg_rating",
      "type": "number",
      "prefix": "",
      "suffix": " stars",
      "hint": "Shown on your GBP profile page."
    }
  ],
  "results": [
    {
      "label": "Checklist Items Complete",
      "key": "checklist_score",
      "formula": "name_match + primary_category + service_area + phone_live + photos_ten_plus + services_listed + qa_populated + posts_current",
      "prefix": "",
      "suffix": " of 8",
      "benchmark": "Target: 8 of 8 before you spend money on any other marketing channel."
    }
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-02-google-business-profile';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "GBP Baseline Set",
  "highlights": [
    "GBP is free and shows up above your website in local searches. It is the first channel to fix.",
    "The 20-minute weekly routine is the maintenance requirement. Skipping weeks costs you ranking.",
    "50 reviews at 4.8 stars is the benchmark to build toward. Most competitors are well below it."
  ],
  "next_steps": [
    "Fix every incomplete item in your audit before moving to the next lesson.",
    "Block 20 minutes on Monday, Wednesday, and Friday in your calendar for the GBP routine.",
    "If your photo count is under 10, take photos at your next job and upload them Wednesday."
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-02-google-business-profile';


-- ----------------------------------------------------------------------------
-- LESSON 3: Review Generation System
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'lmb-03-review-generation',
  'Review Generation System',
  'A business with 200 reviews closes more jobs at higher prices than a business with 20 reviews doing identical work. The difference is not quality. It is proof. This lesson builds the system that collects reviews without you chasing them.',
  'empty_chair',
  3,
  9
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Why Reviews Are a Sales System, Not a Vanity Metric",
  "body": "Reviews are how strangers decide to trust you before you ever show up at their door. A business with 200 reviews at 4.8 stars consistently closes more jobs at higher prices than a business with 20 reviews doing the same quality work. The work is the same. The proof is different.\n\nMost contractors get reviews by accident. A customer loved the job and happened to leave one. That is not a system. A system has defined touchpoints where you ask, a specific way you ask, and a follow-up process if the review does not come in.\n\n**Three moments to ask for a review:**\n\n**1. At job completion (highest probability).**\nBefore you leave the property, tell the customer directly. Text them the link while you are still on-site. Do not wait until you are back in the truck. This is the moment they are most satisfied. It is also the moment you are most likely to get a yes.\n\nScript: ''Hi [first name], thanks for having us out today. If the work looks good, would you mind leaving us a Google review? It takes about 60 seconds and it means a lot. [GBP link]''\n\n**2. Seven-day follow-up (if no review posted).**\nOne text only: ''Just checking everything looks good. The review link is below if you have a minute.''\nSend it once. Do not send again. You are not begging. You are reminding.\n\n**3. Annual touchpoint.**\nOnce per year to past customers: short message with the review link. Keeps your profile growing without extra effort.\n\n**Responding to reviews:**\n- Positive: ''Thank you for taking the time. It was a pleasure working with you and we are glad everything looks the way it should.''\n- Negative: ''We take every piece of feedback seriously. Please contact us at [phone] so we can make this right.''\n\nNever argue in a negative review response. It is a public record.",
  "key_takeaway": "Ask for the review at job completion, on-site, before you leave. That single habit compounds into a 50-review profile inside 12 months."
}'::jsonb
FROM lessons WHERE slug = 'lmb-03-review-generation';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Review Velocity Tracker",
  "description": "Track your monthly review numbers to see if your ask system is producing results.",
  "fields": [
    {
      "label": "Total reviews at start of month",
      "key": "reviews_start",
      "type": "number",
      "prefix": "",
      "suffix": " reviews",
      "hint": "Check your GBP listing on the first of the month."
    },
    {
      "label": "New reviews this month",
      "key": "reviews_new",
      "type": "number",
      "prefix": "",
      "suffix": " reviews",
      "hint": "Count reviews posted this calendar month."
    },
    {
      "label": "Current average rating",
      "key": "avg_rating",
      "type": "number",
      "prefix": "",
      "suffix": " stars",
      "hint": "Shown on your GBP profile."
    },
    {
      "label": "Review requests sent this month",
      "key": "requests_sent",
      "type": "number",
      "prefix": "",
      "suffix": " requests",
      "hint": "Count every text or in-person ask you made this month."
    },
    {
      "label": "Jobs completed this month",
      "key": "jobs_completed",
      "type": "number",
      "prefix": "",
      "suffix": " jobs",
      "hint": "Total jobs finished and invoiced this month."
    }
  ],
  "results": [
    {
      "label": "Review Conversion Rate",
      "key": "review_conversion",
      "formula": "reviews_new / requests_sent * 100",
      "prefix": "",
      "suffix": "%",
      "benchmark": "Target: 30% or higher. Below 20% means your ask is landing wrong or the link is broken."
    },
    {
      "label": "Ask Rate",
      "key": "ask_rate",
      "formula": "requests_sent / jobs_completed * 100",
      "prefix": "",
      "suffix": "%",
      "benchmark": "Target: 100%. Every completed job gets a review request. No exceptions."
    }
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-03-review-generation';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Review System in Place",
  "highlights": [
    "The on-site ask at job completion is your highest-probability moment. Text the link before you leave the driveway.",
    "One follow-up at 7 days is the limit. After that you are bothering people, not reminding them.",
    "Your review response rate should be 100%. Every review, positive or negative, gets a response within 24 hours."
  ],
  "next_steps": [
    "Save your GBP review link in your phone right now so you can send it in 5 seconds at any job site.",
    "Set a weekly reminder for Monday to check for new reviews and respond to all of them.",
    "Send the review text to your last 10 customers today using the script from this lesson."
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-03-review-generation';


-- ----------------------------------------------------------------------------
-- LESSON 4: Customer Referrals
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'lmb-04-customer-referrals',
  'Customer Referrals',
  'Referrals from past customers close at 60 to 80%. Most contractors get them by accident. This lesson turns accidental referrals into a system with three defined touchpoints per customer per year.',
  'empty_chair',
  4,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Turning Past Customers Into a Sales Channel",
  "body": "A referral from a past customer closes at 60 to 80%. A cold lead from a paid ad closes at 10 to 25%. The math alone tells you where to focus your relationship energy.\n\nMost contractors get referrals by accident. A satisfied customer mentions them to a neighbor. That is good luck, not a system. A system has defined moments where you ask, specific language you use, and a cadence that keeps you in front of past customers without being annoying.\n\n**Three customer referral touchpoints per year:**\n\n**1. Post-job (within 3 days).**\nThank them directly. Mention referrals are how you grow your business.\nLanguage: ''If you know anyone who could use us, we would appreciate the introduction.''\n\n**2. 90-day check-in.**\n''Just checking in to make sure everything is still holding up. If you know anyone who could use us, we would appreciate the introduction.''\nThis message serves two purposes: it checks in on the work and reminds them you exist.\n\n**3. Annual check-in.**\nSame message, once per year. Keeps you top of mind without being aggressive.\n\n**The math on three touches:**\nIf you have 100 past customers and you contact all of them at 90 days and again at 12 months, you are consistently in front of 100 people who already trust you. One referral per 20 customers contacted is a 5% referral rate, which at $8,500 average job value is $42,500 in referral revenue per year from 100 customers.",
  "key_takeaway": "Three touches per year per past customer: post-job, 90-day check-in, and annual. That is the minimum to run a referral system, not just hope for referrals."
}'::jsonb
FROM lessons WHERE slug = 'lmb-04-customer-referrals';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Referral Source Breakdown",
  "description": "Understand how much of your current revenue is coming through referrals and where those referrals originate.",
  "fields": [
    {
      "label": "Jobs closed this month from customer referrals",
      "key": "customer_ref_jobs",
      "type": "number",
      "prefix": "",
      "suffix": " jobs",
      "hint": "Jobs where the customer said they were referred by a past customer."
    },
    {
      "label": "Revenue from customer referrals this month",
      "key": "customer_ref_revenue",
      "type": "number",
      "prefix": "$",
      "suffix": "",
      "hint": "Total contract value of jobs sourced from customer referrals."
    },
    {
      "label": "Total revenue this month",
      "key": "total_revenue",
      "type": "number",
      "prefix": "$",
      "suffix": "",
      "hint": "All revenue billed this month across all sources."
    },
    {
      "label": "Number of past customers in your contact list",
      "key": "past_customer_count",
      "type": "number",
      "prefix": "",
      "suffix": " contacts",
      "hint": "How many past customers do you have a phone number or email for?"
    }
  ],
  "results": [
    {
      "label": "Referral Revenue Share",
      "key": "referral_share",
      "formula": "customer_ref_revenue / total_revenue * 100",
      "prefix": "",
      "suffix": "%",
      "benchmark": "Target: 25% or more of revenue from referrals. Below 10% means the touchpoint system is not in place."
    }
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-04-customer-referrals';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Customer Referral System Defined",
  "highlights": [
    "Referrals close at 60 to 80%. No other lead source comes close to that conversion rate.",
    "Three touches per customer per year is the minimum. Post-job, 90 days, and 12 months.",
    "If you have 100 past customers with no referral system, you are leaving significant revenue on the table every month."
  ],
  "next_steps": [
    "Pull your list of every customer from the past 24 months. Count them.",
    "Identify which ones you have contacted since the job was done. Those are the gaps.",
    "Set a recurring reminder to send the 90-day check-in text to every customer whose job completed 90 days ago."
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-04-customer-referrals';


-- ----------------------------------------------------------------------------
-- LESSON 5: Trade Partner Referrals
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'lmb-05-trade-partner-referrals',
  'Trade Partner Referrals',
  'Plumbers, electricians, HVAC techs, painters, and realtors see the same properties you do. Most contractors only use customer referrals. Trade partner referrals are the second type, and most operators are not running them at all.',
  'empty_chair',
  5,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Second Referral Source Most Contractors Ignore",
  "body": "There are two types of referral sources available to every contractor. Most are only using one of them.\n\n**Type 1: Customer referrals.** Past customers who had a good experience and are willing to introduce you to people they know.\n\n**Type 2: Trade partner referrals.** Contractors in adjacent trades who see the same properties you do. They are not your competition. They are your referral network.\n\nA plumber who walks into a house with a damaged ceiling is standing in front of your next roofing customer. An HVAC tech who notices moisture damage near the roofline is standing in front of your next call. A realtor who is listing a house that needs work before it goes on the market needs your number.\n\nTrade partners are already in the field. They are already building trust with homeowners. The introduction they give you is warmer than any ad you can run.\n\n**Outreach script (use this word for word):**\n\n''Hey [name], I am [your name] with [company]. We do [trade]. I know you work on a lot of the same properties we do. I wanted to introduce myself and see if we could send business each other''s way. No formal arrangement. If you run into something that needs [trade], think of us, and we will do the same.''\n\n**Who to target:**\n- Plumbers\n- Electricians\n- HVAC technicians\n- Painters\n- Realtors\n- Property managers\n- General contractors\n- Insurance agents (especially for trades that work storm damage)\n\nStart with 5 partners. Build from there.",
  "key_takeaway": "Identify 5 trade partners this week and make the call or send the text. No formal agreement needed. Just an introduction and a mutual offer to send business each other''s way."
}'::jsonb
FROM lessons WHERE slug = 'lmb-05-trade-partner-referrals';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'summary', '{
  "title": "Trade Partner Network Started",
  "highlights": [
    "Trade partners see the same properties you do. They are pre-positioned to refer warm leads to you.",
    "No formal arrangement is needed. An introduction and a mutual offer is enough to start.",
    "Start with 5 partners. A plumber, an electrician, an HVAC tech, a painter, and a realtor covers most of the bases."
  ],
  "next_steps": [
    "Write down 5 trade partners you already know or have crossed paths with.",
    "Send the outreach script to all 5 this week. Text works as well as a call.",
    "Add them to your contacts with a note about the trade they are in so you can refer back to them."
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-05-trade-partner-referrals';


-- ----------------------------------------------------------------------------
-- LESSON 6: Paid Advertising
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'lmb-06-paid-advertising',
  'Paid Advertising',
  'Paid ads are the dial you turn when you need more volume fast. But they only work when the foundation is solid. Fix GBP, reviews, and referrals first. Paid amplifies what is already working. It does not fix a broken system.',
  'empty_chair',
  6,
  10
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Two Paid Channels That Work for Contractors",
  "body": "Paid ads are not where you start. They are where you go when your organic and referral systems are working and you want to add volume. If your GBP is incomplete, your reviews are low, and you have no referral process, paid ads will deliver leads into a leaky bucket. Fix the bucket first.\n\nWhen you are ready, there are two paid channels worth running:\n\n**Channel 1: Google Local Services Ads (LSA)**\n\nPay-per-lead, not pay-per-click. You pay only when a customer contacts you directly through the ad. LSA shows above organic results with a ''Google Screened'' badge, which increases trust and click rate before the customer even reads your listing.\n\nRequirements: one-time background check and license verification before ads go live. Budget a week for this process.\n\nTypical lead cost: $25 to $80 depending on your trade and market. For a roofer in a mid-size market, expect $40 to $70 per lead.\n\nSet up at: google.com/ads/localservices\n\n**Channel 2: Google Search Ads (PPC)**\n\nPay-per-click with more control over keywords, targeting, and budget. Higher volume ceiling than LSA but requires more active management.\n\nBest when someone is answering the phone within 2 minutes of a lead coming in. Speed-to-contact determines your ROI on PPC. A lead that sits for 4 hours converts at a fraction of the rate of a lead called within 5 minutes.\n\n**Maximum Allowable Cost Per Lead:**\n\nFormula: Avg Job Value multiplied by close rate multiplied by 20%.\nExample: $7,500 avg job value x 30% close rate x 20% = $450 max CPL.\n\nIf your LSA leads cost $60 each and your max CPL is $450, you have room to scale aggressively. If your CPL is approaching your max, pause and fix your close rate before increasing spend.\n\n**ROAS target:** Revenue divided by ad spend. Target 5x minimum. Below 3x, something is broken.",
  "key_takeaway": "Calculate your max allowable cost per lead before spending a dollar. Know your ceiling. Then set your budget below it and watch ROAS, not just lead volume."
}'::jsonb
FROM lessons WHERE slug = 'lmb-06-paid-advertising';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Maximum Allowable Cost Per Lead Calculator",
  "description": "Calculate the most you can profitably pay for a single lead from paid advertising before setting any budget.",
  "fields": [
    {
      "label": "Average Job Value",
      "key": "avg_job_value",
      "type": "number",
      "prefix": "$",
      "suffix": "",
      "hint": "Total revenue divided by jobs completed last year."
    },
    {
      "label": "Close Rate",
      "key": "close_rate",
      "type": "number",
      "prefix": "",
      "suffix": "%",
      "hint": "Jobs closed divided by estimates run. Use your actual number, not a guess."
    },
    {
      "label": "Monthly Ad Spend",
      "key": "monthly_spend",
      "type": "number",
      "prefix": "$",
      "suffix": "",
      "hint": "What you are currently spending or planning to spend per month on paid ads."
    },
    {
      "label": "Leads Generated This Month",
      "key": "leads_generated",
      "type": "number",
      "prefix": "",
      "suffix": " leads",
      "hint": "Total leads that came in from paid channels this month."
    },
    {
      "label": "Revenue From Paid Leads This Month",
      "key": "paid_revenue",
      "type": "number",
      "prefix": "$",
      "suffix": "",
      "hint": "Total revenue from jobs that originated from paid ad leads."
    }
  ],
  "results": [
    {
      "label": "Max Allowable CPL",
      "key": "max_cpl",
      "formula": "avg_job_value * (close_rate / 100) * 0.20",
      "prefix": "$",
      "suffix": "",
      "benchmark": "This is the ceiling. If your actual CPL exceeds this, you are paying to acquire customers at a loss."
    },
    {
      "label": "Actual CPL This Month",
      "key": "actual_cpl",
      "formula": "monthly_spend / leads_generated",
      "prefix": "$",
      "suffix": "",
      "benchmark": "Compare to your Max Allowable CPL. If actual exceeds max, fix close rate before adding budget."
    },
    {
      "label": "Return on Ad Spend (ROAS)",
      "key": "roas",
      "formula": "paid_revenue / monthly_spend",
      "prefix": "",
      "suffix": "x",
      "benchmark": "Target: 5x minimum. Below 3x indicates a problem with close rate, follow-up speed, or lead quality."
    }
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-06-paid-advertising';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Paid Advertising Framework Set",
  "highlights": [
    "LSA is the starting point for most contractors. Pay per lead, not per click. Google Screened badge increases conversion.",
    "Your max allowable CPL is a hard ceiling based on job value and close rate. Know it before spending.",
    "Speed to contact is the variable most operators ignore. A lead called within 5 minutes closes at 4x the rate of one called at 4 hours."
  ],
  "next_steps": [
    "Calculate your max allowable CPL using the formula above.",
    "If you are not on LSA, go to google.com/ads/localservices and start the setup process today.",
    "Set a rule: every inbound lead gets a call within 5 minutes during business hours. No exceptions."
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-06-paid-advertising';


-- ----------------------------------------------------------------------------
-- LESSON 7: The Monthly Routine
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'lmb-07-monthly-routine',
  'The Monthly Routine',
  'Consistent lead flow comes from doing ordinary things on a schedule, not from running campaigns. This lesson defines the minimum weekly and monthly actions across all four lead sources.',
  'empty_chair',
  7,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Lead Generation Is a Routine, Not a Campaign",
  "body": "The operators with consistent lead flow are not doing anything extraordinary. They are doing ordinary things on a schedule. The contractor who runs a 30-day ad campaign and then goes dark for two months will never outperform the contractor who does the GBP routine every week for 12 months.\n\nThree levels of routine:\n\n**After every completed job:**\n- Send review request before leaving the property.\n- Log job source in your tracking sheet. (Where did this lead come from?)\n- Make referral ask within 3 days if you did not do it on-site.\n\n**Every week:**\n- GBP: 20-minute routine. Reviews, one photo, messages and Q&A.\n- Reviews: Follow up on any review requests sent exactly 7 days ago.\n- Referrals: Check referral pipeline. Follow up on any open introductions.\n\n**First Monday of every month:**\n- Run the Lead Gen Formula from Lesson 1 for the coming month.\n- Review each source''s numbers from last month.\n- Identify which source underperformed. Spend 30 minutes on it.\n\nThe tracking sheet matters. You cannot make intelligent decisions about which channels to invest in without data. The minimum data you need is: source of each lead, number of leads per source per month, and revenue per source per month.",
  "key_takeaway": "The monthly review, the weekly GBP routine, and the post-job ask are three habits. If you run all three consistently, your lead flow will compound over time."
}'::jsonb
FROM lessons WHERE slug = 'lmb-07-monthly-routine';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Monthly Lead Source Breakdown",
  "description": "Track leads and revenue by source each month to identify which channels are working and where to focus.",
  "fields": [
    {
      "label": "GBP leads this month",
      "key": "gbp_leads",
      "type": "number",
      "prefix": "",
      "suffix": " leads",
      "hint": "Leads who found you via Google search or your GBP listing."
    },
    {
      "label": "Review-driven leads this month",
      "key": "review_leads",
      "type": "number",
      "prefix": "",
      "suffix": " leads",
      "hint": "Leads who mentioned your reviews as a reason for calling."
    },
    {
      "label": "Customer referral leads this month",
      "key": "customer_ref_leads",
      "type": "number",
      "prefix": "",
      "suffix": " leads",
      "hint": "Leads referred by a past customer."
    },
    {
      "label": "Trade partner referral leads this month",
      "key": "partner_ref_leads",
      "type": "number",
      "prefix": "",
      "suffix": " leads",
      "hint": "Leads sent to you by a trade partner (plumber, electrician, realtor, etc.)."
    },
    {
      "label": "Paid ad leads this month",
      "key": "paid_leads",
      "type": "number",
      "prefix": "",
      "suffix": " leads",
      "hint": "Leads from LSA or Google PPC."
    },
    {
      "label": "Other leads this month",
      "key": "other_leads",
      "type": "number",
      "prefix": "",
      "suffix": " leads",
      "hint": "Yard signs, door knocking, social media, any other source."
    },
    {
      "label": "Total revenue this month",
      "key": "total_revenue",
      "type": "number",
      "prefix": "$",
      "suffix": "",
      "hint": "All revenue billed this month."
    }
  ],
  "results": [
    {
      "label": "Total Leads This Month",
      "key": "total_leads",
      "formula": "gbp_leads + review_leads + customer_ref_leads + partner_ref_leads + paid_leads + other_leads",
      "prefix": "",
      "suffix": " leads",
      "benchmark": "Compare to your monthly lead target from the Lead Gen Formula in Lesson 1."
    },
    {
      "label": "Top Source Concentration",
      "key": "top_source_pct",
      "formula": "0",
      "prefix": "",
      "suffix": "",
      "benchmark": "If any single source is above 60% of total leads, you have a concentration risk. Add time to the next-lowest source."
    }
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-07-monthly-routine';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Routine Locked In",
  "highlights": [
    "Three habits carry the whole system: monthly formula review, weekly GBP routine, and post-job ask. None takes more than 20 minutes.",
    "Tracking lead source on every job is non-negotiable. You cannot fix what you do not measure.",
    "Consistency over 12 months will outperform any 30-day campaign every time."
  ],
  "next_steps": [
    "Block the first Monday of every month in your calendar for the monthly lead review. 30 minutes.",
    "Set your GBP routine on Monday, Wednesday, and Friday. 20 minutes total.",
    "Create a simple tracking sheet with columns: date, job, source, revenue. Start logging today."
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-07-monthly-routine';


-- ----------------------------------------------------------------------------
-- LESSON 8: The 90-Day Build Plan
-- ----------------------------------------------------------------------------
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'lmb-08-90-day-build-plan',
  'The 90-Day Build Plan',
  'A sequenced action plan for building all four lead sources in 90 days. The order matters. Start with clarity and GBP, then layer in reviews, referrals, and paid in sequence.',
  'empty_chair',
  8,
  9
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Sequence Is the Strategy",
  "body": "Doing all four lead sources at once without sequence produces noise, not results. The order matters because each source either prepares the next or depends on it.\n\n**Week 1:** Complete the Clarity Conversation (Lesson 1). Audit and fix your GBP (Lesson 2). These are the two foundations. Nothing else starts until these are done.\n\n**Week 2:** Set up your review request text. Send it to your last 10 customers today.\n\n**Week 3:** Identify 5 trade partners. Reach out to all 5 this week using the script from Lesson 5.\n\n**Week 4:** Set up your lead source tracking sheet. Run the Lead Gen Formula to get your monthly target.\n\n**Weeks 5 to 8:** GBP weekly routine every week without skipping. Review request after every completed job. These become habits before you move on.\n\n**Weeks 9 to 10:** Evaluate paid ads. Calculate your max CPL using the formula from Lesson 6. Set up LSA if the math works.\n\n**Weeks 11 to 12:** Review all four sources. Double down on the top producer. Identify the laggard and spend 30 extra minutes on it.\n\n**After 90 days:**\n1. Run the Lead Gen Formula again. Compare actual leads per source against your targets.\n2. Identify which source produces the highest-quality leads (highest close rate). Allocate more time there.\n3. Document your routines so they can be delegated. A system that only works when you personally execute it is not a system.\n\nA contractor who does the GBP routine every week for 12 months will outrank and out-close a contractor who runs a 30-day ad campaign. Build the habits before you build the budget.",
  "key_takeaway": "Follow the sequence. GBP and clarity first, reviews and referrals second, paid third. Skipping steps creates gaps that paid ads cannot fill."
}'::jsonb
FROM lessons WHERE slug = 'lmb-08-90-day-build-plan';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "90-Day Progress Check",
  "description": "At the end of your 90-day build, measure your progress against the starting point to see what moved.",
  "fields": [
    {
      "label": "GBP reviews at day 90",
      "key": "reviews_day90",
      "type": "number",
      "prefix": "",
      "suffix": " reviews",
      "hint": "Check your GBP profile on day 90."
    },
    {
      "label": "GBP reviews at day 1",
      "key": "reviews_day1",
      "type": "number",
      "prefix": "",
      "suffix": " reviews",
      "hint": "Your review count when you started this blueprint."
    },
    {
      "label": "Monthly leads at day 90",
      "key": "leads_day90",
      "type": "number",
      "prefix": "",
      "suffix": " leads",
      "hint": "Total leads in your most recent completed month."
    },
    {
      "label": "Monthly leads at day 1",
      "key": "leads_day1",
      "type": "number",
      "prefix": "",
      "suffix": " leads",
      "hint": "Total leads in the month before you started."
    },
    {
      "label": "Number of active trade partners",
      "key": "trade_partners",
      "type": "number",
      "prefix": "",
      "suffix": " partners",
      "hint": "Partners who have sent or received at least one referral in 90 days."
    }
  ],
  "results": [
    {
      "label": "Review Growth",
      "key": "review_growth",
      "formula": "reviews_day90 - reviews_day1",
      "prefix": "",
      "suffix": " new reviews",
      "benchmark": "Target: 15 or more new reviews in 90 days with the post-job ask system running."
    },
    {
      "label": "Lead Volume Growth",
      "key": "lead_growth",
      "formula": "(leads_day90 - leads_day1) / leads_day1 * 100",
      "prefix": "",
      "suffix": "%",
      "benchmark": "Target: 20% or more increase in lead volume over your starting point."
    }
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-08-90-day-build-plan';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Lead Machine Blueprint Complete",
  "highlights": [
    "Four sources: GBP, reviews, referrals, and paid. Each one feeds the next when built in sequence.",
    "The routines are the system. Monthly formula review, weekly GBP, post-job ask. Nothing fancy.",
    "After 90 days you will have real data on which source produces your best leads. Let that data drive where you invest more time."
  ],
  "next_steps": [
    "Run the Lead Gen Formula today. Write the number down. That is your target.",
    "Set a 90-day calendar reminder to run your progress check using the form above.",
    "Share the lead source tracking data with anyone helping you run the business so decisions are based on numbers, not feelings."
  ]
}'::jsonb
FROM lessons WHERE slug = 'lmb-08-90-day-build-plan';
