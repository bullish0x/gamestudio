# Skill Test Spec: /pixi-core-concepts

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-core-concepts` skill teaches the foundational rendering model of PixiJS v8: the three renderer backends (WebGLRenderer, WebGPURenderer, CanvasRenderer), the systems-and-pipes architecture, how `autoDetectRenderer` selects a backend, the `preference` hint, the render loop driven by `app.ticker`, `renderer.render({container})`, the `DOMAdapter` abstraction for non-browser environments, and when to use `RenderPipe` for custom renderables. It serves as the mental model layer before diving into scene graph or application specifics. Triggers on: renderer, WebGL, WebGPU, Canvas, render loop, autoDetectRenderer, systems, environments.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-core-concepts` and a `description`
- [ ] Description names concrete trigger keywords (renderer, WebGL, WebGPU, render loop, autoDetectRenderer)
- [ ] Body contains at least one fenced code example showing `app.renderer.name` and `renderer.render()`
- [ ] Contains a "Decision guide" section routing different questions to appropriate sub-skills
- [ ] Contains a "Topics" table linking to `references/renderers.md` and `references/render-loop.md`
- [ ] Contains a "Common Mistakes" section covering async `init()` and `DOMAdapter` ordering

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Explains that each renderer is composed of `Systems` (lifecycle services) and `RenderPipes` (per-renderable instruction builders)
- [ ] Covers `app.renderer.name` returning `'webgl' | 'webgpu' | 'canvas'` and that `preference` is a hint not a guarantee
- [ ] Covers `app.renderer.extract.texture({ target: app.stage })` as an example renderer capability
- [ ] Covers `renderer.render({ container: app.stage })` as the manual render call
- [ ] Explains that `DOMAdapter` must be set before `Application.init()` for Web Worker / SSR environments
- [ ] Covers the render loop priority: `UPDATE_PRIORITY.HIGH` callbacks run before `app.render()` at `LOW`
- [ ] Routes custom renderables to `pixi-custom-rendering` (implementing a `RenderPipe`)
- [ ] References `references/renderers.md` for backend selection and `references/render-loop.md` for timing

## Version Awareness
- [ ] Aligns with PixiJS v8 renderer model; no references to v7 `Renderer` class or `@pixi/core` package imports

## Known Gaps / Notes
This skill is intentionally shallow — it is the mental model layer. Deep renderer details live in `references/renderers.md` and `references/render-loop.md`. Testers should confirm those reference files exist. The skill does not explain `WebGLRenderer` vs `WebGPURenderer` API differences in depth; that is deferred to sub-references.
