# Skill Test Spec: /pixi-scene-container

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-scene-container` skill teaches the full `Container` API in PixiJS v8 — the general-purpose grouping node of the scene graph. It covers constructor options (all ~30 fields including `isRenderGroup`, `sortableChildren`, `boundsArea`, `origin`), child management (`addChild`, `removeChild`, `addChildAt`, `swapChildren`, `setChildIndex`, `removeChildren`, `reparentChild`, `replaceChild`), all transform properties (`position`, `scale`, `rotation`, `angle`, `pivot`, `origin`, `skew`, `alpha`, `tint`, `visible`, `renderable`), `zIndex` + `sortableChildren` sorting, `getBounds()` returning `Bounds` (not Rectangle), `toGlobal`/`toLocal`/`getGlobalPosition`, `setSize`/`getSize`, container lifecycle events, `onRender` per-frame hook, label/`getChildByLabel`/`getChildrenByLabel`, `getLocalBounds`, `removeFromParent`, and `destroy` with options. Triggers on: Container, addChild, removeChild, zIndex, sortableChildren, getBounds, toGlobal, toLocal, onRender, destroy.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-scene-container` and a `description`
- [ ] Description names concrete trigger keywords (Container, addChild, sortableChildren, zIndex, getBounds, toGlobal, onRender)
- [ ] Body contains at least one fenced code example showing `new Container({ label, sortableChildren })` with `addChild` and transform properties
- [ ] Contains a "Common Mistakes" section with [CRITICAL] severity for adding children to leaf scene objects
- [ ] References `skills/pixijs-scene-core-concepts/references/constructor-options.md` for the full options list

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents `origin` as distinct from `pivot`: `origin` changes the rotation/scale center without displacing the object; `pivot` shifts both the transform origin and the visual position
- [ ] Covers that `addChildAt` with an existing child silently moves it (no `added`/`childAdded` events fire)
- [ ] Covers `reparentChild`/`reparentChildAt` for world-transform-preserving reparenting and `replaceChild` for in-place swap
- [ ] Covers `getBounds()` returning a `Bounds` object with `.rectangle` getter for `Rectangle`-specific APIs
- [ ] Documents container lifecycle events: `childAdded`, `childRemoved`, `added`, `removed`, `visibleChanged`, `destroyed` with their argument signatures
- [ ] Covers `onRender` as the v8 replacement for overriding `updateTransform` (which was removed)
- [ ] Covers `boundsArea` forced-bounds optimization for containers with many predictable children
- [ ] Covers `isRenderGroup: true` and warns not to overuse it — profile before promoting

## Version Awareness
- [ ] Aligns with PixiJS v8; flags `getBounds()` returns `Bounds` not `Rectangle`; flags `cacheAsBitmap` renamed to `cacheAsTexture()`; flags `container.name` deprecated in favor of `container.label`

## Known Gaps / Notes
The skill notes that `destroyed` fires after internal cleanup (position, scale, pivot, origin, skew, parent are nulled; children array is emptied). Testers should verify this behavior is clearly documented so users know not to read container state inside a `destroyed` handler. The `sortChildren()` manual call is mentioned for explicit control beyond automatic sorting.
