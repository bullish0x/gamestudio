# Skill Test Spec: /pixi

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi` skill is the entry-point router for the entire PixiJS v8 skill collection. It does not teach a specific API but instead maps task descriptions to the correct specialized sub-skill. It triggers on any PixiJS keyword (pixi, pixijs, Application, Sprite, Container, Graphics, Assets, Ticker, WebGL, WebGPU, etc.) and instructs the agent to load the matching sub-skill or fall back to WebFetch of the live PixiJS llms.txt API index. This skill is the top-level dispatch layer, not an implementation guide.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi` and a `description`
- [ ] Description names concrete trigger keywords covering the full PixiJS surface (Application, Sprite, Container, Assets, Ticker, etc.)
- [ ] Body contains at least one fenced code example (not present — router skill has none by design; verify this is acceptable or flag as gap)
- [ ] Contains a "Skill router" section with Markdown tables mapping each sub-skill to its load condition
- [ ] Contains a "Fallback" section instructing WebFetch of `https://pixijs.download/release/docs/llms.txt`
- [ ] References a `references/index.md` file inside the skill directory

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Router table covers the "Foundations" category with entries for `pixi-application`, `pixi-core-concepts`, `pixi-create`, `pixi-environments`, `pixi-migration-v8`, and `pixi-scene-core-concepts`
- [ ] Router table covers the "Scene Objects" category with entries for all seven leaf skills (`pixi-scene-container`, `pixi-scene-sprite`, `pixi-scene-graphics`, `pixi-scene-text`, `pixi-scene-mesh`, `pixi-scene-particle-container`, `pixi-scene-dom-container`, `pixi-scene-gif`)
- [ ] Router table covers the "Utilities" category with entries for `pixi-assets`, `pixi-color`, `pixi-events`, `pixi-math`, `pixi-ticker`
- [ ] Router table covers the "Advanced" category with entries for `pixi-accessibility`, `pixi-blend-modes`, `pixi-custom-rendering`, `pixi-filters`, `pixi-performance`
- [ ] Each router entry specifies a "Load when..." condition tied to a concrete class or task description
- [ ] Fallback section instructs WebFetch of `https://pixijs.download/release/docs/llms.txt` specifically
- [ ] Skill instructs the agent to load sub-skill SKILL.md files, not to answer from this file directly

## Version Awareness
- [ ] Aligns with PixiJS v8 (all sub-skills linked are v8 variants); flags that `app.init` is async and the router should not be used for v7 patterns

## Known Gaps / Notes
This skill has no code examples by design — it is a pure router. A tester should verify that the router table is exhaustive (25 sub-skills total) and that the fallback URL is current. The `references/index.md` link should be verified to exist in the skill directory.
