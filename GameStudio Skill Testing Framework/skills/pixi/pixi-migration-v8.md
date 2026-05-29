# Skill Test Spec: /pixi-migration-v8

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-migration-v8` skill is a breaking-change checklist for upgrading from PixiJS v7 to v8. It covers all major migration categories: async `app.init()`, single `pixi.js` package replacing all `@pixi/*` core sub-packages, Graphics shape-then-fill API (`rect`/`circle`/`fill`/`stroke`/`cut` replacing `beginFill`/`drawRect`/`endFill`/`beginHole`), Text options-object constructor, Sprite/Mesh/ParticleContainer API renames (`NineSlicePlane` → `NineSliceSprite`, `SimpleMesh` → `MeshSimple`, `MeshGeometry` options object), event system (`eventMode` replaces `interactive`), Ticker callback signature (receives Ticker instance not delta number), shader/filter rework (`{gl, resources}` options + typed uniforms), `DisplayObject` removal, enum constants to string literals, `settings`/`utils` namespace removal, `DOMAdapter` replacing `settings.ADAPTER`, and texture UV update requirements. Triggers on: migrate v7, v8 breaking changes, @pixi/ import, DisplayObject, beginFill, cacheAsBitmap, BaseTexture.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-migration-v8` and a `description`
- [ ] Description names concrete trigger keywords (migrate v7, @pixi/ import, DisplayObject, beginFill, endFill, cacheAsBitmap)
- [ ] Body contains a migration checklist section (checkbox list format)
- [ ] Contains a table mapping v7 shape method names to v8 equivalents (`drawRect` → `rect`, etc.)
- [ ] Contains a table mapping v7 enum constants to v8 string literals (`SCALE_MODES.NEAREST` → `'nearest'`)
- [ ] Contains a "Common Mistakes" section with [CRITICAL] severity for importing from deprecated `@pixi/*` packages

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Lists all deprecated v7 core `@pixi/*` packages that must not be used (at least 20 packages listed)
- [ ] Covers `app.canvas` replacing `app.view` and async `app.init()` replacing synchronous constructor options
- [ ] Covers all Graphics renames: `drawRect`→`rect`, `drawCircle`→`circle`, `drawPolygon`→`poly`, `drawRoundedRect`→`roundRect`, `drawStar`→`star`, `drawRegularPolygon`→`regularPoly`
- [ ] Covers `cut()` replacing `beginHole()`/`endHole()`, and `GraphicsContext` replacing `GraphicsGeometry`
- [ ] Covers `ParticleContainer` using `Particle` + `addParticle` instead of `Sprite` + `addChild`
- [ ] Covers Ticker callback change: `(ticker) => { ticker.deltaTime }` not `(dt) => { dt }`
- [ ] Covers `DisplayObject` removal — `Container` is now the base class for everything
- [ ] Covers `sprite.onViewUpdate()` required after modifying `texture.frame` since sprites no longer auto-subscribe to UV changes
- [ ] Covers enum → string conversion table and notes these are TypeScript types only at runtime

## Version Awareness
- [ ] This skill is entirely about v7→v8 differences; all patterns in this skill are either v7 (wrong) or v8 (correct); no v7 code should be treated as valid in new projects

## Known Gaps / Notes
The skill notes that `container.name` → `container.label` and `cacheAsBitmap = true` → `cacheAsTexture(true)` are renamed properties with deprecated aliases. Testers should verify that `getBounds()` returning `Bounds` not `Rectangle` is documented (it is, under the "Other" section). The skill correctly notes supplemental packages like `@pixi/sound` are still valid (not deprecated).
