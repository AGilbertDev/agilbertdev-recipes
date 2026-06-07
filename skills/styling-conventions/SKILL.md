---
name: styling-conventions
description: AGilbertDev's styling conventions for Nuxt/Tailwind projects — utility-first Tailwind, mobile-responsive rules, and theming. Use when styling components or pages, building responsive layouts, or setting up a theme. Pairs with frontend-conventions.
---

# Styling conventions (Tailwind / Nuxt UI)

## Tailwind
- Utility-first. Avoid custom CSS files unless unavoidable.

## Typography
- Always justify body paragraph text (`text-justify`).
- Never hyphenate words. Use `hyphens-none` and never break a word with a hyphen anywhere on the site.
- Applies to prose and descriptions, not to centered headings or short subtitles.

## Mobile responsive
- Use `min-h-dvh`, not `min-h-screen`.
- Scale vertical padding and margins down on mobile, then step them up at `sm:` and above. Design mobile-first.

## Theming
- Theme through Nuxt UI semantic colors and CSS variables rather than hardcoded color classes, so a palette change is one place, not many.
- Keep a project's palette defined in one spot (app config or `main.css`).
