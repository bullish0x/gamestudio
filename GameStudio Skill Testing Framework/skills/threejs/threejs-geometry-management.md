# Skill Test Spec: /threejs-geometry-management

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Covers all aspects of Three.js geometry work: creating and caching `BufferGeometry` objects, building custom geometry from typed arrays with optional indexed buffers, procedural geometry (planes, terrain height-maps, extrusion), `InstancedMesh` with per-instance matrix and colour, geometry modification helpers (merge, transform, center, scale-to-fit), LOD via `THREE.LOD`, and an object-pool pattern for dynamic geometry. Triggered when creating or modifying 3D geometry, optimising for mobile, or managing geometry memory.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-geometry-management` and a `description`
- [ ] Description names BufferGeometry, instancing, and mobile performance as trigger topics
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body contains a performance-tips section that mentions concrete thresholds (e.g. 10K vertices, 50+ instances)
- [ ] Body contains a checklist covering disposal

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `BufferGeometry.setAttribute` is used with `THREE.BufferAttribute` (not the legacy `Geometry` class)
- [ ] `geometry.computeVertexNormals()` is called when normals are not supplied explicitly
- [ ] `geometry.computeBoundingSphere()` is called so frustum culling works
- [ ] `InstancedMesh` is created with a count parameter and `instanceMatrix.setUsage(THREE.DynamicDrawUsage)`
- [ ] After every instance update `mesh.instanceMatrix.needsUpdate = true` is set
- [ ] Per-instance colour is handled via `mesh.instanceColor` / `mesh.setColorAt`
- [ ] Geometry pool implements `acquire()` / `release()` methods backed by a pre-allocated array
- [ ] `BufferGeometryUtils.mergeGeometries` is mentioned for reducing draw calls
- [ ] `Uint16Array` is recommended for index buffers when vertex count < 65536
- [ ] `THREE.LOD` / `lod.addLevel()` pattern is demonstrated

## Version Awareness
- [ ] Aligns with pinned three 0.184 (`BufferGeometryUtils` moved to `three/examples/jsm/utils/BufferGeometryUtils`; verify import path against installed version)

## Known Gaps / Notes
- The `simplify` method is a stub referencing `SimplifyModifier` from `three/examples`; spec tests should flag it as incomplete.
- No WASM-based simplification (e.g., meshopt) is discussed; relevant for production mobile targets.
