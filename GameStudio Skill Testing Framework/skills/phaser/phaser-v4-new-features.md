# Skill Test Spec: /phaser-v4-new-features

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill documents features that are new or exclusive to Phaser 4: the RenderNode graph architecture (replacing Pipelines), the unified Filters system (replacing FX/BitmapMask), new game objects (`CaptureFrame`, `Gradient`, `Noise`/`NoiseCell2D/3D/4D`/`NoiseSimplex2D/3D`, `SpriteGPULayer`, `Stamp`, `TilemapGPULayer`), new components (`Lighting`, `RenderSteps`, `RenderNodes`), 6 new tint modes (`MULTIPLY`, `FILL`, `ADD`, `SCREEN`, `OVERLAY`, `HARD_LIGHT`), 13 new filters (Blend, Blocky, CombineColorMatrix, GradientMap, ImageLight, Key, Mask, NormalTools, PanoramaBlur, ParallelFilters, Quantize, Sampler, Threshold), GL orientation standardization, and removal of `Point`/`Mesh`/`Plane`. It triggers on "new in v4", Phaser 4 features, RenderNode, SpriteGPULayer, CaptureFrame, Gradient, or Noise game object questions.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-v4-new-features` and a `description`
- [ ] Description names trigger keywords: `new in v4`, `Phaser 4 features`, `RenderNode`, `SpriteGPULayer`, `CaptureFrame`, `Gradient game object`, `Noise game object`, `new tint modes`
- [ ] Body contains a Key Removals and Key Additions summary table
- [ ] Each new game object (`CaptureFrame`, `Gradient`, `Noise` variants, `SpriteGPULayer`) has its own subsection with a code example
- [ ] RenderNode architecture is documented with built-in node types table

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents that `CaptureFrame` requires `camera.setForceComposite(true)` and captures everything rendered above it in the display list
- [ ] Documents `SpriteGPULayer` use case: up to 100x faster than individual sprites by storing data in a static GPU buffer in a single draw call; single texture only; updating buffer is expensive so populate once
- [ ] Documents Gradient game object: extends `Shader`; supports linear/radial/custom shape modes; configured via `GradientQuadConfig` with `bands`, `shapeMode`, `repeatMode`; requires `gradient.ramp.encode()` after runtime ramp modification
- [ ] Documents all 6 Noise game object variants and their use cases: `Noise` (white), `NoiseCell2D/3D/4D` (cellular/Voronoi), `NoiseSimplex2D/3D` (organic clouds/fire/water); all extend Shader; all WebGL only
- [ ] Documents `Lighting` component: `setLighting(true)` replaces v3's `setPipeline('Light2D')`; `setSelfShadow(enabled, penumbra, diffuseFlatThreshold)` for surface shadow simulation; lighting changes shader breaking batches
- [ ] Documents `RenderSteps` component: allows injecting custom logic into render process; Filters system uses this internally; steps stored in `_renderSteps` array
- [ ] Documents RenderNode custom registration: `renderer.renderNodes.addNodeConstructor('MyNode', MyNodeClass)` or `addNode('MyNode', instance)`; game object role override via `setRenderNodeRole('Submitter', 'MyCustomSubmitter')`
- [ ] Documents `TilemapGPULayer` capabilities vs restrictions vs `TilemapLayer`; highlights that editing requires `generateLayerDataTexture()` call
- [ ] Documents the GL orientation change: Y=0 at bottom in v4; custom shaders must use GL conventions; compressed textures need Y-flip recompression
- [ ] Documents new tint modes and how the `tintMode` property is separate from `tint` color; tint system is more expressive than v3's binary fill/multiply

## Version Awareness
- [ ] All features documented in this skill are v4-only by definition
- [ ] Skill correctly notes that `Mesh`/`Plane` are removed; proper 3D support is planned for a future version

## Known Gaps / Notes
The `Stamp` game object (lightweight Image ignoring camera scroll, used internally by DynamicTexture) is documented briefly. The `ShaderQuad` render node for custom shader game objects is in the built-in node types list. `Phaser.Math.Hash()`, `HashCell()`, and `HashSimplex()` as Math equivalents to Noise game objects are documented.
