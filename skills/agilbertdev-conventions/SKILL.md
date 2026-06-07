---
name: agilbertdev-conventions
description: Alexandre Gilbert's (AGilbertDev) personal working conventions for his own projects — git identity, writing voice, frontend solution priority, and security/NDA rules. Use in any AGilbertDev personal project to keep behavior consistent. Not for client or work repos. This is conventions only; tutorial/teaching mode is a separate, per-project concern and is NOT covered here.
---

# AGilbertDev personal conventions

Apply these in Alexandre's own personal projects. They are always true here regardless of the task. (Tutorial mode is a separate collaboration mode set per-project, not part of these conventions.)

## Git identity
- Commit and push as **AGilbertDev**, email **alexandre.gilbert.dev@gmail.com**.
- Never commit with a work identity on personal repos. (Personal Vercel builds also expect this identity.)

## Writing voice (any prose: docs, blog, commit messages, UI copy, PR text)
- Humble, honest, direct. No corporate fluff. Never overclaim skills or results.
- No AI tells. Specifically: **no em-dashes**, no `---` horizontal-rule dividers, no rhetorical setups like "The goal was simple:". He spots these instantly.
- Prefer plain words, short sentences, commas and parentheses over em-dashes.

## Frontend solution priority (Nuxt-stack projects)
When solving a UI problem, reach for solutions in this order, and stop at the first that fits:
1. **Nuxt UI** components/composables
2. **Nuxt core** features
3. **Custom** Vue code
4. **Tailwind** utilities as the last resort for styling gaps
Look up the official docs and teach the reasoning rather than guessing.

## Security
- **Never read `.env` or secrets files.** Do not print or echo their contents.

## Confidentiality (NDA)
- In any public-facing artifact, use generic descriptions only. Never name clients or their clients.

## Context
- Alexandre works solo on personal projects. Docs and config steer Claude (and future-self), not teammates.
