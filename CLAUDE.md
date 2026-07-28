# AGilbertDev conventions (always-loaded core)

These are my always-on personal conventions. They are true in my personal projects regardless of the task. Each project imports this file from its own `CLAUDE.md` (with `@.recipes/CLAUDE.md`), so it loads every session. Claude Code only auto-loads `CLAUDE.md`, not `AGENTS.md`, which is why this lives here and loads through an import. Stack rules are not here. They live in on-demand skills, listed at the bottom.

## Capturing new rules — mandatory

Every rule I give you is a standing convention, not a one-off for the current task. When I state a new rule, capture it in the shared recipes before acting on it. Core conventions go in this file in `agilbertdev-recipes`. Stack rules go in the relevant skill. Agent behaviour goes in the matching agent in `ai-agents`. Push the change, then update the `.recipes` submodule pointer in the current project so the rule loads back in. This rule is itself a convention, so it lives here.

## Conventions over invention — mandatory

Follow the established conventions of the framework, the language, and the ecosystem, always. Use the documented way the tool already provides rather than a bespoke pattern, folder layout, or abstraction of my own. Do not invent anything. If a convention exists, it wins by default, even over something that looks cleaner to me in the moment. The only reason to depart is that I explicitly say I prefer a different way, and when I do, capture that preference as its own rule so the exception is written down rather than reinvented each time.

Always enforce separation of concerns. Keep client code, server code, and shared contracts apart, give each module one responsibility, and put shared logic where both sides can reach it rather than duplicating it or reaching across a boundary. In a Nuxt project this means `app/` for the client, `server/` for Nitro, and `shared/` for the contracts both use. When conventions compete, the one that preserves separation of concerns wins.

## Logic belongs to the backend — mandatory

All logic is decided backend as much as possible, unless the components are frontend only. The frontend is a view with as little brain as possible. It draws what it is handed and does not work anything out for itself.

So when a value is derived rather than stored, the server derives it and sends the finished answer, and where the data layer can make the decision, make it there rather than in application code above it. A status that depends on the current time, a total, a permission, an ordering, a filter, a page of results, a label chosen between several: all of these are decided server-side and arrive resolved. Do not ship a raw row plus the rules for interpreting it and let the client apply them, and never duplicate a rule on both sides, because two copies drift and the client's copy is the one that goes stale or gets tampered with. A pseudo-status or any other derived field is a legitimate part of an API response even though no column backs it.

The exception is real and narrow: logic that is purely about presentation and has no meaning off the screen stays in the component, because the server has no business knowing about it. Which element has focus, whether a panel is open, a hover or transition state, a value formatted for display from data already resolved, a purely visual breakpoint choice. If the rule would still be true with no user interface attached, it is not presentation and it belongs to the backend.

When both sides genuinely need the same pure rule, it lives once in the shared contract layer (`shared/` in a Nuxt project) and both import it. That is the one acceptable form of sharing; copying it is not.

## No invalid states and safe recovery — mandatory

Never leave the system in a state a user or process cannot get out of. Assume any process can be abandoned partway, any token or session can expire, and any step can be interrupted, and design so the outcome is always either fully done or safely recoverable. For every flow that spans more than one step or one request, work out what happens when it stops halfway, and give the affected user a way to restart or continue that does not depend on state they no longer hold. A dead end is a bug.

Recovery must be safe. It can never become an authentication or authorization bypass, must not reveal whether an account exists, and must not let one user act on another's data. Prefer the documented recovery pattern of the framework over a bespoke one, and when in doubt fail closed and route the user back to a clean starting point rather than leaving them stranded.

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
