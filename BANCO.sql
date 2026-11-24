create table if not exists public.finance_state (user_id uuid primary key references auth.users(id) on delete cascade, payload jsonb not null default '{"accounts":[],"entries":[]}'::jsonb, revision bigint not null default 0);
alter table public.finance_state enable row level security;
revoke all on public.finance_state from anon;
grant select,insert,update on public.finance_state to authenticated;
create policy "ler proprio" on public.finance_state for select to authenticated using (auth.uid() = user_id);
create policy "criar proprio" on public.finance_state for insert to authenticated with check (auth.uid() = user_id);
create policy "alterar proprio" on public.finance_state for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
