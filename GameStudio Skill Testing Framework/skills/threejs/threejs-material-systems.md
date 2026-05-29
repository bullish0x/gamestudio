# Skill Test Spec: /threejs-material-systems

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Covers the full Three.js material hierarchy: a `MaterialManager` with ID-based caching, factory creation of Basic / Lambert / Phong / Standard / Physical / Toon materials, custom `ShaderMaterial` examples (water animation, vertex colour, dissolve effect), a `MaterialInstanceManager` for cloning base materials with overrides, and a generic `MaterialPool` for pooling dynamic materials. Triggered when setting up materials, optimising for mobile, creating custom shaders, or managing material memory.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-material-systems` and a `description`
- [ ] Description lists material types and mobile optimisation as trigger topics
- [ ] Body contains at least one fenced TypeScript code example with shader strings
- [ ] Body has a checklist covering reuse, pooling, and disposal
- [ ] Body has a "Performance Tips" section with a mobile recommendation

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `MeshLambertMaterial` is recommended for mobile instead of `MeshStandardMaterial`
- [ ] `depthWrite: false` is set on transparent materials to avoid sorting artifacts
- [ ] `material.needsUpdate = true` is flagged as expensive and should be used sparingly
- [ ] The water `ShaderMaterial` demonstrates updating a `time` uniform each frame
- [ ] The dissolve shader uses `discard` keyword and a `smoothstep` edge-glow pattern
- [ ] `MaterialPool` pre-allocates instances and returns them via `acquire()` / `release()`
- [ ] `MaterialInstanceManager.updateAll()` propagates changes to the base and all clones
- [ ] Sharing one material across multiple meshes is explicitly called out as a draw-call optimisation

## Version Awareness
- [ ] Aligns with pinned three 0.184; note that `MeshStandardMaterial.envMapIntensity` and `scene.environment` are the modern IBL path — check for any legacy `THREE.sRGBEncoding` / `texture.encoding` references and replace with `colorSpace`

## Known Gaps / Notes
- No `MeshPhysicalMaterial` demo (clearcoat, transmission) in this skill; see `threejs-pbr-materials` for those.
- Shader strings are inline; production projects should import `.glsl` files via bundler plugins.
