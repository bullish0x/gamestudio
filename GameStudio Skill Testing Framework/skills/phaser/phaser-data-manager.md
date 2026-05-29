# Skill Test Spec: /phaser-data-manager

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers Phaser 4's `DataManager` key-value storage system at three levels: per-GameObject (`sprite.setData`/`getData`/`incData`/`toggleData`), per-Scene (`this.data`), and global (`this.registry`). It explains event-driven change tracking (`setdata`, `changedata`, `changedata-{key}`, `removedata`), the `values` proxy for direct property access with event emission, batch operations (`merge`, `query`, `each`), `freeze`, and the critical differences in event emitter routing between the three contexts. It triggers when storing custom data, listening for data changes, or managing cross-scene state.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-data-manager` and a `description`
- [ ] Description names trigger keywords: `setData`, `getData`, `data events`, `custom data storage`
- [ ] Body contains code examples for all three levels: per-GameObject, per-Scene (`this.data`), and global registry
- [ ] An event emitter routing table is present showing which emitter fires for each context
- [ ] A Gotchas section exists

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Explains lazy DataManager creation: GameObjects have no DataManager until first call to `setData()`, `getData()`, `incData()`, or `toggleData()`
- [ ] Documents the `values` proxy object and its critical requirement: `set(key)` must be called first to create the key; direct assignment to `values.newKey` does NOT create the event proxy
- [ ] Documents the callback signature difference: generic `changedata` gives `(parent, key, value, previousValue)` but key-specific `changedata-{key}` omits `key` giving `(parent, value, previousValue)`
- [ ] Documents that mutating a stored object/array in place does NOT trigger `changedata`; a new reference must be set via `set(key, newRef)` to fire the event
- [ ] Documents `query(regex)` for filtering keys by RegExp pattern
- [ ] Documents `freeze` / `setFreeze(bool)`: frozen DataManagers silently no-op all write operations without error or event
- [ ] Documents that `reset()` clears all data silently — no `removedata` events fire; individual `remove()` calls are needed to fire events per key
- [ ] Documents the Registry lifecycle: persists for game lifetime, never auto-cleared on scene restart; listeners on `registry.events` must be removed on `SHUTDOWN`
- [ ] Documents `DataManagerPlugin` (scene `this.data`): removes shutdown listener on scene shutdown but does NOT clear data unless `reset()` called manually
- [ ] Documents `inc()` on non-numeric values: uses `+` operator, so strings concatenate and booleans coerce to 0/1

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask); flags any API to verify against the installed version
- [ ] `DataManager` API is stable across v3/v4; no known breaking changes but verify `incData` negative decrement pattern

## Known Gaps / Notes
The skill provides a localStorage save/load pattern using `getAll()` + `merge()` which is a useful practical example. The `pop(key)` method (get + delete in one call) is documented but not shown in an example. The `count` read-only property is listed but may be overlooked by developers.
