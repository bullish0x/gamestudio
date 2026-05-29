# Skill Test Spec: /phaser-physics-matter

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers Matter.js physics integration in Phaser 4 via `this.matter` (MatterPhysics scene plugin), `MatterSprite`/`MatterImage` game objects, all Matter component mixins (Velocity, Force, Bounce, Friction, Mass, Gravity, Sensor, Static, Sleep, Collision, SetBody, Transform), constraints (rigid joint, spring, pin, world constraint), composites (stack, chain, mesh, soft body, Newton's Cradle, car), compound bodies, sensor triggers, collision filtering with bitmasks and groups, pointer dragging, tilemap integration, and queries (raycasting, point intersection, rect overlap). It triggers on Matter.js, rigid bodies, constraints, joints, sensors, or complex physics shapes.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-physics-matter` and a `description`
- [ ] Description names trigger keywords: `Matter`, `matter physics`, `constraint`, `joint`, `rigid body`, `sensor`
- [ ] Body contains a Quick Start with `this.matter.add.sprite()` and input handling
- [ ] Matter component mixins table with all components and their key methods is present
- [ ] `MatterWorldConfig` property table is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents that Matter velocity is in units-per-step NOT pixels/sec; uses small values (1-15 for velocity, 0.01-0.1 for forces)
- [ ] Documents that `setBody()`/`setRectangle()`/etc. resets all properties including mass, friction, and collision filters; must re-apply after shape change
- [ ] Documents compound body creation: `this.matter.body.create({ parts: [partA, partB] })` and that constraints must target parent body, not `parts`
- [ ] Documents collision filter system: `category` (power of 2 bitmask, 32 max), `mask` (what to collide with), `group` (positive = always collide, negative = never, zero = use category/mask)
- [ ] Documents `collisionFilter.group` overrides category/mask; same positive group = always collide; same negative group = never collide
- [ ] Documents sensor behavior: sensors detect collisions and fire events but do not physically react; still need matching collision filters to fire events
- [ ] Documents Matter position is center of mass not top-left (unlike Arcade Physics)
- [ ] Documents restitution uses `Math.max(bodyA.restitution, bodyB.restitution)` — the bouncier value wins in a collision
- [ ] Documents tilemap integration requirement: must call `layer.setCollisionByProperty(...)` before `this.matter.world.convertTilemapLayer(layer)`
- [ ] Documents sleep system opt-in: `enableSleeping: true` in config; `setSleepEvents(true, true)` for `sleepstart`/`sleepend` events on individual bodies

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] Matter.js is bundled in `src/physics/matter-js/lib/`; version may differ from standalone Matter.js; verify API compatibility

## Known Gaps / Notes
PhysicsEditor shape data loading via `this.cache.json.get('shapes')` with `shape: shapes.enemy` config is documented. `fromSVG` and `fromJSON` body creation from SVG or JSON config are in the factory reference. The `nextGroup(isNonColliding)` for group-based filtering is documented. `this.matter.step(delta)` for manual stepping when `autoUpdate: false` is covered.
