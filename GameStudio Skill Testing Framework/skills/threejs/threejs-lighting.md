# Skill Test Spec: /threejs-lighting

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Comprehensive lighting reference covering all major Three.js light types: a `LightManager` that adds/removes Ambient, Directional, Point, Spot, and Hemisphere lights by ID; a `DayNightCycle` that interpolates sun colour, sky/ground colours, and intensities through four time-of-day keyframes; a `LightProbeSystem` using `PMREMGenerator`; and a `DynamicLightPool` that pre-creates point lights and reuses them by ID. Triggered when setting up scene lighting, creating day/night cycles, implementing dynamic lights, or optimising light count for mobile.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-lighting` and a `description`
- [ ] Description names ambient, directional, point, spot, hemisphere lights as trigger topics
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has a checklist with a mobile light-count limit item
- [ ] Body has a "Performance Tips" section recommending baking static lights

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `addDirectionalLight` sets shadow `mapSize.width/height`, `camera.near/far`, and `camera.left/right/top/bottom` when `castShadow` is true
- [ ] `addPointLight` and `addSpotLight` accept `distance` and `decay` parameters
- [ ] `addHemisphereLight` accepts `skyColor` and `groundColor` arguments
- [ ] `DayNightCycle` interpolates colours using `THREE.Color.lerpColors` and intensities using `THREE.MathUtils.lerp`
- [ ] Time-of-day keyframes cover midnight (hour 0), dawn (6), noon (12), dusk (18), and midnight wrap (24)
- [ ] `DynamicLightPool` pre-creates lights with `visible = false` and intensity 0 as sentinels
- [ ] Mobile limit of fewer than 8 active lights total is explicitly stated
- [ ] `light.dispose()` is called when removing a light

## Version Awareness
- [ ] Aligns with pinned three 0.184; `THREE.LightProbeGenerator` import path (`three/examples/jsm/lights/`) should be verified — it may have moved or been promoted to core

## Known Gaps / Notes
- `LightProbeSystem.fromCubeRenderTarget` references `PMREMGenerator` incorrectly (passes `cubeRenderTarget.texture.source.data` as a renderer); spec tests should flag this as a logic error.
- No `RectAreaLight` is covered despite being a common photorealistic choice.
