# Skill Test Spec: /mobile-performance

> **Category**: mobile · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Covers comprehensive mobile optimization for Three.js games through five cooperating classes: `DeviceDetector` (WebGL renderer info, user-agent, `navigator.deviceMemory`, hardware concurrency → tier), `QualityManager` (three quality presets with named fields for pixel ratio, shadows, post-processing, particle count, and render distance), `PerformanceMonitor` (rolling 60-sample FPS history, `renderer.info` draw calls), `AdaptiveQualitySystem` (5-second polling loop that steps quality up or down based on average FPS thresholds), and `BatteryManager` (Battery Status API, charging/level change listeners, `shouldReduceQuality` predicate). The skill also documents a checklist and common pitfalls such as not capping pixel ratio and ignoring battery state.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: mobile-performance` and a `description`
- [ ] Description names trigger keywords (device detection, quality scaling, thermal throttling, battery management)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Five named implementation sections are present (Device Detector, Quality Settings Manager, Performance Monitor, Adaptive Quality System, Battery Manager)
- [ ] A `## Checklist` section is present with mobile-specific items (cap pixel ratio, disable shadows, reduce textures)
- [ ] A `## Performance Tips` section is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `DeviceCapabilities` interface includes `tier`, `isMobile`, `isIOS`, `isAndroid`, `pixelRatio`, `memory`, and `cores` fields
- [ ] `DeviceDetector` uses `WEBGL_debug_renderer_info` extension to read GPU string
- [ ] Pixel ratio is capped at `Math.min(window.devicePixelRatio, 2)` in the detector
- [ ] `QualitySettings` preset for `low` has `enableShadows: false` and `targetFPS: 30`
- [ ] `QualitySettings` preset for `high` has `enableShadows: true`, `enablePostProcessing: true`, and `targetFPS: 60`
- [ ] `PerformanceMonitor.isPerformanceLow()` returns `true` when average FPS is below 30
- [ ] `AdaptiveQualitySystem.update` checks every 5000 ms and steps quality down when FPS < 30, up when FPS ≥ 55
- [ ] `BatteryManager.shouldReduceQuality()` returns `true` when `level < 0.2` and not charging
- [ ] `QualityManager.applyToRenderer` sets `renderer.setPixelRatio` and `renderer.shadowMap.enabled`

## Version Awareness
- [ ] The skill uses Three.js `renderer.info` and `THREE.PCFSoftShadowMap` — verify these API paths against the installed Three.js version (r140+ recommended). The Battery Status API (`navigator.getBattery`) is not available in all browsers; the skill's `try/catch` guards this.

## Known Gaps / Notes
- `DeviceCapabilities` interface has a typo in the source (`maxTexture Size` with a space) — flag in review.
- Thermal throttling is mentioned in the Checklist but `ThermalManager` implementation lives in `battery-optimization`, not this skill.
