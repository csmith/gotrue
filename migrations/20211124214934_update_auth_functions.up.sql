-- update auth functions

create or replace function {{ index .Options "Namespace" }}.uid() 
returns uuid 
language sql stable
as $$
  select 
  	coalesce(
		current_setting('request.jwt.claim.sub', true),
		(current_setting('request.jwt.claims', true)::jsonb ->> 'sub')
	)::uuid
$$;

create or replace function {{ index .Options "Namespace" }}.role() 
returns text 
language sql stable
as $$
  select 
  	coalesce(
		current_setting('request.jwt.claim.role', true),
		(current_setting('request.jwt.claims', true)::jsonb ->> 'role')
	)::text
$$;

create or replace function {{ index .Options "Namespace" }}.email() 
returns text 
language sql stable
as $$
  select 
  	coalesce(
		current_setting('request.jwt.claim.email', true),
		(current_setting('request.jwt.claims', true)::jsonb ->> 'email')
	)::text
$$;
