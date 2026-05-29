# Skill Test Spec: /pixi-scene-text

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-scene-text` skill teaches the five PixiJS v8 text-rendering classes and their trade-offs. `Text` uses canvas rendering for full CSS-style fidelity (expensive updates). `BitmapText` uses a pre-generated glyph atlas for cheap per-frame updates. `HTMLText` renders HTML fragments via SVG `<foreignObject>` for rich markup. `SplitText` and `SplitBitmapText` expose per-character/word/line containers for animation. It covers the options-object constructor (v7 positional args removed), `TextStyle`, `tagStyles` for per-tag inline styling, `BitmapFont.install` for atlas pre-generation, MSDF font loading, the update cost comparison table, and `import 'pixi.js/text-bitmap'` for custom builds. Triggers on: Text, BitmapText, HTMLText, SplitText, TextStyle, BitmapFont.install, tagStyles, fontFamily, wordWrap.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-scene-text` and a `description`
- [ ] Description names concrete trigger keywords (Text, BitmapText, HTMLText, SplitText, TextStyle, BitmapFont.install, tagStyles)
- [ ] Body contains at least one fenced code example showing `new Text({ text, style: { fontFamily, fontSize, fill, stroke, dropShadow } })`
- [ ] Contains an update cost comparison table across all five variants showing High/Very low/Free costs
- [ ] Contains a "Common Mistakes" section with [HIGH] severity for updating `Text.text` every frame
- [ ] Contains an "API Reference" section linking to Text, TextStyle, BitmapText, BitmapFont, HTMLText, SplitText, SplitBitmapText

## Content Coverage Assertions (`/skill-test spec`)
- [ ] States all v8 text classes use options-object constructors; `(string, style)` positional form from v7 is removed
- [ ] Explains that `BitmapText` text updates only reposition quads (no canvas re-draw or GPU upload) making it ideal for scores/timers
- [ ] Documents `tagStyles` in `TextStyle` for per-tag inline styling (only parsed when `tagStyles` has entries)
- [ ] Covers the decision guide: CJK/Arabic/emoji-heavy text → `Text` or `HTMLText` (not `BitmapText` — glyph set too large)
- [ ] Covers MSDF fonts: generate externally, load via `Assets.load('font.fnt')`, require `import 'pixi.js/text-bitmap'` in custom builds
- [ ] Documents `BitmapFont.install` for pre-generating the glyph atlas before first `BitmapText` use
- [ ] Covers `SplitText` and `SplitBitmapText` for per-character animation with the trade-off: `SplitText` expensive for long strings
- [ ] Covers that all text classes have `allowChildren = false` — wrap in `Container` to group

## Version Awareness
- [ ] Aligns with PixiJS v8; flags that positional `(string, style)` constructor form was removed; flags `import 'pixi.js/text-bitmap'` required for bitmap font in custom builds

## Known Gaps / Notes
Sub-reference files contain detailed options for each text variant. Testers should verify `references/text.md`, `references/bitmap-text.md`, `references/html-text.md`, `references/split-text.md`, and `references/split-bitmap-text.md` all exist. The `TextStyle` `stroke` option changed to an object format in v8 (`{ color, width }` instead of separate `strokeThickness`) — this should be verified in the reference files.
