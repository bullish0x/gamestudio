# Skill Test Spec: /phaser-text-and-bitmaptext

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers text rendering in Phaser 4 via `Text` (Canvas 2D API, flexible styling, web fonts, shadows/gradients/strokes, word wrap, `appendText`, canvas gradients as fill) and `BitmapText`/`DynamicBitmapText` (pre-rendered font texture, fast batched rendering, `setCharacterTint`, `setWordTint`, drop shadow, per-character display callbacks for wave effects, `getTextBounds`). It also covers RetroFont for fixed-width grid fonts. It triggers when displaying any text, score counters, dialog, or UI labels.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-text-and-bitmaptext` and a `description`
- [ ] Description names trigger keywords: `Text`, `BitmapText`, `this.add.text`, `font`, `word wrap`, `text style`
- [ ] Body contains a comparison table of Text vs BitmapText vs DynamicBitmapText
- [ ] `TextStyle` properties table with at least 10 properties is present
- [ ] BitmapText alignment constants (`ALIGN_LEFT` = 0, `ALIGN_CENTER` = 1, `ALIGN_RIGHT` = 2) are documented

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents that Text origin defaults to (0, 0) top-left (unlike Sprites which default to 0.5 center); requires `setOrigin(0.5)` for centering
- [ ] Documents `setText()` re-renders the entire canvas and re-uploads GPU texture; advises BitmapText for frequently-updating text like scores/timers
- [ ] Documents `font` shorthand overrides `fontFamily`, `fontSize`, and `fontStyle` simultaneously; e.g. `font: 'bold 28px Arial'`
- [ ] Documents font names with special characters require double-quoting inside the string: `fontFamily: '"Press Start 2P"'`
- [ ] Documents `setWordWrapWidth(width, useAdvanced?)`: basic wrap uses whitespace; advanced collapses spaces and trims whitespace
- [ ] Documents `align` only affects multi-line text; for single-line centering use `setOrigin(0.5)` or manual positioning
- [ ] Documents `DynamicBitmapText.setDisplayCallback(fn)` callback data properties: `parent`, `tint`, `index`, `charCode`, `x`, `y`, `scale`, `rotation`, `data`
- [ ] Documents `setCharacterTint(start, length, tintMode, color)` and `setWordTint(word, count, tintMode, color)` are WebGL only
- [ ] Documents `setDropShadow(x, y, color, alpha)` is WebGL only AND static BitmapText only (not DynamicBitmapText)
- [ ] Documents RetroFont pattern: load image → parse with `Phaser.GameObjects.RetroFont.Parse(scene, config)` → add to `this.cache.bitmapFont` → use with `this.add.bitmapText()`

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `setRTL(true)` right-to-left mode must be set BEFORE `setText()`; setting after may cause incorrect rendering; verify this behavior in v4

## Known Gaps / Notes
`setResolution(value)` for HiDPI/Retina display sharpness is documented. `setLetterSpacing` on Text is noted as expensive (renders each character separately). `getWrappedText()` to get wrapped lines as an array is documented. The `metrics` style property for pre-computed font metrics to skip measurement is in the reference table.
