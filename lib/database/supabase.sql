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

-- Set up storage for posts
insert into storage.buckets (id, name)
  values ('posts', 'posts');

create policy "Only authenticated users can see post media." on storage.objects for select to authenticated using (bucket_id = 'posts');

create policy "Only authenticated users can upload post media." on storage.objects for insert to authenticated with check (bucket_id = 'posts');

create policy "Only authenticated can delete posts media." on storage.objects for delete to authenticated using (bucket_id = 'posts');

create policy "Only authenticated can update posts media." on storage.objects for update to authenticated using (bucket_id = 'posts');

-- Set up storage for stories
insert into storage.buckets (id, name)
  values ('stories', 'stories');

create policy "Only authenticated users can see story media." on storage.objects for select to authenticated using (bucket_id = 'stories');

create policy "Only authenticated can upload stories media." on storage.objects for insert to authenticated with check (bucket_id = 'stories');

create policy "Only authenticated can delete stories media." on storage.objects for delete to authenticated using (bucket_id = 'stories');

create policy "Only authenticated can update stories media." on storage.objects for update to authenticated using (bucket_id = 'stories');

create table public.profiles (
  id uuid not null,
  full_name text not null,
  email text not null,
  username text not null,
  avatar_url text null,
  push_token text null,
  constraint profiles_pkey primary key (id),
  constraint profiles_email_key unique (email),
  constraint profiles_id_fkey foreign key (id) references auth.users (id) on update cascade on delete cascade,
  constraint username_length check (
    (
      (char_length(username) >= 3)
      and (char_length(username) <= 16)
    )
  )
) tablespace pg_default;

alter table profiles enable row level security;

create policy "Profiles are viewable by everyone." on profiles for select using (true);

create policy "Allow to create profiles for everyone." on profiles for insert with check (true);

create policy "Only owner can update the profile." on profiles for update with check(auth.uid() = id);

create policy "Only owner can delete the profile." on profiles for delete using (auth.uid() = id);

create type media_type as enum('photo', 'video');

-- Create Posts table
create table public.posts (
  id uuid not null default gen_random_uuid(),
  user_id uuid not null,
  caption text null,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone null,
  media text null, 
  constraint posts_pkey primary key (id),
  constraint posts_user_id_fkey foreign key (user_id) references profiles (id) on update cascade on delete cascade
) tablespace pg_default;

alter table posts enable row level security;

create policy "Allow to see posts for everybody." on public.posts for select using (true);

create policy "Allow upload posts only to authenticated users." on public.posts for insert to authenticated with check (true);

create policy "Allow update posts only to owner." on public.posts for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);