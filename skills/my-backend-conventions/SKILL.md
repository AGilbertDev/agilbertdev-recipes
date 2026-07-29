---
name: my-backend-conventions
description: AGilbertDev's backend conventions for personal Nuxt/Nitro projects — database, validation, server routes, auth, and email. Use when working on server routes, the database layer, schemas, or auth in a personal project. Starting defaults, adjust per project.
---

# Backend conventions (Nuxt / Nitro)

These are defaults for personal projects. Adjust per project when a project's needs differ.

## Database

- Turso (libSQL) with Drizzle ORM. SQLite dialect: `drizzle-orm/libsql` + `sqliteTable`, not the Postgres or MySQL cores.
- Define schema in Drizzle, derive validation with `drizzle-zod`.
- Migrations with `drizzle-kit`.

### A migration is for schema, not for data the seed owns

Write a migration when the database structure changes. A table, a column, an index, a constraint, a type. Do not write one to rewrite rows that only exist because the dev seed put them there, because the seed already owns those rows and rebuilds them on the next run, so the migration duplicates work that is about to happen anyway and then sits in the history implying a structural change that never occurred.

Check who owns the rows before reaching for a migration. Dev and test data is seed-owned and dev-only, so it is fixed by editing the seed. Real user data is migration-owned, and only that needs a backfill.

This matters most when a stored value is renamed or split. If a column is free text with no CHECK, enum, or foreign key, then new values are already storable and there is no DDL to write at all, so the only question left is who rewrites the existing rows. And when a rename splits one value into two, a backfill has to pick a side for a distinction the old rows never recorded, which writes a guess permanently into the history. Rewriting the seed avoids inventing that answer. If real user rows are affected and the mapping is genuinely unknowable, stop and ask rather than choosing for the user.

### Migrations must be idempotent and crash-resistant

Every migration must be safe to re-run and must complete even after a partial failure or a crash, so running it again always drives the schema to the target state no matter where a prior run stopped. Never write a migration that only works against one exact starting state.

- Use `IF NOT EXISTS` / `IF EXISTS` wherever the SQLite dialect supports it: `CREATE TABLE IF NOT EXISTS`, `CREATE INDEX IF NOT EXISTS`, `DROP TABLE IF EXISTS`, `DROP INDEX IF EXISTS`.
- SQLite does not support `IF [NOT] EXISTS` on `ALTER TABLE ADD COLUMN` or `DROP COLUMN`, so guard those instead. Read `PRAGMA table_info(<table>)` first and skip the statement when the column already matches the target, or run through a runner that catches the benign `duplicate column name` and `no such column` errors and continues rather than aborting the whole migration.
- Make backfills re-runnable. Use `INSERT ... WHERE NOT EXISTS` or `INSERT OR IGNORE` so a second run does not duplicate rows.
- Apply through a runner that executes statement by statement and continues past statements that are already satisfied, so a crashed migration finishes cleanly on the next run rather than getting stuck halfway.

## Validation

- Zod for all input validation. Validate at the server boundary (request body, params, query) before touching the database.

## Server routes

- Nitro server routes under `server/`. Keep handlers thin: validate, call a small typed function, return. Push reusable logic into `server/utils`.

## List endpoints

List endpoints paginate, sort, and search on the server, never on the client. The client sends the page, page size, sort column, sort direction, and search term as query params, and the endpoint returns only the rows for that page plus a total count. Client-side sorting or filtering only reorders the rows already loaded, so it silently breaks the moment the list spans more than one page. Do the work where the whole dataset lives.

- Accept `page`, `pageSize`, `sort`, `order`, and `search` as validated query params. Use `z.coerce.number()` for the numeric ones with sane defaults and a max page size.
- Whitelist the sortable columns with a Zod enum. Never sort by a raw column name taken from the query string.
- Return the page rows plus a `total` count so the client can render pagination without loading everything.
- Push the paging, sorting, and filtering against the full dataset. When a list is assembled in memory from more than one source, filter and sort the merged set before slicing the page, not after.

## Auth

- Owner-managed auth with `nuxt-auth-utils`. No public signup and no third-party identity providers unless a project explicitly needs them.

## Email

- Resend for transactional email.

## Tooling

- Bun for scripts and seeding.
