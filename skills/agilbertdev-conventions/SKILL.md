---
name: agilbertdev-conventions
description: AGilbertDev's always-on personal conventions for personal projects — git identity, writing voice, security, and confidentiality. Use in any AGilbertDev personal project. Stack-specific rules live in separate skills (frontend-conventions, backend-conventions, styling-conventions). Not for client or work repos. Tutorial/teaching mode is the separate opt-in tutorial-mode skill.
---

# AGilbertDev conventions

Always true in AGilbertDev personal projects, regardless of the task. Stack-specific rules are in `frontend-conventions`, `backend-conventions`, and `styling-conventions`.

## Git identity
- Commit and push using the personal AGilbertDev git identity, configured locally in each repo.
- Never commit with a work identity on personal repos. Personal Vercel builds also expect the personal identity.

## Writing voice (any prose: docs, blog, commit messages, UI copy, PR text)
- Humble, honest, direct. No corporate fluff. Never overclaim skills or results.
- No AI tells. Specifically: no em-dashes, no `---` horizontal-rule dividers, no rhetorical setups like "The goal was simple:". They are easy to spot.
- Prefer plain words, short sentences, commas and parentheses over em-dashes.

## Security
- Never read `.env` or secrets files. Do not print or echo their contents.

## Confidentiality
- In any public-facing artifact, use generic descriptions only. Never name clients, their clients, or employers.

## Context
- Solo developer on personal projects. Docs and config steer Claude and future-self, not teammates.
