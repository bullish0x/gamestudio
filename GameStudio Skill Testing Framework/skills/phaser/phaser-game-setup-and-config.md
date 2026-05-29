# Skill Test Spec: /phaser-game-setup-and-config

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers creating a Phaser 4 game instance with `new Phaser.Game(config)`, the complete `GameConfig` and all sub-configs (scale, render, fps, callbacks, dom, input, loader, physics, plugins, audio, images), renderer selection constants (`AUTO`, `CANVAS`, `WEBGL`, `HEADLESS`), the 6-step boot sequence, pixel art mode, transparent canvas, multiple scenes, and the game lifecycle (pause/resume/destroy). It triggers when a developer creates a new Phaser game or configures global game options.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-game-setup-and-config` and a `description`
- [ ] Description names trigger keywords: `new Phaser.Game`, `GameConfig`, `game setup`, `renderer`, `pixel art`, `FPS`
- [ ] Body contains at least one complete `new Phaser.Game(config)` code example
- [ ] A configuration reference table for top-level `GameConfig` properties including `type`, `width`, `height`, `parent`, `backgroundColor` is present
- [ ] Scale mode constants table is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents the 6-step boot sequence: parse config → create managers → wait for DOMContentLoaded → boot (create renderer, add canvas to DOM) → textures ready → start game loop
- [ ] Documents default game dimensions: width 1024, height 768 (changed from v3's 800x600)
- [ ] Documents renderer constant behaviors: `AUTO` falls back to Canvas if WebGL unavailable; `WEBGL` does NOT fall back and fails silently
- [ ] Documents `pixelArt: true` automatically sets `antialias: false`, `antialiasGL: false`, `roundPixels: true`
- [ ] Documents `smoothPixelArt: true` (WebGL only) sets `antialias: true` and `pixelArt: false`
- [ ] Documents `transparent: true` forces background to `rgba(0,0,0,0)` regardless of `backgroundColor`
- [ ] Documents `fps.target` is advisory; `fps.limit` actually caps the frame rate; limit only slows down, never speeds up above display refresh rate
- [ ] Documents `parent: undefined` appends to `document.body`; `parent: null` means Phaser does NOT add canvas to DOM
- [ ] Documents `game.destroy(removeCanvas, noReturn)` is asynchronous (flags for next frame); listen to `DESTROY` event for completion
- [ ] Documents `window.FORCE_WEBGL` and `window.FORCE_CANVAS` global overrides parsed by `Config.js` for development/testing

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `EXPAND` scale mode (value 6) is new in v4
- [ ] `render.renderNodes`, `render.skipUnreadyShaders`, `render.pathDetailThreshold`, and `render.selfShadow` are v4-only render config properties

## Known Gaps / Notes
The `stableSort` game config property (auto-detect vs force native vs force merge-sort) is documented. The `customEnvironment` flag for non-browser environments is noted. The `scale` sub-object vs top-level width/height priority conflict (scale wins) is a notable gotcha.
