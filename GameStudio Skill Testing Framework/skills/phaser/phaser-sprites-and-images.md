# Skill Test Spec: /phaser-sprites-and-images

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers creating and manipulating Sprite and Image game objects in Phaser 4. It explains the only difference between them (Sprite has AnimationState + `preUpdate` cost; Image does not), the complete component mixin set applied to both, factory signatures for `this.add.sprite()` and `this.add.image()`, all component operations (position/scale/rotation, tint with v4 TintModes, alpha, flip, origin, depth, scrollFactor, blendMode, visibility, texture/frame, crop), and specialized game objects: NineSlice, TileSprite (with v4 `tileRotation`), Blitter/Bob, and Video. It triggers when working with sprites, images, textures, `setTint`, or `setAlpha`.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-sprites-and-images` and a `description`
- [ ] Description names trigger keywords: `Sprite`, `Image`, `this.add.sprite`, `this.add.image`, `texture`, `setTint`, `setAlpha`
- [ ] Body contains a comparison table of Sprite vs Image features
- [ ] The factory signatures for both `this.add.sprite(x, y, texture, frame)` and `this.add.image(x, y, texture, frame)` are documented
- [ ] All component operations have code examples with chaining

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents the v4 Tint system change: `setTintFill()` is REMOVED; replacement is `setTint(color).setTintMode(Phaser.TintModes.FILL)` with 6 available modes
- [ ] Documents that `alpha = 0` clears a render flag bit (object not drawn at all, not merely transparent); same for `scale = 0`; setting back to non-zero restores rendering
- [ ] Documents `TextureCrop` component's `setCrop(x, y, width, height)` to show only a region; no-argument call clears the crop; `isCropped` boolean
- [ ] Documents `setFrame(frame, updateSize?, updateOrigin?)`: passing `false, false` prevents automatic size/origin recalculation after frame change
- [ ] Documents that flip is rendering-only: `flipX`/`flipY` do not affect physics bodies or hit areas
- [ ] Documents `setScrollFactor(0)` for HUD elements fixed to camera; `0.5` for parallax half-speed
- [ ] Documents `setOrigin()` default (0.5, center) vs Text game objects which default to (0, 0) top-left
- [ ] Documents depth: `setDepth(n)` queues a sort; `setToTop()`/`setAbove(go)` reorder display list without changing depth value
- [ ] Documents `NineSlice` for scalable UI panels: `this.add.nineslice(x, y, texture, frame, width, height, leftWidth, rightWidth, topHeight, bottomHeight)` with `setSize()` for runtime resize
- [ ] Documents `TileSprite` v4 new `tileRotation` property for rotating repeating pattern; notes atlas frame support added in v4

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `tileRotation` on TileSprite is v4-only; TileSprite atlas frame support is v4-only; `Phaser.TintModes` enum is v4-only

## Known Gaps / Notes
The `Blitter`/`Bob` pattern for high-performance batched static sprites (no rotation/scale/physics) is documented with a 1000-bob example. `Video` game object with `this.load.video()` and `video.play()` is briefly covered. The `this.add` (adds to display list) vs `this.make` (creates but does NOT add, use `this.add.existing()` later) distinction is documented in game-object-components but referenced here.
