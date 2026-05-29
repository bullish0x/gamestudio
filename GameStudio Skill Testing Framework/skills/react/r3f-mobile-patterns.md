# Skill Test Spec: /r3f-mobile-patterns

> **Category**: react · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill provides mobile-first React Three Fiber patterns covering device capability detection, battery-aware quality adjustment, dual-zone touch controls (left-side movement / right-side look), a virtual joystick overlay component, responsive breakpoint hooks, and a complete `AdaptiveMobileCanvas` that selects WebGL settings based on detected GPU tier. The skill uses the Battery Status API (`navigator.getBattery`), `WEBGL_debug_renderer_info` extension for GPU identification, and `orientationchange`/`resize` events to keep layout state current. It emphasizes `touch-action: none` on the canvas, `passive: false` on touch listeners, and keeping touch handlers lightweight.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: r3f-mobile-patterns` and a `description`
- [ ] Description names concrete trigger keywords: "touch controls", "device adaptation", "battery optimization", "responsive layouts"
- [ ] Body contains fenced code for: `useDeviceCapabilities`, `AdaptiveMobileCanvas`, `TouchControls`, `VirtualJoystick`, `useResponsiveLayout`, `useBatteryQuality`, and complete game setup
- [ ] Skill has a `## Checklist` section with 14 items including real-device testing
- [ ] Skill has a `## Common Pitfalls` section
- [ ] Skill has a layered `## Performance Tips` section covering device detection, touch controls, battery optimization, mobile rendering, and responsive design

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `useDeviceCapabilities` uses `WEBGL_debug_renderer_info` GL extension to read the unmasked renderer string and classifies GPU tier using regex patterns (Mali-4/Adreno 3/PowerVR = low; Apple A1x/Adreno 6-7/Mali-G7 = high)
- [ ] `useDeviceCapabilities` subscribes to `battery.addEventListener('levelchange')` and `'chargingchange'` and returns `batteryLevel` and `isCharging` fields
- [ ] `AdaptiveMobileCanvas` derives `canvasConfig` from `useMemo` (not computed inline on every render) and switches `powerPreference` to `'low-power'` for both low-end GPU and low-battery cases
- [ ] Battery-saving mode triggers when `batteryLevel < 0.2` AND `!isCharging`, setting `dpr: 1` and `performance.min: 0.2`
- [ ] `TouchControls` uses `{ passive: false }` on all three touch event registrations (touchstart, touchmove, touchend) to allow `e.preventDefault()`
- [ ] `TouchControls` splits screen at `window.innerWidth / 2`: left half controls movement (normalizes delta to window size), right half controls camera rotation (clamps `camera.rotation.x` to ±π/2)
- [ ] `VirtualJoystick` clamps stick distance to `maxDistance` using `Vector2.normalize().multiplyScalar(maxDistance)` and outputs a `normalized` direction via `onMove`
- [ ] `useResponsiveLayout` defines five breakpoints (xs < 640, sm < 768, md < 1024, lg < 1280, xl ≥ 1280) and returns both `isMobile`/`isTablet`/`isDesktop` booleans and the raw `width`/`height`
- [ ] `useBatteryQuality` returns `'low'` below 15%, `'medium'` below 30%, `'high'` otherwise (or when charging)
- [ ] Performance tips explicitly state: cap DPR at 2 maximum, limit draw calls to under 100 on mobile, max texture size 1024 px for mobile, disable antialiasing on low-end

## Version Awareness
- [ ] For React Three Fiber skills: aligns with pinned R3F 9 / drei 10 / three 0.184. Battery Status API (`navigator.getBattery`) is deprecated in some browsers — the skill correctly guards with `'getBattery' in navigator`. `WEBGL_debug_renderer_info` availability should be confirmed in WebGL2 contexts used by three 0.184.

## Known Gaps / Notes
- `useDeviceCapabilities` creates a throwaway `<canvas>` element in a `useEffect` for GPU detection — this is a side effect that should be cleaned up, though the GL context itself has no explicit cleanup.
- The `TouchControls` component holds `touches` state as `Map<number, Vector2>` in React state, causing a re-render on every touch event; a ref-based map would be more performant.
- `VirtualJoystick` listens for `touchmove` and `touchend` on `window` (not the container) — this is intentional for drag tracking outside the container bounds, but testers should verify this is clearly documented.
