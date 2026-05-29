# Skill Test Spec: /phaser-graphics-and-shapes

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers two approaches to rendering primitives in Phaser 4: the imperative `Graphics` game object (command buffer, paths, arcs, gradients, rounded rects, canvas transforms, `generateTexture`) and individual `Shape` game objects (Arc/Circle, Curve, Ellipse, Grid, IsoBox, IsoTriangle, Line, Polygon, Rectangle, Star, Triangle). It explains when to use each, fill/stroke style APIs, the `pathDetailThreshold` v4 config optimization, and shape-specific methods (Star points, Grid alternating colors, IsoBox faces). It triggers when drawing shapes, custom paths, graphics primitives, or generating textures from drawn content.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-graphics-and-shapes` and a `description`
- [ ] Description names trigger keywords: `Graphics`, `draw shape`, `fillRect`, `lineStyle`, `polygon`, `arc`
- [ ] Body contains code examples for both Graphics object (`gfx.fillStyle(...); gfx.fillRect(...)`) and Shape factory (`this.add.rectangle(...)`)
- [ ] A table of all Shape factory methods with parameters is present
- [ ] A Gotchas section exists

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Explains that Graphics angle in `arc()` is in radians while `this.add.arc()` factory angle parameters are in degrees
- [ ] Documents that Graphics does NOT include Origin or GetBounds components (unlike Shape objects); positioning uses `setPosition(x, y)`
- [ ] Documents that `fillGradientStyle` does NOT appear in textures from `generateTexture()` (Canvas API limitation)
- [ ] Documents that `isFilled` defaults to `true` when a fill color is given but `isStroked` defaults to `false`; must call `setStrokeStyle()` explicitly
- [ ] Documents Line Shape is stroke-only (no fill); its constructor takes `strokeColor`/`strokeAlpha`, not fillColor
- [ ] Documents IsoBox/IsoTriangle are fill-only; Grid's outline is via constructor params (`outlineFillColor`, `outlineFillAlpha`) not `setStrokeStyle()`
- [ ] Documents `pathDetailThreshold` (v4 new): Graphics property that skips vertices below pixel threshold; improves WebGL perf on complex paths; default -1 uses `render.pathDetailThreshold` game config
- [ ] Documents `fillRoundedRect` per-corner radius as object `{ tl, tr, bl, br }` with negative values creating concave corners
- [ ] Documents `Shape.closePath` property (default `true`) controls whether stroke path is automatically closed; set to `false` for open stroked shapes
- [ ] Documents that Shape objects do NOT support `setTint()`; use `setFillStyle(color, alpha)` and `setStrokeStyle(lineWidth, color, alpha)` instead

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `pathDetailThreshold` on Graphics and `render.pathDetailThreshold` game config are v4-only
- [ ] Grid shape property rename from `outline` to `stroke` is a v3-to-v4 breaking change; `strokeOutside` and `strokeOutsideIncomplete` are v4-only Grid properties

## Known Gaps / Notes
The `Line.setLineWidth(startWidth, endWidth)` taper effect is documented (Canvas uses only startWidth, WebGL supports both). The `Polygon.getBounds()` bug with negative coordinates is noted in Gotchas. Performance advice to call `generateTexture()` for static Graphics is documented.
