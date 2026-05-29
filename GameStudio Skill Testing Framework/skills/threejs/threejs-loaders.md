# Skill Test Spec: /threejs-loaders

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
A concise, practical reference for all Three.js loader patterns: `TextureLoader` with callback and promise styles, texture configuration (colorSpace, wrapping, filtering, anisotropy, flipY), `CubeTextureLoader` for skyboxes, `RGBELoader`/`EXRLoader` with `PMREMGenerator`, GLTF/GLB loading with Draco and KTX2, post-load processing (shadows, bone/mesh finding, centering/scaling), OBJ+MTL, FBX, STL, PLY, async `Promise.all` patterns, `THREE.Cache`, a custom `AssetManager` with keyed dedup, and advanced source patterns (ArrayBuffer, Blob URL, base64 DataURL, CDN path modifiers). Triggered when loading 3D models, textures, HDR environments, or managing loading progress.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-loaders` and a `description`
- [ ] Description names GLTF, textures, images, models, and async patterns as topics
- [ ] Body contains a Quick Start section with minimal code
- [ ] Body contains at least one fenced JavaScript code example for each major loader type
- [ ] Body has a "Performance Tips" section

## Content Coverage Assertions (`/skill-test spec`)
- [ ] All loader imports use `three/addons/loaders/` (not `three/examples/jsm/loaders/`)
- [ ] `tex.colorSpace = THREE.SRGBColorSpace` is shown for colour/albedo maps
- [ ] `DRACOLoader.setDecoderPath()` and `dracoLoader.preload()` are shown before attaching to GLTF loader
- [ ] `KTX2Loader.detectSupport(renderer)` is called before loading KTX2 textures
- [ ] `THREE.AnimationMixer` is created from `gltf.animations` in the GLTF load callback
- [ ] `THREE.AnimationClip.findByName(clips, 'Walk')` is demonstrated for clip lookup by name
- [ ] `THREE.Cache.enabled = true` is set before any load calls for caching
- [ ] `loader.parse(buffer, '', callback)` is shown for loading from `ArrayBuffer`
- [ ] `URL.createObjectURL(blob)` + `URL.revokeObjectURL(url)` pattern is shown for Blob loading
- [ ] `manager.setURLModifier()` is demonstrated for CDN URL rewriting

## Version Awareness
- [ ] Aligns with pinned three 0.184; imports use `three/addons/` which is the canonical path from r152 onward; verify `EXRLoader` is also in `three/addons/loaders/EXRLoader.js`

## Known Gaps / Notes
- `GLTFLoader` usage in `threejs-animation-systems` skill uses the old `three/examples/jsm/` path — there is an inconsistency between skills to flag.
- No `MeshoptDecoder` integration shown alongside Draco despite being the preferred modern compressor for geometry.
