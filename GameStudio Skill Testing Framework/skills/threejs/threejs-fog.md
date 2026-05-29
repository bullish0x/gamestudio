# Skill Test Spec: /threejs-fog

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Covers Three.js fog and atmospheric effects: a `FogManager` wrapping `THREE.Fog` (linear) and `THREE.FogExp2` (exponential/exponential²) with colour-matched background updates; a `FogPresets` catalogue (clear, morning, foggy, heavy fog, dusk, night, cave, desert, underwater, toxic); an `AnimatedFog` that pulses density and colour over time; a `HeightFog` custom `ShaderPass`; and a `WeatherSystem` that transitions smoothly between five weather states. Triggered when creating depth cues, atmospheric mood, draw-distance management, or weather effects.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-fog` and a `description`
- [ ] Description names linear fog, exponential fog, and atmospheric effects
- [ ] Body contains at least one fenced TypeScript code example with fog construction
- [ ] Body has a "Fog is Cheap!" performance note
- [ ] Body has a checklist that includes matching fog colour to background

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `scene.fog = new THREE.Fog(color, near, far)` is used for linear fog
- [ ] `scene.fog = new THREE.FogExp2(color, density)` is used for exponential fog
- [ ] `scene.background = new THREE.Color(config.color)` is set to match fog colour
- [ ] `FogManager.updateLinearFog()` modifies `fog.near` and `fog.far` directly
- [ ] `FogManager.updateExponentialFog()` modifies `fog.density` directly
- [ ] `AnimatedFog.update()` oscillates density with `Math.sin(time * 0.5)` and colour via `setRGB`
- [ ] `WeatherSystem.update()` interpolates `near/far` or `density` using `THREE.MathUtils.lerp`
- [ ] Weather colour transition uses `THREE.Color.lerp()` between from/to configs
- [ ] `HeightFog` shader defines `tDiffuse` and `tDepth` uniforms and a custom `fragmentShader`

## Version Awareness
- [ ] Aligns with pinned three 0.184 (`THREE.Fog` and `THREE.FogExp2` API unchanged); verify that `scene.fog` property still accepts `null` to disable

## Known Gaps / Notes
- `HeightFog` fragment shader defines `perspectiveDepthToViewZ` and `viewZToOrthographicDepth` inline but these are also available via `THREE.ShaderChunk.packing` — note duplication.
- `WeatherSystem` only interpolates linear or exponential fog, not mixed transitions between types.
