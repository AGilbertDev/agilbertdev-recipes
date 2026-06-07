# agilbertdev-recipes

My personal "recipes": curated Agent Skills plus my working conventions, shared across my own projects as a git submodule.

Personal projects only. Do not add this to client or work repos.

## What's inside

- `skills/` — curated Agent Skills (Claude Code, Cursor, etc.)
  - Framework: `nuxt-ui` (official), `vue`, `vue-best-practices`, `nuxt`, `zod`, `bun`, `tailwind-css-patterns`, `typescript-advanced-types`
  - Quality: `accessibility`, `seo`, `frontend-design`
  - `agilbertdev-conventions` — my personal conventions (git identity, voice, solution priority, security/NDA). Tutorial/teaching mode is intentionally NOT here; that is a per-project collaboration mode.
- `settings.base.json` — baseline deny rules (never read `.env`).

## Add to a project (submodule)

```bash
# from the project root
git submodule add git@github.com:AGilbertDev/agilbertdev-recipes.git .recipes

# bridge skills into the path Claude reads (relative symlink, commit it):
mkdir -p .claude
ln -s ../.recipes/skills .claude/skills

# optional: copy baseline deny rules into the project once
#   merge settings.base.json into .claude/settings.json (or settings.local.json)
```

Commit the submodule pointer and the `.claude/skills` symlink. On any machine:

```bash
git clone --recurse-submodules <project>          # or, after a plain clone:
git submodule update --init
```

## Update a project to the latest recipes

```bash
git submodule update --remote .recipes
git add .recipes && git commit -m "chore: bump recipes"
```

The submodule pins each project to a specific commit, so projects only move when you bump them. That is intentional: update on your schedule, per project.
