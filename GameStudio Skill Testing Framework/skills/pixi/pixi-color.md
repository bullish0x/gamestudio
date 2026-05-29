# Skill Test Spec: /pixi-color

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-color` skill teaches the PixiJS v8 `Color` class for creating, converting, and manipulating colors. It covers all accepted input formats (hex integers, hex strings, CSS names, RGB/HSL/HSV objects, CSS strings, normalized arrays, Uint8 arrays, 8-digit hex with alpha), all conversion methods (`toHex`, `toHexa`, `toNumber`, `toArray`, `toRgbArray`, `toRgbaString`, `toRgba`, `toRgb`, `toUint8RgbArray`), component accessors (`red`, `green`, `blue`, `alpha`), mutation methods (`setAlpha`, `multiply`, `premultiply`, `setValue`), GPU-packing helpers (`toBgrNumber`, `toLittleEndianNumber`, `toPremultiplied`), reusable output buffers, `Color.shared` singleton, `Color.isColorLike`, and the removal of the `utils` namespace. Triggers on: Color, ColorSource, hex, rgb, hsl, tint, premultiply, Color.shared.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-color` and a `description`
- [ ] Description names concrete trigger keywords (Color, ColorSource, hex, rgb, hsl, tint, premultiply, Color.shared)
- [ ] Body contains at least one fenced code example showing `new Color('#ff6600')` and conversion methods
- [ ] Contains a "Common Mistakes" section covering normalized vs 0-255 input range confusion
- [ ] Contains an "API Reference" section linking to `Color` and `ColorSource`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Lists all accepted input formats including hex integer, hex string, short hex, CSS names, RGB/HSL/HSV objects, CSS function strings, normalized arrays, `Uint8Array`, `Uint8ClampedArray`, 8-digit hex, and copying from another `Color`
- [ ] Covers all conversion output methods: `toHex`, `toHexa`, `toNumber`, `toArray`, `toRgbArray`, `toRgbaString`, `toRgba`, `toRgb`, `toUint8RgbArray`
- [ ] Covers `setValue()` as the chainable way to reuse a `Color` instance
- [ ] Explains that plain number arrays use normalized 0-1 range (not 0-255), but `Uint8Array` uses 0-255
- [ ] Covers `Color.shared` singleton for hot paths and warns against storing references to it
- [ ] Covers `Color.isColorLike()` for type-guard validation
- [ ] Covers `toPremultiplied(alpha, applyToRGB?)` for non-destructive premultiplied output
- [ ] Covers reusable output buffers: `toArray(out)`, `toRgbArray(out)`, `toUint8RgbArray(out)` with pre-allocated typed arrays
- [ ] Covers the [MEDIUM] mistake: `utils.string2hex` and `utils.hex2string` were removed in v8

## Version Awareness
- [ ] Aligns with PixiJS v8 `Color` class; flags that `utils` namespace was removed and all conversions use `Color`

## Known Gaps / Notes
The skill does not explicitly document that `multiply()` and `premultiply()` are destructive (they null the original format). This is mentioned in passing but worth a direct warning. Testers should verify that `Color.shared.setValue(...)` pattern is shown for per-frame tint calculations.
