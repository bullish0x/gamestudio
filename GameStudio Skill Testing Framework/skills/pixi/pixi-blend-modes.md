# Skill Test Spec: /pixi-blend-modes

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-blend-modes` skill teaches how to composite display objects using the `blendMode` property in PixiJS v8. It covers the full set of standard hardware-accelerated modes (`normal`, `add`, `multiply`, `screen`, `erase`, `none`, `inherit`, `min`, `max`) and the advanced filter-based modes (`color-burn`, `overlay`, `soft-light`, etc.) that require `import 'pixi.js/advanced-blend-modes'` and `useBackBuffer: true` on WebGL. It also covers the batching impact of blend mode ordering and the removal of the `BLEND_MODES` enum in v8. Triggers on: blendMode, additive, multiply, screen, overlay, advanced-blend-modes, erase.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-blend-modes` and a `description`
- [ ] Description names concrete trigger keywords (blendMode, add, multiply, screen, overlay, color-burn, advanced-blend-modes, erase)
- [ ] Body contains at least one fenced code example assigning `sprite.blendMode = 'add'`
- [ ] Contains a table listing all advanced blend modes with their visual effects
- [ ] Contains a "Common Mistakes" section with [HIGH] severity for missing advanced-blend-modes import
- [ ] Contains an "API Reference" section with links to filter classes for each advanced blend mode

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Lists all standard built-in blend modes: `normal`, `add`, `multiply`, `screen`, `erase`, `none`, `inherit`, `min`, `max`
- [ ] Covers the `import 'pixi.js/advanced-blend-modes'` side-effect requirement and that advanced modes use the filter pipeline
- [ ] Covers `useBackBuffer: true` in `app.init` as a requirement for advanced blend modes on WebGL
- [ ] Explains that WebGPU enables back buffer unconditionally (so `useBackBuffer` is only needed for WebGL)
- [ ] Covers batch-friendly ordering: same blend modes adjacent = fewer draw calls
- [ ] Covers the [HIGH] mistake: `BLEND_MODES` enum was removed in v8; string literals must be used (`'add'` not `BLEND_MODES.ADD`)
- [ ] Covers `'inherit'` as the actual default value and explains how it differs from `'normal'`

## Version Awareness
- [ ] Aligns with PixiJS v8 string-based blend mode API; flags that `BLEND_MODES` is a TypeScript type only with no runtime value

## Known Gaps / Notes
The skill does not cover the `min`/`max` modes being WebGL2+ only (not available on Canvas fallback). Testers should watch for use cases on legacy browsers. The skill correctly notes advanced modes use filters internally, linking to `pixi-filters` and `pixi-performance` for cost implications.
