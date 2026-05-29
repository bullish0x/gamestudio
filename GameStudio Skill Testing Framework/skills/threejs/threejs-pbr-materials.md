# Skill Test Spec: /threejs-pbr-materials

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Deep dive into physically-based rendering with Three.js: a `PBRMaterialManager` that wraps `PMREMGenerator` for HDR environment map loading and maintains a library of `MeshStandardMaterial`/`MeshPhysicalMaterial` instances; a `MaterialPresets` catalogue covering metals (gold, silver, copper, chrome), non-metals (plastic, wood, glass, water), and special materials (car paint, skin); a `PBRTextureLoader` for loading full texture sets; a `MaterialVariantSystem` for colour/property variants; and a `MaterialAnimator` for time-based property interpolation. Triggered when creating realistic materials, implementing metalness-roughness workflow, or adding clearcoat/transmission.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-pbr-materials` and a `description`
- [ ] Description names metalness-roughness, clear coat, transmission, and IBL
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has a material-type performance order list
- [ ] Body has external references to Three.js docs and PBR theory articles

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `PMREMGenerator.fromEquirectangular(texture).texture` is used to create the PMREM env map
- [ ] The raw HDR texture is disposed after PMREM generation via `hdrTexture.dispose()`
- [ ] `scene.environment = envMap` is set for IBL on all materials
- [ ] `scene.backgroundBlurriness` and `scene.backgroundIntensity` are set when background is enabled
- [ ] Glass preset uses `transmission: 1`, `thickness: 0.5`, `ior: 1.5` via `MeshPhysicalMaterial`
- [ ] Car paint preset uses `clearcoat: 1` and `clearcoatRoughness: 0.1`
- [ ] `PBRTextureLoader` notes that normal maps need `LinearEncoding` / linear colour space while albedo needs sRGB
- [ ] `MaterialAnimator` uses `THREE.MathUtils.lerp` for scalar and `THREE.Color.lerpColors` for colour properties
- [ ] `PBRMaterialManager.dispose()` also calls `pmremGenerator.dispose()`

## Version Awareness
- [ ] Aligns with pinned three 0.184; `PBRTextureLoader` still uses deprecated `texture.encoding = THREE.sRGBEncoding` / `THREE.LinearEncoding` — must be updated to `texture.colorSpace = THREE.SRGBColorSpace` / `THREE.LinearSRGBColorSpace`; flag as a breaking change

## Known Gaps / Notes
- `RGBELoader` is imported from `three/examples/jsm/loaders/RGBELoader` — in the loaders skill the `addons/` path is used; ensure consistency.
- No sheen or iridescence presets despite `MeshPhysicalMaterial` supporting them in r150+.
