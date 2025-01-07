-- Set up Storage for avatars 
insert into storage.buckets (id, name) 
  values ('avatars', 'avatars');

-- set up access controls for storage.
create policy "Avatar images are publicly accessible."
  on storage.objects for select
  using ( bucket_id = 'avatars' );

create policy "Anyone can upload an avatar."
  on storage.objects for insert
  with check ( bucket_id = 'avatars' );

create policy "Anyone can update their own avatar."
  on storage.objects for update
  using (auth.uid() = owner) with check ( bucket_id = 'avatars' );

create policy "Anyone can delete their own avatar."
  on storage.objects for delete
  using (bucket_id = 'avatars' and auth.uid ()::text = (storage.foldername (name))[1]);