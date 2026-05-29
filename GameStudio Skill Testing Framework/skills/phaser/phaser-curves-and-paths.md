# Skill Test Spec: /phaser-curves-and-paths

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers `Phaser.Curves.Path` as a composite curve container plus all curve types (Line, Spline/Catmull-Rom, CubicBezier, QuadraticBezier, Ellipse), including their construction, arc-length-based vs parameter-based point sampling, drawing with Graphics, and the `PathFollower` game object for making sprites follow paths using an internal tween. It triggers when working with splines, bezier curves, path followers, or curve-based movement.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-curves-and-paths` and a `description`
- [ ] Description names trigger keywords: `curve`, `path`, `spline`, `bezier`, `path follower`
- [ ] Body contains a Quick Start code block using `this.add.path()`, at least one curve add method, and `this.add.follower()`
- [ ] A table of all curve types (Line, Spline, CubicBezier, QuadraticBezier, Ellipse) with constructors is present
- [ ] A PathConfig typedef reference exists

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Distinguishes `getPoint(t)` (raw curve parameter, uneven spacing) from `getPointAt(u)` (arc-length normalized, even spacing) on individual curves
- [ ] Documents that on a `Path`, `getPoint(t)` already accounts for arc length across the entire path
- [ ] Documents `cubicBezierTo` parameter order discrepancy: numbers form is `(endX, endY, cp1X, cp1Y, cp2X, cp2Y)` but Vector2 form is `(cp1, cp2, endPoint)` with end point last
- [ ] Documents `path.moveTo(x, y)` creates a MoveTo pseudo-curve with `active: false`, zero length, which is skipped by `getPoints()` and `draw()`
- [ ] Documents Spline Catmull-Rom behavior needing 4+ points for correct interpolation
- [ ] Documents Ellipse curve angle unit: constructor and `startAngle`/`endAngle` use degrees; `rotation` property uses radians; `angle` property is degrees alias
- [ ] Documents PathFollower `positionOnPath: false` (default) uses current position as offset vs `positionOnPath: true` which snaps to path start and zeros offset
- [ ] Documents that PathFollower internally uses `scene.tweens.addCounter()` with `persist: true`, meaning all tween config (ease, repeat, yoyo, callbacks) applies to `startFollow`
- [ ] Documents cached arc lengths: call `path.updateArcLengths()` after modifying curve control points since cache is invalidated only by array length changes
- [ ] Documents `path.autoClose = true` only affects `getPoints()`/`getSpacedPoints()` output; `closePath()` adds an explicit Line curve

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask); flags any API to verify against the installed version
- [ ] PathFollower is part of core game objects; `this.add.follower` factory should be verified present in v4

## Known Gaps / Notes
The skill covers all curve types and PathFollower thoroughly. The `getCurveAt(t)` method for identifying which sub-curve a path position falls on is listed but not elaborated. The `Line` curve's `arcLengthDivisions: 1` override (inherently uniform) is noted in Gotchas, which is a useful performance note.
