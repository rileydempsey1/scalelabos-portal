-- ============================================================
-- Migration: 011_overhead_calculator_lessons.sql
-- Pillar: prison
-- Lesson count: 11
-- PDF source: SLO-Overhead-Calculator.pdf (37 pages)
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
--   4. pillar_key 'prison' must already exist in your pillars reference
--      (or no FK constraint on that column -- confirm either way)
-- ============================================================

-- ============================================================
-- LESSON 1: What Overhead Is and Why It Matters
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'oc-01-what-overhead-is',
  'What Overhead Is and Why It Matters',
  'Most contractors have no idea what it costs to keep the doors open. This lesson gives you the definition and sets up the entire calculator.',
  'prison',
  1,
  6
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Definition That Changes Everything",
  "body": "Overhead is every dollar your business spends that is not directly tied to completing a specific job. It is not materials. It is not subcontractors. It is not crew labor on the site. Overhead exists whether the crew is on a roof or sitting in your parking lot.\n\nMost roofing contractors can tell you what they paid for shingles on the last job. Almost none of them can tell you what it cost to keep the business running last month. That gap is the problem.\n\nThe five overhead categories that cover everything a roofing and restoration company spends:\n\n**1. Personnel.** Every dollar paid to people not doing direct job work: owner salary, project managers, office staff, estimators, salespeople. Typically 40-60% of total overhead.\n\n**2. Facilities and Equipment.** Rent, utilities, all vehicle costs, equipment leases. These are largely fixed and locked into contracts. They are the floor of your overhead before a single person is paid.\n\n**3. Sales and Marketing.** Every dollar to generate a lead: Google Ads, Facebook, direct mail, yard signs, CRM software, Xactimate subscriptions. Contractors undercount this category constantly by forgetting software and time-based costs.\n\n**4. Business Expenses.** Insurance, professional fees, IT, office supplies, banking, continuing education. These keep the business legally compliant and operationally functional.\n\n**5. Owner Discretionary.** Owner-specific expenses run through the business: personal vehicle use, meals, travel, personal insurance. These must be isolated to get an accurate picture of true operating overhead.\n\nPull your last three months of bank statements and your most recent P&L before you go further. Done with real data, this exercise takes 45 minutes. Done in your head, it takes 45 minutes and produces the wrong number.",
  "key_takeaway": "Overhead exists whether you are running jobs or not. If you do not know the number, you are pricing blind."
}'::jsonb
FROM lessons WHERE slug = 'oc-01-what-overhead-is';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'summary', '{
  "title": "Before You Go Further",
  "highlights": [
    "Overhead is not job cost. It runs whether you have work or not.",
    "There are five categories: Personnel, Facilities, Sales and Marketing, Business Expenses, Owner Discretionary.",
    "Personnel is almost always the biggest category and the one with the most room to change.",
    "You need real bank statements and a P&L to do this accurately. Estimates from memory will be wrong."
  ],
  "next_steps": [
    "Pull your last 3 months of bank statements right now.",
    "Pull your most recent P&L from your accounting software.",
    "In the next lesson you will go line by line through Personnel costs."
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-01-what-overhead-is';


-- ============================================================
-- LESSON 2: Personnel Worksheet
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'oc-02-personnel-worksheet',
  'Personnel: Your Biggest Overhead Line',
  'Personnel is 40-60% of overhead for most roofing companies. Every person on payroll gets counted here. Every payroll tax. Every benefit. Get an accurate number.',
  'prison',
  2,
  10
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Who Counts as Overhead Personnel",
  "body": "Personnel overhead includes every person you pay who is not doing direct job work. If someone installs shingles and you pay them per job or per square, they are a direct cost, not overhead. If they show up regardless of whether you have a job running, they are overhead.\n\n**What goes in this category:**\n- Owner salary or guaranteed draw\n- Operations manager or GM\n- Project managers (full-time, not per-job)\n- Estimators\n- Office and admin staff\n- Sales staff base salaries (not commission -- that can go in Sales and Marketing)\n- Warehouse and yard staff\n- Contract employees who work regular hours regardless of job load\n\n**What also goes here (and gets missed most often):**\n- Payroll taxes: Social Security at 6.2%, Medicare at 1.45%, FUTA/SUTA\n- Health insurance, dental, vision (employer portion only)\n- 401K employer match\n- Bonuses and performance pay (use a monthly average)\n- Payroll processing fees\n- HR software and applicant tracking costs\n- Recruiting and job board fees (monthly average)\n\nFor most roofing and restoration businesses doing $1M-$3M in revenue, total personnel overhead runs $40,000-$70,000 per month. If you are under $500K revenue, $15,000-$30,000 per month is typical.\n\nUse your most recent 90-day average for any number that varies month to month. Do not skip something because you are unsure of the number. Estimate conservatively and confirm later.",
  "key_takeaway": "Payroll taxes and benefits add roughly 20-25% on top of base wages. Most operators forget this and understate personnel overhead by thousands per month."
}'::jsonb
FROM lessons WHERE slug = 'oc-02-personnel-worksheet';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Personnel Overhead Worksheet",
  "description": "Enter your monthly dollar figure for each line item. Use your most recent 90-day average for anything that varies. Leave a line blank only if it genuinely does not apply to your business.",
  "fields": [
    {"label": "Owner Salary / Guaranteed Draw", "key": "owner_salary", "type": "number", "prefix": "$", "suffix": "", "hint": "What you pay yourself consistently each month, not distributions."},
    {"label": "Operations Manager / GM Salary", "key": "ops_manager_salary", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost for any GM or operations lead."},
    {"label": "Project Managers - Total Salaries", "key": "pm_salaries", "type": "number", "prefix": "$", "suffix": "", "hint": "Combined monthly salaries for all full-time PMs."},
    {"label": "Estimators - Total Salaries", "key": "estimator_salaries", "type": "number", "prefix": "$", "suffix": "", "hint": "Combined monthly salaries for all estimators."},
    {"label": "Office / Admin Staff - Total Salaries", "key": "admin_salaries", "type": "number", "prefix": "$", "suffix": "", "hint": "All office-based admin and support staff."},
    {"label": "Sales Staff - Base Salaries", "key": "sales_base_salaries", "type": "number", "prefix": "$", "suffix": "", "hint": "Base pay only. Commission goes in Sales and Marketing."},
    {"label": "Warehouse / Yard Staff", "key": "warehouse_salaries", "type": "number", "prefix": "$", "suffix": "", "hint": "Staff who work at your facility regardless of job count."},
    {"label": "Other W2 Employees", "key": "other_w2", "type": "number", "prefix": "$", "suffix": "", "hint": "Any other salaried or hourly overhead staff."},
    {"label": "Contract Employees (regular, not per-job)", "key": "contract_employees", "type": "number", "prefix": "$", "suffix": "", "hint": "Regular contract workers who are not tied to specific jobs."},
    {"label": "Payroll Taxes - Social Security (6.2%)", "key": "ss_taxes", "type": "number", "prefix": "$", "suffix": "", "hint": "6.2% of total overhead payroll wages."},
    {"label": "Payroll Taxes - Medicare (1.45%)", "key": "medicare_taxes", "type": "number", "prefix": "$", "suffix": "", "hint": "1.45% of total overhead payroll wages."},
    {"label": "FUTA / SUTA Taxes", "key": "futa_suta", "type": "number", "prefix": "$", "suffix": "", "hint": "Federal and state unemployment taxes. Divide annual amount by 12."},
    {"label": "Health Insurance Premiums (employer portion)", "key": "health_insurance", "type": "number", "prefix": "$", "suffix": "", "hint": "What the company pays, not employee deductions."},
    {"label": "Dental / Vision Insurance (employer portion)", "key": "dental_vision", "type": "number", "prefix": "$", "suffix": "", "hint": "Employer-paid portion of dental and vision plans."},
    {"label": "401K Contributions (employer match)", "key": "retirement_match", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average of employer retirement contributions."},
    {"label": "Bonuses / Performance Pay (monthly average)", "key": "bonuses", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual bonuses divided by 12. Include all performance pay."},
    {"label": "Payroll Processing Fees", "key": "payroll_processing", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost from your payroll service provider."},
    {"label": "HR Software / Recruiting Fees (monthly avg)", "key": "hr_software", "type": "number", "prefix": "$", "suffix": "", "hint": "Job boards, ATS software, recruiting agency fees averaged monthly."}
  ],
  "results": [
    {"label": "Personnel Monthly Total", "key": "personnel_total", "formula": "owner_salary + ops_manager_salary + pm_salaries + estimator_salaries + admin_salaries + sales_base_salaries + warehouse_salaries + other_w2 + contract_employees + ss_taxes + medicare_taxes + futa_suta + health_insurance + dental_vision + retirement_match + bonuses + payroll_processing + hr_software", "prefix": "$", "suffix": "", "benchmark": "Typical range: $15K-$35K/mo under $500K revenue; $40K-$70K/mo at $1M-$3M revenue"}
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-02-personnel-worksheet';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Personnel Worksheet Complete",
  "highlights": [
    "Personnel is typically 40-60% of total overhead. If it is over 60%, that is the first problem to address.",
    "Payroll taxes and benefits add 20-25% on top of base wages. Most operators miss this.",
    "If your payroll exceeds 35% of gross revenue, you likely have a staffing structure problem."
  ],
  "next_steps": [
    "Transfer your Personnel Total to the Section 02 summary in the next lesson.",
    "Note which line items surprised you. Those are the ones to watch.",
    "Move to Lesson 3: Facilities and Equipment."
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-02-personnel-worksheet';


-- ============================================================
-- LESSON 3: Facilities and Equipment Worksheet
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'oc-03-facilities-equipment',
  'Facilities and Equipment: The Floor of Your Overhead',
  'These costs are fixed and often locked into contracts. They run whether you have one job or twenty. Know this number exactly.',
  'prison',
  3,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Costs That Never Stop",
  "body": "Facilities and equipment costs are largely fixed. You signed a lease, you have vehicle payments, you pay insurance whether or not a single shingle gets installed. This makes them the floor of your overhead: the minimum the business spends every month before anyone is paid.\n\n**What belongs in this category:**\n- All rent and lease payments: office, warehouse, yard, staging area\n- All utilities: electricity, gas, water, trash, internet, phone lines\n- All vehicle costs: fuel for the company fleet, insurance on all vehicles, lease or loan payments, registration, maintenance and repairs\n- Equipment rental (ongoing contracts, not per-job rentals)\n- Equipment lease payments and maintenance\n- Tool replacement budget (monthly average)\n- Storage units and off-site storage\n- Business licenses and permits (divide annual by 12)\n- Contractor license fees (divide annual by 12)\n\n**The vehicle line is where most operators are surprised.** A fleet of 5 trucks with lease payments, insurance, fuel, and maintenance can easily run $8,000-$15,000 per month. Most operators know the payment but forget the insurance and maintenance portions.\n\nFor each cost that is paid annually or quarterly, divide by the appropriate number of months to get the monthly figure. Enter that number. Do not leave it blank just because the bill has not arrived this month.",
  "key_takeaway": "Facilities and equipment costs run even when your crews are idle. Knowing this number tells you the absolute minimum revenue needed to keep the lights on."
}'::jsonb
FROM lessons WHERE slug = 'oc-03-facilities-equipment';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Facilities and Equipment Worksheet",
  "description": "Enter monthly costs for every physical and vehicle expense. Divide annual or quarterly costs by the appropriate number of months to get the monthly figure.",
  "fields": [
    {"label": "Office Rent / Lease Payment", "key": "office_rent", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly payment for your primary office space."},
    {"label": "Warehouse / Storage Rent", "key": "warehouse_rent", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost for any warehouse or storage facility."},
    {"label": "Yard / Staging Area Lease", "key": "yard_rent", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost for any outdoor staging or material storage area."},
    {"label": "Electricity", "key": "electricity", "type": "number", "prefix": "$", "suffix": "", "hint": "90-day average monthly electric bill."},
    {"label": "Gas / Heating Fuel", "key": "gas_heating", "type": "number", "prefix": "$", "suffix": "", "hint": "90-day average for gas and heating costs."},
    {"label": "Water / Sewer / Trash", "key": "water_trash", "type": "number", "prefix": "$", "suffix": "", "hint": "Combined monthly utility costs."},
    {"label": "Business Phone Lines", "key": "phone_lines", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost for all business telephone lines."},
    {"label": "Internet / Data Service", "key": "internet", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost for all internet and data services at your facility."},
    {"label": "Vehicle Fuel - Company Fleet", "key": "vehicle_fuel", "type": "number", "prefix": "$", "suffix": "", "hint": "90-day average monthly fuel spend for all non-crew vehicles."},
    {"label": "Vehicle Insurance - All Vehicles", "key": "vehicle_insurance", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average for all business vehicle insurance premiums."},
    {"label": "Vehicle Lease / Loan Payments", "key": "vehicle_payments", "type": "number", "prefix": "$", "suffix": "", "hint": "Total monthly payments on all leased or financed company vehicles."},
    {"label": "Vehicle Registration / Taxes (monthly avg)", "key": "vehicle_registration", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual registration costs divided by 12."},
    {"label": "Vehicle Maintenance and Repairs (monthly avg)", "key": "vehicle_maintenance", "type": "number", "prefix": "$", "suffix": "", "hint": "90-day average for all vehicle maintenance and repair costs."},
    {"label": "Equipment Rental (ongoing, not per-job)", "key": "equipment_rental", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost for any ongoing equipment rental contracts."},
    {"label": "Equipment Lease Payments", "key": "equipment_leases", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly payments on all leased equipment."},
    {"label": "Equipment Maintenance and Service", "key": "equipment_maintenance", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average for equipment service and repair."},
    {"label": "Tool Replacement Budget (monthly avg)", "key": "tool_replacement", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual tool replacement spend divided by 12."},
    {"label": "Storage Units / Off-Site Storage", "key": "storage_units", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost for any external storage units."},
    {"label": "Business Licenses and Permits (monthly avg)", "key": "licenses_permits", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual license and permit costs divided by 12."},
    {"label": "Contractor License Fees (monthly avg)", "key": "contractor_license", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual contractor license fees divided by 12."}
  ],
  "results": [
    {"label": "Facilities and Equipment Monthly Total", "key": "facilities_total", "formula": "office_rent + warehouse_rent + yard_rent + electricity + gas_heating + water_trash + phone_lines + internet + vehicle_fuel + vehicle_insurance + vehicle_payments + vehicle_registration + vehicle_maintenance + equipment_rental + equipment_leases + equipment_maintenance + tool_replacement + storage_units + licenses_permits + contractor_license", "prefix": "$", "suffix": "", "benchmark": "This number runs every month regardless of job volume. It is the absolute minimum you must cover before profiting a dollar."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-03-facilities-equipment';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Facilities and Equipment Done",
  "highlights": [
    "These costs are fixed. They run in slow season the same as peak season.",
    "A fleet of 5 trucks commonly runs $8,000-$15,000/month when you include insurance, payments, fuel, and maintenance.",
    "This total is the floor of your monthly overhead before a single salary is paid."
  ],
  "next_steps": [
    "Transfer your Facilities and Equipment Total to the summary worksheet.",
    "Move to Lesson 4: Sales and Marketing costs."
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-03-facilities-equipment';


-- ============================================================
-- LESSON 4: Sales and Marketing Worksheet
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'oc-04-sales-marketing',
  'Sales and Marketing: The Most Undercounted Category',
  'Contractors remember the big ad spend and forget the CRM, the yard signs, and the estimating software. This lesson captures all of it.',
  'prison',
  4,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Why This Category Always Comes in Higher Than Expected",
  "body": "Sales and marketing is the overhead category most frequently undercounted. Contractors remember the Google Ads bill because it is big and obvious. They forget:\n\n- The $200/month CRM subscription\n- The $300/month Xactimate or estimating software\n- The monthly yard sign restocking order\n- The truck wrap they amortize across 3 years\n- The referral program payouts\n- The marketing agency retainer\n\nAll of it is overhead. All of it belongs in this category.\n\n**What belongs here:**\n- All digital advertising: Google, Facebook, Instagram, lead purchase services\n- All print and physical marketing: direct mail, door hangers, yard signs, truck wraps\n- Billboard, radio, TV, trade shows, sponsorships\n- Website hosting and maintenance\n- SEO and content marketing services\n- Photography and video production (monthly average)\n- CRM software (JobNimbus, Salesforce, HubSpot, etc.)\n- Estimating software (Xactimate, Hover, EagleView subscriptions)\n- Referral program payouts\n- Branded apparel and uniforms (if marketing-driven)\n- Business cards and print collateral\n- Any marketing consultant or agency retainer\n\nFor items paid annually, divide by 12. For items that spike seasonally, use a 12-month average rather than a peak-month number.",
  "key_takeaway": "Most roofing contractors undercount their real marketing spend by 30-40% because they miss the software subscriptions and smaller monthly items."
}'::jsonb
FROM lessons WHERE slug = 'oc-04-sales-marketing';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Sales and Marketing Worksheet",
  "description": "Enter every dollar spent to generate leads and support sales activity. Include software subscriptions. Use 12-month averages for items that vary seasonally.",
  "fields": [
    {"label": "Google Ads / Pay-Per-Click", "key": "google_ads", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average spend on Google PPC campaigns."},
    {"label": "Facebook / Instagram Advertising", "key": "social_ads", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average on all paid social media advertising."},
    {"label": "Direct Mail Campaigns (monthly avg)", "key": "direct_mail", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual direct mail spend divided by 12."},
    {"label": "Door Hangers / Flyer Distribution", "key": "door_hangers", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average for door hanger printing and distribution."},
    {"label": "Yard Sign Production and Restocking", "key": "yard_signs", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average cost to maintain and restock yard sign inventory."},
    {"label": "Truck Wraps / Vehicle Graphics (amortized)", "key": "truck_wraps", "type": "number", "prefix": "$", "suffix": "", "hint": "Total wrap cost divided by months of expected use."},
    {"label": "Billboard / Outdoor Advertising", "key": "billboards", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost for any billboard or outdoor ad placements."},
    {"label": "Radio / TV Advertising (monthly avg)", "key": "broadcast_ads", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual broadcast advertising spend divided by 12."},
    {"label": "Home Show / Trade Show Costs (monthly avg)", "key": "trade_shows", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual trade show costs divided by 12."},
    {"label": "Sponsorships / Community Marketing", "key": "sponsorships", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average for local sponsorships and community marketing."},
    {"label": "Website Hosting and Maintenance", "key": "website", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost for hosting, domain, and any maintenance contracts."},
    {"label": "SEO / Content Marketing Services", "key": "seo", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly retainer or average spend on SEO services."},
    {"label": "Photography / Video Production (monthly avg)", "key": "photo_video", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual spend on content production divided by 12."},
    {"label": "CRM Software (monthly subscription)", "key": "crm_software", "type": "number", "prefix": "$", "suffix": "", "hint": "JobNimbus, Salesforce, or other CRM monthly cost."},
    {"label": "Estimating Software (Xactimate, Hover, etc.)", "key": "estimating_software", "type": "number", "prefix": "$", "suffix": "", "hint": "All estimating software subscriptions combined."},
    {"label": "Lead Purchase Services (monthly avg)", "key": "lead_purchase", "type": "number", "prefix": "$", "suffix": "", "hint": "HomeAdvisor, Angi, or other paid lead service monthly spend."},
    {"label": "Referral Program Payouts (monthly avg)", "key": "referral_payouts", "type": "number", "prefix": "$", "suffix": "", "hint": "Average monthly referral fees paid to customers or partners."},
    {"label": "Branded Apparel / Uniforms", "key": "branded_apparel", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average for branded clothing and uniforms."},
    {"label": "Business Cards / Print Collateral", "key": "print_collateral", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average for business card printing and other collateral."},
    {"label": "Marketing Consultant / Agency Retainer", "key": "agency_retainer", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly retainer for any marketing agency or consultant."}
  ],
  "results": [
    {"label": "Sales and Marketing Monthly Total", "key": "sales_marketing_total", "formula": "google_ads + social_ads + direct_mail + door_hangers + yard_signs + truck_wraps + billboards + broadcast_ads + trade_shows + sponsorships + website + seo + photo_video + crm_software + estimating_software + lead_purchase + referral_payouts + branded_apparel + print_collateral + agency_retainer", "prefix": "$", "suffix": "", "benchmark": "Target: below 8% of gross revenue. Above 12% requires a channel-by-channel ROI review."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-04-sales-marketing';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Sales and Marketing Total Captured",
  "highlights": [
    "Software subscriptions alone commonly add $500-$1,500/month that operators forget to count.",
    "Target: marketing spend below 8% of gross revenue. Above 12% requires channel-by-channel ROI analysis.",
    "Every channel needs a cost-per-closed-job metric, not just a cost-per-lead."
  ],
  "next_steps": [
    "Transfer your Sales and Marketing Total to the summary worksheet.",
    "Note which channels you are spending on without knowing the return. Those get reviewed in Lesson 10.",
    "Move to Lesson 5: Business Expenses."
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-04-sales-marketing';


-- ============================================================
-- LESSON 5: Business Expenses Worksheet
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'oc-05-business-expenses',
  'Business Expenses: Compliance and Operations',
  'Insurance, professional fees, software, and the costs that keep you legally functional. Do not skip the insurance lines. Underinsurance is one of the fastest ways to lose a profitable business.',
  'prison',
  5,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Costs That Protect the Business",
  "body": "Business expenses are the operational costs that keep your company compliant, protected, and administratively functional. Many of them are paid annually. Divide each by 12 to get the monthly figure.\n\n**Do not skip the insurance categories.** Underinsurance is one of the fastest ways a profitable roofing contractor can lose everything in a single claim. General liability, workers comp, commercial auto, and umbrella coverage are all required here.\n\n**What belongs in Business Expenses:**\n- General Liability Insurance\n- Workers Compensation Insurance\n- Commercial Auto Insurance (non-vehicle lines)\n- Umbrella / Excess Liability Insurance\n- Errors and Omissions Insurance\n- Accounting and bookkeeping fees\n- CPA and tax preparation (annual divided by 12)\n- Legal fees: ongoing retainer plus average for contracts and disputes\n- IT support and managed services\n- Cloud storage and data backup\n- Business management software (QuickBooks, etc.)\n- Project management software\n- Communication tools (Slack, Teams, etc.)\n- Office supplies, printing, postage, shipping\n- Bank account fees\n- Merchant processing and credit card fees\n- Continuing education and training\n- Industry association dues\n\nMerchant processing fees are commonly underestimated. If you process $200,000/month in credit card payments at 2.5%, that is $5,000/month in fees alone.",
  "key_takeaway": "Business expenses are unavoidable costs of operating legally and professionally. Skipping any insurance line to save money is a business risk, not a cost savings."
}'::jsonb
FROM lessons WHERE slug = 'oc-05-business-expenses';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Business Expenses Worksheet",
  "description": "Enter monthly costs for all compliance, professional, and operational expenses. For annual items, divide by 12.",
  "fields": [
    {"label": "General Liability Insurance", "key": "gl_insurance", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual premium divided by 12."},
    {"label": "Workers Compensation Insurance", "key": "workers_comp", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual premium divided by 12. This is often a large number for roofing."},
    {"label": "Commercial Auto Insurance (non-vehicle lines)", "key": "commercial_auto", "type": "number", "prefix": "$", "suffix": "", "hint": "Any commercial auto coverage not already captured in vehicle costs."},
    {"label": "Umbrella / Excess Liability Insurance", "key": "umbrella", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual umbrella policy premium divided by 12."},
    {"label": "Errors and Omissions Insurance", "key": "eo_insurance", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual E&O premium divided by 12. Especially relevant for restoration work."},
    {"label": "Accounting / Bookkeeping Fees", "key": "accounting", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly bookkeeping service cost."},
    {"label": "CPA / Tax Preparation (monthly avg)", "key": "cpa_fees", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual CPA and tax prep fees divided by 12."},
    {"label": "Legal Fees - Ongoing Retainer", "key": "legal_retainer", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly retainer for business legal counsel."},
    {"label": "Legal Fees - Contracts / Disputes (monthly avg)", "key": "legal_disputes", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual average for contract review and dispute resolution divided by 12."},
    {"label": "IT Support / Managed Services", "key": "it_support", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost for IT support, managed services, or tech support."},
    {"label": "Cloud Storage / Data Backup", "key": "cloud_storage", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost for cloud storage, backup, and security services."},
    {"label": "Business Management Software (QuickBooks, etc.)", "key": "business_software", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly subscription for accounting and business management software."},
    {"label": "Project Management Software", "key": "pm_software", "type": "number", "prefix": "$", "suffix": "", "hint": "Any project management tool not already counted in CRM."},
    {"label": "Communication Tools (Slack, Teams, etc.)", "key": "comms_tools", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost for business communication platforms."},
    {"label": "Office Supplies", "key": "office_supplies", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average for office supplies and consumables."},
    {"label": "Printing / Copying / Postage / Shipping", "key": "printing_postage", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average for all print and mail costs."},
    {"label": "Bank Account Fees", "key": "bank_fees", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly banking fees across all business accounts."},
    {"label": "Merchant Processing / Credit Card Fees", "key": "merchant_fees", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly credit card processing fees. Check your last 3 statements."},
    {"label": "Continuing Education / Training (monthly avg)", "key": "education", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual training and certification spend divided by 12."},
    {"label": "Industry Association Dues (monthly avg)", "key": "association_dues", "type": "number", "prefix": "$", "suffix": "", "hint": "Annual dues for NRCA, local trade associations, etc., divided by 12."}
  ],
  "results": [
    {"label": "Business Expenses Monthly Total", "key": "business_expenses_total", "formula": "gl_insurance + workers_comp + commercial_auto + umbrella + eo_insurance + accounting + cpa_fees + legal_retainer + legal_disputes + it_support + cloud_storage + business_software + pm_software + comms_tools + office_supplies + printing_postage + bank_fees + merchant_fees + education + association_dues", "prefix": "$", "suffix": "", "benchmark": "Merchant processing alone can be $3,000-$8,000/month at $1M-$3M revenue. Check this line carefully."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-05-business-expenses';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Business Expenses Captured",
  "highlights": [
    "Workers comp insurance is often the largest single line item in this category for roofing companies.",
    "Merchant processing fees are commonly underestimated. At 2.5% on $200K/month in revenue, that is $5,000/month.",
    "Every insurance line is required. Skipping one to save on overhead is not a cost savings, it is a risk transfer."
  ],
  "next_steps": [
    "Transfer your Business Expenses Total to the summary worksheet.",
    "Move to Lesson 6: Owner Discretionary costs."
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-05-business-expenses';


-- ============================================================
-- LESSON 6: Owner Discretionary Worksheet
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'oc-06-owner-discretionary',
  'Owner Discretionary: Isolate What You Run Through the Business',
  'These are legitimate deductions but they distort your operating overhead if not separated. Be honest here. The number only helps you if it is accurate.',
  'prison',
  6,
  6
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Why This Category Needs to Be Separated",
  "body": "Owner discretionary costs are business expenses that primarily benefit the owner personally. They are legitimate tax deductions and real business expenses. But they need to be isolated so you can distinguish between true operating overhead and owner compensation in disguise.\n\nWhen you present financials to a lender, a buyer, or an advisory team, owner discretionary expenses are typically added back to EBITDA. Knowing your overhead with and without this category gives you two different and both useful numbers.\n\n**What belongs here:**\n- Owner vehicle (personal-use portion of company vehicle)\n- Owner vehicle insurance (personal-use portion)\n- Owner fuel (personal-use portion)\n- Meals and entertainment\n- Owner travel not related to a specific project\n- Owner cell phone (personal-use portion)\n- Owner home office (if applicable)\n- Health insurance for owner only, if not in payroll\n- Owner life insurance policy\n- Owner disability insurance policy\n- Owner retirement contributions beyond payroll 401K\n- Personal development and coaching for the owner\n- Personal subscriptions and memberships run through the business\n- Other owner expenses run through the business\n\nNote: Owner discretionary totals are included in overhead for break-even and pricing calculations. When presenting to a lender or buyer, these are added back. Know the total with and without this category.",
  "key_takeaway": "Owner discretionary is real overhead for pricing purposes but should be tracked separately so you can present clean operating overhead when needed."
}'::jsonb
FROM lessons WHERE slug = 'oc-06-owner-discretionary';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Owner Discretionary Worksheet",
  "description": "Enter the monthly cost of owner-specific expenses run through the business. Be accurate. These numbers affect your pricing model.",
  "fields": [
    {"label": "Owner Vehicle (personal-use portion)", "key": "owner_vehicle", "type": "number", "prefix": "$", "suffix": "", "hint": "Estimate what portion of your company vehicle cost is personal use."},
    {"label": "Owner Vehicle Insurance (personal-use portion)", "key": "owner_vehicle_insurance", "type": "number", "prefix": "$", "suffix": "", "hint": "Personal-use portion of company vehicle insurance."},
    {"label": "Owner Fuel (personal-use portion)", "key": "owner_fuel", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly fuel cost attributable to personal use of company vehicles."},
    {"label": "Meals and Entertainment", "key": "meals_entertainment", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average for business meals and entertainment."},
    {"label": "Owner Travel (not project-related)", "key": "owner_travel", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly average for owner travel not tied to a specific job or client."},
    {"label": "Owner Cell Phone (personal-use portion)", "key": "owner_cell", "type": "number", "prefix": "$", "suffix": "", "hint": "Portion of owner cell phone bill that is personal use."},
    {"label": "Owner Home Office (if applicable)", "key": "home_office", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly home office deduction if applicable."},
    {"label": "Health Insurance - Owner Only (if not in payroll)", "key": "owner_health", "type": "number", "prefix": "$", "suffix": "", "hint": "Owner health insurance premiums if not already captured in payroll."},
    {"label": "Life Insurance - Owner Policy", "key": "owner_life", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly premium for owner life insurance paid by the business."},
    {"label": "Disability Insurance - Owner Policy", "key": "owner_disability", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly premium for owner disability insurance paid by the business."},
    {"label": "Owner Retirement Beyond Payroll 401K", "key": "owner_retirement", "type": "number", "prefix": "$", "suffix": "", "hint": "Any additional retirement contributions beyond what is in payroll."},
    {"label": "Personal Development / Coaching (owner)", "key": "owner_coaching", "type": "number", "prefix": "$", "suffix": "", "hint": "Monthly cost for owner coaching, masterminds, or personal development."},
    {"label": "Personal Subscriptions / Memberships", "key": "personal_subs", "type": "number", "prefix": "$", "suffix": "", "hint": "Personal subscriptions or memberships run through the business."},
    {"label": "Other Owner Expenses Run Through Business", "key": "other_owner", "type": "number", "prefix": "$", "suffix": "", "hint": "Any other owner-specific expenses not captured above."}
  ],
  "results": [
    {"label": "Owner Discretionary Monthly Total", "key": "owner_discretionary_total", "formula": "owner_vehicle + owner_vehicle_insurance + owner_fuel + meals_entertainment + owner_travel + owner_cell + home_office + owner_health + owner_life + owner_disability + owner_retirement + owner_coaching + personal_subs + other_owner", "prefix": "$", "suffix": "", "benchmark": "Include this in overhead for pricing. Remove it when presenting to lenders or buyers to show clean operating overhead."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-06-owner-discretionary';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Owner Discretionary Complete",
  "highlights": [
    "Owner discretionary must be included in pricing overhead. It is a real cost of the business.",
    "Keep this total separate so you can present clean EBITDA to lenders or buyers.",
    "You now have all five worksheets done. The next lesson builds your total monthly overhead number."
  ],
  "next_steps": [
    "Transfer your Owner Discretionary Total to the summary worksheet.",
    "Move to Lesson 7 to build your complete monthly overhead number."
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-06-owner-discretionary';


-- ============================================================
-- LESSON 7: Your Monthly Overhead Total
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'oc-07-monthly-overhead-total',
  'Your Monthly Overhead Total',
  'Transfer the five worksheet totals and get the single most important number in your pricing model: what it costs to keep your doors open every month.',
  'prison',
  7,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Number That Runs Everything",
  "body": "Your total monthly overhead is the single most important number in your pricing model. Every job you price, every bid you build, every margin decision you make starts here.\n\nThe daily overhead figure is the most operationally useful version of this number. It tells you what the business spends simply by being open before a single job is touched. Every day that revenue does not exceed this number, the business moves backward.\n\n**Typical overhead ranges by company size:**\n- Under $500K annual revenue: $15,000-$35,000 per month\n- $1M-$3M annual revenue: $40,000-$80,000 per month\n- Above $3M: Structure matters more than raw overhead. Use the percentage metrics instead.\n\nOnce you have the monthly total, calculate the following:\n- **Annual Overhead:** Monthly x 12\n- **Weekly Overhead:** Monthly divided by 4.33\n- **Daily Overhead:** Monthly divided by 22 working days\n\nPost the daily number somewhere your operations team sees it. It changes how they make decisions about slow days, callbacks, and schedule gaps.",
  "key_takeaway": "Post your daily overhead number where your team can see it. Every idle day costs that number. Every inefficiency comes out of what is left after covering it."
}'::jsonb
FROM lessons WHERE slug = 'oc-07-monthly-overhead-total';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Monthly Overhead Summary",
  "description": "Transfer the total from each of the five worksheets. This gives you your complete monthly overhead figure.",
  "fields": [
    {"label": "Personnel Total (from Lesson 2)", "key": "personnel_total", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy your Personnel Monthly Total from the Personnel worksheet."},
    {"label": "Facilities and Equipment Total (from Lesson 3)", "key": "facilities_total", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy your Facilities and Equipment Monthly Total."},
    {"label": "Sales and Marketing Total (from Lesson 4)", "key": "sales_marketing_total", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy your Sales and Marketing Monthly Total."},
    {"label": "Business Expenses Total (from Lesson 5)", "key": "business_expenses_total", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy your Business Expenses Monthly Total."},
    {"label": "Owner Discretionary Total (from Lesson 6)", "key": "owner_discretionary_total", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy your Owner Discretionary Monthly Total."}
  ],
  "results": [
    {"label": "Total Monthly Overhead", "key": "total_monthly_overhead", "formula": "personnel_total + facilities_total + sales_marketing_total + business_expenses_total + owner_discretionary_total", "prefix": "$", "suffix": "", "benchmark": "Target range: 15-25% of monthly revenue. Above 30% requires immediate overhead review."},
    {"label": "Annual Overhead", "key": "annual_overhead", "formula": "total_monthly_overhead * 12", "prefix": "$", "suffix": "", "benchmark": "This is what the business spends annually just to exist."},
    {"label": "Weekly Overhead", "key": "weekly_overhead", "formula": "total_monthly_overhead / 4.33", "prefix": "$", "suffix": "", "benchmark": "Revenue needs to exceed this every week the business operates."},
    {"label": "Daily Overhead", "key": "daily_overhead", "formula": "total_monthly_overhead / 22", "prefix": "$", "suffix": "", "benchmark": "Post this number. Every idle crew day costs this amount."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-07-monthly-overhead-total';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "You Have Your Number",
  "highlights": [
    "This monthly total is the foundation of every pricing decision in your business.",
    "Daily overhead is the most operationally useful metric. Post it where your team sees it.",
    "If monthly overhead exceeds 30% of monthly revenue, the next three lessons show you how to fix it."
  ],
  "next_steps": [
    "Write your daily overhead number on a whiteboard or in your ops meeting notes.",
    "Move to Lesson 8: Overhead as a Percentage of Revenue.",
    "Then Lesson 9: Your Break-Even Calculator."
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-07-monthly-overhead-total';


-- ============================================================
-- LESSON 8: Overhead as a Percentage of Revenue
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'oc-08-overhead-percentage',
  'Overhead as a Percentage of Revenue',
  'The overhead percentage tells you how much of every dollar earned is consumed by operating the business. This is the metric that determines whether your structure is sustainable.',
  'prison',
  8,
  7
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Metric That Tells You If the Structure Is Working",
  "body": "Overhead as a percentage of revenue is the most direct measure of whether your overhead structure is sustainable at your current revenue level. It is not an absolute dollar number. It is a ratio.\n\nThe formula: Monthly Overhead divided by Monthly Revenue multiplied by 100 = Overhead %\n\n**Industry benchmarks for roofing and restoration:**\n\n- **Below 15%:** Lean structure. Usually found in owner-operator models or very high-volume operations. Verify nothing is being misclassified as direct cost.\n- **15% to 25%:** Target range for a well-run roofing and restoration business. Overhead is proportionate to revenue and allows for healthy net margin.\n- **25% to 30%:** Acceptable but watch the trend. If revenue drops 10%, this becomes a serious problem. Review all personnel and marketing line items.\n- **30% to 40%:** Red flag territory. The business is likely consuming most or all gross margin in overhead. Immediate audit required.\n- **Above 40%:** The business cannot sustain this structure. Net loss is likely. Restructure before adding any revenue.\n\nIf your overhead percentage is above 25%, the fix guides in Lessons 10 and 11 identify which categories are driving it. Almost always, the issue is personnel structure, marketing spend without tracking, or lease obligations entered into before the revenue supported them.",
  "key_takeaway": "If your overhead is 22% of revenue and your target net margin is 10%, your gross margin floor on every job must be at least 32%. Any job priced below that is not profitable after overhead."
}'::jsonb
FROM lessons WHERE slug = 'oc-08-overhead-percentage';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Overhead Percentage Calculator",
  "description": "Enter your monthly overhead total and your average monthly revenue to calculate your overhead percentage.",
  "fields": [
    {"label": "Total Monthly Overhead", "key": "monthly_overhead", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy from Lesson 7 summary."},
    {"label": "Average Monthly Revenue (last 90 days)", "key": "monthly_revenue", "type": "number", "prefix": "$", "suffix": "", "hint": "Use actual trailing 90-day average, not projections."},
    {"label": "Target Net Profit Margin", "key": "target_net_margin", "type": "number", "prefix": "", "suffix": "%", "hint": "What percentage of revenue do you want to keep as profit? Typical target: 8-15%."}
  ],
  "results": [
    {"label": "Overhead Percentage", "key": "overhead_pct", "formula": "monthly_overhead / monthly_revenue * 100", "prefix": "", "suffix": "%", "benchmark": "Target: 15-25%. Above 30% is a red flag. Above 40% requires restructuring before adding revenue."},
    {"label": "Minimum Gross Margin Floor", "key": "gross_margin_floor", "formula": "overhead_pct + target_net_margin", "prefix": "", "suffix": "%", "benchmark": "Every job must be priced to hit at least this gross margin. Any job below this floor loses money after overhead."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-08-overhead-percentage';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Overhead Percentage Calculated",
  "highlights": [
    "The gross margin floor is your most important pricing output from this entire calculator.",
    "Every estimate you build must clear that floor or the job is not profitable after overhead.",
    "Benchmark minimums by job type: Residential Replacement 35-45%, Storm/Insurance 40-50%, Commercial Low-Slope 30-40%, Service/Repairs 50-65%."
  ],
  "next_steps": [
    "Write your gross margin floor into your estimating software as a required minimum markup.",
    "Move to Lesson 9: Break-Even Calculator.",
    "If your overhead percentage is above 30%, move to Lesson 10 before anything else."
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-08-overhead-percentage';


-- ============================================================
-- LESSON 9: Break-Even Calculator
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'oc-09-break-even-calculator',
  'Your Break-Even Job Count',
  'Break-even is the point where revenue covers all costs with zero profit. Knowing your break-even job count changes how you manage pipeline, sales activity, and pricing decisions.',
  'prison',
  9,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Number That Drives Pipeline Management",
  "body": "Break-even is the point at which revenue covers all costs: overhead plus direct job costs. Below break-even, you are losing money. Above it, you are building equity.\n\nThe break-even formula: Monthly Overhead divided by Average Job Gross Profit = Jobs Needed to Break Even\n\n**Gross profit per job is revenue minus direct costs.** Direct costs are materials, labor on the job, and subcontractors. It is not revenue. A $25,000 job with $15,000 in direct costs has a gross profit of $10,000.\n\nPost the break-even job count in your weekly ops meeting. If the pipeline shows fewer jobs than break-even for the coming month, that is the only conversation that matters until the pipeline is full.\n\n**The pricing insight most operators miss:** Increasing average job size is often more effective than adding job count. If your average gross profit per job increases by 15%, your break-even job count drops by the same percentage. Pricing accuracy is as important as sales volume.\n\nUse your blended average: if you do 70% residential and 30% commercial, weight the gross profit accordingly to get a realistic blended average.",
  "key_takeaway": "Your break-even job count is the number your sales team is measured against first. Revenue targets matter second. Get above break-even before optimizing for growth."
}'::jsonb
FROM lessons WHERE slug = 'oc-09-break-even-calculator';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Break-Even Calculator",
  "description": "Enter your job revenue and direct cost data to calculate your blended gross profit per job, then calculate your monthly break-even job count.",
  "fields": [
    {"label": "Average Residential Job Revenue", "key": "res_revenue", "type": "number", "prefix": "$", "suffix": "", "hint": "Your typical residential job total contract value."},
    {"label": "Average Direct Cost per Residential Job", "key": "res_direct_cost", "type": "number", "prefix": "$", "suffix": "", "hint": "Materials + labor on-site + subs for a typical residential job."},
    {"label": "Average Commercial Job Revenue", "key": "com_revenue", "type": "number", "prefix": "$", "suffix": "", "hint": "Your typical commercial job total contract value. Enter 0 if no commercial."},
    {"label": "Average Direct Cost per Commercial Job", "key": "com_direct_cost", "type": "number", "prefix": "$", "suffix": "", "hint": "Materials + labor on-site + subs for a typical commercial job."},
    {"label": "Residential Job Mix Percentage", "key": "res_mix_pct", "type": "number", "prefix": "", "suffix": "%", "hint": "What percent of your jobs are residential? e.g., 70"},
    {"label": "Total Monthly Overhead", "key": "monthly_overhead_be", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy from Lesson 7 summary."},
    {"label": "Target Profit per Month", "key": "target_profit", "type": "number", "prefix": "$", "suffix": "", "hint": "How much net profit do you want to generate per month above break-even?"}
  ],
  "results": [
    {"label": "Residential Gross Profit per Job", "key": "res_gp", "formula": "res_revenue - res_direct_cost", "prefix": "$", "suffix": "", "benchmark": "Target: 35-45% gross margin on residential replacement work."},
    {"label": "Commercial Gross Profit per Job", "key": "com_gp", "formula": "com_revenue - com_direct_cost", "prefix": "$", "suffix": "", "benchmark": "Target: 30-40% gross margin on commercial low-slope work."},
    {"label": "Blended Average Job Gross Profit", "key": "blended_gp", "formula": "(res_gp * res_mix_pct / 100) + (com_gp * (1 - res_mix_pct / 100))", "prefix": "$", "suffix": "", "benchmark": "This is the gross profit number that drives break-even calculations."},
    {"label": "Break-Even Jobs Per Month", "key": "break_even_jobs", "formula": "monthly_overhead_be / blended_gp", "prefix": "", "suffix": " jobs", "benchmark": "Post this number in your weekly ops meeting. Fewer jobs in pipeline than this is your only priority."},
    {"label": "Target Jobs Per Month (break-even + profit goal)", "key": "target_jobs", "formula": "(monthly_overhead_be + target_profit) / blended_gp", "prefix": "", "suffix": " jobs", "benchmark": "This is the real monthly job target, not an arbitrary revenue goal."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-09-break-even-calculator';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Break-Even Number in Hand",
  "highlights": [
    "Your break-even job count is the metric that drives all pipeline conversations.",
    "Every 15% increase in average gross profit per job reduces your break-even count by the same percentage.",
    "Pricing accuracy and job count are equally important levers. Most operators only pull job count."
  ],
  "next_steps": [
    "Post your break-even job count on the whiteboard in your next ops meeting.",
    "Move to Lesson 10: The Sustainability Ratio and Cash Reserve Target.",
    "Then Lesson 11: The Overhead Tracking Dashboard."
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-09-break-even-calculator';


-- ============================================================
-- LESSON 10: The Sustainability Ratio and Cash Reserve
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'oc-10-sustainability-ratio',
  'The Sustainability Ratio: Your Cash Reserve Target',
  'A healthy business keeps three months of operating expenses accessible at all times. Most contractors have less than one month. This lesson calculates your target and builds the path to get there.',
  'prison',
  10,
  8
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "Why Three Months Is the Number",
  "body": "The sustainability ratio is a cash reserve framework: a healthy business should maintain accessible cash equal to at least three times monthly operating expenses at all times.\n\nThis is not a savings account. It is working capital. Cash that can be deployed immediately if revenue drops, a large receivable goes 60-90 days past due, a key employee leaves and requires immediate recruiting spend, or a warranty claim on a prior job hits.\n\nMost contractors have less than one month of operating expenses in reserve. That is a structural vulnerability. It means a single slow month or a single large unexpected cost can force decisions made from desperation rather than strategy.\n\n**Why three months covers the common disruptions in roofing:**\n- A slow weather season that cuts revenue by 30% for 6 weeks\n- A large receivable that goes 60-90 days past due\n- A key employee departure that requires immediate recruiting and training spend\n- A warranty claim on a prior job requiring crew time and materials\n\n**A business with a funded reserve bids differently.** It does not take low-margin jobs out of desperation. It waits for the right jobs at the right price. The reserve is not just a safety net. It is a competitive advantage.\n\n**Building the reserve without outside capital:** Treat it as a line item in the budget. Set a monthly contribution of 3-5% of gross revenue until the target is reached. Open a separate savings or money market account labeled "Operating Reserve." Do not commingle with payroll. Automate the transfer on the first of each month.",
  "key_takeaway": "A funded three-month reserve lets you bid jobs on your terms, not on desperation. Build it as a budget line item at 3-5% of monthly revenue until the target is reached."
}'::jsonb
FROM lessons WHERE slug = 'oc-10-sustainability-ratio';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'form', '{
  "title": "Cash Reserve Calculator",
  "description": "Calculate your cash reserve target and how long it will take to reach it from current margin.",
  "fields": [
    {"label": "Total Monthly Overhead", "key": "monthly_overhead_sr", "type": "number", "prefix": "$", "suffix": "", "hint": "Copy from Lesson 7 summary."},
    {"label": "Monthly Payroll (if not fully included above)", "key": "additional_payroll", "type": "number", "prefix": "$", "suffix": "", "hint": "Any payroll not captured in your overhead total. Usually 0."},
    {"label": "Current Cash on Hand (checking + accessible savings)", "key": "current_cash", "type": "number", "prefix": "$", "suffix": "", "hint": "Liquid cash only. Do not include receivables or equipment."},
    {"label": "Average Monthly Revenue (last 90 days)", "key": "monthly_revenue_sr", "type": "number", "prefix": "$", "suffix": "", "hint": "Trailing 90-day average monthly revenue."},
    {"label": "Reserve Contribution Rate", "key": "reserve_rate", "type": "number", "prefix": "", "suffix": "%", "hint": "Recommended: 4%. Range: 3-5% of monthly revenue."}
  ],
  "results": [
    {"label": "Total Monthly Operating Expenses", "key": "monthly_operating", "formula": "monthly_overhead_sr + additional_payroll", "prefix": "$", "suffix": "", "benchmark": "This is your full monthly burn rate."},
    {"label": "Sustainability Ratio Target (3x monthly)", "key": "reserve_target", "formula": "monthly_operating * 3", "prefix": "$", "suffix": "", "benchmark": "This is the cash reserve you need to maintain at all times."},
    {"label": "Cash Reserve Gap", "key": "reserve_gap", "formula": "reserve_target - current_cash", "prefix": "$", "suffix": "", "benchmark": "If positive, this is the gap you are building toward. If negative, you have already funded the reserve."},
    {"label": "Monthly Reserve Contribution", "key": "monthly_contribution", "formula": "monthly_revenue_sr * reserve_rate / 100", "prefix": "$", "suffix": "", "benchmark": "Automate this transfer on the first of each month."},
    {"label": "Months to Reach Target", "key": "months_to_target", "formula": "reserve_gap / monthly_contribution", "prefix": "", "suffix": " months", "benchmark": "Most operators reach the target in 12-24 months with consistent 4% contributions."}
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-10-sustainability-ratio';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "Reserve Target Established",
  "highlights": [
    "Three months of operating expenses is the target. Most roofing operators have less than one month.",
    "Build the reserve at 3-5% of monthly revenue. Automate the transfer so it does not require a decision each month.",
    "A funded reserve changes how you bid. You can walk away from low-margin jobs when you do not need them to cover payroll."
  ],
  "next_steps": [
    "Open a separate savings or money market account labeled Operating Reserve this week.",
    "Set up an automatic transfer for your monthly contribution amount.",
    "Move to Lesson 11: The Monthly Overhead Tracking Dashboard."
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-10-sustainability-ratio';


-- ============================================================
-- LESSON 11: Monthly Overhead Tracking and Operating at the Number
-- ============================================================
INSERT INTO lessons (id, slug, title, description, pillar_key, position, duration_minutes)
VALUES (
  uuid_generate_v4(),
  'oc-11-overhead-tracking-dashboard',
  'Operating at the Number: Monthly Tracking and the 90-Day Reduction Plan',
  'The overhead number is not a one-time calculation. It is a living figure. This lesson sets up the monthly tracking routine and shows how to build a 90-day reduction plan if categories are out of range.',
  'prison',
  11,
  9
);

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 1, 'reading', '{
  "title": "The Three Habits That Make This Work",
  "body": "Completing this calculator is not the goal. Using it operationally is the goal. The contractors who build durable businesses know their overhead the way a pilot knows fuel burn: not as a general concept, but as a precise number that informs every operational decision.\n\n**The three habits that make this work:**\n\n**1. Know the number before you bid.** Overhead allocation belongs in every estimate. It is not an after-the-fact calculation. Before any job is priced, the overhead floor should be built into the pricing model. If your overhead is 22% and your target net margin is 10%, your gross margin floor on every job is 32%. That is not negotiable.\n\n**2. Review actuals monthly.** The monthly tracking dashboard works only if actuals are entered. Make it a routine: first business day of each month, enter last month actual numbers. The comparison against the prior month takes less than 10 minutes.\n\n**Track five metrics every month:**\n- Total Overhead ($)\n- Revenue ($)\n- Overhead % of Revenue\n- Operator Output Score (Revenue / Total FTEs)\n- Net Profit %\n\nLook for three patterns. Is overhead stable or growing as a percentage of revenue? Overhead % creeping up quarter over quarter is an early warning sign. Is the Operator Output Score trending up? If revenue is growing but Output Score is flat, headcount is growing faster than revenue. Is net profit % holding as revenue grows? If not, margin is being consumed somewhere in the structure.\n\n**3. Adjust pricing when overhead changes.** If overhead increases because of a new hire, a lease renewal, or an insurance increase, the pricing model must be updated before the next job is bid. Pricing lag is how overhead increases get absorbed into margin instead of passed to the customer.",
  "key_takeaway": "Update your overhead calculation every time a meaningful cost changes. The business makes pricing decisions off this number every day. Stale data produces stale bids."
}'::jsonb
FROM lessons WHERE slug = 'oc-11-overhead-tracking-dashboard';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 2, 'reading', '{
  "title": "The 90-Day Overhead Reduction Plan",
  "body": "If the worksheets revealed categories out of range, this is the structured path to reduction in the next 90 days. Focus on the top three overhead items above target. Three changes executed well produce more impact than ten changes done poorly.\n\n**For each overhead item to reduce, document:**\n- Category (Personnel, Facilities, Marketing, etc.)\n- Specific line item\n- Current monthly spend\n- Target monthly spend (90-day goal)\n- Monthly reduction amount\n- Annual savings (monthly reduction x 12)\n- Specific action to take\n- Person responsible\n- Deadline for implementation\n- How success will be measured\n\n**Common overhead reduction approaches by category:**\n\n**Personnel bloat:** Payroll exceeds 35% of gross revenue. Operator Output Score below $200K per FTE. Solution: do not add headcount until the business has operated at capacity for 60 consecutive days. The new role must be attached to a specific revenue-generating function. The projected Output Score after the hire must stay above $200K.\n\n**Marketing without ROI:** Any channel running more than 60 days without a trackable closed job gets paused. Cut spend on any channel where cost per closed job exceeds 8% of average job revenue. Double spend on channels showing 500%+ ROI.\n\n**Lease obligations ahead of revenue:** These are the hardest to exit quickly. Document the escape clauses. Explore subletting. Begin the conversation with the landlord 90 days before a decision is forced.\n\n**The 90-day review:** At the end of 90 days, recalculate your total monthly overhead, your overhead percentage, and your break-even job count. The change in those three numbers is the measurable outcome of the reduction plan.",
  "key_takeaway": "Pick the three highest overhead items above target. Execute one reduction at a time. Each completed reduction recalculates break-even and compounds across all future months."
}'::jsonb
FROM lessons WHERE slug = 'oc-11-overhead-tracking-dashboard';

INSERT INTO lesson_steps (lesson_id, position, step_type, content)
SELECT id, 3, 'summary', '{
  "title": "You Have the Complete System",
  "highlights": [
    "Update overhead every 90 days and any time a meaningful cost changes. Stale numbers produce bad bids.",
    "The five monthly metrics to track: Total Overhead, Revenue, Overhead %, Operator Output Score, Net Profit %.",
    "If overhead is above 25%, the three usual causes are: personnel ahead of revenue, marketing spend without ROI tracking, and lease obligations entered into before the revenue supported them.",
    "The Operator Output Score benchmark: below $150K means headcount likely exceeds capacity. $250K-$500K is the healthy range for roofing operations."
  ],
  "next_steps": [
    "Schedule a recurring 30-minute calendar block on the first business day of each month to update your tracking dashboard.",
    "If your overhead percentage is above 25%, identify your top three overhead reduction targets and assign a responsible person to each.",
    "Share your daily overhead number with your operations team. Make it part of the weekly ops meeting."
  ]
}'::jsonb
FROM lessons WHERE slug = 'oc-11-overhead-tracking-dashboard';
