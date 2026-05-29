# Skill Test Spec: /threejs-raycasting

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a complete raycasting toolkit for Three.js: a `RaycastManager` that wraps `THREE.Raycaster` with NDC pointer normalisation for both mouse and touch, a `ClickHandler` that distinguishes click from drag via a pixel threshold and emits `onClick` / `onHover` / `onHoverEnd` callbacks, and a `DragDropManager` that constrains dragged objects to a camera-facing `THREE.Plane`. Triggered when implementing object picking, 3D UI interaction, collision tests, or drag-and-drop mechanics.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-raycasting` and a `description`
- [ ] Description names mouse/touch picking and NDC normalisation as trigger topics
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has a checklist item for reusing a single raycaster instance
- [ ] Body has a "Performance Tips" section recommending event-driven (not per-frame) casting

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Pointer NDC formula `((clientX - rect.left) / rect.width) * 2 - 1` is present for X
- [ ] Pointer NDC formula `-((clientY - rect.top) / rect.height) * 2 + 1` is present for Y
- [ ] `raycaster.setFromCamera(pointer, camera)` is called before `intersectObjects`
- [ ] Layer filtering is demonstrated via `raycaster.layers.disableAll()` + `enable(layer)`
- [ ] `dragThreshold` in pixels separates click from drag in `ClickHandler`
- [ ] `DragDropManager` sets the drag plane via `THREE.Plane.setFromNormalAndCoplanarPoint`
- [ ] All `addEventListener` calls are matched with corresponding `removeEventListener` in `dispose()`
- [ ] `recursive: false` is flagged as a performance option for flat scene graphs

## Version Awareness
- [ ] Aligns with pinned three 0.184 (raycasting API unchanged); verify `THREE.Raycaster` constructor signature if using near/far shorthand constructor overload

## Known Gaps / Notes
- No spatial-partitioning integration (octree, BVH) is shown; important for scenes with thousands of objects.
- `ClickHandler.isChildOf()` traverses ancestors recursively; could be replaced with `object.traverseAncestors` for clarity.
