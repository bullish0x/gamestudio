# Skill Test Spec: /pixi-performance

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-performance` skill teaches profiling and optimizing PixiJS v8 applications for FPS, draw calls, and GPU memory. It covers proper destroy patterns (`releaseGlobalResources`, `cacheAsTexture(false)` before destroy), texture garbage collection via `GCSystem` (`gcMaxUnusedTime`, `gcFrequency`, `texture.source.unload()`), `PrepareSystem` for GPU pre-upload, `cacheAsTexture(true)` for static complex content, object pooling patterns (reuse vs destroy/recreate), batching optimization (group same type/blend-mode), spritesheets for atlas batching, `BitmapText` for per-frame text updates, Graphics stability guidelines, `CullerPlugin` and `Culler.shared.cull()`, resolution/antialias tradeoffs, and staggered bulk texture destruction. Triggers on: FPS, draw calls, batching, object pool, GCSystem, PrepareSystem, Culler, cacheAsTexture, memory leak, destroy patterns.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-performance` and a `description`
- [ ] Description names concrete trigger keywords (FPS, draw calls, batching, GCSystem, PrepareSystem, Culler, cacheAsTexture, memory leak)
- [ ] Body contains at least one fenced code example showing `app.destroy({ releaseGlobalResources: true })`
- [ ] Contains a batching optimization example showing same-type grouped vs interleaved children
- [ ] Contains a "Common Mistakes" section with [CRITICAL] severity for missing `releaseGlobalResources`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Covers `app.destroy({ releaseGlobalResources: true })` and explains that omitting it causes stale pools to leak into new app instances
- [ ] Covers `GCSystem` options via `app.init`: `gcActive`, `gcMaxUnusedTime`, `gcFrequency` and that deprecated `textureGC.*` properties were replaced in 8.15.0
- [ ] Covers `import 'pixi.js/prepare'` (not included by default) and `app.renderer.prepare.upload(app.stage)` pattern with `app.stop()`/`app.start()`
- [ ] Covers `cacheAsTexture(true)` with `{ resolution, antialias }` options, `updateCacheTexture()`, and the requirement to call `cacheAsTexture(false)` before `destroy()`
- [ ] Covers object pool pattern showing `visible = false` / property reset instead of destroy + recreate
- [ ] Covers batch-break causes: object type change, texture source change, blend mode change, topology change
- [ ] Covers culling: `extensions.add(CullerPlugin)`, `sprite.cullable = true`, `cullArea`, `cullableChildren = false`, and `Culler.shared.cull(stage, screen)` for manual culling
- [ ] Covers `BitmapText` for per-frame dynamic content with explanation that `Text` triggers canvas re-render + GPU upload
- [ ] Covers `renderer.generateTexture(complex)` to convert complex `Graphics` to a texture for `Sprite`

## Version Awareness
- [ ] Aligns with PixiJS v8; flags that `textureGC.*` Application init properties are deprecated since 8.15.0 and `gcMaxUnusedTime`/`gcFrequency` are the current API

## Known Gaps / Notes
The skill does not cover `RenderGroup` (`isRenderGroup: true`) as a performance technique — this is documented in `pixi-scene-core-concepts`. Testers should note that the skill correctly warns against calling `clear()` and redrawing `Graphics` every frame (opposite of HTML Canvas 2D). The mask cost comparison (scissor < stencil < alpha filter) is in the "Filters and masks cost" section rather than a dedicated masks skill.
