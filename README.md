# agilbertdev-recipes

A small SDK of agent instructions: my reusable conventions and a curated skill set, pulled into any of my projects like a package.

It is the single source of truth for how I work with coding agents (Claude Code, and anything else that reads Agent Skills). Instead of re-explaining my preferences in every repo or copying a growing `AGENTS.md` around by hand, a project pulls this recipe and gets my conventions plus a tuned skill set in one command. Project repos then keep only their own project-specific facts.

## What's inside

**Instruction skills (mine, shipped here):**

| Skill | What it is |
|---|---|
| `agilbertdev-conventions` | Always-on personal conventions: git identity, writing voice, security, confidentiality. |
| `frontend-conventions` | Nuxt/Vue: solution priority (Nuxt UI first), component patterns, icons. |
| `backend-conventions` | Nuxt/Nitro: Turso + Drizzle, Zod validation, server routes, owner-managed auth, email. |
| `styling-conventions` | Tailwind utility-first, mobile `dvh` rules, theming through semantic colors. |
| `tutorial-mode` | An opt-in collaboration mode for learning-by-building: teach step by step, do not write the code for me. |

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
2. **Instructions travel as skills, not as copied docs.** Conventions and modes are modular, loadable units. The always-on conventions are separate from the opt-in tutorial mode.
3. **Consumed as a git submodule, pinned per project.** A project records the exact recipe commit it uses, so it updates only when I bump it. It behaves like a versioned package and travels across machines with the clone.

## Requirements

- `git` (the recipe is consumed as a submodule)
- Node.js 18+ with `npx` (the installer uses the [`skills`](https://skills.sh) CLI)
- `bash`

## Install into a project

Run from the project root:

```bash
git submodule add https://github.com/AGilbertDev/agilbertdev-recipes.git .recipes
bash .recipes/bin/install
```

`bin/install` does two things:

- Symlinks the local instruction skills (`agilbertdev-conventions`, `tutorial-mode`) from the submodule into `.claude/skills/`.
- Downloads the third-party skills into `.claude/skills/` as real directories (via `npx skills add ...`), and fetches the official `nuxt-ui` skill from `nuxt/ui`. A `skills-lock.json` is written at the project root pinning the downloaded versions.

Then ignore the generated files and commit the recipe wiring:

```bash
printf '\n# agent skills (downloaded, re-installable from .recipes)\n.claude/skills/\nskills-lock.json\n' >> .gitignore
git add .gitmodules .recipes .gitignore
git commit -m "chore: add agilbertdev-recipes"
```

What gets committed: `.gitmodules`, the `.recipes` submodule pointer, and the `.gitignore` change. The downloaded skills and lock file stay out of git, because `bin/install` regenerates them.

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
