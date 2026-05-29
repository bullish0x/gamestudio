# Skill Test Spec: /pixi-scene-graphics

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-scene-graphics` skill teaches the PixiJS v8 `Graphics` vector-drawing API. It covers the shape-then-style pattern (draw shape → `fill()` → `stroke()`), all shape primitives (`rect`, `circle`, `ellipse`, `poly`, `roundRect`, `star`, `regularPoly`, `roundPoly`, `chamferRect`, `filletRect`, `roundShape`), all path methods (`moveTo`, `lineTo`, `bezierCurveTo`, `quadraticCurveTo`, `arc`, `arcTo`, `arcToSvg`, `closePath`, `beginPath`), `FillGradient` (linear/radial), `FillPattern`, `cut()` for holes, `GraphicsContext` sharing, `GraphicsPath` reuse, `svg()` import and `graphicsContextToSvg()` export, draw-time transform stack (`rotateTransform`, `scaleTransform`, `translateTransform`, `save`/`restore`), `setFillStyle`/`setStrokeStyle` defaults, hit testing via `containsPoint`, and `clone`/`clear`/`bounds`. Triggers on: Graphics, GraphicsContext, rect, circle, fill, stroke, cut, FillGradient, FillPattern, svg, GraphicsPath.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-scene-graphics` and a `description`
- [ ] Description names concrete trigger keywords (Graphics, GraphicsContext, rect, circle, fill, stroke, cut, FillGradient, svg, GraphicsPath)
- [ ] Body contains at least one fenced code example showing `new Graphics().rect().fill().stroke()` chain
- [ ] Contains a "Common Mistakes" section with [CRITICAL] severity for v7 `beginFill`/`drawRect`/`endFill`
- [ ] Contains an "API Reference" section linking to Graphics, GraphicsContext, GraphicsPath, FillGradient, FillPattern, graphicsContextToSvg

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Covers `fill()` accepting `FillInput`: color number/string, `{ color, alpha, texture, matrix, textureSpace }`, `FillGradient`, `FillPattern`, or `Texture`
- [ ] Covers `stroke()` `StrokeStyle` options: `width`, `cap`, `join`, `miterLimit`, `alignment`, `pixelLine`
- [ ] Covers `cut()` rules: hole must be completely inside the target shape; `cut()` looks back at up to two instructions; multiple shapes in active path before a single `cut()` creates multiple holes
- [ ] Covers `GraphicsContext` sharing: `new Graphics(ctx)` shares tessellation; `g.clone(true)` creates an independent context
- [ ] Covers `FillGradient` with `type: 'linear'` and `type: 'radial'` including `center`/`innerRadius`/`outerCenter`/`outerRadius`
- [ ] Covers draw-time transform stack (separate from Container transform): `rotateTransform`, `scaleTransform`, `translateTransform`, `save`/`restore`
- [ ] Covers `g.svg(markup)` for SVG import and `graphicsContextToSvg(source, precision)` for SVG export
- [ ] Covers `GraphicsPath` reuse with `g.path(graphicsPath)` for drawing the same path multiple times

## Version Awareness
- [ ] Aligns with PixiJS v8 shape-then-fill API; flags `beginFill`/`drawRect`/`endFill`/`lineStyle`/`beginHole`/`endHole` as v7 patterns that do not exist in v8; `GraphicsGeometry` replaced by `GraphicsContext`

## Known Gaps / Notes
The skill warns that calling `clear()` and redrawing every frame is expensive (unlike HTML Canvas 2D). Testers should verify this anti-pattern is clearly labeled. `GraphicsContext.batchMode` and `customShader` are advanced features documented in the GraphicsContext utilities table — testers should check these are present.
