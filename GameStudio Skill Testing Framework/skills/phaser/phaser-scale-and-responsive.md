# Skill Test Spec: /phaser-scale-and-responsive

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers the Phaser 4 `ScaleManager` (`game.scale` / `this.scale`) for making games responsive. Topics include the three internal Size components (`gameSize`, `baseSize`, `displaySize`), all 7 scale modes (NONE, WIDTH_CONTROLS_HEIGHT, HEIGHT_CONTROLS_WIDTH, FIT, ENVELOP, RESIZE, EXPAND), 4 center modes (NO_CENTER, CENTER_BOTH, CENTER_HORIZONTALLY, CENTER_VERTICALLY), zoom constants (NO_ZOOM, ZOOM_2X, ZOOM_4X, MAX_ZOOM), orientation detection and locking, fullscreen API, the RESIZE event with its three Size parameter arguments, `resize()` vs `setGameSize()` method differences, snap values, min/max constraints, and iOS-specific quirks. It triggers on ScaleManager, responsive, resize, fullscreen, FIT mode, or scale mode questions.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-scale-and-responsive` and a `description`
- [ ] Description names trigger keywords: `ScaleManager`, `responsive`, `resize`, `fullscreen`, `FIT`, `scale mode`
- [ ] Body contains a Quick Start code block using `scale.mode: Phaser.Scale.FIT` with `autoCenter`
- [ ] Scale modes table with all 7 modes, their values, and behaviors is present
- [ ] Center modes, zoom constants, and orientation constants tables are present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents the three Size components: `gameSize` (unmodified config dimensions, used for world bounds/cameras), `baseSize` (sets canvas width/height attributes), `displaySize` (sets canvas CSS size after scaling)
- [ ] Documents `displayScale` Vector2 as ratio `baseSize / canvasBounds` used internally for input coordinate transformation
- [ ] Explains FIT mode leaves letterbox/pillarbox empty space; ENVELOP crops content but fills parent; RESIZE creates 1:1 pixel canvas matching parent
- [ ] Documents EXPAND mode (v4 new, value 6): hybrid of RESIZE visible area + FIT canvas scaling
- [ ] Documents that fullscreen must use `pointerup` not `pointerdown`; touch devices block fullscreen on `pointerdown`
- [ ] Documents `resize()` vs `setGameSize()`: use `resize()` only in NONE mode (direct set); use `setGameSize()` for FIT/ENVELOP etc. to preserve scale calculations
- [ ] Documents that the parent element must have calculable bounds; unstyled `<div>` has zero height; `expandParent: true` (default) sets parent to 100% height
- [ ] Documents that styling the canvas directly conflicts with ScaleManager CSS control (`style.width`, `style.height`, `marginLeft`, `marginTop`)
- [ ] Documents percentage string resolution: `width: '100%'` resolves against parent; falls back to `window.innerWidth`/`innerHeight` if parent has no size
- [ ] Documents `Phaser.Scale.MAX_ZOOM` (-1) for pixel art: calculates largest integer multiplier fitting in parent; combine with `pixelArt: true`

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] EXPAND scale mode (value 6) is new in v4; `this.scale.setSnap()` and `snap` config are available in v4

## Known Gaps / Notes
iOS height quirk: ScaleManager uses `GetInnerHeight` to work around Safari's dynamic toolbar affecting `getBoundingClientRect`. The `resizeInterval` polling fallback (default 500ms) is documented for older browsers. `getViewPort(camera?)` for getting visible area rectangle per camera is in the quick reference.
