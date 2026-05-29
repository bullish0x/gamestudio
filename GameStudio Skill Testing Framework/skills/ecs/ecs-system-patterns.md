# Skill Test Spec: /ecs-system-patterns

> **Category**: ecs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill catalogs the major ECS system archetypes and composition patterns. It defines a `System` interface with `priority`, `enabled`, and `update(world, deltaTime)`, then provides four concrete base classes: `UpdateSystem` (every frame), `ReactiveSystem` (accumulates component-change events, drains in `update`), `IntervalSystem` (fixed-frequency using an accumulator and `while` loop), and `CleanupSystem` (priority 1000, runs last). It also demonstrates three composition meta-patterns: `SystemGroup` for batching related systems, `ConditionalSystem` for pause/unpause gating, and `ParallelSystem` for independent async execution. A `SystemManager` handles priority-sorted registration, enable/disable, and cleanup. A `SystemPriority` enum provides conventional ranges.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: ecs-system-patterns` and a `description`
- [ ] Description names concrete trigger keywords: "reactive systems", "interval systems", "system priorities", "modular game mechanics"
- [ ] Body contains fenced code for all four base system types and three composition patterns
- [ ] Skill has a `## Checklist` section
- [ ] Skill has a `## Common Pitfalls` section (7 items)
- [ ] Skill has a `## Performance Tips` section (system optimization + profiling)
- [ ] Skill has a `## System Priority Guidelines` section or enum showing concrete numeric ranges
- [ ] Skill includes a `ProfiledSystem` wrapper example in the performance section

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `ReactiveSystem.update()` processes events from `this.events` array and then clears it (`this.events = []`) — frame-delayed processing pattern
- [ ] `IntervalSystem` constructor takes `frequency` in Hz and converts to interval in seconds (`1 / frequency`); uses a `while` loop (not `if`) to catch up on missed ticks
- [ ] `AIDecisionSystem` extends `IntervalSystem` at 10 Hz and demonstrates an expensive `findNearestTarget` inside `tick()` rather than `update()` — justifying the interval pattern
- [ ] `EntityCleanupSystem` extends `CleanupSystem` with `priority = 1000` and handles both dead (Health ≤ 0) and expired (Lifetime age ≥ maxAge) entities in one pass
- [ ] `SystemManager.add()` pushes the system then re-sorts by `priority` ascending so lower numbers run first
- [ ] `SystemManager.get<T>()` uses `systemsByType` Map keyed by `systemType.name` (constructor name string)
- [ ] `ConditionalSystem` wraps an inner system and a `() => boolean` condition; the inner system is only updated when condition returns true
- [ ] `ParallelSystem.update()` is `async` and uses `Promise.all` — the skill acknowledges this is only appropriate for truly independent systems
- [ ] `SystemPriority` enum covers: Input=0, AI=10, Logic=15, Movement=20, Collision=30, PhysicsResponse=35, Animation=40, Particles=45, Render=50, PostProcess=60, UI=70, Cleanup=1000
- [ ] `ProfiledSystem` wraps `system.update` by monkey-patching it with a `performance.now()` timing block and uses an exponential moving average (`avgTime * 0.9 + time * 0.1`)

## Version Awareness
- [ ] For ECS skills: flag any library-specific API to verify against the installed version. This is a custom implementation. The `async update()` in `ParallelSystem` breaks the `System` interface contract (interface declares `update` as synchronous `void`) — testers should flag this type inconsistency.

## Known Gaps / Notes
- `ReactiveSystem` accumulates events but only processes them in `update()` — if a system is `enabled = false`, events will pile up indefinitely; the spec should clarify whether events should be discarded or held.
- `SystemManager.remove()` calls `system.cleanup()` if present but does not call `this.systems.sort()` after removal — the sort order is not affected by removal since splice preserves order.
- The `DependentSystem` example in the usage section retrieves `PhysicsSystem` from `SystemManager` via constructor, which creates a hard coupling; the skill notes this but does not provide an alternative injection pattern.
