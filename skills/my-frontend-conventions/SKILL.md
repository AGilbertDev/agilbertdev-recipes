---
name: my-frontend-conventions
description: AGilbertDev's frontend conventions for Nuxt/Vue projects — component and composable choices, solution priority, and icons. Use when building UI, components, or pages in a personal Nuxt project. Pairs with my-styling-conventions for Tailwind and theming.
---

# Frontend conventions (Nuxt / Vue)

## Solution priority

Reach for solutions in this order, and stop at the first that fits:

1. Nuxt UI components and composables
2. Nuxt core features
3. Custom Vue
4. Tailwind utilities for styling gaps

Look up the official docs and explain the reasoning rather than guessing. When naming a component or API, name it exactly (for example `UFormField` with a `UInput` inside) so it is easy to look up.

## Components

- Prefer Nuxt UI primitives (`UButton`, `UCard`, `UForm`, `UModal`, `UTable`, `UInput`, and so on) before building custom.
- Vue 3 Composition API with `<script setup>`. Keep components small and composable; pull shared logic into composables.

## Icons

- Phosphor is the default set, via the Nuxt UI icon prop (`i-ph-*`). Match the icon weight to the text it sits with: use the `-bold` variants next to bold or large text so the glyph does not look thin, and scale the icon up as the text scales. Pick one weight family per project and stay consistent.
- Simple Icons for brand and logo marks only (`i-simple-icons-*`).

## Page composition

- Build a long landing or portfolio page as one route that scrolls through sections, each its own component under `components/home/` (hero, about, experience, and so on), assembled in the page. Keep the page file a thin list of those sections.
- A small reusable `SectionHeader` component (a mono `text-primary` kicker plus the section `h2`) keeps headers consistent. Exactly one `h1` (the hero), one `h2` per section, in order.
- For in-page anchor nav, keep the section ids in one composable (for example `useSectionId`) so the nav links and each `<section :id>` always agree. On a bilingual site make the ids locale-aware there (`#a-propos` / `#about`), and translate the current hash when toggling locale so the toggle stays on the same section.

## Scroll reveal

- Reveal sections on scroll with a small client plugin: add a `js` class to `<html>`, hide `[data-reveal]` elements only when that class is present (so a no-JS render still shows everything), then add an `is-in` class through an `IntersectionObserver` on mount and after each navigation. Stagger children with a `--reveal-i` custom property. Gate the whole effect behind `prefers-reduced-motion`.
