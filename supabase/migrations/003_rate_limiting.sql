-- Daily coach message count tracker
create table public.coach_usage (
  id uuid default uuid_generate_v4() primary key,
  user_id uuid references auth.users(id) on delete cascade,
  date date default current_date,
  message_count integer default 0,
  unique(user_id, date)
);

alter table public.coach_usage enable row level security;
create policy "Users view own usage" on public.coach_usage for select using (auth.uid() = user_id);
create policy "Service role manages usage" on public.coach_usage for all using (true);
