---
name: agilbertdev-conventions
description: AGilbertDev's always-on working conventions for personal projects — git identity, writing voice, Nuxt-stack frontend rules, security, and confidentiality. Use in any AGilbertDev personal project to keep behavior consistent. Not for client or work repos. Conventions only; tutorial/teaching mode is a separate opt-in skill (tutorial-mode), not part of these.
---

# AGilbertDev conventions

Always true in AGilbertDev personal projects, regardless of the task.

## Git identity
- Commit and push using the personal AGilbertDev git identity, configured locally in each repo.
- Never commit with a work identity on personal repos. Personal Vercel builds also expect the personal identity.

## Writing voice (any prose: docs, blog, commit messages, UI copy, PR text)
- Humble, honest, direct. No corporate fluff. Never overclaim skills or results.
- No AI tells. Specifically: no em-dashes, no `---` horizontal-rule dividers, no rhetorical setups like "The goal was simple:". They are easy to spot.
- Prefer plain words, short sentences, commas and parentheses over em-dashes.

## Frontend (Nuxt stack)
- Solution priority. Reach for solutions in this order, stop at the first that fits: (1) Nuxt UI components/composables, (2) Nuxt core features, (3) custom Vue, (4) Tailwind utilities for styling gaps. Look up the official docs and explain the reasoning rather than guessing.
- Mobile responsive. Use `min-h-dvh` (not `min-h-screen`). Scale vertical padding and margins down on mobile, then step them up at `sm:` and above.
- Icons. Carbon is the default set, via the Nuxt UI icon prop (`i-carbon-*`). Use Simple Icons for brand and logo marks only (`i-simple-icons-*`).
- Styling. Tailwind utility-first. Avoid custom CSS files unless unavoidable.

## Security
- Never read `.env` or secrets files. Do not print or echo their contents.

## Confidentiality
- In any public-facing artifact, use generic descriptions only. Never name clients, their clients, or employers.

## Context
- Solo developer on personal projects. Docs and config steer Claude and future-self, not teammates.
