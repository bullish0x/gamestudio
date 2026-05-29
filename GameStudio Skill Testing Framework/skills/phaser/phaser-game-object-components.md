# Skill Test Spec: /phaser-game-object-components

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill documents the mixin-based component system in Phaser 4 where shared behaviors (Alpha, AlphaSingle, BlendMode, Depth, Flip, GetBounds, Lighting, Mask, Origin, ScrollFactor, Size, Texture, TextureCrop, Tint, Transform, Visible, PathFollower, RenderNodes, RenderSteps, Filters, FilterList) are copied onto game object prototypes at class-definition time. It covers the `renderFlags` bitmask, method chaining, `this.add` vs `this.make` factory/creator distinction, `GetAdvancedValue` for flexible config, display list ordering, and custom game object registration. It triggers when working with transforms, bounds, tinting, masking, or any shared game object behavior.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-game-object-components` and a `description`
- [ ] Description names trigger keywords: `component`, `mixin`, `transform`, `mask`, `bounds`, `lighting`
- [ ] Body contains a Quick Start code block calling multiple chainable component methods on a sprite
- [ ] Each major component (Alpha, Depth, Flip, GetBounds, Origin, ScrollFactor, Size, Tint, Transform, Visible) has its own subsection with properties and methods
- [ ] `this.add` vs `this.make` distinction is documented

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Explains `renderFlags` bitmask: bit 0=visible, bit 1=alpha, bit 2=scale, bit 3=texture; ALL bits must be set to render; alpha=0 and scale=0 each clear their bit preventing rendering
- [ ] Distinguishes `Alpha` (per-corner WebGL alpha) from `AlphaSingle` (single global alpha); documents which game objects use each (Containers use AlphaSingle)
- [ ] Documents `setTintMode(mode)` with v4 modes `MULTIPLY`, `FILL`, `ADD`, `SCREEN`, `OVERLAY`, `HARD_LIGHT` and notes `setTintFill()` is REMOVED in v4
- [ ] Documents `Mask` component is Canvas-only in v4; WebGL masking requires `enableFilters()` then `filters.internal.addMask()`; `setMask()` logs a warning in WebGL
- [ ] Documents `Lighting` component (v4 only): `setLighting(true)` replaces v3's `setPipeline('Light2D')`; `setSelfShadow(enabled, penumbra, diffuseFlatThreshold)`
- [ ] Explains `setSize()` vs `setDisplaySize()`: `setSize` changes internal dimensions (physics/frames), `setDisplaySize` changes rendered size by adjusting scale
- [ ] Documents `depth` vs display list position: `setDepth()` queues a sort (primary z-ordering); `setToTop()`/`setAbove()` reorder without changing `depth`; `depth` wins after next sort
- [ ] Documents `Transform.z` is NOT depth: z is for custom use, rendering order uses the `depth` component
- [ ] Documents `GetAdvancedValue` for flexible config: resolves static values, random arrays, randInt/Float ranges, and callback functions
- [ ] Documents custom Game Object factory registration via `Phaser.GameObjects.GameObjectFactory.register(key, fn)`

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `Lighting`, `RenderNodes`, `RenderSteps`, and `Filters`/`FilterList` components are v4-only additions
- [ ] `setTintFill()` removed in v4 — must use `setTint().setTintMode(Phaser.TintModes.FILL)`

## Known Gaps / Notes
The full component-to-game-object matrix (which objects include which components) is referenced as being in `references/REFERENCE.md` rather than directly in the skill. `TransformMatrix` is listed in the source file map but its API is only briefly mentioned through `getLocalTransformMatrix()` and `getWorldTransformMatrix()`.
