# Skill Test Spec: /pixi-math

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-math` skill teaches PixiJS v8's math primitives: `Point`/`ObservablePoint` with set/clone/equals/copyFrom, the 2D affine `Matrix` with translate/scale/rotate/append/prepend/invert/decompose/apply/applyInverse, all shape classes (Rectangle, Circle, Ellipse, Polygon, RoundedRectangle, Triangle) with `contains`, `getBounds`, `strokeContains`, `isClockwise`, `containsPolygon`, Rectangle layout helpers (`pad`, `scale`, `fit`, `enlarge`, `ceil`, `copyFromBounds`), container `toGlobal`/`toLocal`/`getGlobalPosition`, constants (`DEG_TO_RAD`, `RAD_TO_DEG`, `PI_2`), type interfaces (`PointData`, `PointLike`, `Size`), and the `pixi.js/math-extras` side-effect import for vector operations and `lineIntersection`/`segmentIntersection`. Triggers on: Point, ObservablePoint, Matrix, Rectangle, Circle, Polygon, toGlobal, toLocal, hitArea, strokeContains, math-extras.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-math` and a `description`
- [ ] Description names concrete trigger keywords (Point, Matrix, Rectangle, Circle, Polygon, toGlobal, toLocal, math-extras)
- [ ] Body contains at least one fenced code example showing `Matrix` construction with chained `translate/rotate/scale`
- [ ] Contains a "Common Mistakes" section covering ObservablePoint mutation vs reference replacement
- [ ] Contains an "API Reference" section linking to Point, ObservablePoint, Matrix, Rectangle, Circle, Ellipse, Polygon, RoundedRectangle, Triangle

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Covers `Point.shared` as a temporary singleton and warns against storing references to it
- [ ] Covers `Matrix` `apply(point)` (local to parent) and `applyInverse(point)` (parent to local) plus `decompose(transform)`
- [ ] Covers `container.toGlobal(point)`, `container.toLocal(point, from?)`, and `container.getGlobalPosition()`
- [ ] Documents native Rectangle methods without math-extras: `contains`, `containsRect`, `intersects(other, matrix?)`, `isEmpty`, `left`/`right`/`top`/`bottom`
- [ ] Documents Rectangle layout helpers: `pad`, `scale`, `fit`, `enlarge`, `ceil`, `copyFromBounds`
- [ ] Covers `strokeContains(x, y, lineWidth, alignment?)` on shapes with alignment explanation (1=inner, 0.5=centered, 0=outer)
- [ ] Covers `Polygon.isClockwise()` and `Polygon.containsPolygon(other)` for hole detection
- [ ] Covers `import 'pixi.js/math-extras'` for vector operations (`add`, `subtract`, `multiply`, `dot`, `cross`, `magnitude`, `normalize`, `reflect`, `rotate`) and geometry functions (`lineIntersection`, `segmentIntersection`, `floatEqual`)
- [ ] Explains the distinction between native `Rectangle.intersects()` (boolean) and math-extras `intersection()` (returns overlap Rectangle)

## Version Awareness
- [ ] Aligns with PixiJS v8 single package; flags that `@pixi/math` sub-package was removed and `math-extras` is a separate side-effect import not included in the default bundle

## Known Gaps / Notes
The skill warns about `Rectangle.intersects(other)` vs math-extras `intersection(other)` — this is an easy confusion point that testers should verify is clearly distinguished. The `SHAPE_PRIMITIVE` type union for shape branching without `instanceof` is a useful detail that may be overlooked in generated code.
