# Skill Test Spec: /phaser-cameras

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers Phaser 4's camera system including `CameraManager` (`this.cameras`), viewport vs world-scroll distinction, zoom, bounds, follow with lerp and deadzone, all camera effects (fade in/out, flash, shake, pan, zoomTo, rotateTo), ignore lists for HUD setups, multiple cameras with minimap pattern, keyboard controls (`FixedKeyControl`, `SmoothedKeyControl`), `worldView` rectangle, pointer-to-world coordinate conversion, force composite mode, and v4 filter support on cameras. It triggers when working with scroll, zoom, follow, viewport, shake, fade, or multi-camera setups.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-cameras` and a `description`
- [ ] Description names trigger keywords: `camera`, `viewport`, `scroll`, `zoom`, `follow`, `shake`, `fade`
- [ ] Body contains a Quick Start code block accessing `this.cameras.main` and calling at least one effect
- [ ] Skill distinguishes viewport (canvas rectangle) from scroll (world position)
- [ ] An events table covers at minimum fade, flash, shake, pan, zoom, and rotate start/complete pairs

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents `CameraManager` limit of 32 cameras for bitmask-based `ignore()` support; cameras beyond 32 get ID 0
- [ ] Explains `worldView` as the read-only Rectangle updated each frame reflecting world area visible to the camera
- [ ] Documents `startFollow` full signature: `(target, roundPixels?, lerpX?, lerpY?, offsetX?, offsetY?)` and notes lerp of 0 on an axis disables tracking on that axis
- [ ] Documents deadzone behavior: `setDeadzone(w, h)` re-centers on camera midpoint each frame; camera only scrolls when target leaves the rectangle
- [ ] Documents `cam.ignore(gameObject | array | Group | Layer)` for the HUD pattern: main camera ignores HUD objects, HUD camera ignores world objects
- [ ] Documents effect callback signature for fade/flash/shake: `(camera, progress)` where progress is 0 to 1
- [ ] Documents `rotateTo(angle, shortestPath, duration, ease, force, callback)` noting angle is in radians
- [ ] Documents `FixedKeyControl` vs `SmoothedKeyControl` and that both require `update(delta)` called in scene update
- [ ] Documents `cam.filters.external.addBlur()` and `cam.filters.internal.addColorMatrix()` as v4 camera filter patterns
- [ ] Documents `setForceComposite(true)` requirement for CaptureFrame and explicit framebuffer rendering without filters

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask); flags any API to verify against the installed version
- [ ] Notes `cam.filters` (FilterList) is a v4-only addition replacing v3 `postFX`

## Known Gaps / Notes
The skill mentions `cam.renderList` for seeing what was rendered this frame but does not provide usage examples. The `getWorldPoint(pointer.x, pointer.y)` essential pattern for scrolled/zoomed scenes is documented but should be emphasized for pointer input integration.
