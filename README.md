# agilbertdev-recipes

A small SDK of agent instructions: my reusable conventions and a curated skill set, pulled into any of my projects like a package.

It is the single source of truth for how I work with coding agents (Claude Code, and anything else that reads Agent Skills). Instead of re-explaining my preferences in every repo or copying a growing `AGENTS.md` around by hand, a project pulls this recipe and gets my conventions plus a tuned skill set in one command. Project repos then keep only their own project-specific facts.

## What's inside

**Always-loaded core ([`CLAUDE.md`](./CLAUDE.md)):** my personal conventions (git identity, writing voice, Québécois French, security, confidentiality). Each project imports it from its own `CLAUDE.md`, so it loads every session. Claude Code only auto-loads `CLAUDE.md`, not `AGENTS.md`, which is why the core lives here and loads through an import.

**Instruction skills (mine, shipped here, loaded on demand):**

| Skill | What it is |
|---|---|
| `my-frontend-conventions` | Nuxt/Vue: solution priority (Nuxt UI first), component patterns, icons. |
| `my-backend-conventions` | Nuxt/Nitro: Turso + Drizzle, Zod validation, server routes, owner-managed auth, email. |
| `my-styling-conventions` | Visual identity: Hanken Grotesk type, semantic-token theming, fluid `clamp()` sizing, dark mode, accessible Nuxt UI components. |
| `new-project` | The playbook for bootstrapping a new project: scaffold the Nuxt app, wire in this recipe, set the Bun/ESLint/Prettier/husky/i18n baseline. |
| `tutorial-mode` | An opt-in collaboration mode for learning-by-building: teach step by step, do not write the code for me. |

The `my-` prefix marks the skills I author. Everything without it is a framework or community skill, downloaded from upstream.

**Third-party skills (downloaded from their sources at install time, not vendored here):**

| Skill | Source |
|---|---|
| `nuxt-ui` (official) | [`nuxt/ui`](https://github.com/nuxt/ui) `@v4`, `skills/nuxt-ui` |
| `vue`, `vue-best-practices`, `nuxt` | [`antfu/skills`](https://github.com/antfu/skills) |
| `zod` | [`pproenca/dot-skills`](https://github.com/pproenca/dot-skills) |
| `bun` | [`midudev/autoskills`](https://github.com/midudev/autoskills) |
| `tailwind-css-patterns` | [`giuseppe-trisciuoglio/developer-kit`](https://github.com/giuseppe-trisciuoglio/developer-kit) |
| `typescript-advanced-types` | [`wshobson/agents`](https://github.com/wshobson/agents) |
| `accessibility`, `seo` | [`addyosmani/web-quality-skills`](https://github.com/addyosmani/web-quality-skills) |
| `frontend-design` | [`anthropics/skills`](https://github.com/anthropics/skills) |
| `vue-debug-guides` | [`hyf0/vue-skills`](https://github.com/hyf0/vue-skills) |

The machine-readable manifest is [`skills.manifest.json`](./skills.manifest.json).

## Design choices

1. **Third-party skills are downloaded from upstream, not vendored.** This repo stores which skills to use and where each lives, then pulls the real files from their source repos at install time. They stay current and credit stays with their authors.
2. **Always-on rules live in an imported core, task rules in on-demand skills.** Claude Code always loads `CLAUDE.md`, so the universal conventions go there (through an import) and are guaranteed every session. Stack rules stay as skills that load only when the task matches, so they cost nothing until needed.
3. **Hard rules are enforced, not just stated.** A `settings.json` baseline denies reads of `.env` and secrets files, and a hook blocks a commit or push made under the wrong git identity. Instructions shape behavior, hooks guarantee it.
4. **Consumed as a git submodule, pinned per project.** A project records the exact recipe commit it uses, so it updates only when I bump it. It behaves like a versioned package and travels across machines with the clone.

## Requirements

- `git` (the recipe is consumed as a submodule)
- Node.js 18+ with `npx` (the installer uses the [`skills`](https://skills.sh) CLI)
- `bash`

## Install into a project

To scaffold a brand-new project from scratch (create the Nuxt app, then wire this in plus the shared tooling baseline), follow the `new-project` skill. To add the recipe to an existing project, run from the project root:

```bash
git submodule add https://github.com/AGilbertDev/agilbertdev-recipes.git .recipes
bash .recipes/bin/install
```

`bin/install` is re-runnable and does five things:

- Symlinks every local skill (the `my-*` conventions, `new-project`, `tutorial-mode`) from the submodule into `.claude/skills/`, pruning links for any renamed or retired skill.
- Downloads the third-party skills into `.claude/skills/` as real directories (via `npx skills add ...`), and fetches the official `nuxt-ui` skill from `nuxt/ui`. A `skills-lock.json` pins the downloaded versions.
- Merges the security baseline (`settings.base.json`) into `.claude/settings.json`.
- Wires the conventions core into the project's `CLAUDE.md`, creating it if needed and importing `@.recipes/CLAUDE.md` and `@AGENTS.md`.
- Copies a `.devcontainer/` from [`templates/devcontainer`](./templates/devcontainer) if the project has none: a Claude Code sandbox container (Node base with git, curl, sudo, bun, and the Claude Code CLI) so an agent can run autonomously in an isolated container. Copied as real files, never overwriting an existing `.devcontainer/`, so each project owns and can diverge its copy.

Then ignore the generated files and commit the recipe wiring:

```bash
printf '\n# agent skills (downloaded, re-installable from .recipes)\n.claude/skills/\nskills-lock.json\n' >> .gitignore
git add CLAUDE.md .claude/settings.json .gitmodules .recipes .gitignore .devcontainer
git commit -m "chore: add agilbertdev-recipes"
```

What gets committed: `CLAUDE.md`, `.claude/settings.json`, `.gitmodules`, the `.recipes` submodule pointer, the `.gitignore` change, and `.devcontainer/`. The downloaded skills and lock file stay out of git, because `bin/install` regenerates them.

## Set up on another machine

After cloning a project that uses the recipe:

```bash
git submodule update --init
bash .recipes/bin/install
```

## Install by hand (no script)

Every command `bin/install` runs is listed in [`bin/install`](./bin/install). The core of it:

```bash
npx skills add antfu/skills --skill vue vue-best-practices nuxt --agent claude-code
npx skills add pproenca/dot-skills --skill zod --agent claude-code
npx skills add midudev/autoskills --skill bun --agent claude-code
npx skills add giuseppe-trisciuoglio/developer-kit --skill tailwind-css-patterns --agent claude-code
npx skills add wshobson/agents --skill typescript-advanced-types --agent claude-code
npx skills add addyosmani/web-quality-skills --skill accessibility seo --agent claude-code
npx skills add hyf0/vue-skills --skill vue-debug-guides --agent claude-code
npx skills add anthropics/skills --skill frontend-design --agent claude-code

# official Nuxt UI skill (lives in a subdir, so fetch it directly):
git clone --no-checkout --depth 1 --filter=blob:none --branch v4 https://github.com/nuxt/ui.git /tmp/ui
git -C /tmp/ui sparse-checkout set --no-cone skills/nuxt-ui && git -C /tmp/ui checkout
cp -r /tmp/ui/skills/nuxt-ui .claude/skills/nuxt-ui && rm -rf /tmp/ui
```

## Update

```bash
git submodule update --remote .recipes   # pull the latest recipe, then commit the bump
bash .recipes/bin/install                 # re-link and re-download
# or, to bump only the third-party skills:
npx skills update
```

## License

MIT. See [LICENSE](./LICENSE).
