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

## The default branch is mine to merge — mandatory

**Never merge into the default branch, and never push to it directly. I am the only one who merges, and only through a pull request.** Work on a branch, open the pull request, and stop there. Landing it is my decision and my click, not the last step of your task, so a finished feature means an open pull request rather than a merged one.

This holds even when the work is obviously correct, the tests pass, and the review is clean. Those are arguments for opening the pull request, never for merging it. It also holds for the tidying that feels like it does not count, so no fast-forward of the default branch, no force push, no branch deletion, and no committing straight to it to fix a typo. If something on the default branch needs changing, it needs a branch and a pull request like everything else.

Protect it on the remote as well as by convention, since a rule only I remember is not protection. On GitHub that is a repository ruleset on `~DEFAULT_BRANCH` requiring a pull request and blocking deletion and non-fast-forward pushes, with no bypass actors. Verify it with `gh api repos/<owner>/<repo>/rules/branches/<branch>`, which reports the rules the server actually applies. Do not verify with `git push --dry-run`, because dry-run skips the ref-update stage where rulesets are evaluated and will happily report a push that the server would reject.

One honest limit to state rather than paper over. Agents run with my credentials, so the remote cannot tell an agent's merge from mine. The ruleset stops direct pushes and it cannot stop a merge made with my token, which is exactly why this is written as a convention too.

## Leave the working branch checked out — mandatory

**Keep the branch you are working on checked out, so I can see the work live on localhost.** The dev server serves the working tree, so whichever branch is checked out is the app I am looking at. Leaving me on the default branch, or on a different feature, or on a detached HEAD, means the running app silently stops matching the work being described, and I end up testing something other than what you changed without knowing it.

If you genuinely have to visit another branch, to run a script against it or to compare, go back the moment you are done rather than at the end of the turn. Never finish a turn on a branch other than the one the current work lives on, and if the work has just landed and the branch is gone, say which branch I am on now instead of leaving me to discover it.

This also rules out building the active feature in an isolated worktree. A worktree is the right tool when parallel agents would otherwise fight over the same files, but code that lives there is invisible to the dev server, so the feature I am supposed to be watching does not appear. When I want to see it live, the work belongs in the main working tree.

## Security

Never read `.env` or secrets files, and never print or echo their contents. This is also enforced by deny rules in `.claude/settings.json`, so a read attempt is blocked rather than trusted to good behavior.

## Confidentiality — mandatory

In any public-facing artifact, use generic descriptions only. Never name clients, their clients, or employers.

**Never mention a real person from my life, and never say where they work.** No partner, no family, no friends, no colleagues, not by name and not by relationship. "The developer's partner" identifies someone just as surely as a name does, and a public repo keeps it forever. When a real person is behind a project, describe them by role and nothing more, so "the primary user" or "a professional translator", never who they are to me. Use they/them for that person throughout, because a pronoun is one more identifying detail and a role never needs one.

**Never describe a third party's internal workings.** An employer's productivity standards, category lists, internal rates, tooling, and processes belong to them and are not mine to publish, even when a project is built around them and even when no name appears. Numbers taken from a real workplace go in as ordinary configurable defaults with no provenance attached, never as "their real numbers".

**Frame the product generically rather than around one person's job.** Build for "a freelance translator" rather than for a specific employed person, so the domain reads as a product instead of as a description of somebody's employment. This is also the better product decision, since the generic framing is the one that can serve a second user.

**A personal project never stores a third party's data.** Client names, project titles, and anything else belonging to a company I do not own stay out of the database, the seed, the fixtures, and the screenshots. Where the domain genuinely needs the concept, store a reference the user chooses rather than the real name, and say so in the spec. Seeds and fixtures use invented names, always.

**This reaches the git history, which is the part that is hard to undo.** A public repo keeps every past commit, pull request title, and review comment, so scrubbing the working tree fixes the present and leaves the past intact. Get it right on the way in. When something does slip through, say plainly that the history still holds it and let me decide whether a rewrite is worth it, rather than quietly cleaning the tree and reporting it as done.

## Writing voice (any prose, including docs, blog, commit messages, UI copy, and PR text)

Humble, honest, and direct. No corporate fluff, and never overclaim skills or results. Write complete sentences like a human. Never use a dash or a colon to join or separate clauses. No em-dashes, no `---` dividers, and no rhetorical setups like "The goal was simple". Prefer plain words and short sentences.

Write English in English. Do not reach for a French word when an English one exists, and do not keep repeating a French term as jargon just because a file, a branch, or a past feature was named that way. Say "simplifying pass", not "alléger". If a French name is already baked into a filename or a spec, refer to the thing in plain English and link the file, rather than turning its name into vocabulary. This is about my English prose only, and it takes nothing away from the Québécois French rules below, which govern actual French copy.

## Language (Québécois French)

All French copy is Québécois, never français de France. Follow my own usage. Write "dans mon temps libre" rather than "sur mon temps libre", treat "un stack" and "mon stack" as masculine, and use "outils" rather than "outillage". Colloquial Québécois fits my voice, for example "le fun à faire". Write what I would actually say, and never adjust toward France French.

## Running agents — mandatory

**Parallelise everything that has no dependency on everything else.** Launch every stage whose inputs are ready in one message. Design and backend do not wait for each other. Accessibility and unit tests do not wait for each other. Only a real input dependency justifies a stage waiting, and when one does, name the output it is waiting for rather than serialising out of habit.

**Background or foreground is your call, but always leave me a hint that something is running.** A silent finished turn is indistinguishable from being stuck, and I will ask whether you are working. One line naming what is in flight is enough.

**A hint at launch is not enough. Arm a liveness watch that keeps reporting, so waiting is never ambiguous.** One line when the agent starts goes stale within a minute, and after that a working agent and a dead one look exactly the same from where I sit, which leaves me waiting on a corpse with no way to tell. Never hand back a turn whose only evidence of progress is a sentence I have to trust. Arm something that speaks on its own: a monitor or a background poll that emits when real output lands and, just as importantly, emits when nothing has changed for a few minutes. Silence must mean the watch is broken, never "probably still fine".

Cover death, not just progress. A watch that only fires on success is the same failure again, because a crash, a hang, and a finished run all present as quiet. Emit on new files, new commits, and a stall, and prefer a slightly noisy watch over one that can go silent while something is wrong. Do not spam a fixed heartbeat either; report state changes plus a stall alert, so every message I get means something happened.

**Never silence stderr on a check you are about to draw a conclusion from.** `2>/dev/null` on a diagnostic turns a missing tool, a permission error or a typo into a clean empty result, and an empty result reads as a confident negative. That is how "nothing is listening on that port" gets reported when the truth was that the command did not exist. Keep `2>&1` on anything whose output becomes evidence, and read the error text rather than the line count, because "command not found" is itself one line and looks exactly like a header with no rows.

Before trusting a negative, confirm the instrument can produce a positive. If a check reports the absence of something, prove it can see that thing when it is definitely there, by creating one and looking for it. A tool that reports nothing because it is broken and a world that genuinely contains nothing are indistinguishable from the output alone, and only the second one is a finding.

**Probe running agents on a bounded timeout, in a loop. They crash, and they crash silently.** Never fire an agent and then wait on a single open-ended call, because that is how five minutes disappear on a dead loop. A crashed agent usually leaves nothing behind, so treat "still running" as a claim to re-check rather than a fact, and look at the working tree for real output rather than trusting a status.

When a probe shows an agent died, say so plainly, say what it had produced if anything, and restart it. Never report a crashed agent's work as finished and never guess at what it would have returned.

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
