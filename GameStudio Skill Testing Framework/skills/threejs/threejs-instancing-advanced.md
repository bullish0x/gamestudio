# Skill Test Spec: /threejs-instancing-advanced

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Advanced `THREE.InstancedMesh` usage: an `InstancedMeshManager` with per-instance position/rotation/scale/colour and hide-by-displacement; a `InstancePool` for acquire/release lifecycle management (pre-hides freed instances); an `InstancedLOD` that maintains one `InstancedMesh` per LOD level and switches per-instance by camera distance; and an `InstanceFrustumCulling` that computes per-instance `Box3` bounding boxes and hides those outside the frustum. Triggered when rendering 100+ identical objects, reducing draw calls, building forests or crowds, or implementing procedural environments.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-instancing-advanced` and a `description`
- [ ] Description names InstancedMesh, dynamic updates, LOD, frustum culling, custom attributes
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has instance-count recommendations per platform (mobile / desktop / high-end)
- [ ] Body has a checklist noting that `instanceMatrix.needsUpdate = true` is required

## Content Coverage Assertions (`/skill-test spec`)
- [ ] A reusable `THREE.Object3D()` dummy is used to compose matrices via `.compose()` or `.updateMatrix()`
- [ ] Instances are hidden by moving them to `y = -10000` rather than using a visibility flag
- [ ] `mesh.setMatrixAt(index, matrix)` and `mesh.getMatrixAt(index, matrix)` are both demonstrated
- [ ] `instanceColor` / `mesh.setColorAt()` is used for per-instance colour without creating new materials
- [ ] `InstancePool.release()` hides the freed instance and pushes the index back to `availableIndices`
- [ ] `InstancedLOD.update()` re-evaluates LOD level for every instance each frame using `camera.position.distanceTo`
- [ ] `InstanceFrustumCulling` builds `frustum.setFromProjectionMatrix(projScreenMatrix)` each frame
- [ ] A draw-call count of 1 per `InstancedMesh` is explicitly stated

## Version Awareness
- [ ] Aligns with pinned three 0.184 (`THREE.InstancedMesh` stable; `instanceColor` attribute available); `InstancedMesh.instanceMatrix.setUsage(THREE.DynamicDrawUsage)` should be set for frequently updated instances — verify in geometry-management skill consistency

## Known Gaps / Notes
- `InstanceFrustumCulling` stores original matrices but `updateInstanceBounds` needs to be called whenever an instance moves — callers must manage this.
- `InstancedLOD` hides/shows instances by overwriting matrices rather than using a visibility mask — any external position updates will be lost on the next `update()` pass if not re-applied to all LOD levels.
