# Skill Test Spec: /ecs-queries

> **Category**: ecs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill builds a complete typed query system for ECS. It defines a `QueryResult<T>` interface with `entities`, `iterate`, `filter`, `first`, and `count`, backed by a `Query<T>` class that caches results and tracks a `dirty` flag. An `ArchetypeManager` indexes entities by sorted component-name signature strings for O(subset) query dispatch. A `QueryManager` caches `Query` instances by key and invalidates them on component add/remove. A chainable `FilteredQuery<T>` wraps any `QueryResult` with a predicate. A `SpatialQuery` class provides `withinRadius`, `withinBox`, `nearest`, and `raycast` helpers using Three.js `Vector3`. Three optimization patterns (caching, early exit, batch processing) round out the skill.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: ecs-queries` and a `description`
- [ ] Description names concrete trigger keywords: "archetype-based queries", "filtered queries", "cached queries", "spatial queries"
- [ ] Body contains fenced code for: `Query`, `ArchetypeManager`, `QueryManager`, `FilteredQuery`, `SpatialQuery`, optimization patterns, and profiling utility
- [ ] Skill has a `## Checklist` section
- [ ] Skill has a `## Common Pitfalls` section (7 items)
- [ ] Skill has a `## Performance Tips` section covering query, memory, and profiling subsections
- [ ] Skill references Unity DOTS queries, Bevy ECS, and Data-Oriented Design in a References section

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `Query<T>` uses a `dirty` boolean flag that is set by `markDirty()` and cleared after `refresh()`; `entities` getter checks `dirty` before returning cached results
- [ ] `ArchetypeManager.getArchetype()` builds the signature by sorting component type names alphabetically and joining with `':'`
- [ ] `ArchetypeManager.queryArchetypes()` iterates all known archetype keys, splits each on `':'` into a `Set`, and checks that every required component name is present
- [ ] `QueryManager.query<T>()` returns the same cached `Query` instance for identical component type sets (same key) — subsequent calls do not allocate new Query objects
- [ ] `FilteredQuery<T>.iterate()` calls `this.baseQuery.iterate(...)` and only invokes `callback` when `predicate` returns true — filters lazily during iteration, not pre-filtering into an array
- [ ] `FilteredQuery<T>.filter()` returns a new `FilteredQuery` wrapping `this`, enabling unlimited chain depth
- [ ] `SpatialQuery.withinRadius()` uses `distanceToSquared` (not `distanceTo`) for the comparison to avoid a square root per entity
- [ ] `SpatialQuery.nearest()` sorts an intermediate array by distance and returns a slice of the top `count` entities
- [ ] "Good" caching pattern shows query created in system constructor (not inside `update`) and cached as `this.query`
- [ ] `BatchedSystem` pattern processes one batch of `batchSize` entities per frame by modulo-indexing into the entity array by `frameCount % batchCount`

## Version Awareness
- [ ] For ECS skills: flag any library-specific API to verify against the installed version. `SpatialQuery` imports `Vector3` from `'three'` — verify three 0.184 exports `Vector3.distanceToSquared`. The `ArchetypeQuery` class is a private inner class that accesses `this.cachedEntities` (a protected field of `Query`) — verify TypeScript allows this access pattern.

## Known Gaps / Notes
- `ArchetypeQuery` constructor passes `null!` as the `world` argument to the `Query` super-constructor because it uses `archetypeManager` directly — this is a type lie that bypasses the null check; testers should flag this as a design smell.
- `FilteredQuery.first()` references `this.componentTypes` which is not defined on `FilteredQuery` (only on `Query`) — this looks like a bug in the skill code; testers should verify and flag.
- The `raycast` implementation is described as "simplified" and not suitable for production; the skill should note which Three.js `Raycaster` or physics library to use instead.
