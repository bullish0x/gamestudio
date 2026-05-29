# Skill Test Spec: /pixi-scene-sprite

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-scene-sprite` skill teaches the four sprite classes in PixiJS v8: `Sprite` (single texture), `AnimatedSprite` (frame-based animation), `NineSliceSprite` (resizable UI panels), and `TilingSprite` (repeating/scrolling backgrounds). It covers the `anchor` vs `pivot` distinction, `Sprite.from` cache-read-only behavior, `tint` coloring, the options-object constructor, `texture.dynamic = true` for dynamic texture changes, and proper loading via `Assets.load`. Each variant has a sub-reference file with its full options. Triggers on: Sprite, AnimatedSprite, NineSliceSprite, TilingSprite, Sprite.from, anchor, tint, tilePosition, animationSpeed, gotoAndPlay, leftWidth.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-scene-sprite` and a `description`
- [ ] Description names concrete trigger keywords (Sprite, AnimatedSprite, NineSliceSprite, TilingSprite, anchor, tint, animationSpeed)
- [ ] Body contains at least one fenced code example showing `await Assets.load(url)` + `new Sprite({ texture, anchor })` + `app.stage.addChild(sprite)`
- [ ] Contains a variant comparison table with use cases and trade-offs for all four sprite types
- [ ] Contains a "Common Mistakes" section with [HIGH] severity for `Texture.from(url)` to load
- [ ] Contains an "API Reference" section linking to Sprite, AnimatedSprite, NineSliceSprite, TilingSprite, Texture

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents `anchor` vs `pivot` distinction: `anchor` is normalized 0-1 and shifts only the texture draw origin; `pivot` is pixel-space and shifts both transform origin and visual position
- [ ] Covers `Sprite.from(id)` only reads the cache in v8 — does not fetch; must `await Assets.load` first
- [ ] Documents that `AnimatedSprite` is a `Sprite` subclass (all Sprite properties like `anchor`, `tint`, `position` apply)
- [ ] Covers `NineSliceSprite` as the v8 rename of `NineSlicePlane` with its options-object constructor (`leftWidth`, `topHeight`, `rightWidth`, `bottomHeight`)
- [ ] Covers `TilingSprite` use case: scrolling repeating background with `tilePosition` animation
- [ ] Documents `texture.dynamic = true` or `sprite['onViewUpdate']()` for dynamic texture frame changes
- [ ] States that all sprite classes have `allowChildren = false` — wrap in `Container` to group
- [ ] Recommends `ParticleContainer` (not plain sprites) for thousands of identical sprites

## Version Awareness
- [ ] Aligns with PixiJS v8; flags `NineSlicePlane` renamed to `NineSliceSprite` with options-object constructor; flags `Texture.from(url)` no longer fetches in v8

## Known Gaps / Notes
Sub-reference files contain detailed options for each variant (`references/sprite.md`, `references/animated-sprite.md`, `references/nineslice-sprite.md`, `references/tiling-sprite.md`). Testers should verify these exist. `AnimatedSprite` frame timing, `gotoAndPlay`, `gotoAndStop`, and `onComplete` are not shown in the main skill body — testers should check sub-references cover these.
