# Skill Test Spec: /physics-system

> **Category**: game-systems · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides two physics integration paths: a lightweight `SimplePhysicsSystem` that implements semi-implicit Euler integration with per-body gravity, damping, axis locks, sleep detection, and a fixed-timestep accumulator; and a `CannonPhysicsSystem` that wraps Cannon.js (`cannon-es`) with lazy body creation, shape mapping (box, sphere, cylinder), SAPBroadphase, body sleep, and bidirectional Transform/velocity synchronization. `RigidBody` component holds mass, velocity, angular velocity, forces, material properties (restitution, friction, damping), axis constraints, and sleep state. `Collider` component maps to `BodyType` × `ColliderShape` combinations. `CharacterController` adds grounded-check and jump force. `VehiclePhysicsSystem` demonstrates simplified arcade vehicle steering with Ackermann turn rate and motor/brake forces. `Vehicle` component stores axle, steering, and wheel position data.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: physics-system` and a `description`
- [ ] Description names trigger keywords (rigid body dynamics, forces, constraints, Cannon.js, Rapier)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Five named implementation sections are present (Basic Physics Components, Simple Physics System, Cannon.js Physics Integration, Character Controller, Vehicle Physics)
- [ ] A `## Checklist` section is present with fixed timestep, collision layers, and sleep items
- [ ] A `## Common Pitfalls` section warns against variable timestep and large forces causing tunnelling

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `BodyType` enum defines `Static`, `Dynamic`, and `Kinematic`
- [ ] `RigidBody.applyForce` adds to `this.force` and optionally computes torque via `point × force` cross product
- [ ] `RigidBody.applyImpulse` adds `impulse / mass` directly to velocity (bypasses force accumulation)
- [ ] `SimplePhysicsSystem.update` uses an accumulator loop to run `fixedUpdate` at a constant `fixedDeltaTime`
- [ ] `SimplePhysicsSystem.fixedUpdate` skips `Static` and sleeping bodies, applies gravity force, integrates velocity with `F/m * dt`, integrates position, then clears forces
- [ ] `RigidBody.shouldSleep()` checks `velocity.length() + angularVelocity.length() < sleepThreshold`
- [ ] `CannonPhysicsSystem` sets `world.broadphase = new CANNON.SAPBroadphase(world)` and `world.allowSleep = true`
- [ ] `CannonPhysicsSystem.syncToTransforms` copies `body.position` and `body.quaternion` back to the ECS `Transform` each frame
- [ ] `CharacterController` has `groundCheckDistance` and `isGrounded` fields; jump applies velocity only when grounded
- [ ] `VehiclePhysicsSystem` computes turn rate as `(steerAngle / wheelBase) * speed` for simplified Ackermann steering

## Version Awareness
- [ ] `CannonPhysicsSystem` imports from `cannon-es` — verify the installed `cannon-es` version exposes `SAPBroadphase`, `Body.STATIC/DYNAMIC/KINEMATIC`, and `Body.SLEEPING` constants. Rapier is listed as a reference only; no Rapier code is provided in this skill.

## Known Gaps / Notes
- `CharacterController.checkGrounded` uses `transform.position.y <= 0.1` as a ground check placeholder; a proper implementation requires a downward raycast against the physics world.
- Collision response (impulse resolution, friction) is handled by Cannon.js in the engine integration path; the `SimplePhysicsSystem` does not implement collision response — it requires the `collision-system` skill for detection and leaves response to the caller.
