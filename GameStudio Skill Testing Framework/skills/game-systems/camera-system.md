# Skill Test Spec: /camera-system

> **Category**: game-systems · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a multi-mode camera system built on ECS components. `CameraController` stores per-mode settings (follow distance/damping, orbit angles/clamping/zoom range, first-person height/sensitivity) plus shake state (intensity, duration, remaining time) and a collision enabled flag. `CameraSystem` dispatches to five mode handlers (Follow, Orbit, FirstPerson, Fixed, Cinematic), applies exponential damping via `1 - Math.exp(-damping * deltaTime)` for frame-rate independence, handles camera shake by adding random offsets, and finds the highest-priority `CameraTarget` entity each frame. `CinematicCamera` interpolates position, lookAt point, and FOV between sorted keyframes using linear `t = (currentTime - prev.time) / (next.time - prev.time)` and supports loop mode.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: camera-system` and a `description`
- [ ] Description names trigger keywords (follow camera, orbit controls, shake effects, cinematic cameras)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Three named implementation sections are present (Camera Components, Camera System, Cinematic Camera System)
- [ ] A `## Checklist` section is present with damping, collision, and transition items
- [ ] A `## Common Pitfalls` section warns against frame-rate-dependent speed and missing FOV projection matrix updates

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `CameraMode` enum defines `Follow`, `Orbit`, `FirstPerson`, `Fixed`, and `Cinematic`
- [ ] `CameraController` has `orbitMinAngleX`, `orbitMaxAngleX`, `orbitMinDistance`, and `orbitMaxDistance` clamp fields
- [ ] `updateFollowCamera` uses `new Vector3().lerpVectors(current, desired, 1 - Math.exp(-damping * dt))` for smooth tracking
- [ ] `updateOrbitCamera` computes position using spherical coordinates from `orbitAngleX` (pitch) and `orbitAngleY` (yaw)
- [ ] `updateFirstPersonCamera` copies target position then adds a `Vector3(0, firstPersonHeight, 0)` offset
- [ ] Camera shake applies a random `Vector3` scaled by `shakeIntensity` and decrements `shakeTime` each frame
- [ ] `updateTarget` iterates `CameraTarget` components and selects the entity with the highest `priority`
- [ ] `CinematicCamera.update` finds bracketing keyframes using `findIndex` and interpolates `t` linearly
- [ ] Orbit camera mouse example clamps `orbitAngleX` between `orbitMinAngleX` and `orbitMaxAngleX` after each mouse move

## Version Awareness
- [ ] The skill is Three.js-oriented (`THREE.Camera`, `THREE.PerspectiveCamera`) but the ECS component patterns are engine-agnostic. Verify that the installed Three.js version supports `PerspectiveCamera.updateProjectionMatrix()` after FOV changes.

## Known Gaps / Notes
- Camera collision (`handleCameraCollision`) is stubbed with a `TODO` comment — actual raycasting is deferred to the `collision-system` skill.
- `shake()` method references `world` from the outer scope which is not a parameter; this is a latent bug in the source that should be flagged in code review.
