# Skill Test Spec: /pixi-scene-dom-container

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-scene-dom-container` skill teaches `DOMContainer`, an EXPERIMENTAL PixiJS v8 feature for overlaying HTML elements on the canvas with their CSS transforms driven by the scene graph. It covers the `pixi.js/dom` side-effect import, `DOMContainerOptions` (`element`, `anchor`), CSS transform propagation, `alpha` → `style.opacity`, the shared root `<div>` via `app.domContainerRoot`, `ResizeObserver` alignment, visibility sync, destroy behavior (HTML element preserved), and important limitations (filters/masks/blendMode have no effect; must not nest PixiJS children; not available in Web Workers). Triggers on: DOMContainer, pixi.js/dom, DOMPipe, HTML overlay, input on canvas, iframe overlay, element, anchor.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-scene-dom-container` and a `description`
- [ ] Description names concrete trigger keywords (DOMContainer, pixi.js/dom, DOMPipe, HTML overlay, element, anchor)
- [ ] Body contains at least one fenced code example showing `new DOMContainer({ element: input, anchor: 0.5 })`
- [ ] Contains an EXPERIMENTAL callout or note about the unstable API status
- [ ] Contains a "Common Mistakes" section covering filters/masks having no effect on DOM elements
- [ ] Contains an "API Reference" section linking to `DOMContainer`, `DOMContainerOptions`, `ViewContainer`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents both import forms: `import 'pixi.js/dom'` side-effect and `import { DOMContainer } from 'pixi.js/dom'` named export
- [ ] Explains that the default `pixi.js` browser bundle already includes `pixi.js/dom` automatically; explicit import only needed with `skipExtensionImports: true`
- [ ] Documents `anchor` behavior: `0` = top-left, `0.5` = centered, `1` = bottom-right; single number or `{ x, y }` object
- [ ] Explains that `alpha` (including inherited parent alpha) is written to `style.opacity` every frame
- [ ] Covers `app.domContainerRoot` and the recommendation to append it next to `app.canvas` for explicit DOM placement
- [ ] Documents `visible = false` / remove from scene = element detached from DOM; `destroy()` removes element but HTML element reference is preserved
- [ ] Explicitly states that PixiJS `filters`, `mask`, and `blendMode` on `DOMContainer` have no visual effect (use CSS directly)
- [ ] States DOMContainer is not available in Web Workers (no real DOM to overlay)

## Version Awareness
- [ ] Aligns with PixiJS v8 (EXPERIMENTAL in v8); API may change in minor releases; verify against installed version

## Known Gaps / Notes
The skill notes that `tint`, `filters`, `mask`, and `blendMode` are accepted by the constructor (inherited from Container) but have no visual effect. This is a potentially confusing API surface. Testers should confirm this is explicitly called out so users don't waste time trying CSS-via-PixiJS. All DOM elements live above canvas content — interleaving DOM elements between draw calls is not possible.
