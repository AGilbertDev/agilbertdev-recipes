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

- Carbon is the default set, via the Nuxt UI icon prop (`i-carbon-*`).
- Simple Icons for brand and logo marks only (`i-simple-icons-*`).
