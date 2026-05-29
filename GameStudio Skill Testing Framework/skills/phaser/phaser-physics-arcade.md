# Skill Test Spec: /phaser-physics-arcade

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers Phaser 4's Arcade Physics system, including game config setup, the `World` (gravity, bounds, RTree, fixed-step, timeScale, debug), dynamic `Body` properties (velocity, acceleration, drag, bounce, friction, mass, immovable, pushable, collideWorldBounds, angular, enable/disable), `StaticBody`, the factory (`this.physics.add`) for sprites/images/groups/bodies, persistent Colliders vs one-shot checks, `collide()` vs `overlap()`, collision categories with bitmasks, world bounds events, the full `ArcadeWorldConfig` reference, and utility methods like `moveTo`, `accelerateTo`, `velocityFromAngle`, `overlapRect`, and `overlapCirc`. It triggers on any physics, velocity, gravity, collision, or physics body question.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-physics-arcade` and a `description`
- [ ] Description names trigger keywords: `physics`, `arcade`, `velocity`, `gravity`, `collide`, `overlap`, `bounce`, `physics body`
- [ ] Body contains a Quick Start with game config `physics.arcade` and at least one collider
- [ ] `ArcadeWorldConfig` property table is present
- [ ] Body/StaticBody method quick reference tables are present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents persistent collider (`this.physics.add.collider()`, checked every frame automatically) vs one-shot check (`this.physics.collide()` in update); recommends persistent Colliders
- [ ] Documents that `collide()` performs separation while `overlap()` only detects without moving bodies; overlap for triggers/pickups
- [ ] Documents `processCallback` for conditional collision: must return boolean to allow; useful for invincibility frames
- [ ] Documents static body synchronization: after changing GO position/scale, must call `body.reset()` or `gameObject.refreshBody()`; static bodies do not auto-sync
- [ ] Documents `useDamping: true` mode: drag values are multiplier (0-1) not linear; `0.05` keeps 5% velocity per second
- [ ] Documents collision categories: `this.physics.nextCategory()` returns next bitmask value; max 32 categories; `resetCollisionCategory()` to set mask to all bits
- [ ] Documents default category behavior: all bodies have category `0x0001` mask `1`; PhysicsGroup defaults mask to `2147483647` (all bits)
- [ ] Documents world bounds event opt-in: `body.onWorldBounds = true` required before `'worldbounds'` world event fires; same for `onCollide`/`onOverlap`
- [ ] Documents `immovable` vs `pushable`: `immovable=true` means never moved; `pushable=false` reflects velocity to collider but body can still be separated
- [ ] Documents `customUpdate: true` stops auto world update; requires manual `this.physics.world.update(time, delta)` call

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] Collision categories API (`nextCategory`, `setCollisionCategory`, `setCollidesWith`, `addCollidesWith`, `removeCollidesWith`, `willCollideWith`) — verify these are available in v4

## Known Gaps / Notes
`useTree: false` recommendation for 5000+ dynamic bodies (RTree becomes expensive to rebuild) is documented. The `fixedStep: false` option for syncing physics to render FPS is documented. `body.slideFactor.set(0, 0)` for Sokoban-style stop-after-push is documented. `overlapRect` and `overlapCirc` spatial queries are in the quick reference.
