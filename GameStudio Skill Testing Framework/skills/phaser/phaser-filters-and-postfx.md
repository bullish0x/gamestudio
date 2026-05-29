# Skill Test Spec: /phaser-filters-and-postfx

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers Phaser 4's unified Filter system that replaces v3's separate FX and BitmapMask systems. Topics include the rendering pipeline (render to texture → internal filters → camera transform → external filters → composite), `FilterList` with factory methods, the 24 built-in filter types (Blur, Glow, ColorMatrix, Displacement, Vignette, Wipe, ParallelFilters for bloom, Mask, etc.), enabling filters on game objects vs cameras, `CaptureFrame` for scene-level effects, mask usage with texture keys and game object sources, and the v4-to-v3 API mapping table. It triggers when applying visual post-processing, bloom, blur, glow, color effects, or masks.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-filters-and-postfx` and a `description`
- [ ] Description names trigger keywords: `filter`, `post-processing`, `shader`, `bloom`, `blur`, `glow`, `color effects`
- [ ] Body contains a Quick Start code block calling `sprite.enableFilters()` and `sprite.filters.internal.addGlow()`
- [ ] A table of all 24 built-in filters with their `addXxx()` factory methods is present
- [ ] A v3-to-v4 API mapping table is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Explains internal vs external filter distinction: internal filters run in object-local space (cheaper, object-region sized); external run in screen space (full-screen, more expensive)
- [ ] Documents that game objects require `enableFilters()` before `filters` is available; cameras have filters by default and do NOT require this call
- [ ] Documents that `enableFilters()` creates an internal `filterCamera` on the game object
- [ ] Documents ParallelFilters as the v4 bloom replacement: `top.addThreshold() + top.addBlur()` with `blend.blendMode = ADD`; notes no dedicated Bloom filter exists
- [ ] Documents that v3's `FX.addBloom()` is replaced by `Phaser.Actions.AddEffectBloom()` as a convenience wrapper
- [ ] Documents `CaptureFrame` requirement: camera must have `setForceComposite(true)` or otherwise use a framebuffer
- [ ] Documents Glow filter immutable properties: `quality` and `distance` cannot be changed after creation; must destroy and recreate
- [ ] Documents Mask filter API: `addMask(key | gameObject)`, `invert`, `autoUpdate`, `needsUpdate` for static masks
- [ ] Documents Wipe filter `progress` property (0 to 1) as the animation target for tween-driven transitions
- [ ] Documents `controller.setPaddingOverride(left, top, right, bottom)` for expanding effects like Blur and Glow, and `null` to clear override

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] Entire filter system is WebGL only; `enableFilters()` returns early in Canvas renderer
- [ ] Glow `quality` is now an integer (default 10) not a 0-1 fraction as in v3; stochastic sampling replaced line sampling

## Known Gaps / Notes
The ImageLight, NormalTools, and PanoramaBlur filters are listed but have minimal documentation on their config parameters. The `colorMatrix.sepia()` etc. methods now require going through `.colorMatrix` sub-property (v3 breaking change). The `ignoreDestroy` controller property for reusing filters across multiple objects is documented in Gotchas.
