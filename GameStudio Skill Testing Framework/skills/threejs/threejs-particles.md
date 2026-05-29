# Skill Test Spec: /threejs-particles

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Covers Two particle-system patterns: a CPU-driven `ParticleSystem` using `THREE.Points` with pooled `Particle` objects and `BufferAttribute` position/colour/size arrays; a `ParticleEmitter` with configurable rate, spread, velocity, and burst emission; a GPU-driven `GPUParticleSystem` where the vertex shader computes physics from stored velocity/age attributes; and `ParticlePresets` defining fire, smoke, rain, snow, explosion, and sparkle configurations. Triggered when creating fire, smoke, rain, explosion VFX, or large particle counts.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-particles` and a `description`
- [ ] Description names GPU particles, instanced particles, and effects as trigger topics
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has a checklist with pooling and mobile count limits
- [ ] Body has a "Performance Tips" section with device-tier particle count recommendations

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `THREE.Points` is used (not individual `Mesh` instances) for the particle object
- [ ] Inactive particles are moved to a far-away position (`1000000`) rather than removed
- [ ] `geometry.attributes.position.needsUpdate = true` and `.color.needsUpdate = true` are set each frame
- [ ] `geometry.setDrawRange(0, activeCount)` restricts GPU processing to active particles
- [ ] `THREE.AdditiveBlending` and `depthWrite: false` are set on the particle material
- [ ] `ParticleEmitter` accumulates `emitTimer` and emits based on `1 / rate` interval
- [ ] `ParticleEmitter.burst(count)` emits multiple particles in one call without using the timer
- [ ] GPU particle shader computes position as `position + velocity * age + 0.5 * gravity * age * age`
- [ ] Mobile particle limit is explicitly stated as 100–500

## Version Awareness
- [ ] Aligns with pinned three 0.184 (`THREE.Points`, `THREE.PointsMaterial` unchanged); verify `PointsMaterial.sizeAttenuation` still behaves as expected in WebGL2 context

## Known Gaps / Notes
- CPU-side age reset in `GPUParticleSystem.update()` means the GPU shader receives inconsistent age values; a pure GPU solution should ping-pong buffers or use a compute shader (WebGPU).
- `ParticleSystem` sets `material.opacity` inside the per-particle loop which overwrites all particles with the last particle's opacity.
