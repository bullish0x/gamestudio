# Skill Test Spec: /phaser-scenes

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers Phaser 4's Scene system: the 10 lifecycle states (PENDING through DESTROYED), the 4 lifecycle methods (`init`, `preload`, `create`, `update`), all injected scene properties (global managers like `this.anims`/`this.textures` vs scene-specific like `this.add`/`this.cameras`), the `ScenePlugin` (`this.scene`) for start/stop/launch/run/sleep/wake/pause/resume/switch/restart/transition, render order control (`bringToTop`, `moveAbove`), cross-scene communication methods, the `InjectionMap` for custom property names, plugin configuration per scene, and the SHUTDOWN vs DESTROY lifecycle distinction. It triggers on scene lifecycle, transitions, parallel scenes, or SceneManager operations.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-scenes` and a `description`
- [ ] Description names trigger keywords: `Scene`, `scene lifecycle`, `preload`, `create`, `update`, `scene transition`, `SceneManager`
- [ ] Body contains a minimal scene class extending `Phaser.Scene` with all four lifecycle methods
- [ ] All injected scene properties (global vs scene-specific) are documented
- [ ] Lifecycle events table with all state-change events (`PAUSE`, `RESUME`, `SLEEP`, `WAKE`, `SHUTDOWN`, `DESTROY`) is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents all 10 scene states (PENDING=0 through DESTROYED=9) with their meaning
- [ ] Documents frame loop event order: `preupdate` → `update` → scene `update()` → `postupdate` → `prerender` → `render`
- [ ] Distinguishes `start()` (shuts down current, starts target) from `launch()` (parallel, doesn't stop current) from `run()` (start if not running, resume if paused, wake if sleeping)
- [ ] Documents that all ScenePlugin operations are QUEUED, not immediate; take effect at next SceneManager update
- [ ] Documents `switch()` sleeps current scene (preserves state) while `start()` fully shuts down; notes `switch()` restarts a paused scene rather than resuming
- [ ] Documents `pause()` stops update but still renders; `sleep()` stops BOTH update and render
- [ ] Documents that sleeping scenes can still receive events from other scenes (registry listeners still fire)
- [ ] Documents state reset pattern: `init()` runs every start/restart; constructor runs once; use `init()` for state resets NOT the constructor
- [ ] Documents `this.scene.start()` with no key restarts the current scene (equivalent to `restart()`)
- [ ] Documents render order: scenes later in array render on top; updates in reverse order (top scene updates first for input priority); use `bringToTop`/`sendToBack`/`moveAbove`/`moveBelow` to reorder

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `this.physics` and `this.matter` are undefined unless the respective physics system is configured; verify which scenes have physics enabled

## Known Gaps / Notes
The `InjectionMap` for renaming injected properties (e.g. `map: { add: 'makeStuff' }`) is documented. The Scene payload `pack` config for pre-preload loading is covered. Plugin selection per scene via `plugins: ['Loader']` is documented. The `this.scene.get('OtherScene')` pattern for direct scene property access is covered in cross-scene communication.
