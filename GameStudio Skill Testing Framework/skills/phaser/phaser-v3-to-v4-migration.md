# Skill Test Spec: /phaser-v3-to-v4-migration

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill is a comprehensive migration guide for upgrading Phaser v3 projects to v4. It covers the 21 breaking change categories in priority order: renderer Pipelines → RenderNodes, Canvas deprecation, FX/BitmapMask → Filters, tint system overhaul, camera matrix changes, GL texture orientation flip, DynamicTexture command-buffer architecture, Shader API rewrite, GLSL loading changes, lighting (`setPipeline('Light2D')` → `setLighting(true)`), TileSprite improvements, Graphics/Shape changes, `Geom.Point` → `Vector2`, `Math.TAU` value correction (PI/2 → PI*2), data structure replacements (Struct.Set/Map → native Set/Map), `roundPixels` default change, removed game objects (Mesh, Plane), removed plugins (Camera3D, Layer3D, Facebook), removed utilities (Create.GenerateTexture, polyfills), Spine plugin changes, and miscellaneous breaking changes. It triggers on migrate, upgrade, v3 to v4, breaking changes, or migration guide questions.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-v3-to-v4-migration` and a `description`
- [ ] Description names trigger keywords: `migrate`, `upgrade`, `v3 to v4`, `breaking changes`, `Phaser 3 to 4`, `migration guide`
- [ ] Body contains a numbered migration checklist with at least 20 checkboxes
- [ ] A table mapping v3 FX to v4 filter replacements is present
- [ ] A `Math.TAU` correction table showing old value (PI/2) vs new value (PI*2) is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents Pipeline → RenderNode change and that only custom WebGL pipeline authors need to rewrite; standard API users are unaffected
- [ ] Documents `BitmapMask` removal and `filterMask` replacement: `sprite.filters.internal.addMask(maskObject)`
- [ ] Documents `setTintFill(color)` removal and replacement: `setTint(color).setTintMode(Phaser.TintModes.FILL)`
- [ ] Documents `Math.TAU` value change: was PI/2 in v3 (WRONG), now PI*2 in v4 (CORRECT); `Math.PI2` removed; `Math.PI_OVER_2` added for PI/2
- [ ] Documents `Phaser.Struct.Set` replaced by native JavaScript `Set`; `Phaser.Struct.Map` replaced by native `Map`; removed methods like `iterateLocal`, `contains`, `setAll`
- [ ] Documents DynamicTexture breaking change: draw commands no longer execute immediately; must call `render()` to flush command buffer
- [ ] Documents texture Y-axis GL orientation change: compressed textures must be re-compressed with Y=0 at bottom; standard PNG/JPG handled automatically
- [ ] Documents camera matrix change: `Camera#matrix` now includes scroll; `Camera#matrixExternal` for position only; `Camera#matrixCombined` for both
- [ ] Documents `roundPixels` default changed from `true` (v3) to `false` (v4); `vertexRoundMode` property is new in v4
- [ ] Documents `Mesh` and `Plane` game objects removed in v4 (proper 3D planned for future)

## Version Awareness
- [ ] This skill IS the version awareness guide; all documented changes are specific to the v3→v4 transition
- [ ] All APIs documented here require verification against the specific v4 build in use

## Known Gaps / Notes
The skill is organized from highest-impact (renderer, FX, masks) to smaller details. `DOMElement` now throws if it has no container — this is documented in Miscellaneous. `Shader` game object constructor changed to `ShaderQuadConfig` config object — documented. Spine 3/4 plugin removal and redirect to official Esoteric Software plugin is documented.
