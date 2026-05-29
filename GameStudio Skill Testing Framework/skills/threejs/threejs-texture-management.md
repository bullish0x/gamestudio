# Skill Test Spec: /threejs-texture-management

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Covers loading, caching, and optimising Three.js textures: a `TextureManager` with async loading and dedup, GPU-compressed textures via `KTX2Loader` / `BasisTextureLoader`, a `TextureAtlas` that converts sprite names to UV offsets, a `TextureOptimizer` for POT resizing and mobile presets, and a priority-queue `TextureStreamer`. Triggered when loading textures for materials, optimising texture memory for mobile, creating sprite atlases, or implementing texture streaming.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-texture-management` and a `description`
- [ ] Description names KTX2/Basis, POT dimensions, and atlases as trigger topics
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has a checklist with POT dimensions and disposal items
- [ ] Body has a "Performance Tips" section citing concrete size limits

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `KTX2Loader` and `BasisTextureLoader` are imported from `three/examples/jsm/loaders/`
- [ ] `ktx2Loader.detectSupport(renderer)` is called before loading compressed textures
- [ ] `TextureManager.load()` deduplicates concurrent requests via an in-progress `Map`
- [ ] `THREE.MathUtils.floorPowerOfTwo` is used in the POT resize helper
- [ ] `texture.generateMipmaps = false` is set for UI/sprite textures on mobile
- [ ] `texture.anisotropy = 0` is recommended on mobile
- [ ] `TextureAtlas.getUV()` computes `offset` and `repeat` from atlas sprite dimensions
- [ ] `TextureStreamer` limits concurrent loads via `maxConcurrent` and uses a priority sort
- [ ] Max texture size on mobile is stated as 1024×1024

## Version Awareness
- [ ] Aligns with pinned three 0.184: `texture.colorSpace = THREE.SRGBColorSpace` replaces `texture.encoding = THREE.sRGBEncoding`; the skill's `PBRTextureLoader` still uses `encoding` — flag this as a deprecated API to update

## Known Gaps / Notes
- `TextureOptimizer.compress()` is a stub (no actual compression happens); production should use offline tooling.
- No `DataTexture` streaming or mipmap chain generation is demonstrated beyond the basic loader.
