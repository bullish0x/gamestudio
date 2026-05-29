# Skill Test Spec: /pixi-scene-particle-container

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-scene-particle-container` skill teaches `ParticleContainer` for high-throughput rendering of thousands of lightweight sprites in a single draw call in PixiJS v8. It covers the v8 Particle API (completely rewritten from v7): `ParticleContainer` with `addParticle`/`removeParticle`/`addParticleAt`/`removeParticleAt`/`removeParticles`, `Particle` struct with flat numeric fields (`x`, `y`, `scaleX`, `scaleY`, `anchorX`, `anchorY`, `rotation`, `tint`, `alpha`, `texture`), `dynamicProperties` flags (`vertex`, `position`, `rotation`, `uvs`, `color`), `boundsArea` requirement, `particles` bulk init, `Particle.defaultOptions` override, `container.update()` for static property changes, `particleChildren` array for batch ops, the `shader` option for custom particle shaders, and limitations (no filters/masks per particle, same base texture required). Triggers on: ParticleContainer, Particle, addParticle, particleChildren, dynamicProperties, boundsArea, particle effects.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-scene-particle-container` and a `description`
- [ ] Description names concrete trigger keywords (ParticleContainer, Particle, addParticle, particleChildren, dynamicProperties, boundsArea)
- [ ] Body contains at least one fenced code example showing `new ParticleContainer({ texture, boundsArea })` with `new Particle({ texture, x, y })` + `addParticle`
- [ ] Contains a container method migration table comparing `addChild`/`removeChild` to `addParticle`/`removeParticle`
- [ ] Contains a "Common Mistakes" section with [CRITICAL] severity for using `addChild(sprite)` on ParticleContainer
- [ ] Contains an "API Reference" section linking to `ParticleContainer`, `Particle`, `IParticle`, `ParticleProperties`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents all `dynamicProperties` flags: `vertex`, `position`, `rotation`, `uvs`, `color`, and explains that only `position` is dynamic by default
- [ ] Explains that changing a static property requires calling `container.update()` to re-upload to GPU
- [ ] Documents `boundsArea` as effectively required: without it the container returns `(0,0,0,0)` bounds causing culling failures
- [ ] Covers `Particle.defaultOptions` static override for changing defaults globally
- [ ] Covers bulk operations: direct `particleChildren.push(...batch)` + `container.update()` as faster alternative to repeated `addParticle` calls
- [ ] Documents the `shader` option for custom particle shaders with required attribute declarations
- [ ] Lists ParticleContainer limitations: no filters/masks/blend modes per particle; no nested children on particles; all particles must share the same base texture source (atlases work)
- [ ] Explicitly notes this is a complete rework from v7 where `ParticleContainer` accepted `Sprite` children

## Version Awareness
- [ ] Aligns with PixiJS v8 Particle API (stable but new in v8); flags that v7 `ParticleContainer.addChild(sprite)` pattern is entirely replaced by `addParticle(new Particle(texture))`

## Known Gaps / Notes
The `IParticle` interface for custom particle implementations is mentioned but not deeply documented. Testers should verify that using `container.children` (always empty) vs `container.particleChildren` is clearly explained. The note about `texture` in `ParticleContainerOptions` being optional (falls back to first particle's texture) is an important subtlety for flexible initialization.
