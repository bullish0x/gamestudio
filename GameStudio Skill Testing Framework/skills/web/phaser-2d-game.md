# Skill Test Spec: /phaser-2d-game

> **Category**: web · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The primary execution-path skill for 2D browser games in this plugin. It establishes the Phaser + TypeScript + Vite preferred stack and four architectural principles: gameplay state lives outside Phaser scenes, scenes are thin (Boot/Preload, Menu, Gameplay, optional Overlay/Debug), renderer-facing objects (sprites, tweens, emitters) are disposable view state, and asset manifest keys are the only stable reference in gameplay code. It specifies the covered 2D modes (turn-based grids, top-down, side-view platformers, character-action combat, lightweight management), camera model choice guidance, DOM-overlay-first UI policy for HUD and menus, and an asset folder convention. Anti-patterns include game rules in `update()` loops, scene-to-scene mutable global state, and HUD text in the game canvas.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-2d-game` and a `description`
- [ ] Description names trigger keywords (Phaser, TypeScript, Vite, scenes, gameplay systems, cameras, sprite animation, DOM-overlay HUD)
- [ ] No implementation code blocks are required (this is an architectural guidance skill); body should be prose and lists
- [ ] An `## Architecture` section with at least 4 numbered principles is present
- [ ] A `## 2D Modes Covered Well` section listing at least 5 mode types is present
- [ ] A `## UI Integration` section with DOM-overlay guidance is present
- [ ] An `## Anti-Patterns` section is present
- [ ] A `## References` section citing `web-game-foundations` and `phaser-architecture.md` is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Architecture principle 1 states gameplay state (rules, turn order, movement, combat, inventory, progression) belongs outside Phaser scenes
- [ ] Architecture principle 2 specifies four scene roles: Boot/Preload, Menu/Shell, Gameplay, and optional Overlay/Debug
- [ ] Architecture principle 3 identifies sprite containers, emitters, tweens, and camera rigs as disposable view state, not source of truth
- [ ] Architecture principle 4 mandates stable asset manifest keys over direct file-path references
- [ ] `## Implementation Guidance` recommends one integration boundary where the scene reads simulation state and emits input actions back
- [ ] Camera model guidance lists at least four options: locked, follow, room-based, and tactical-pan
- [ ] UI Integration explicitly prohibits shoving dense text or complex settings into Phaser unless the project requires in-canvas presentation
- [ ] Asset folder convention lists `characters/`, `environment/`, `ui/`, `fx/`, `audio/`, and `data/`
- [ ] Anti-Patterns list includes game rules inside `update()` loops and scene-to-scene state via mutable global objects

## Version Awareness
- [ ] The skill specifies Phaser as the framework but does not pin a version number. Verify the installed Phaser version in the project's `package.json` — Phaser 4 API changes (scene lifecycle, GameObjects, loader) differ significantly from Phaser 3. Flag any Phaser 3-specific API usage against the installed version.

## Known Gaps / Notes
- The skill defers all concrete implementation details to `references/phaser-architecture.md` — verify this file exists in the project.
- No code examples are provided by design; the skill governs architecture choices, not Phaser API usage. For Phaser-specific patterns, consult the `phaser-*` specialist skills.
