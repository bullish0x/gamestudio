# Skill Test Spec: /pixi-application

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-application` skill teaches the complete lifecycle of a PixiJS v8 `Application`: constructing with no arguments, awaiting `app.init(options)`, accessing `app.stage`, `app.renderer`, `app.canvas`, `app.screen`, and `app.domContainerRoot`, controlling the render loop via `app.start()`/`app.stop()`, using `ResizePlugin` (`resizeTo`, `app.resize()`, `app.queueResize()`), `TickerPlugin` (`app.ticker.add`), the opt-in `CullerPlugin` (`cullable`, `cullArea`), creating custom `ApplicationPlugin`s via `ExtensionType.Application`, and `app.destroy(rendererOptions, stageOptions)` with `releaseGlobalResources`. Triggers on: Application, app.init, app.stage, app.renderer, app.canvas, resizeTo, CullerPlugin.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-application` and a `description`
- [ ] Description names concrete trigger keywords (Application, app.init, app.stage, resizeTo, CullerPlugin)
- [ ] Body contains at least one fenced code example showing `new Application()` + `await app.init({...})` + `document.body.appendChild(app.canvas)`
- [ ] Contains a "Common Mistakes" section with [CRITICAL] severity for passing options to the constructor
- [ ] Contains an "API Reference" section with links to `Application`, `ApplicationOptions`, `ResizePlugin`, `TickerPlugin`, `CullerPlugin`
- [ ] References a `references/application-options.md` file for full option documentation

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Covers the `new Application()` (no-args) + `await app.init(options)` pattern and explains why options passed to the constructor are ignored
- [ ] Covers `app.canvas` (v8 name) vs deprecated `app.view`
- [ ] Covers `app.destroy({ removeView: true, releaseGlobalResources: true }, { children: true, texture: true, textureSource: true })`
- [ ] Covers `ResizePlugin` with `resizeTo`, `app.resize()`, `app.queueResize()`, `app.cancelResize()`
- [ ] Covers `app.ticker.add((ticker) => { ... ticker.deltaTime ... })` with the v8 callback signature (Ticker instance, not delta number)
- [ ] Covers `autoStart: false` + manual `app.render()` loop pattern
- [ ] Covers `CullerPlugin` registration via `extensions.add(CullerPlugin)` and `container.cullable = true`
- [ ] Covers custom `ApplicationPlugin` creation with `static extension = ExtensionType.Application` and `static init/destroy`

## Version Awareness
- [ ] Aligns with PixiJS v8: `await app.init()` is async, `app.canvas` not `app.view`, no `new Application({...})` constructor options; flags that accessing `app.canvas` before `init` resolves returns `undefined`

## Known Gaps / Notes
The skill defers full option documentation to `references/application-options.md`. A tester should verify that file exists and covers per-renderer overrides (`webgl`, `webgpu`, `canvasOptions`). The `app.domContainerRoot` property is mentioned briefly; DOMContainer setup is fully covered in `pixi-scene-dom-container`.
