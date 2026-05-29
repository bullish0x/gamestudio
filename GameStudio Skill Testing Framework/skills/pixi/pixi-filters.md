# Skill Test Spec: /pixi-filters

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-filters` skill teaches applying visual effects to PixiJS v8 containers via the filter pipeline. It covers the five built-in filters (`AlphaFilter`, `BlurFilter`, `ColorMatrixFilter`, `DisplacementFilter`, `NoiseFilter`) and their options, `Filter.from({ gl, resources })` for custom GLSL fragment shaders, `GlProgram.from` for custom vertex shaders, filter options (`resolution`, `padding`, `antialias`, `blendRequired`, `clipToViewport`), `filterArea` optimization, the community `pixi-filters` package with its new `pixi-filters/{name}` import paths, and how advanced blend modes (`color-burn`, `overlay`, etc.) use the filter system. Triggers on: filters, BlurFilter, ColorMatrixFilter, DisplacementFilter, NoiseFilter, Filter.from, pixi-filters, filterArea.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-filters` and a `description`
- [ ] Description names concrete trigger keywords (BlurFilter, ColorMatrixFilter, DisplacementFilter, Filter.from, pixi-filters, filterArea)
- [ ] Body contains at least one fenced code example assigning `sprite.filters = [blur, colorMatrix]`
- [ ] Contains a "Common Mistakes" section with [CRITICAL] severity for old `new Filter(vertex, fragment, uniforms)` constructor
- [ ] Contains an "API Reference" section linking to `Filter`, `BlurFilter`, `ColorMatrixFilter`, `DisplacementFilter`, `NoiseFilter`, `FilterSystem`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents `BlurFilter` options: `strength`, `quality`, `kernelSize` (must be odd 5-15), `repeatEdgePixels`, `strengthX`/`strengthY`
- [ ] Documents `ColorMatrixFilter` preset methods: `brightness`, `contrast`, `saturate`, `desaturate`, `greyscale`, `sepia`, `negative`, `hue`, plus `matrix` array and `alpha` blend property
- [ ] Documents `DisplacementFilter` with `sprite` and `scale` (`PointData` or number) options
- [ ] Documents `NoiseFilter` with `noise` and `seed` options
- [ ] Covers `Filter.from({ gl: { fragment }, resources })` pattern with `out vec4 finalColor`, `texture()`, and typed uniforms
- [ ] Covers `filter.enabled = false` toggle and sharing one filter across multiple containers
- [ ] Covers `container.filterArea = new Rectangle(x, y, w, h)` optimization to avoid per-frame bounds measurement
- [ ] Covers community `pixi-filters` with `pixi-filters/{name}` import path (not `@pixi/filter-*`)
- [ ] Covers `blendRequired: true` + `useBackBuffer: true` requirement for filters that sample the back buffer

## Version Awareness
- [ ] Aligns with PixiJS v8 filter API; flags that `@pixi/filter-*` packages are v7 only and `pixi-filters/{name}` is the v8 path; flags that old `new Filter(vertex, fragment, uniforms)` constructor was removed

## Known Gaps / Notes
The skill does not document all ColorMatrixFilter presets (e.g., `technicolor`, `polaroid`, `kodachrome`, `browni`, `vintage`, `colorTone`, `night`, `predator`, `lsd`, `reset`). A tester should verify the skill at least mentions the full preset list exists. The `AlphaFilter` is useful for applying uniform transparency without per-child compositing, which is mentioned but not deeply explained.
