# Skill Test Spec: /ecs-component-patterns

> **Category**: ecs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers advanced ECS component design patterns beyond basic data structs. It catalogs: full-featured `Transform` and `Velocity` components with helper methods (setPosition, normalize, clone); zero-data tag components using `readonly __brand` for type uniqueness; Singleton components (`GameState`, `InputState`) via private constructors and static `getInstance()`; composite components (`Health` with regeneration timer, `Stats` with derived combat values); parent-child relationship components for scene hierarchies; temporal components (`Lifetime`, `Cooldown`) that self-update; a generic `ComponentPool<T>` for allocation-free acquire/release; and a global `ComponentRegistry` that manages named pools.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: ecs-component-patterns` and a `description`
- [ ] Description names concrete trigger keywords: "tag components", "singleton components", "shared data", "component pools"
- [ ] Body contains fenced code for each pattern type (basic, tag, singleton, composite, relationship, temporal, pool, registry)
- [ ] Skill has a `## Checklist` section
- [ ] Skill has a `## Common Pitfalls` section (6 items)
- [ ] Skill has a `## Performance Tips` section mentioning TypedArrays and tag components

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `Transform` component has fluent setter methods (`setPosition`, `setRotation`, `setScale`) that return `this` for chaining, and a `clone()` method
- [ ] `Velocity` component exposes computed `get magnitude()` and a `normalize()` method that guards against zero-magnitude
- [ ] Tag components use `readonly __brand = 'Player' as const` pattern — not just empty classes — to ensure structural uniqueness in TypeScript
- [ ] `GameState` and `InputState` are Singletons with `private constructor()` and `static getInstance()` that lazily creates the single instance
- [ ] `InputState.getAxis(positive, negative)` returns a number in `{-1, 0, 1}` derived from two key-press checks
- [ ] `Health.damage(amount, time)` records `lastDamageTime` and `Health.regenerate()` only heals if `currentTime - lastDamageTime > 3` (3-second combat regen delay)
- [ ] `Lifetime.isExpired` is a getter (`get isExpired()`) and `Lifetime.percentComplete` clamps to 1 via `Math.min`
- [ ] `Cooldown` accepts a `startOnCooldown` boolean that initializes `elapsed` to 0 (not ready) vs `duration` (ready immediately)
- [ ] `ComponentPool<T>` logs a warning (`console.warn`) when the pool is exhausted and must allocate a new instance
- [ ] `ComponentRegistry` is a class with static methods only — it is never instantiated, and usage example shows `registerPool` → `acquire` → `release` cycle

## Version Awareness
- [ ] For ECS skills: flag any library-specific API to verify against the installed version. This skill is a custom implementation. The Singleton `private constructor` pattern is standard TypeScript — verify the `static instance?` optional field pattern compiles without strictPropertyInitialization errors.

## Known Gaps / Notes
- `GameState.getInstance()` stores the instance on the class itself (`private static instance?`) — this is a module-level singleton that will persist across test runs; testers should note this makes unit testing harder without a `reset()` method.
- `ComponentPool` uses a `Set<T>` for `inUse` tracking — Set membership uses object identity, which is correct but adds O(1) overhead per acquire/release vs. a simple counter.
- The `Parent` component stores `children: EntityId[]` as a mutable array on the component; systems that query this array must handle concurrent modification carefully.
