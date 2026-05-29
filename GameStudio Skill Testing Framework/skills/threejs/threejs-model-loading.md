# Skill Test Spec: /threejs-model-loading

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Covers loading and managing 3D models in GLTF/GLB, FBX, and OBJ formats: a `ModelLoader` that integrates `DRACOLoader` for geometry compression, caches loaded models with clone-on-serve, a `ProgressiveModelLoader` for low-res-first loading, a `ModelPool` for pre-warmed model instances, and a `MobileModelOptimizer` that downgrades textures and disables features by device tier. Triggered when loading external 3D assets, implementing asset systems, optimising file size, or managing model memory.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-model-loading` and a `description`
- [ ] Description names GLTF, FBX, OBJ, compression, and mobile as trigger topics
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has a checklist that includes Draco compression, caching, and error handling
- [ ] Body has a "Performance Tips" section with mobile poly-count limits

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `DRACOLoader.setDecoderPath('/draco/')` and `gltfLoader.setDRACOLoader(dracoLoader)` are shown
- [ ] `cache.get(url)` is checked before loading and `cloneModel()` is returned on hit
- [ ] `THREE.LoadingManager` `onProgress` callback is wired to report `(url, loaded, total)`
- [ ] `extractMaterials` and `extractMeshes` traverse the scene graph using `child.isMesh`
- [ ] `optimizeModel` sets `castShadow = true` and `receiveShadow = true` on mesh children
- [ ] `ProgressiveModelLoader` loads low-res first and calls `onLowResLoaded` callback before high-res resolves
- [ ] `MobileModelOptimizer` has `'low' | 'medium' | 'high'` tiers with different `maxTextureSize` values
- [ ] `clearCache()` disposes all cached materials and geometries before clearing the map

## Version Awareness
- [ ] Aligns with pinned three 0.184; `DRACOLoader` and `GLTFLoader` should be imported from `three/addons/` (alias for `three/examples/jsm/`); verify decoder path CDN version matches library version

## Known Gaps / Notes
- MTL loading for OBJ is not shown (only OBJ URL); multi-material OBJ models need `OBJLoader.setMaterials`.
- `MobileModelOptimizer.resizeTexture` modifies `texture.image` directly via canvas, which may not work for all texture types (e.g., `CompressedTexture`).
