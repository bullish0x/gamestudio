# Skill Test Spec: /phaser-particles

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers Phaser 4's particle system where `this.add.particles()` returns a `ParticleEmitter` game object directly (no separate manager). Topics include the complete `EmitterOp` value formats (static, random-array, random-range, stepped, start/end lifetime interpolation, callbacks), flow vs explode modes, gravity wells, emission zones (RandomZone, EdgeZone), death zones, particle properties, particle animations, particle bounds/bounce, following game objects, `forEachAlive`, duration/stopAfter/advance, custom `ParticleProcessor` and custom `Particle` classes, and all emitter events. It triggers when creating particle effects, explosions, fire, smoke, or any emitter-based effect.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-particles` and a `description`
- [ ] Description names trigger keywords: `particles`, `emitter`, `particle effect`, `explosion`, `fire`, `smoke`
- [ ] Body contains a Quick Start showing both flow mode and `explode()` burst mode
- [ ] EmitterOp value format table or code block showing all formats (static, array, range, stepped, start/end, callbacks) is present
- [ ] Events table covering `START`, `STOP`, `COMPLETE`, `EXPLODE`, and `DEATH_ZONE` is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents that `ParticleEmitterManager` was removed (v3.60+ change); `this.add.particles()` returns a `ParticleEmitter` directly
- [ ] Explains `speed` vs `speedX`/`speedY`: `speed` sets `speedX` and deactivates `speedY` (radial mode); `speedX`/`speedY` switches to point mode (`radial: false`)
- [ ] Explains `scale` vs `scaleX`/`scaleY` mutex: `scale` applies to `scaleX` and deactivates `scaleY`; use both for non-uniform scaling
- [ ] Documents `color` property overrides `tint`: they are mutually exclusive; `color` (array for interpolation) takes priority
- [ ] Documents `moveToX`/`moveToY` requirement: BOTH must be set to activate; overrides `angle` and `speed`
- [ ] Documents RandomZone source requirement: needs `getRandomPoint(point)` method; EdgeZone source needs `getPoints(quantity, stepRate)`; DeathZone source needs `contains(x, y)`
- [ ] Documents `frequency: 0` means emit every frame (max rate), NOT never; use `emitting: false` to stop emission
- [ ] Documents `stop` event fires when emission stops; `complete` event fires when last alive particle dies after emission stops
- [ ] Documents `advance` config for pre-warming: simulates `advance` ms on creation so particles appear on first frame
- [ ] Documents `reserve(count)` / `reserve` config for pre-allocating particle objects to avoid GC spikes during gameplay

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `ParticleEmitter` as direct game object (not requiring manager) is a v3.60+ architecture change carried into v4

## Known Gaps / Notes
The `sortProperty` and `sortCallback` APIs for depth-ordering particles are documented. The `particleClass` config for custom particle subclasses is documented with a full example. The `hold` property behavior (freezes particle after lifespan before dying) is explained. Multiple emission zones via array or `addEmitZone()` with `total` rotation control is documented.
