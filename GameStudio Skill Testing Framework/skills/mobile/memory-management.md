# Skill Test Spec: /memory-management

> **Category**: mobile · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a structured mobile memory management system with reference-counted resource ownership (`ResourceManager`), VRAM-aware texture loading with LRU eviction and a 256 MB mobile cap (`TextureManager`), pre-allocated `ObjectPool<T extends Poolable>` with factory function and active/inactive sets, periodic heap monitoring with 85%/95% thresholds and a `memory:critical` custom event (`MemoryMonitor`), shared geometry instances tracked by usage count (`GeometryManager`), and hashed material deduplication (`MaterialManager`). A `DisposableScene` wrapper ties these managers together for explicit scene lifecycle management.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: memory-management` and a `description`
- [ ] Description names trigger keywords (resource disposal, memory pooling, texture management, leak prevention)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Six named implementation sections are present (Resource Manager, Texture Memory Manager, Object Pooling, Memory Monitor, Geometry Pool Manager, Material Manager)
- [ ] A `## Checklist` section is present
- [ ] Four tips sub-sections exist under `## Performance Tips` (Memory Efficiency, Leak Prevention, GC Optimization, Mobile Considerations)

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `ResourceManager.register` increments a ref count if the resource already exists rather than registering a duplicate
- [ ] `ResourceManager.release` calls `dispose()` only when the ref count reaches 1 (last reference)
- [ ] `TextureManager` has a `MAX_VRAM_MB = 256` constant and calls `evictLeastRecentlyUsed()` before loading when the limit is reached
- [ ] `TextureManager.calculateTextureSize` computes `width * height * 4 * 1.33` to account for RGBA bytes plus mipmaps
- [ ] `ObjectPool.acquire()` logs a warning and reuses an active object when the pool is exhausted rather than throwing
- [ ] `ObjectPool.release(obj)` calls `obj.reset()` before returning the object to the available pool
- [ ] `MemoryMonitor` uses `performance.memory.usedJSHeapSize` with a fallback returning zeros when the API is unavailable
- [ ] `MemoryMonitor.onCriticalMemory()` dispatches a `memory:critical` custom event on `window`
- [ ] `GeometryManager.getOrCreate` increments an instance count and only disposes geometry when the count reaches zero via `release`
- [ ] `DisposableScene.remove` calls `geometryManager.release` and `materialManager.release` recursively via `traverse`

## Version Awareness
- [ ] `TextureManager` uses `THREE.TextureLoader.loadAsync`, `THREE.LinearMipmapLinearFilter`, and `THREE.LinearFilter` — verify these exist in the installed Three.js version. `performance.memory` is a Chrome-only API; the fallback is correctly handled.

## Known Gaps / Notes
- `TextureManager.evictLeastRecentlyUsed` removes the first key in insertion order (Map iteration order), which is true LRU only if the map is never reordered. A proper LRU would require a doubly-linked list or an access-order Map.
- ASTC / ETC2 texture compression selection is mentioned but the implementation is marked as a placeholder; actual compressed format selection is deferred to the project's asset pipeline.
