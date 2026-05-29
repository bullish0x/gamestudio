# Skill Test Spec: /r3f-state-management

> **Category**: react · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill explains state management strategies for React Three Fiber games using Zustand as the primary tool. It demonstrates building a typed `useGameStore` with `devtools` + `persist` middleware, slice-based selectors to prevent unnecessary re-renders, `shallow` comparison for object selectors, transient (no-re-render) updates via `subscribeWithSelector`, async actions for data fetching, a secondary `actionsStore` for audit logging, and React Context for level-scoped state. The skill also shows how to combine stores into composite action hooks and how to subscribe to high-frequency data (mouse position) without triggering React renders.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: r3f-state-management` and a `description`
- [ ] Description names concrete trigger keywords: "Zustand", "React Context", "global stores", "game state"
- [ ] Body contains fenced code for store setup, component usage, HUD UI integration, selectors, actions middleware, context, combined stores, async actions, and transient updates
- [ ] Skill has a `## Checklist` section referencing Zustand install step
- [ ] Skill has a `## Common Pitfalls` section
- [ ] Skill has a `## Performance Tips` section mentioning `subscribeWithSelector` and `shallow`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `useGameStore` is created with `create<GameState>()(devtools(persist(...)))` — both middlewares are stacked in the correct order (devtools wraps persist)
- [ ] `persist` middleware uses `partialize` to save only `playerScore` and `gameLevel` (excluding transient fields like `playerPosition` and `enemies`)
- [ ] `Player` component subscribes to `playerPosition` and `playerHealth` as separate `useGameStore` selector calls to avoid merging into a single object subscription
- [ ] `Player` component updates the store from `useFrame` only when position has actually changed (guard comparison before calling `setPosition`)
- [ ] `usePlayerStats` selector uses `shallow` from `zustand/shallow` for the multi-field object selector to prevent spurious re-renders
- [ ] `useTransientStore` is created with `subscribeWithSelector` middleware; `subscribeToMouse` uses `.subscribe(selector, callback)` form that bypasses React rendering entirely
- [ ] Transient usage example shows updating a Three.js object's position directly inside the subscription callback (imperative mutation, no setState)
- [ ] `useGameActions` combined hook composes actions from two stores and adds wrapped versions (`damagePlayerWithLog`, `addScoreWithLog`) that call both underlying actions
- [ ] `LevelProvider` context uses a partial-update pattern: `setLevelData` merges via spread `{ ...prev, ...data }` rather than full replacement
- [ ] Performance tips explicitly list: avoid storing Three.js objects in state, use refs instead; avoid nested objects (flatten state)

## Version Awareness
- [ ] For React Three Fiber skills: aligns with pinned R3F 9 / drei 10 / three 0.184. Zustand 4+ changed the `shallow` import path to `zustand/shallow` — verify this is the form used. `subscribeWithSelector` middleware import path should be `zustand/middleware`.

## Known Gaps / Notes
- The `logger` middleware in `actionsStore` uses `any` types throughout — testers should flag this as a type safety gap.
- `useGameStore` uses `persist` which writes to `localStorage` by default; the skill does not cover IndexedDB or async storage for larger saves.
- The HUD component subscribes to five separate store slices in five separate `useGameStore` calls — testers should verify this is intentional (correct pattern) vs. a candidate for a combined selector.
