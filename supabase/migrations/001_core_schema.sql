-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- User profiles (extends Supabase auth.users)
create table public.profiles (
  id uuid references auth.users(id) on delete cascade primary key,
  email text,
  company_name text,
  annual_revenue text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

alter table public.profiles enable row level security;
create policy "Users can view own profile" on public.profiles for select using (auth.uid() = id);
create policy "Users can update own profile" on public.profiles for update using (auth.uid() = id);
create policy "Users can insert own profile" on public.profiles for insert with check (auth.uid() = id);

-- Auto-create profile on signup
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, email, company_name, annual_revenue)
  values (
    new.id,
    new.email,
    new.raw_user_meta_data->>'company_name',
    new.raw_user_meta_data->>'annual_revenue'
  );
  return new;
end;
$$ language plpgsql security definer;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- Courses
create table public.courses (
  id text primary key,
  title text not null,
  description text,
  category text,
  lesson_count integer default 0,
  created_at timestamptz default now()
);

alter table public.courses enable row level security;
create policy "Courses are publicly readable" on public.courses for select using (true);

-- Lessons
create table public.lessons (
  id text primary key,
  course_id text references public.courses(id) on delete cascade,
  title text not null,
  lesson_type text not null check (lesson_type in ('reading', 'form', 'upload', 'quiz', 'summary')),
  position integer not null,
  content jsonb not null default '{}',
  created_at timestamptz default now()
);

alter table public.lessons enable row level security;
create policy "Lessons are publicly readable" on public.lessons for select using (true);

-- User lesson state (inputs, progress, uploads)
create table public.lesson_state (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users(id) on delete cascade,
  course_id text references public.courses(id),
  lesson_id text references public.lessons(id),
  completed boolean default false,
  data jsonb default '{}',
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  unique(user_id, lesson_id)
);

alter table public.lesson_state enable row level security;
create policy "Users manage own lesson state" on public.lesson_state for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Quiz results
create table public.quiz_results (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users(id) on delete cascade,
  course_id text references public.courses(id),
  lesson_id text references public.lessons(id),
  score integer not null,
  total integer not null,
  answers jsonb default '{}',
  passed boolean default false,
  created_at timestamptz default now()
);

alter table public.quiz_results enable row level security;
create policy "Users manage own quiz results" on public.quiz_results for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- AI Coach conversations
create table public.coach_conversations (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users(id) on delete cascade,
  course_id text references public.courses(id),
  lesson_id text,
  role text not null check (role in ('user', 'assistant')),
  content text not null,
  created_at timestamptz default now()
);

alter table public.coach_conversations enable row level security;
create policy "Users manage own conversations" on public.coach_conversations for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- File uploads metadata
create table public.uploads (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users(id) on delete cascade,
  course_id text references public.courses(id),
  lesson_id text,
  storage_path text not null,
  original_filename text not null,
  file_size integer,
  mime_type text,
  parsed_data jsonb default '{}',
  uploaded_at timestamptz default now()
);

alter table public.uploads enable row level security;
create policy "Users manage own uploads" on public.uploads for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

-- Course progress view
create or replace view public.course_progress as
select
  ls.user_id,
  ls.course_id,
  count(*) filter (where ls.completed = true) as lessons_completed,
  count(*) as lessons_started,
  c.lesson_count as total_lessons,
  round(count(*) filter (where ls.completed = true)::numeric / nullif(c.lesson_count, 0) * 100) as percent_complete
from public.lesson_state ls
join public.courses c on c.id = ls.course_id
group by ls.user_id, ls.course_id, c.lesson_count;
