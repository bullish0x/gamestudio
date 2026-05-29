# Skill Test Spec: /phaser-input-keyboard-mouse-touch

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers Phaser 4's unified input system via `this.input` (InputPlugin), `this.input.keyboard` (KeyboardPlugin), and `this.input.gamepad` (GamepadPlugin). Topics include cursor key creation, `addKey`/`addKeys`, polling (`isDown`, `isUp`, `JustDown`, `JustUp`, `checkDown`), keyboard events and key combos, `setInteractive()` with default and custom hit areas (rectangle, circle, ellipse, triangle, polygon, pixel-perfect), the three levels of pointer events (game object → scene per-object → scene global), drag-and-drop with drop zones, multi-touch via `addPointer`, mouse wheel, pointer lock, and gamepad API. It triggers when handling keyboard, mouse, touch, pointer, drag, or gamepad input.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-input-keyboard-mouse-touch` and a `description`
- [ ] Description names trigger keywords: `keyboard`, `mouse`, `touch`, `pointer`, `drag`, `drop`, `click`, `input`, `gamepad`, `cursor keys`
- [ ] Body contains a Quick Start code block showing `createCursorKeys()`, a `pointerdown` listener, and `setInteractive()` usage
- [ ] The three levels of pointer event hierarchy are documented
- [ ] Gamepad polling API (`pad.A`, `pad.leftStick.x`, etc.) is documented

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents `JustDown(key)` returning true only once per press (resets after check) vs `isDown` which is true every frame while held
- [ ] Documents `checkDown(key, duration)` for throttled polling: returns true at most once per `duration` ms while key held
- [ ] Documents `setInteractive({ pixelPerfect: true, alphaTolerance: 1 })` and warns it is expensive — use sparingly
- [ ] Documents custom hit area API: `sprite.setInteractive(new Phaser.Geom.Circle(32, 32, 32), Phaser.Geom.Circle.Contains)`
- [ ] Documents Container input requirement: must call `container.setSize(w, h)` before `setInteractive()` works
- [ ] Documents drag thresholds: `input.dragDistanceThreshold` (pixels) and `input.dragTimeThreshold` (ms) to prevent accidental drags
- [ ] Documents `zone.setRectangleDropZone(w, h)` for creating drop targets and the `drop`, `dragenter`, `dragleave`, `dragover` events
- [ ] Documents `this.input.addCapture('SPACE,UP,DOWN,LEFT,RIGHT')` to prevent browser default behavior; notes captures are global across all Scenes
- [ ] Documents pointer `worldX`/`worldY` (translated through camera) vs `x`/`y` (screen space); `updateWorldPoint(camera)` to recalculate
- [ ] Documents gamepad vibration via `pad.vibration.playEffect('dual-rumble', { duration, strongMagnitude, weakMagnitude })` as experimental

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `this.input.topOnly` default `true` behavior; `setTopOnly(false)` for multi-object event delivery; verify these are v4

## Known Gaps / Notes
Key combo API (`createCombo` with string or key code array, Konami code example) is documented. Pointer lock (`requestPointerLock`, `movementX`/`movementY`) is documented for FPS-style mouse. The `input.pollRate` property (-1 = on movement only, 0 = every frame) is documented in the concepts section but has no standalone example.
