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
- Write complete sentences, like a human. Never use a dash or a colon to separate or join clauses.
- No em-dashes, no `---` dividers, no rhetorical setups like "The goal was simple".
- Prefer plain words and short, complete sentences.

## Language (Québécois French)
- All French copy is Québécois, never français de France.
- Follow his usage. Write "dans mon temps libre" (not "sur mon temps libre"), "un stack" and "mon stack" as masculine (not "une stack" or "ma stack"), and "outils" (not "outillage").
- Québécois colloquial fits his voice, for example "le fun à faire".
- Write what he would actually say, never adjust toward France French.

## Security
- Never read `.env` or secrets files. Do not print or echo their contents.

## Confidentiality
- In any public-facing artifact, use generic descriptions only. Never name clients, their clients, or employers.

## Context
- Solo developer on personal projects. Docs and config steer Claude and future-self, not teammates.
