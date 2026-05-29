# Skill Test Spec: /phaser-render-textures

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers off-screen rendering in Phaser 4 using `RenderTexture` (a visible Image game object with an auto-created DynamicTexture) and `DynamicTexture` (a Texture Manager entry usable by any game object). Topics include the command-buffer architecture (draw → buffer → `render()` flush), `draw()`, `stamp()`, `capture()`, `erase()`, `fill()`, `clear()`, `repeat()`, `callback()`, `preserve()`, `renderMode` ('render'/'redraw'/'all'), `saveTexture(key)`, `snapshotPixel()`, the internal camera for positioning, the `Stamp` game object, and practical patterns (paint canvas, minimap, procedural generation). It triggers when drawing game objects to textures, snapshots, dynamic composite textures, or off-screen rendering.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-render-textures` and a `description`
- [ ] Description names trigger keywords: `RenderTexture`, `DynamicTexture`, `snapshot`, `draw to texture`, `stamp`
- [ ] Body contains a comparison table of RenderTexture vs DynamicTexture
- [ ] Body contains a Quick Start code block calling `this.add.renderTexture()` and `rt.draw()` followed by `rt.render()`
- [ ] `StampConfig` and `CaptureConfig` property tables are present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents the command-buffer architecture: draw calls push to `commandBuffer` array; NOTHING appears until `render()` is called
- [ ] Documents the three `renderMode` values: `'render'` (display but manual render), `'redraw'` (auto-render without displaying), `'all'` (both auto-render and display)
- [ ] Documents `preserve(true)` to keep the command buffer between renders so same drawing replays each frame
- [ ] Documents that `stamp()` IGNORES the internal camera; only `draw()` and game object rendering respect the `.camera` property
- [ ] Documents `capture(entry, config)` for rendering with temporary property overrides (x, y, scale, alpha, rotation, transform) without modifying the game object
- [ ] Documents `saveTexture(key)` assigns the DynamicTexture to the Texture Manager; calling again with different key renames it; destroying RenderTexture without saving destroys the texture
- [ ] Documents default size difference: RenderTexture defaults to 32x32; DynamicTexture defaults to 256x256
- [ ] Documents that a DynamicTexture/RenderTexture silently skips entries that reference itself (cannot draw to itself)
- [ ] Documents that `resize()` erases all content (destroys and recreates framebuffer)
- [ ] Documents that `draw()` alpha/tint params only affect Texture Frames and key strings; game objects use their own alpha/tint when drawn

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] Command-buffer architecture requiring explicit `render()` is a v4 breaking change from v3's immediate execution; `preserve()`, `capture()`, `callback()`, and the three renderMode values are all v4-only

## Known Gaps / Notes
The `Stamp` game object (lightweight Image ignoring camera scroll, used internally by DynamicTexture) is documented. WebGL context loss note: DynamicTexture contents are lost; listen for `restorewebgl` event to redraw. WebGL1 has no anti-aliasing on framebuffers — shapes drawn to RenderTexture may have jagged edges.
