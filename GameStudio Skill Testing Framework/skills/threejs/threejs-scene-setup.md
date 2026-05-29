# Skill Test Spec: /threejs-scene-setup

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Teaches the canonical approach for initialising a Three.js scene with a `SceneManager` class. Covers renderer creation (WebGLRenderer options, pixel-ratio cap, `SRGBColorSpace`, shadow map), perspective camera setup, ambient + directional lighting, a self-contained animation loop with start/stop, window resize handling, and full resource disposal via a tracked disposables Set. Triggered when a developer starts a new Three.js project, adds a scene, or needs to refactor scene-initialisation code.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-scene-setup` and a `description`
- [ ] Description names concrete trigger keywords (new scene, scene setup, resource management)
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body contains a "Checklist" section with actionable checkboxes
- [ ] Body contains a "Common Pitfalls" section
- [ ] Body contains a "Performance Tips" section

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Renderer is created with `powerPreference: 'high-performance'` and `antialias: true`
- [ ] Pixel ratio is capped with `Math.min(window.devicePixelRatio, 2)`
- [ ] `renderer.outputColorSpace` is set to `THREE.SRGBColorSpace`
- [ ] Shadow map type is set to `THREE.PCFSoftShadowMap`
- [ ] Camera `aspect` is updated in the resize handler and `updateProjectionMatrix()` is called
- [ ] A `dispose()` method iterates over tracked disposables calling `.dispose()` on each
- [ ] The animation loop uses `requestAnimationFrame` and can be cancelled with `cancelAnimationFrame`
- [ ] Both `geometry.dispose()` and `material.dispose()` (including array materials) are handled during `disposeObject`
- [ ] Scene is cleared and renderer DOM element removed on final disposal

## Version Awareness
- [ ] Aligns with pinned three 0.184 (`SRGBColorSpace` replaces deprecated `sRGBEncoding`; `outputColorSpace` replaces `outputEncoding`); flags `outputEncoding` as a legacy API to verify against the installed version

## Known Gaps / Notes
- The `trackDisposable` helper casts geometry to `any` — spec tests should note this is a compromise for TypeScript strictness.
- `setupLights` adds a directional shadow with hardcoded `2048` map size; no adaptive quality logic is present in this skill (see `threejs-shadows` for that).
