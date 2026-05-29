# Skill Test Spec: /phaser-geometry-and-math

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers Phaser 4's geometry data classes (`Phaser.Geom`: Circle, Ellipse, Line, Polygon, Rectangle, Triangle), their static helper functions, and the complete `Phaser.Geom.Intersects` namespace for boolean and point-returning intersection tests. It also covers math utilities: `Vector2` and `Vector3` methods, `Matrix4`, `Phaser.Math` helpers (Clamp, Wrap, Linear/lerp, DegToRad, Between, SmoothStep), the `Angle`, `Distance`, `Interpolation`, `Snap`, `Fuzzy`, and `Easing` sub-namespaces, `RandomDataGenerator` (seeded PRNG), `Phaser.Math.TAU` (now PI*2 in v4), and `Phaser.Display.Color` with its interpolation utilities. It triggers when working with vectors, rectangles, circles, distances, angles, or random numbers.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-geometry-and-math` and a `description`
- [ ] Description names trigger keywords: `Vector2`, `Rectangle`, `Circle`, `math`, `distance`, `angle`, `random`, `lerp`
- [ ] Body contains a Quick Start code block using at least two geometry classes and one math utility
- [ ] Geom classes table with constructors and key properties is present
- [ ] Vector2 API quick reference with at least 10 methods is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents that geom objects are pure data containers; they are NOT game objects and cannot be added to the display list; use Graphics or Shape game objects to render them
- [ ] Documents `Phaser.Math.TAU` value change: was PI/2 in v3, is now correctly PI*2 in v4; `Math.PI2` is removed; `Math.PI_OVER_2` (PI/2) is new
- [ ] Documents `Point` class removal in v4: use `Vector2` or plain `{x, y}` objects; `GEOM_CONST.POINT` (3) still exists but the class does not
- [ ] Documents Vector2 mutation-in-place behavior: methods return `this`; call `.clone()` first to preserve original
- [ ] Documents `Distance.Squared` / `vec.distanceSq()` as faster alternatives to Euclidean distance for comparisons not needing actual distance
- [ ] Documents Easing short names default to `.Out` variant: `'Quad'` means `Quadratic.Out`; use full string `'Quad.easeIn'` for other variants
- [ ] Documents `RandomDataGenerator.state()` for serializable PRNG state enabling deterministic replay
- [ ] Documents `Phaser.Geom.Intersects` boolean tests vs `Get*` functions: `Get*` functions return `Vector2[]` intersection points and should receive a reusable `out` array to avoid GC pressure in hot loops
- [ ] Documents `Polygon` input formats: space-separated string, `{x,y}[]`, flat number array `[x1,y1,...]`, or `[x,y][]` sub-arrays
- [ ] Documents `Color.Interpolate.HSVWithHSV` (v4 addition) for smooth hue transitions via HSV color space interpolation

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `Math.TAU` value change from PI/2 to PI*2 is a breaking change from v3; `Math.PI_OVER_2` is v4-only

## Known Gaps / Notes
`Matrix3` and `Quaternion` are mentioned in the source file map but not covered in depth — they're primarily used for 3D/shader work. `Phaser.Math.GetVec2Bounds` (replacing v3's `Point.GetRectangleFromPoints`) is in the v3-to-v4 migration skill. The `Power-of-Two` sub-namespace (`GetPowerOfTwo`, `IsValuePowerOfTwo`) is documented for texture size validation.
