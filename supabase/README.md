# Supabase Setup

## Run migrations in order

1. Go to your Supabase dashboard: https://supabase.com/dashboard
2. Select your project
3. Go to SQL Editor
4. Run each file in order: 001, 002, 003

## Tables created

- `profiles` — user account data (company, revenue range)
- `courses` — course catalog
- `lessons` — individual lessons per course
- `lesson_state` — per-user inputs and progress per lesson
- `quiz_results` — quiz scores
- `coach_conversations` — AI coach chat history
- `uploads` — uploaded file metadata
- `coach_usage` — daily rate limiting for AI coach (30 messages/day)

## Storage

Bucket `lesson-uploads` — files stored as `{user_id}/{lesson_id}/{filename}`
