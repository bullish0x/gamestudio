# Skill Test Spec: /ecs-performance

> **Category**: ecs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers ECS performance optimization from first principles through advanced data-oriented techniques. It starts with archetype storage that groups component data into contiguous per-type arrays for cache-friendly iteration. It provides a generic `ComponentPool<T>` with factory + reset functions and a `prewarm(count)` method, plus a parallel `EntityPool` that recycles entities without destroying them. A `PackedArray<T>` implements sparse-set storage for O(1) add/remove with cache-friendly dense-array iteration. A `SystemProfiler` wraps systems with monkey-patched timing and exponential moving average stats. A `QueryCache` holds dirty-flagged cached entity arrays. A `BatchProcessor` utility spreads heavy work across frames using a time budget. Memory profiling uses `performance.memory` and an `EntityProfiler` dumps component distribution.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: ecs-performance` and a `description`
- [ ] Description names concrete trigger keywords: "archetype optimization", "memory pooling", "cache-friendly data structures", "profiling techniques"
- [ ] Body contains fenced code for: `ArchetypeStorage`, `ComponentPool`, `EntityPool`, `PackedArray`, `SystemProfiler`, `QueryCache`, `BatchProcessor`, `MemoryProfiler`, `EntityProfiler`
- [ ] Skill has a `## Checklist` section (10 items)
- [ ] Skill has a `## Common Pitfalls` section (7 items)
- [ ] Skill has a layered `## Performance Tips` section covering data-oriented design, memory, CPU, and mobile subsections

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `ArchetypeStorage.addEntity()` pushes entity and each component value to their respective dense arrays — components are stored in parallel arrays, not as objects with component fields
- [ ] `ArchetypeStorage.removeEntity()` uses an index lookup (not `indexOf` scan) via the `entities` array — note: the skill's implementation actually uses `indexOf`, which testers should flag as O(n)
- [ ] `ArchetypeStorage.iterateArchetype()` uses a `for` loop with a pre-computed `length` variable (not `array.length` in the condition) for micro-optimization
- [ ] `ComponentPool` constructor takes both a `factory: () => T` and a `reset: (component: T) => void` — the reset function is called in `release()` before pushing back to the pool
- [ ] `ComponentPool.prewarm(count)` pre-allocates instances at initialization time to avoid runtime allocations during gameplay
- [ ] `EntityPool.release(entity)` calls `entity.removeAllComponents()` and sets `entity.active = false` before pushing to the pool — entities are deactivated, not destroyed
- [ ] `PackedArray<T>` maintains three parallel structures: `dense[]` (contiguous data), `sparse[]` (index → dense index), `indices[]` (dense index → original index); `remove()` uses swap-with-last to keep dense array contiguous
- [ ] `SystemProfiler.wrap()` monkey-patches `system.update` to record timing and computes `avgUpdateTime` with exponential moving average formula `avg * 0.9 + time * 0.1`
- [ ] `BatchProcessor.processBatches()` checks elapsed time every `batchSize` iterations (not every iteration) to minimize `performance.now()` call overhead
- [ ] `MemoryProfiler` uses `performance.memory.usedJSHeapSize` (Chrome-only API) and skill should note the non-standard nature of this API

## Version Awareness
- [ ] For ECS skills: flag any library-specific API to verify against the installed version. Custom implementation. `performance.memory` is a non-standard Chrome extension — not available in Firefox or Safari; the skill should document this limitation. `PackedArray` sparse array uses numeric keys on a regular JS array — for very sparse entity ID spaces this could cause memory issues; a `Map<number, number>` may be preferable.

## Known Gaps / Notes
- `ArchetypeStorage.removeEntity()` uses `archetype.entities.indexOf(entity)` which is O(n) — for large archetypes this defeats the performance goal; the skill should recommend a reverse lookup map.
- `EntityPool` calls `entity.active = false` but the `Entity` type in this skill does not define an `active` field — this is an implicit interface that testers should flag as undocumented.
- `BatchProcessor.processBatches()` returns a boolean indicating completion, but the calling system (`ExpensiveSystem`) ignores the return value and just resets the batch counter unconditionally — testers should verify the interaction is correct.
