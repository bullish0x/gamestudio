# Skill Test Spec: /threejs-best-practices

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
A meta-skill covering architecture and coding standards for Three.js projects: directory structure best practices, resource-management patterns (dispose traversal), geometry sharing, a fixed-physics / variable-render game loop, instancing / merged geometry for draw calls, material libraries, optimised texture loading with anisotropy, camera configuration anti-patterns, strategic lighting limits, and graceful error handling with fallback placeholders. Also includes a production-deployment checklist and visual/performance debugging helpers. Triggered when starting a project, training team members, preparing for release, or establishing coding standards.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-best-practices` and a `description`
- [ ] Description names optimisation, architecture, debugging, and production deployment
- [ ] Body contains at least two fenced code examples contrasting good vs bad patterns
- [ ] Body has a multi-section performance checklist covering geometry, materials, textures, lighting, shadows, and post-processing
- [ ] Body has a "Common Anti-Patterns" section with `❌` / `✅` markers

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Resource disposal traverses children and handles both array and single `material` properties
- [ ] Geometry sharing (one `BoxGeometry` instance for multiple meshes) is shown as a good pattern
- [ ] Fixed timestep for physics uses `accumulator += deltaTime` with a `while (accumulator >= fixedDeltaTime)` loop
- [ ] `InstancedMesh` (1 draw call) is contrasted with 1000 individual meshes (1000 draw calls)
- [ ] `renderer.info.render.calls` and `renderer.info.render.triangles` are shown for debug monitoring
- [ ] Object-pool pattern via `BulletPool.acquire()` / `release()` is provided as an anti-pattern fix
- [ ] `texture.anisotropy = renderer.capabilities.getMaxAnisotropy()` is shown
- [ ] `renderer.shadowMap.autoUpdate = false` is recommended for production to allow manual control

## Version Awareness
- [ ] Aligns with pinned three 0.184; `THREE.Geometry` (legacy) is correctly absent — only `BufferGeometry` is used; verify `BufferGeometryUtils.mergeBufferGeometries` renamed to `mergeGeometries` in the installed version

## Known Gaps / Notes
- The "production deployment" section imports `three/build/three.module.js` directly — modern bundlers (Vite, webpack) tree-shake from `three` automatically; this note is outdated.
- No web-worker or off-thread loading strategy is shown despite being listed as a performance technique in the model-loading skill.
