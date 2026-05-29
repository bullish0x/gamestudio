# Skill Test Spec: /threejs-post-processing

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Covers setting up Three.js post-processing pipelines: a `PostProcessingManager` wrapping `EffectComposer` with `RenderPass` always first, configurable passes for `UnrealBloomPass`, `SSAOPass`, FXAA, gamma correction, and tone mapping; custom `ShaderPass` definitions (vignette, film grain, colour grading); a `DOFPass` extending `Pass` with depth-packing and a box-blur composite; and quality presets mapping named tiers to pass configurations. Triggered when adding visual effects, implementing DOF, SSAO, bloom, or building custom screen-space passes.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-post-processing` and a `description`
- [ ] Description names bloom, SSAO, DOF, tone mapping as trigger topics
- [ ] Body contains at least one fenced TypeScript code example with shader strings
- [ ] Body has a checklist that includes `EffectComposer` setup and resize handling
- [ ] Body lists effects by cost from cheapest to most expensive

## Content Coverage Assertions (`/skill-test spec`)
- [ ] All pass imports use `three/examples/jsm/postprocessing/` paths
- [ ] `RenderPass` is always added first before any effect passes
- [ ] `composer.render(deltaTime)` is used instead of `renderer.render()`
- [ ] FXAA resolution uniform is updated on resize: `1 / (width * pixelRatio)`
- [ ] `ACESFilmicToneMapping` is used on `renderer.toneMapping` for the tone-mapping preset
- [ ] `UnrealBloomPass` receives a `THREE.Vector2` resolution as first argument
- [ ] `PostProcessingPresets` defines at least `mobile_low`, `desktop_medium`, and `cinematic` named objects
- [ ] `DOFPass.render()` sets `scene.overrideMaterial` to the depth material and restores it after
- [ ] Each custom shader object has a `tDiffuse: { value: null }` uniform as the input sampler

## Version Awareness
- [ ] Aligns with pinned three 0.184; note that `GammaCorrectionShader` may be superseded by `renderer.outputColorSpace = THREE.SRGBColorSpace` — flag as potentially redundant when `SRGBColorSpace` is set on the renderer

## Known Gaps / Notes
- `PostProcessingManager.getPass()` returns `any`; typed accessors would be safer in TypeScript projects.
- No `TAA` (temporal anti-aliasing) or `SSR` (screen-space reflections) passes are covered despite being mentioned in the performance-priority list.
