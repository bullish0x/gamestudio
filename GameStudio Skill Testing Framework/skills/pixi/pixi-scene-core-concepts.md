# Skill Test Spec: /pixi-scene-core-concepts

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-scene-core-concepts` skill is the shared mental model for all `pixi-scene-*` skills. It covers the scene graph tree structure rooted at `app.stage`, the critical container-vs-leaf distinction (Containers hold children; leaves draw things and must not have children), local vs world coordinate spaces, render order (array index = draw order), `sortableChildren` + `zIndex` for explicit z-ordering, `RenderLayer` for hierarchy-decoupled render order, `isRenderGroup: true` for GPU-level transform caching, masking (stencil, alpha, scissor, color), `cullable`/`cullArea`/`cullableChildren`, visibility/alpha/tint/blend mode inheritance, destroy semantics, lifecycle events, and a leaf comparison table mapping each display object class to its specialized skill. Triggers on: scene graph, Container, Sprite, Graphics, RenderLayer, masking, render group, world transform, constructor options.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-scene-core-concepts` and a `description`
- [ ] Description names concrete trigger keywords (scene graph, Container, RenderLayer, masking, render group, world transform)
- [ ] Body contains at least one fenced code example showing `isRenderGroup: true` and `container.mask = graphics`
- [ ] Contains a leaf comparison table mapping each display object type to its specialized skill
- [ ] Contains a "References" section listing at least 6 sub-reference files (constructor-options, container-hierarchy, transforms, masking, layers, render-groups, scene-management)
- [ ] Mentions the PixiJS Devtools Chrome extension for scene graph inspection

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Establishes the CRITICAL rule: leaves (`Sprite`, `Graphics`, `Text`, `Mesh`, `ParticleContainer`, `DOMContainer`, `GifSprite`) must not have children; adding children logs a deprecation warning and will become an error
- [ ] Covers `DisplayObject` removal — all display objects are `Container` subclasses in v8
- [ ] Documents render order: earlier siblings draw behind later siblings (index 0 = drawn first)
- [ ] Covers `RenderLayer` for decoupled render order where children keep logical parent but render at a different z
- [ ] Covers masking with all four types: stencil (Graphics/Container mask), alpha (Sprite mask), scissor (axis-aligned Rectangle), color mask (number)
- [ ] Explains `visible = false` (skips render AND transform updates) vs `renderable = false` (skips render, keeps transforms live)
- [ ] Routes each leaf type to its specialized skill: Sprite, Text/BitmapText/HTMLText, Graphics, Mesh, ParticleContainer, DOMContainer, GifSprite
- [ ] References `references/constructor-options.md` as the shared canonical option reference for all scene nodes

## Version Awareness
- [ ] Aligns with PixiJS v8 scene graph; flags `DisplayObject` removal and the `allowChildren = false` leaf enforcement as v8-specific

## Known Gaps / Notes
Deep topics (masking types, RenderLayer API, transform matrices, scene management) are deferred to reference files. Testers should verify that `references/masking.md`, `references/layers.md`, `references/render-groups.md`, and `references/scene-management.md` all exist in the skill directory.
