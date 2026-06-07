# agilbertdev-recipes

A small SDK of agent instructions: my reusable conventions and a curated skill set, pulled into any of my projects like a package.

It is the single source of truth for how I work with coding agents (Claude Code, and anything else that reads Agent Skills). Instead of re-explaining my preferences in every repo or copying a growing `AGENTS.md` around by hand, a project pulls this recipe and gets my conventions plus a tuned skill set in one command. Project repos then hold only their own project-specific facts.

## What's inside

Two kinds of thing:

**Instruction skills (mine, shipped here):**

| Skill | What it is |
|---|---|
| `agilbertdev-conventions` | Always-on conventions: git identity, writing voice, Nuxt-stack frontend rules, security, confidentiality. |
| `tutorial-mode` | An opt-in collaboration mode for learning-by-building: teach step by step, do not write the code for me. |

**Third-party skills (downloaded from their sources, not vendored here):**

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

The skill list is tuned for my stack (Nuxt, Vue, Tailwind, Bun, Zod, TypeScript). Fork it and swap the manifest for yours.

## Use it in a project

```bash
# from the project root:
git submodule add https://github.com/AGilbertDev/agilbertdev-recipes.git .recipes
bash .recipes/bin/install              # links my instruction skills + downloads the rest
echo ".claude/skills/" >> .gitignore   # downloaded and re-installable, kept out of git
git add .recipes .gitignore && git commit -m "chore: add agilbertdev-recipes"
```

On another machine, after cloning the project:

```bash
git submodule update --init
bash .recipes/bin/install
```

Every command the script runs is listed in [`bin/install`](./bin/install), if you prefer to do it by hand.

## Update

```bash
git submodule update --remote .recipes   # pull the latest recipe, then commit the bump
npx skills update                         # refresh the downloaded third-party skills
```

## License

MIT. See [LICENSE](./LICENSE).
