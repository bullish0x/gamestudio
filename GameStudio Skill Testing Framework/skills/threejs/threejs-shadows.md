# Skill Test Spec: /threejs-shadows

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
A deep-dive into Three.js shadow configuration: a `ShadowManager` with type-specific helpers for directional, spot, and point lights; Cascaded Shadow Maps (CSM) via `three/examples/jsm/csm/CSM`; a `ContactShadows` renderer using depth packing and an orthographic render target; and an `AdaptiveShadowQuality` class that detects GPU tier via `WEBGL_debug_renderer_info` and applies matching quality presets. Triggered when implementing realistic shadows, fixing shadow artifacts, optimising shadow performance, or supporting mobile shadow strategies.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-shadows` and a `description`
- [ ] Description names shadow maps, CSM, PCFSS, and mobile as trigger topics
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has a performance-tips section listing shadow map sizes by importance
- [ ] Body explains the four `ShadowMapType` values ordered by performance

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `renderer.shadowMap.enabled = true` and `.type` are set in the `enable()` method
- [ ] `shadow.mapSize.width` and `shadow.mapSize.height` are set to power-of-two values
- [ ] `shadow.bias` and `shadow.normalBias` are configured to mitigate acne and peter-panning
- [ ] `shadow.camera.updateProjectionMatrix()` is called after modifying the shadow camera frustum
- [ ] CSM is imported from `three/examples/jsm/csm/CSM` with `cascades`, `maxFar`, and `lightDirection`
- [ ] `csmManager.setupMaterial(material)` is required for CSM-aware materials
- [ ] `ContactShadows` uses `THREE.MeshDepthMaterial` with `RGBADepthPacking` for the depth pass
- [ ] `AdaptiveShadowQuality` maps `'low' | 'medium' | 'high' | 'ultra'` to distinct `ShadowMapType` values and map sizes
- [ ] Point lights are noted as needing 6 shadow maps vs 1 for directional lights

## Version Awareness
- [ ] Aligns with pinned three 0.184 (`THREE.VSMShadowMap` available; `THREE.BasicShadowMap` is fastest); verify CSM import path as it may live under `three/addons/`

## Known Gaps / Notes
- `AdaptiveShadowQuality.detectGPUTier` uses a regex on the renderer string — heuristic only, not a replacement for a proper GPU-tier library.
- `ContactShadows` does not implement blur; the skill's "blur" config field is accepted but unused.
