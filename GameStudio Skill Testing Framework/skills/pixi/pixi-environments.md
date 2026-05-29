# Skill Test Spec: /pixi-environments

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-environments` skill teaches how to run PixiJS v8 outside a standard browser context. It covers the `DOMAdapter` abstraction, swapping in `WebWorkerAdapter` before `app.init()` for Web Worker / OffscreenCanvas usage, implementing a custom `Adapter` interface for Node/SSR/headless environments, the `pixi.js/browser` and `pixi.js/webworker` subpath imports, `loadEnvironmentExtensions`, and the `pixi.js/unsafe-eval` import for CSP-restricted contexts. It also lists features unavailable in Web Workers (DOMContainer, AccessibilitySystem, FontFace loading). Triggers on: DOMAdapter, WebWorkerAdapter, Web Worker, OffscreenCanvas, Node, SSR, CSP, unsafe-eval, Adapter.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-environments` and a `description`
- [ ] Description names concrete trigger keywords (DOMAdapter, WebWorkerAdapter, Web Worker, OffscreenCanvas, CSP, unsafe-eval)
- [ ] Body contains at least one fenced code example showing `DOMAdapter.set(WebWorkerAdapter)` before `app.init()`
- [ ] Contains a "Common Mistakes" section with [CRITICAL] severity for setting adapter after `app.init()`
- [ ] Contains an "API Reference" section linking to `DOMAdapter`, `BrowserAdapter`, `WebWorkerAdapter`, `loadEnvironmentExtensions`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Covers the complete main-thread + worker OffscreenCanvas transfer pattern (canvas creation, `transferControlToOffscreen`, `postMessage` with transfer)
- [ ] Lists features that do NOT work inside Web Workers: `DOMContainer`, `AccessibilitySystem`, `FontFace` loading via Font Loading API
- [ ] Covers `import 'pixi.js/webworker'` vs `import 'pixi.js/browser'` subpath imports and their contents
- [ ] Covers `loadEnvironmentExtensions(skip)` as replacement for deprecated `autoDetectEnvironment`
- [ ] Covers the full `Adapter` interface with all 9 required methods: `createCanvas`, `createImage`, `getCanvasRenderingContext2D`, `getWebGLRenderingContext`, `getNavigator`, `getBaseUrl`, `getFontFaceSet`, `fetch`, `parseXML`
- [ ] Covers `import 'pixi.js/unsafe-eval'` for CSP environments and clarifies the counterintuitive naming (it removes the need for eval, not enables it)
- [ ] Covers [HIGH] mistake: using `document` or `Image` directly breaks Web Worker / SSR — all DOM access must go through `DOMAdapter.get()`
- [ ] Covers [HIGH] mistake: old `settings.ADAPTER = WebWorkerAdapter` pattern removed in v8

## Version Awareness
- [ ] Aligns with PixiJS v8 `DOMAdapter` API; flags that `settings.ADAPTER` was removed and `autoDetectEnvironment` is deprecated since 8.1.6

## Known Gaps / Notes
The skill does not cover `@xmldom/xmldom` as a Node dependency for the custom adapter `parseXML` method — this is an implicit requirement for Node SSR environments. Testers should note that the `HeadlessAdapter` example uses `canvas` npm package which must be installed separately.
