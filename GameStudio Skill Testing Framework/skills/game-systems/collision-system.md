# Skill Test Spec: /collision-system

> **Category**: game-systems · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a broadphase/narrowphase ECS collision detection system without a physics engine. `Collider` component holds shape (`box`|`sphere`|`capsule`), size, offset, trigger flag, and bitmask layer/mask fields. `AABB` and `Sphere` classes provide self-contained intersection tests (AABB×AABB, Sphere×Sphere, Sphere×AABB). `SpatialGrid` maintains a 3D hash map keyed by cell coordinates, mapping entity IDs into all overlapping cells and supporting AABB range queries. `CollisionSystem` rebuilds the grid each frame, performs pairwise narrowphase with pair-key deduplication, applies layer/mask filtering, emits `CollisionEvent` objects with contact point and normal, and exposes a `raycast` method implemented with both ray-sphere and ray-AABB intersection algorithms.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: collision-system` and a `description`
- [ ] Description names trigger keywords (spatial partitioning, broadphase/narrowphase, AABB, sphere collision)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Three named implementation sections are present (Collision Components, Spatial Grid, Collision System)
- [ ] A `## Checklist` section is present with spatial partitioning, layer filtering, and trigger vs solid items
- [ ] A `## Performance Tips` section recommends spatial grid, cell size guidance, and collision layers

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `Collider.getBounds` returns an `AABB` for box shape and a `Sphere` for sphere shape
- [ ] `AABB.intersects` checks all three axis pairs using min/max overlap
- [ ] `Sphere.intersectsAABB` clamps the sphere center to the AABB to find the closest point
- [ ] `SpatialGrid.insert` removes the entity from old cells before inserting into new cells (update support)
- [ ] `SpatialGrid.query` iterates all cells overlapping the query AABB and accumulates entity IDs into a `Set`
- [ ] `CollisionSystem.detectCollisions` builds a pair key from sorted entity IDs to avoid duplicate processing
- [ ] Layer filtering applies `colliderA.mask & (1 << colliderB.layer)` bitmask before narrowphase
- [ ] `checkCollision` handles all four shape pair combinations (AABB×AABB, Sphere×Sphere, Sphere×AABB, AABB×Sphere via recursion)
- [ ] `raySphere` uses the discriminant formula `b*b - 4*a*c`; returns `null` when discriminant < 0
- [ ] `rayAABB` uses the slab method with per-axis `tmin`/`tmax` and returns `null` when `tmax < 0` or `tmin > tmax`

## Version Awareness
- [ ] The skill uses `THREE.Vector3` for geometry but the collision math is self-contained. No Three.js version constraints on the core algorithms; verify that `THREE.Vector3.distanceToSquared` and `.subVectors` exist in the installed version.

## Known Gaps / Notes
- The grid is fully rebuilt each frame (`clear()` + re-insert all entities). For large scenes with many static entities, a dirty-flag incremental update would be significantly faster.
- Capsule shape is declared in `ColliderShape` but no `Capsule` class or capsule intersection test is implemented; capsule colliders fall through to a box fallback.
