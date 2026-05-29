# Skill Test Spec: /spawn-system

> **Category**: game-systems · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a data-driven entity spawning system with pooling, wave management, and configurable spawn points. `Spawner` component holds an array of `SpawnConfig` objects (prefabName, count, interval, maxActive), tracks active entities, and advances through configs via `nextConfig()`. `SpawnPoint` component provides randomized spawn position offsets within a radius. `SpawnSystem` ticks each spawner's interval, enforces the `maxActive` cap by counting live active entities, instantiates via `EntityPrefabManager`, and advances the config when the count is reached. `WaveSystem` cycles through `WaveConfig` arrays using a `waiting → active → complete` state machine with configurable pre- and post-wave delays, assigns spawn configs to available spawn points, and detects wave completion when all spawned entities are inactive. `EntityPool` prewarms entities, reactivates pooled entities on `spawn()`, resets Health and Velocity on `despawn()`, and tracks active vs available sets.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: spawn-system` and a `description`
- [ ] Description names trigger keywords (entity spawning, spawn pools, waves, spawn points)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Four named implementation sections are present (Spawn Components, Spawn System, Wave System, Entity Pool)
- [ ] A `## Checklist` section is present with pooling, wave, and performance items
- [ ] A `## Common Pitfalls` section warns against no pooling and no max active limit

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `SpawnPoint.getRandomOffset()` returns a zero vector when `radius === 0` and a random polar-coordinate offset otherwise
- [ ] `Spawner.nextConfig()` advances `currentConfigIndex` modulo `configs.length` and resets `timeSinceLastSpawn`
- [ ] `SpawnSystem.update` skips spawn when `activeCount >= config.maxActive`
- [ ] `SpawnSystem.spawnEntity` copies the spawner transform position plus `spawnPoint.getRandomOffset()` to the new entity
- [ ] `WaveSystem` state machine has three states: `waiting`, `active`, and `complete`
- [ ] `WaveSystem.startWave` assigns one `SpawnConfig` per active `SpawnPoint` in round-robin order
- [ ] `WaveSystem.updateActive` only transitions to `complete` when all spawners have reached their count AND no active entities remain
- [ ] `EntityPool.spawn` returns a pooled (inactive) entity if available, creates a new one if the pool is empty
- [ ] `EntityPool.despawn` sets `entity.active = false`, resets `Health.current = Health.max` and `Velocity` to zero, then returns to pool
- [ ] `EntityPool.prewarm(count)` pre-creates `count` inactive entities before gameplay begins

## Version Awareness
- [ ] The skill is engine-agnostic ECS; no library version pinning is required. `EntityPrefabManager` is referenced but not defined in this skill — it must come from the project's ECS layer.

## Known Gaps / Notes
- `WaveSystem.updateActive` counts spawners that have reached `config.count` to determine completion, but the check for "no active entities" iterates `spawner.activeEntities` — entities that were pooled and reactivated later may cause premature wave-complete detection if not tracked carefully.
- `EntityPool` uses `setTimeout` in the usage example for bullet lifetime, which is not frame-synchronized; a timer component or the ECS time system is the recommended production approach.
