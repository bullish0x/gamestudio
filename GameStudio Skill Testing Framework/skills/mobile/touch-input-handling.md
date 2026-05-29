# Skill Test Spec: /touch-input-handling

> **Category**: mobile · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a complete mobile touch input stack for Three.js games with three cooperating classes. `TouchManager` tracks live `TouchPoint` objects (id, position, delta, force) across touchstart/touchmove/touchend and detects swipe direction via `atan2` angle bucketing and pinch scale via two-finger distance ratio. `VirtualJoystick` renders to a dedicated canvas overlay, confines stick displacement to `maxDistance`, and exposes `getDirection()` (−1..1 normalized), `getAngle()`, and `getMagnitude()` (0..1). `UnifiedInputSystem` bridges touch, virtual joystick, and keyboard/mouse into a single `InputState` with a `pointer`, a `buttons` map, and an `axes` map — providing a shared API for desktop fallback during development.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: touch-input-handling` and a `description`
- [ ] Description names trigger keywords (gestures, virtual joystick, multi-touch support)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Three named implementation sections are present (Touch Manager, Virtual Joystick, Unified Input System)
- [ ] A `## Checklist` section is present with items for `preventDefault`, touch IDs, swipe, pinch, and cleanup
- [ ] A `## Performance Tips` section is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `TouchPoint` interface has `id`, `x`, `y`, `startX`, `startY`, `deltaX`, `deltaY`, and `force`
- [ ] Event listeners are registered with `{ passive: false }` to allow `preventDefault()`
- [ ] Swipe detection threshold is 50px and direction is determined by `Math.atan2`
- [ ] Pinch gesture stores `initialPinchDist` and computes `scale = dist / initialPinchDist`
- [ ] `VirtualJoystick` canvas has `pointer-events: none` so it does not intercept game taps
- [ ] `VirtualJoystick.getDirection()` divides stick offset by `maxDistance` returning a −1..1 vector
- [ ] `VirtualJoystick` draws both a base circle and a stick circle with `rgba` fill colors
- [ ] `UnifiedInputSystem` maps WASD keys to the `movement` axis as a fallback alongside the joystick
- [ ] `TouchManager.dispose()` removes all four event listeners (touchstart, touchmove, touchend, touchcancel)

## Version Awareness
- [ ] The skill is framework-agnostic browser JavaScript; no library version pinning is required. Touch force (`touch.force`) is only available on iOS Safari — the skill correctly reads it as `(touch as any).force || 1.0`.

## Known Gaps / Notes
- `getBoundingClientRect()` is called per event in the handlers; the Performance Tips section recommends caching this result, but no cached implementation is shown.
- `UnifiedInputSystem` clears swipe buttons after 100 ms via `setTimeout`, which is frame-rate-dependent; this is noted as a potential source of missed inputs on slow devices.
