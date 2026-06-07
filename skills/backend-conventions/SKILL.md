---
name: backend-conventions
description: AGilbertDev's backend conventions for personal Nuxt/Nitro projects — database, validation, server routes, auth, and email. Use when working on server routes, the database layer, schemas, or auth in a personal project. Starting defaults, adjust per project.
---

# Backend conventions (Nuxt / Nitro)

These are defaults for personal projects. Adjust per project when a project's needs differ.

## Database
- Turso (libSQL) with Drizzle ORM. SQLite dialect: `drizzle-orm/libsql` + `sqliteTable`, not the Postgres or MySQL cores.
- Define schema in Drizzle, derive validation with `drizzle-zod`.
- Migrations with `drizzle-kit`.

## Validation
- Zod for all input validation. Validate at the server boundary (request body, params, query) before touching the database.

## Server routes
- Nitro server routes under `server/`. Keep handlers thin: validate, call a small typed function, return. Push reusable logic into `server/utils`.

## Auth
- Owner-managed auth with `nuxt-auth-utils`. No public signup and no third-party identity providers unless a project explicitly needs them.

## Email
- Resend for transactional email.

## Tooling
- Bun for scripts and seeding.
