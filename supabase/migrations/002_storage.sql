-- Create storage bucket for lesson uploads
insert into storage.buckets (id, name, public) values ('lesson-uploads', 'lesson-uploads', false);

-- RLS on storage: users can only read/write their own files
create policy "Users upload own files" on storage.objects
  for insert with check (
    bucket_id = 'lesson-uploads' and
    auth.uid()::text = (storage.foldername(name))[1]
  );

create policy "Users read own files" on storage.objects
  for select using (
    bucket_id = 'lesson-uploads' and
    auth.uid()::text = (storage.foldername(name))[1]
  );

create policy "Users delete own files" on storage.objects
  for delete using (
    bucket_id = 'lesson-uploads' and
    auth.uid()::text = (storage.foldername(name))[1]
  );
