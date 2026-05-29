# Skill Test Spec: /threejs-sprites

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides sprite and billboard tooling for Three.js: a `SpriteManager` that creates and caches `THREE.Sprite` objects backed by `SpriteMaterial`; a `SpriteAnimation` player that advances UV offset/repeat through `SpriteFrame` arrays at a configurable FPS; a `SpriteAtlas` class that computes per-frame UVs from a uniform grid; a `BillboardSystem` supporting spherical and cylindrical facing modes; and a `DamageNumberSystem` that renders canvas-text textures as floating sprites with fade-out. Triggered when adding 2D labels, billboards, animated sprites, foliage impostors, health bars, or damage numbers.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-sprites` and a `description`
- [ ] Description names billboards, texture atlases, sprite animation, and particle sprites
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has a checklist with atlas and `depthWrite` items
- [ ] Body has a performance-tips section recommending texture atlases

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `THREE.SpriteMaterial` is created with `depthWrite: false` and `transparent: true`
- [ ] `SpriteAnimation.applyFrame()` sets `material.map.offset` and `material.map.repeat`
- [ ] `SpriteAtlas.getFrame()` computes `v = 1 - (row + 1) * height` to flip the Y axis
- [ ] `SpriteAtlas` sets `texture.magFilter = THREE.NearestFilter` for pixel-perfect rendering
- [ ] `BillboardSystem.update()` calls `object.lookAt(cameraPosition)` for spherical mode
- [ ] Cylindrical mode passes `new THREE.Vector3(cameraPosition.x, object.position.y, cameraPosition.z)` to `lookAt`
- [ ] `DamageNumberSystem.spawn()` renders text via `CanvasRenderingContext2D` and creates a `THREE.CanvasTexture`
- [ ] `DamageNumberSystem.update()` floats sprites upward (`position.y += t * 2`) and fades `material.opacity = 1 - t`

## Version Awareness
- [ ] Aligns with pinned three 0.184 (`THREE.Sprite`, `THREE.SpriteMaterial` unchanged); `sizeAttenuation` on `SpriteMaterial` is distinct from `PointsMaterial` — confirm expected behaviour

## Known Gaps / Notes
- `DamageNumberSystem` creates a new `THREE.CanvasTexture` per damage number — should pool or reuse a single canvas to reduce GC pressure.
- `SpriteAnimation` does not handle non-uniform frame dimensions; the atlas assumes equal-sized cells.
