# Skill Test Spec: /battery-optimization

> **Category**: mobile · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a layered mobile battery management system built around a `PowerState` enum (High / Normal / Low / Critical) that drives `AdaptiveQualityManager` presets and a `FrameRateThrottle` accumulator. `PowerStateManager` wires the Battery Status API and Page Visibility API into state transitions, emitting change events to registered listeners. `AdaptiveQualityManager` maps each `PowerState` to a `QualitySettings` preset (render scale 0.5–1.0, shadow quality, particle limit, post-processing toggle) and applies them to a Three.js renderer and scene graph. `PowerAwareGameLoop` pauses on Critical/background, `ThermalManager` monitors long frames via `PerformanceObserver` and aggressively reduces settings on throttling, and `BatteryAwareSystem` provides an abstract base class that adjusts its update interval based on the current power state.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: battery-optimization` and a `description`
- [ ] Description names trigger keywords (adaptive quality, power-efficient rendering, background behavior)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Five named implementation sections are present (Power State Management, Adaptive Quality System, Frame Rate Throttling, Thermal Management, Battery-Aware Updates)
- [ ] A `## Checklist` section is present
- [ ] Four tips sub-sections exist under `## Performance Tips` (Power Efficiency, Thermal Management, Battery Optimization, Mobile Considerations)

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `PowerState` enum defines `High`, `Normal`, `Low`, and `Critical` values
- [ ] `PowerStateManager.calculatePowerState()` returns `High` when charging, `Critical` when battery < 10%, `Low` when < 20%
- [ ] Page Visibility API listener calls `onBackgrounded()` which emits `Critical` to all listeners
- [ ] `AdaptiveQualityManager` has four presets mapped by `PowerState`; `Critical` preset has `targetFPS: 20`, `renderScale: 0.5`, and `shadowQuality: 'none'`
- [ ] `FrameRateThrottle.shouldRender()` uses an accumulator so fractional-frame remainders carry over between calls
- [ ] `PowerAwareGameLoop` cancels `requestAnimationFrame` in `pause()` and restores it in `resume()`
- [ ] `ThermalManager` uses `PerformanceObserver` with `entryTypes: ['measure']` and treats frames > 50 ms as throttling evidence
- [ ] `BatteryAwareSystem.onPowerStateChanged` sets `updateInterval` to 0.5 s on Critical and 0 on High/Normal
- [ ] Background visibility handler calls `gameLoop.pause()`, `audioManager.pauseAll()`, and `networkManager.setBackgroundMode(true)`

## Version Awareness
- [ ] `AdaptiveQualityManager` calls `THREE.Light` and `THREE.MeshStandardMaterial` APIs — verify against the installed Three.js version. `PerformanceObserver` for `measure` entry types has broad browser support but verify on target mobile browsers.

## Known Gaps / Notes
- `AdaptiveQualityManager.updateTextureQuality` iterates `scene.traverse` which is O(n) per power state change — acceptable for infrequent state changes but should not be called every frame.
- `BatteryAwareSystem` extends `UpdateSystem` which is not defined in this skill — it is assumed to come from the ECS architecture layer.
