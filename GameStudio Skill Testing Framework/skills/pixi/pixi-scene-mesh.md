# Skill Test Spec: /pixi-scene-mesh

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-scene-mesh` skill teaches custom geometry rendering in PixiJS v8 using the `Mesh` family. It covers the base `Mesh` class with `MeshGeometry` (positions, uvs, indices, topology), the four specialized subclasses (`MeshSimple` for animated vertices, `MeshPlane` for subdivided deformation, `MeshRope` for path-following textures, `PerspectiveMesh` for 2.5D perspective), batching conditions, topology placement on geometry, `Mesh.containsPoint`, `shrinkBuffersToFit`, and the v8 API renames from `SimpleMesh`/`SimplePlane`/`SimpleRope`. Subclass details are deferred to sub-reference files. Triggers on: Mesh, MeshGeometry, MeshSimple, MeshPlane, MeshRope, PerspectiveMesh, positions, uvs, indices, topology.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-scene-mesh` and a `description`
- [ ] Description names concrete trigger keywords (Mesh, MeshGeometry, MeshSimple, MeshPlane, MeshRope, PerspectiveMesh, positions, uvs, indices, topology)
- [ ] Body contains at least one fenced code example showing `new MeshGeometry({ positions, uvs, indices, topology })` and `new Mesh({ geometry, texture })`
- [ ] Contains a variant comparison table with use cases and trade-offs for each mesh subclass
- [ ] Contains a "Common Mistakes" section with [HIGH] severity for old `SimpleRope`/`SimpleMesh` names
- [ ] Contains an "API Reference" section linking to all five mesh classes and `MeshGeometry`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Covers `MeshGeometry` options: `positions` (Float32Array), `uvs` (Float32Array), `indices` (Uint32Array), `topology` ('triangle-list' default)
- [ ] Covers that `positions` is the v8 property name (not `vertices` — `vertices` is only used by `MeshSimple`)
- [ ] Documents batching conditions: no custom shader, no depth/culling state, `batchMode = 'auto'`, ≤100 vertices
- [ ] Covers `topology` as a geometry property (not mesh property); shows `'triangle-list'`, `'triangle-strip'` options
- [ ] Covers `new MeshGeometry({ shrinkBuffersToFit: true })` for one-shot large geometries
- [ ] Covers `Mesh.containsPoint(point)` for topology-aware hit testing
- [ ] Documents when NOT to use mesh: "textured quad" → use `Sprite`; "true 3D" → use a 3D library
- [ ] Covers `new Mesh({ geometry, state })` with `State.for2d()` default

## Version Awareness
- [ ] Aligns with PixiJS v8; flags that `SimpleMesh`→`MeshSimple`, `SimplePlane`→`MeshPlane`, `SimpleRope`→`MeshRope` were renamed and all switched to options-object constructors; `MeshGeometry` positional constructor was also removed

## Known Gaps / Notes
The skill defers all variant-specific options to sub-reference files (`references/mesh.md`, `references/mesh-simple.md`, `references/mesh-plane.md`, `references/mesh-rope.md`, `references/mesh-perspective.md`). Testers should verify these reference files exist. `PerspectiveMesh.setCorners()` is a key API not mentioned in the main SKILL.md — testers should verify it is in `references/mesh-perspective.md`.
