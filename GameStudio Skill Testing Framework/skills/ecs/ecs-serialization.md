# Skill Test Spec: /ecs-serialization

> **Category**: ecs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers the full serialization stack for ECS worlds. It defines a `SerializableComponent` abstract base with `serialize()` / `deserialize()` contract, concrete implementations for `Transform` (using Three.js `Vector3.toArray`/`fromArray`) and `Health`. An `EntitySerializer` handles per-entity round-trips using a `componentRegistry` map from type-name string to constructor. A `WorldSerializer` wraps the full world with a `version` field and timestamp. A `SaveLoadSystem` persists to `localStorage` with export-to-file and import-from-file capabilities. An `EntityPrefabManager` creates reusable templates from live entities. A `NetworkSerializer` tracks dirty entities and generates snapshots for network sync. Advanced patterns include pako-based compression, incremental delta saves, and async serialization via `requestIdleCallback`.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: ecs-serialization` and a `description`
- [ ] Description names concrete trigger keywords: "save/load systems", "component serialization", "entity prefabs", "network synchronization"
- [ ] Body contains fenced code for: `SerializableComponent`, `EntitySerializer`, `WorldSerializer`, `SaveLoadSystem`, `EntityPrefabManager`, `NetworkSerializer`, and advanced patterns
- [ ] Skill has a `## Checklist` section (10 items)
- [ ] Skill has a `## Common Pitfalls` section (7 items)
- [ ] Skill has a `## Performance Tips` section with serialization, memory, and network subsections

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `Transform.serialize()` uses `this.position.toArray()` / `this.rotation.toArray()` / `this.scale.toArray()` and `deserialize()` uses the corresponding `fromArray()` — Three.js array round-trip pattern
- [ ] `EntitySerializer.deserializeEntity()` logs a `console.warn` for unknown component types rather than throwing — graceful degradation for forward-compatibility
- [ ] `WorldSerializer.deserializeWorld()` calls `world.clear()` before deserializing — ensures no entity ID collisions with stale world state
- [ ] `WorldSerializer` checks version compatibility with `isCompatibleVersion()` before proceeding; throws `Error` on mismatch with the version string in the message
- [ ] `SaveLoadSystem.save()` persists to both an in-memory `Map` and `localStorage` (dual write) to allow fast in-session access
- [ ] `SaveLoadSystem.exportSave()` creates a `Blob`, generates an object URL, programmatically clicks an `<a>` element, and revokes the URL after click
- [ ] `SaveLoadSystem.importSave()` is `async`, uses `file.text()` to read the `File` object, and returns a `boolean` success flag
- [ ] `EntityPrefabManager.instantiate()` generates a new entity ID via `world.generateEntityId()` rather than reusing the template's ID
- [ ] `VersionedComponent` example stores a `version` field in serialized output and checks `data.version ?? 1` in `deserialize()` to handle saves that predate the version field
- [ ] `SelectivelySerializedComponent` demonstrates explicitly NOT serializing `cachedValue` and `tempBuffer`, and calls `recalculateCache()` at the end of `deserialize()`

## Version Awareness
- [ ] For ECS skills: flag any library-specific API to verify against the installed version. `Vector3.toArray()` and `Quaternion.toArray()` are stable Three.js APIs present in three 0.184. The `pako` compression pattern requires `pako` as an npm dependency — testers should verify it is listed in `package.json` if that pattern is used. `requestIdleCallback` is not available in all environments (notably Node.js and some mobile browsers) — the skill should note a fallback.

## Known Gaps / Notes
- `NetworkSerializer.applySnapshot()` accesses `this.entitySerializer['componentRegistry']` using bracket notation to bypass `private` — this is a brittle accessor; testers should flag and recommend exposing a proper method.
- The `CompressedSerializer` stores compressed data as `entities: compressed as any` in the `SerializedWorld` shape — this breaks the TypeScript type contract and will confuse consumers; a separate `CompressedSaveData` type should be used.
- `SaveLoadSystem.listSaves()` enumerates `localStorage` by key prefix scan — this is O(localStorage.length) and may be slow with many unrelated keys; no limit or pagination is provided.
