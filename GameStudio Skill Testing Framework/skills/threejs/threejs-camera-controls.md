# Skill Test Spec: /threejs-camera-controls

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides four camera-control archetypes for Three.js: an `OrbitCameraController` using spherical coordinates with damping, pan, and zoom constraints; a `FirstPersonCamera` with pointer-lock mouse look and WASD/arrow-key movement; a `ThirdPersonCamera` that lerps to an offset behind a target object; and a `CinematicCamera` that interpolates along `CatmullRomCurve3` keyframe paths. Triggered when implementing camera movement, orbit/pan/zoom, first-person or third-person views, or cinematic cut-scenes.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-camera-controls` and a `description`
- [ ] Description names orbit, first-person, third-person, and cinematic as trigger topics
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has a checklist with smoothing and constraint items
- [ ] Body mentions gimbal lock as a pitfall

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `OrbitCameraController` converts mouse delta to `sphericalDelta.theta` and `.phi`
- [ ] Polar angle is clamped with `Math.max(minPolarAngle, Math.min(maxPolarAngle, phi))`
- [ ] Damping is applied by multiplying `sphericalDelta` by `(1 - dampingFactor)` each frame
- [ ] `FirstPersonCamera` uses `document.pointerLockElement` to gate mouse-move handling
- [ ] Pitch is clamped to `[-Math.PI/2, Math.PI/2]` to prevent camera flip
- [ ] Camera rotation order `'YXZ'` is set to avoid gimbal lock in `FirstPersonCamera`
- [ ] `ThirdPersonCamera` uses `currentPosition.lerp(idealPosition, smoothness)` for smooth follow
- [ ] `CinematicCamera` builds `CatmullRomCurve3` from keyframe positions and uses `curve.getPoint(t)`
- [ ] All controllers dispose event listeners in a `dispose()` method

## Version Awareness
- [ ] Aligns with pinned three 0.184 (`THREE.Spherical`, `THREE.CatmullRomCurve3` APIs unchanged); note that production projects typically use `OrbitControls` from `three/addons/` — this skill teaches the underlying math

## Known Gaps / Notes
- No collision-avoidance (camera clipping through walls) is handled; real third-person cameras need raycasting behind the target.
- `CinematicCamera.addKeyframe` rebuilds curves on every call — could be expensive at scale.
