# Skill Test Spec: /threejs-math-utilities

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
A comprehensive math utility library for Three.js game development: `VectorUtils` covering 2D distance (ignoring Y), direction, angle, projection, reflection, random-in-sphere/circle, clamping, and axis rotation; `InterpolationUtils` with easing functions (quad, cubic, elastic, smoothstep, smootherstep), spring physics for scalars and vectors; `QuaternionUtils` for look-rotation, from-to rotation, rotate-towards, forward/right/up extraction, and Euler conversion; `CurveUtils` wrapping Catmull-Rom / Bezier / arc curves; and `CollisionUtils` for sphere-sphere, point-AABB, AABB-AABB, sphere-AABB, ray-sphere, and ray-plane tests. Triggered when implementing game mechanics, movement, pathfinding, or collision detection.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-math-utilities` and a `description`
- [ ] Description names vector operations, quaternions, interpolation, and collision helpers
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has a checklist recommending squared distances for comparisons
- [ ] Body has a "Performance Tips" section about caching and reusing vector objects

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `distanceSquared2D` avoids `Math.sqrt` for performance-sensitive distance comparisons
- [ ] `InterpolationUtils.spring()` accepts a mutable `velocity: { value: number }` ref object
- [ ] `InterpolationUtils.smootherStep` uses the Ken Perlin formula `x³(x(x*6−15)+10)`
- [ ] `QuaternionUtils.lookRotation` builds a `Matrix4.lookAt` then extracts the quaternion
- [ ] `QuaternionUtils.rotateTowards` clamps the slerp `t` to `maxRadians / angle`
- [ ] `CollisionUtils.sphereIntersectsAABB` uses `THREE.MathUtils.clamp` to find the closest AABB point
- [ ] `CollisionUtils.rayIntersectsSphere` returns `{ hit, distance, point }` using the discriminant formula
- [ ] `CurveUtils.closestPointOnCurve` iterates `divisions + 1` sample points to find minimum squared distance

## Version Awareness
- [ ] Aligns with pinned three 0.184 (`THREE.MathUtils.clamp`, `THREE.CatmullRomCurve3`, `THREE.Quaternion.slerp` all stable); no API changes expected

## Known Gaps / Notes
- `springVector` creates new `Vector3` allocations inside the update loop — should use pre-allocated scratch vectors in performance-critical code.
- No 2D (Vector2) spring or collision helpers are provided; game-logic on the XZ plane requires adapting these utilities.
