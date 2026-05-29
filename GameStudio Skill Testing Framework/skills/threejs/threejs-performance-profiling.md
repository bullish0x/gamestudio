# Skill Test Spec: /threejs-performance-profiling

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
A complete profiling toolkit for Three.js: a `PerformanceMonitor` that reads `renderer.info` for draw calls/triangles/textures/geometries and calculates rolling FPS; a `PerformanceHUD` DOM overlay with colour-coded FPS; a `FrameTimeGraph` canvas that visualises 100 samples against 60/30 FPS budget lines; a `DrawCallAnalyzer` that traverses the scene graph and emits actionable suggestions; and a `MemoryProfiler` that aggregates texture VRAM, vertex counts, and JS heap size. Triggered when diagnosing frame-rate issues, identifying CPU vs GPU bottlenecks, or setting performance budgets.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-performance-profiling` and a `description`
- [ ] Description names FPS monitoring, draw-call analysis, and bottleneck identification
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has a metrics-target table (FPS / draw calls / triangles / memory by platform)
- [ ] Body has a "Bottleneck Identification" section distinguishing CPU-bound vs GPU-bound

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `renderer.info.render.calls`, `.triangles`, `.points`, `.lines` are all read in `update()`
- [ ] `renderer.info.memory.textures` and `.geometries` are read for memory metrics
- [ ] FPS is calculated as `Math.round((frames * 1000) / delta)` over a 1-second window
- [ ] `PerformanceHUD` colour-codes FPS: green ≥ 55, yellow ≥ 30, red < 30
- [ ] `FrameTimeGraph` draws horizontal lines at 16.67 ms (60 FPS) and 33.33 ms (30 FPS)
- [ ] `DrawCallAnalyzer` suggests `InstancedMesh` when the same geometry is used > 10 times
- [ ] `MemoryProfiler` calculates texture VRAM as `width * height * 4` (RGBA bytes)
- [ ] `performance.memory.usedJSHeapSize` is read when available for JS heap tracking
- [ ] Mobile draw-call budget is stated as < 100 and desktop < 500

## Version Awareness
- [ ] Aligns with pinned three 0.184 (`renderer.info` object shape unchanged); `renderer.info.programs` is an array — verify `.length` works on the installed version

## Known Gaps / Notes
- `performance.memory` is only available in Chromium browsers; the skill does not mention this limitation.
- `renderer.info.reset()` in `PerformanceMonitor.reset()` resets per-frame counters — callers must call it after rendering, not before, to get accurate values.
