-- Migration 015: lesson_steps table + pillar_key column on lessons
-- Run this BEFORE migrations 016-021.
-- Safe to run on existing data — uses IF NOT EXISTS and ADD COLUMN IF NOT EXISTS.

-- ─── lesson_steps table ───────────────────────────────────────────────────────
-- Stores individual steps within a lesson.
-- Each lesson has 3-6 steps of types: reading, form, summary.
-- Content is stored as JSONB with a type-specific schema (see migrations 016-021).

create table if not exists public.lesson_steps (
  id               uuid default uuid_generate_v4() primary key,
  lesson_id        uuid not null references public.lessons(id) on delete cascade,
  position         integer not null,
  step_type        text not null check (step_type in ('reading', 'form', 'summary')),
  content          jsonb not null default '{}',
  created_at       timestamptz default now(),
  unique(lesson_id, position)
);

alter table public.lesson_steps enable row level security;

create policy "Lesson steps are publicly readable"
  on public.lesson_steps for select using (true);

-- ─── pillar_key column on lessons ─────────────────────────────────────────────
-- Maps each lesson to one of the six Scale Lab OS pillars.
-- Valid values: mirror, prison, crew, leak, empty_chair, burial

alter table public.lessons
  add column if not exists pillar_key text;

-- ─── Jared: verify before running 016-021 ─────────────────────────────────────
-- 1. Confirm uuid_generate_v4() works (uuid-ossp extension must be enabled).
-- 2. Confirm your lessons.id column is type uuid (lesson_steps references it).
-- 3. pillar_key has no enum constraint — it accepts any text value.
--    If you want to enforce values, add a check constraint after loading data:
--    ALTER TABLE lessons ADD CONSTRAINT lessons_pillar_key_check
--      CHECK (pillar_key IN ('mirror','prison','crew','leak','empty_chair','burial'));
