# AGilbertDev conventions (always-loaded core)

These are my always-on personal conventions. They are true in my personal projects regardless of the task. Each project imports this file from its own `CLAUDE.md` (with `@.recipes/CLAUDE.md`), so it loads every session. Claude Code only auto-loads `CLAUDE.md`, not `AGENTS.md`, which is why this lives here and loads through an import. Stack rules are not here. They live in on-demand skills, listed at the bottom.

## Capturing new rules — mandatory
Every rule I give you is a standing convention, not a one-off for the current task. When I state a new rule, capture it in the shared recipes before acting on it. Core conventions go in this file in `agilbertdev-recipes`. Stack rules go in the relevant skill. Agent behaviour goes in the matching agent in `ai-agents`. Push the change, then update the `.recipes` submodule pointer in the current project so the rule loads back in. This rule is itself a convention, so it lives here.

## Git identity
Commit and push with the personal AGilbertDev identity, configured locally in each repo. Never commit with a work identity on a personal repo. Personal Vercel builds also expect the personal identity. A guard hook blocks a commit or push made under a different identity, so set the local identity early.

## Security
Never read `.env` or secrets files, and never print or echo their contents. This is also enforced by deny rules in `.claude/settings.json`, so a read attempt is blocked rather than trusted to good behavior.

## Confidentiality
In any public-facing artifact, use generic descriptions only. Never name clients, their clients, or employers.

## Writing voice (any prose, including docs, blog, commit messages, UI copy, and PR text)
Humble, honest, and direct. No corporate fluff, and never overclaim skills or results. Write complete sentences like a human. Never use a dash or a colon to join or separate clauses. No em-dashes, no `---` dividers, and no rhetorical setups like "The goal was simple". Prefer plain words and short sentences.

## Language (Québécois French)
All French copy is Québécois, never français de France. Follow my own usage. Write "dans mon temps libre" rather than "sur mon temps libre", treat "un stack" and "mon stack" as masculine, and use "outils" rather than "outillage". Colloquial Québécois fits my voice, for example "le fun à faire". Write what I would actually say, and never adjust toward France French.

## Context
Solo developer on personal projects. Docs and config steer Claude and my future self, not teammates.

## Agent pipeline — mandatory

Do not write implementation code directly. Every feature, page, route, bug fix, or non-trivial change must go through the agent pipeline.

**How to start:** invoke the `pipeline` agent. It will ask what you are building, build a stage plan, and hand off to each specialist in order. The full sequence is:

`specs` → `design` → `frontend` / `backend` → `compliance` → `seo` → `accessibility` → `unit-test` → `code-review` → `commit`

Stages that do not apply to a given feature are skipped. Specs and code review are never skipped.

The specialist agents live in `.claude/agents/agilbertdev/`, symlinked from the shared `ai-agents` repo. They are plain markdown files — the instructions work regardless of which AI tool is running them. A project may add its own agent as a real `.md` file at the top level of `.claude/agents/` to override or extend the shared set.

## On-demand skills
Load these by name when the task matches. They carry the stack rules so this core stays small.
- `my-frontend-conventions` for Nuxt and Vue components, composables, solution priority, and icons.
- `my-styling-conventions` for Tailwind, theming, the visual identity, responsive layout, and accessibility.
- `my-backend-conventions` for server routes, the database, validation, auth, and email.
- `new-project` when scaffolding a new repo from scratch.
- `tutorial-mode` only when a project opts in to learning-by-building.
