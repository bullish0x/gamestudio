# Skill Test Spec: /pixi-custom-rendering

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-custom-rendering` skill teaches writing custom shaders, uniforms, and batchers in PixiJS v8. It covers `Shader.from({ gl, gpu, resources })`, `GlProgram`/`GpuProgram` for WebGL/WebGPU programs, `UniformGroup` with typed `{ value, type }` uniform pairs (f32, vec2, mat4x4, etc.), UBO mode with `{ ubo: true, isStatic: true }`, textures as top-level resources (`texture.source`, `texture.style`), dual-renderer shaders targeting both backends, `Filter.from({ gl, resources })` for custom filters, GLSL ES 3.0 conventions (`in/out`, `finalColor`, `texture()`), `blendRequired` + `uBackTexture` for render-target sampling, `pixi.js/unsafe-eval` for CSP compliance, and custom `Batcher` via `ExtensionType.Batcher`. Triggers on: Shader, GlProgram, GpuProgram, UniformGroup, custom shader, Filter.from, GLSL, WGSL, UBO, finalColor, uBackTexture.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-custom-rendering` and a `description`
- [ ] Description names concrete trigger keywords (Shader, GlProgram, GpuProgram, UniformGroup, Filter.from, GLSL, WGSL, UBO)
- [ ] Body contains at least one fenced code example showing `Shader.from({ gl: { vertex, fragment }, resources })` with a `UniformGroup`
- [ ] Contains a "Common Mistakes" section with [CRITICAL] severity for old `Shader.from(vertex, fragment, uniforms)` API
- [ ] References `references/uniform-types.md` for the complete type table
- [ ] Contains an "API Reference" section linking to `Shader`, `GlProgram`, `GpuProgram`, `UniformGroup`, `Filter`, `Batcher`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Covers `Shader.from({ gl, gpu, resources })` options object and explains `gl`-only = WebGL only, `gpu`-only = WebGPU only
- [ ] Covers typed `UniformGroup` with `{ value, type }` pairs and shows examples for `f32`, `vec4<f32>`, `mat4x4<f32>`
- [ ] Covers textures as top-level resources: `uTexture: texture.source` and `uSampler: texture.source.style`
- [ ] Covers UBO mode: `new UniformGroup({...}, { ubo: true, isStatic: true })` and the requirement to call `ubo.update()` after changes
- [ ] Explains GLSL ES 3.0 conventions: `in/out` instead of `attribute/varying`, `out vec4 finalColor` instead of `gl_FragColor`, `texture()` instead of `texture2D()`
- [ ] Covers `Filter.from({ gl: { fragment }, resources })` shorthand for custom filters with PixiJS-supplied vertex shader
- [ ] Covers `blendRequired: true` + `uBackTexture` for sampling the render target behind the filter
- [ ] Covers `pixi.js/unsafe-eval` requirement for CSP environments (UBO sync uses `new Function` internally)
- [ ] Covers custom `Batcher` skeleton with `ExtensionType.Batcher`, `packAttributes`, and `packQuadAttributes`

## Version Awareness
- [ ] Aligns with PixiJS v8 shader API; flags that positional `Shader.from(vertex, fragment, uniforms)` was removed and uniform values without `type` cause a runtime error

## Known Gaps / Notes
The skill references `references/uniform-types.md` for the complete type table. A tester should verify that file exists. The skill does not cover `RenderPipe` — that is implied under "custom renderables" but the `Batcher` is the only full implementation shown. WGSL patterns for WebGPU are documented but less detailed than the GLSL examples.
