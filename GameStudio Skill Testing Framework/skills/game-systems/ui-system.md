# Skill Test Spec: /ui-system

> **Category**: game-systems · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a DOM-overlay UI system for 3D games. `UIElement` wraps an `HTMLElement` created from a type discriminant (`healthBar`, `label`, `image`, `button`, `panel`) with show/hide/remove lifecycle, position/content/health-bar update methods, and a color-coded fill bar (green/yellow/red at 60%/30% thresholds). `UIManager` creates and tracks elements by string ID, injects a `<style>` block with CSS classes, provides `worldToScreen` projection via camera, and exposes `clear`/`hide`/`show` for the entire overlay. `UISystem` runs at priority 70 (late update), drives world-anchored health bars and labels by projecting entity transforms each frame. `HUDManager` creates a fixed three-element HUD (health bar, score, ammo). `MenuSystem` creates button grids centered on screen and manages single-active-menu exclusion. A floating damage number example demonstrates position animation with `requestAnimationFrame`.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: ui-system` and a `description`
- [ ] Description names trigger keywords (HUD elements, menus, health bars, damage numbers, UI state management)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Six named implementation sections are present (UI Components, UI Manager, UI System, UI Components for Entities, HUD Manager, Menu System)
- [ ] A `## Checklist` section is present with world-to-screen, responsive, and cleanup items
- [ ] A `## Performance Tips` section addresses batching DOM updates and CSS transforms for animation

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `UIElement.updateHealthBar` changes fill width as percentage and updates background color in three bands
- [ ] `UIManager` creates its container `div` if it does not exist, with `pointer-events: none` to allow click-through
- [ ] `UIManager.worldToScreen` uses `worldPos.clone().project(camera)` and maps NDC to pixel coordinates
- [ ] `UISystem.updateHealthBars` repositions world-anchored health bars by calling `worldToScreen` each frame
- [ ] `UISystem` runs at priority 70, placing it after physics (20), AI (30), combat (35), and camera (65) systems
- [ ] `HUDManager` creates a `healthBar` element at position `(20, 20)` with size `(200, 20)` on construction
- [ ] `MenuSystem.showMenu` hides the currently active menu before showing the requested menu
- [ ] Floating damage number example decrements opacity and moves element upward over 1 second via `requestAnimationFrame`
- [ ] CSS `ui-button` class sets `pointer-events: auto` to re-enable interaction within the otherwise non-interactive overlay

## Version Awareness
- [ ] `UIManager.worldToScreen` uses `THREE.Vector3.project(camera)` — verify the installed Three.js version's `.project` signature accepts a `THREE.Camera` parameter (changed between r100 and r125; now requires the camera argument).

## Known Gaps / Notes
- `UIElement.updatePosition` sets inline `left`/`top` style which triggers layout reflow. The Performance Tips section recommends CSS `transform: translate()` instead for hardware-accelerated positioning — but the implementation does not use this approach.
- `MenuSystem` stores element IDs per menu in a `Map<string, string[]>` but does not track which elements belong to nested sub-menus; showing a parent menu does not hide its children automatically.
