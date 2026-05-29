# Skill Test Spec: /web-game-foundations

> **Category**: web · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
An architectural framing skill that establishes the non-negotiable design decisions before browser-game implementation begins: simulation/rendering boundary (simulation owns state, renderer owns scene), explicit input action mapping, asset manifest key discipline (GLB/glTF 2.0 as the 3D default), save/debug/perf boundaries, DOM-overlay-first for HUD and menus, and early 3D runtime convention locks (units, pivots, collision proxies). It provides an engine selection rubric (Phaser for 2D arcade flows, vanilla Three.js for explicit 3D control, React Three Fiber for React-app integration, raw WebGL only when engine abstractions would interfere) and an implementation checklist of 11 decisions to make before writing core code.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: web-game-foundations` and a `description`
- [ ] Description names trigger keywords (engine choice, simulation and render boundaries, input model, asset organization, save/debug/performance strategy)
- [ ] No fenced code blocks are required (this is a pure architecture/guidance skill); the body should contain only prose and lists
- [ ] A `## Architecture Rules` section with at least 6 numbered rules is present
- [ ] An `## Engine Selection` section explicitly names Phaser, Three.js, React Three Fiber, and raw WebGL
- [ ] An `## Implementation Checklist` section listing pre-code decisions is present
- [ ] An `## Anti-Patterns` section listing common mistakes is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Rule 1 separates simulation ownership (entities, turns, collisions, progression, saveable state) from renderer ownership (scene composition, camera, particles)
- [ ] Rule 3 requires 3D content to default to GLB or glTF 2.0 and use stable manifest keys grouped by domain
- [ ] Rule 5 states DOM overlays should handle text-heavy HUD, menus, and accessibility-sensitive controls while canvas handles the playfield
- [ ] Engine selection recommends Phaser specifically for sprites, tilemaps, top-down/side-view action, turn-based grids, and classic browser arcade flows
- [ ] Engine selection recommends vanilla Three.js for projects wanting direct scene, camera, renderer, and loop control in plain TypeScript/Vite
- [ ] Engine selection recommends React Three Fiber when the 3D scene lives inside a React application
- [ ] Implementation Checklist includes camera model, input action map, simulation modules, renderer modules, asset manifest layout, and save data boundary
- [ ] Anti-Patterns list includes mixing gameplay rules into scene callbacks and treating the renderer as the source of truth for game state
- [ ] At least four `references/` file paths are cited for follow-on context (engine-selection.md, phaser-architecture.md, three-webgl-architecture.md, web-3d-asset-pipeline.md)

## Version Awareness
- [ ] The skill is engine-agnostic architectural guidance; no library version pinning is required. Verify that the referenced `references/engine-selection.md` file exists in the project at the cited path before running skill tests.

## Known Gaps / Notes
- The skill explicitly states it should hand off to runtime-specific skills once the engine is chosen — it is not intended to be used as a recurring reference during implementation.
- No code examples are provided by design; the skill's value is in architecture decisions, not implementation patterns.
