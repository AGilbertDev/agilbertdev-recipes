# agilbertdev-recipes

My personal "recipes": a manifest of curated Agent Skills plus my own working conventions, shared across my own projects.

Third-party skills are **downloaded from their upstream sources**, not copied into this repo. Only `agilbertdev-conventions` (my own content) lives here.

Personal projects only. Do not add this to client or work repos.

## What's in the recipe

| Skill | Source | How |
|---|---|---|
| `nuxt-ui` (official) | `nuxt/ui` @ `v4`, `skills/nuxt-ui` | git sparse-checkout |
| `vue` | `antfu/skills` | `skills add` |
| `vue-best-practices` | `antfu/skills` | `skills add` |
| `nuxt` | `antfu/skills` | `skills add` |
| `zod` | `pproenca/dot-skills` | `skills add` |
| `bun` | `midudev/autoskills` | `skills add` |
| `tailwind-css-patterns` | `giuseppe-trisciuoglio/developer-kit` | `skills add` |
| `typescript-advanced-types` | `wshobson/agents` | `skills add` |
| `accessibility` | `addyosmani/web-quality-skills` | `skills add` |
| `seo` | `addyosmani/web-quality-skills` | `skills add` |
| `frontend-design` | `anthropics/skills` | `skills add` |
| `vue-debug-guides` | `hyf0/vue-skills` | `skills add` |
| `agilbertdev-conventions` | this repo | symlinked from the submodule |

The machine-readable version is [`skills.manifest.json`](./skills.manifest.json).

## Add the recipe to a project

```bash
# from the project root (personal projects only):
git submodule add git@github.com:AGilbertDev/agilbertdev-recipes.git .recipes
bash .recipes/bin/install            # downloads the skills above into .claude/skills
echo ".claude/skills/" >> .gitignore  # downloaded + re-installable; keep out of git/Vercel
git add .recipes .gitignore && git commit -m "chore: add agilbertdev-recipes"
```

On another machine, after cloning the project:

```bash
git submodule update --init
bash .recipes/bin/install
```

## Install the skills manually (no script)

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

The submodule pins which recipe version a project uses (manifest + conventions). Bump it when you want:

```bash
git submodule update --remote .recipes && git add .recipes && git commit -m "chore: bump recipes"
```

Third-party skills are versioned by the project's own `skills-lock.json` (written by the skills CLI). Refresh them with:

```bash
npx skills update          # all
npx skills update vue      # one
```
