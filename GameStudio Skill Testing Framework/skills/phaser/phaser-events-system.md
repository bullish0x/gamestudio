# Skill Test Spec: /phaser-events-system

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers the eventemitter3-based `Phaser.Events.EventEmitter` pattern used throughout Phaser 4, including the full API (`on`, `once`, `off`, `emit`, `removeAllListeners`, `listeners`, `listenerCount`, `eventNames`), named event constants for all major namespaces (Scene, Game, Input, Loader, Animations, Camera, Sound, Tweens, Arcade Physics, Textures, GameObjects, Time), key-suffix event patterns (`filecomplete-image-logo`, `animationcomplete-walk`), context binding, memory leak prevention, and inter-scene communication patterns. It triggers whenever a developer works with events, listeners, EventEmitter, or scene lifecycle events.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-events-system` and a `description`
- [ ] Description names trigger keywords: `events`, `on`, `emit`, `EventEmitter`, `scene events`, `listeners`
- [ ] Body contains code showing both `on()` (persistent) and `once()` (auto-remove) usage
- [ ] Named event constants (e.g. `Phaser.Scenes.Events.UPDATE`) are shown preferred over raw strings
- [ ] Event namespace reference tables covering at least Scene, Game, Input, Loader, and Animation events are present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents the key-suffix event pattern: `Phaser.Loader.Events.FILE_KEY_COMPLETE + 'image-logo'` evaluates to `'filecomplete-image-logo'`
- [ ] Explains context (third argument to `on`/`once`) and notes arrow functions ignore context; regular functions need `this` passed explicitly
- [ ] Documents that `off()` requires the exact same function reference AND same context used with `on()`; anonymous arrow functions cannot be removed
- [ ] Documents the memory leak: calling `on()` in `create()` without cleanup in `shutdown` duplicates listeners on scene restart; shows correct SHUTDOWN cleanup pattern
- [ ] Distinguishes `this.events` (scene-specific, cleaned with scene) from `this.game.events` (global, persists across restarts; must be cleaned on SHUTDOWN)
- [ ] Documents that `SHUTDOWN` fires when a scene stops but can restart; `DESTROY` fires for permanent removal; scene restart fires SHUTDOWN then START then CREATE (NOT DESTROY)
- [ ] Documents all three inter-scene communication methods: `game.events` global bus, `this.registry` DataManager, and `this.scene.get('OtherScene').events`
- [ ] Documents the input event hierarchy order: (1) gameobject's own event, (2) scene `gameobjectdown`, (3) scene `pointerdown`
- [ ] Documents `Phaser.Events.EventEmitter` `shutdown()` and `destroy()` both call `removeAllListeners()`
- [ ] Documents `Phaser.Textures.Events.ADD_KEY + 'myTexture'` pattern for cross-scene texture load notification

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask); flags any API to verify against the installed version
- [ ] Event constants are stable across v3/v4; no major changes; verify `Phaser.Scenes.Events.ADDED_TO_SCENE` and `REMOVED_FROM_SCENE` availability

## Known Gaps / Notes
The skill covers 13 event namespaces comprehensively. Video game object events (`VIDEO_PLAY`, `VIDEO_COMPLETE`, etc.) are listed in the GameObjects section. The `Phaser.Time.Events.COMPLETE` for Timeline is documented. The frame-loop event order (`preupdate` -> `update` -> `postupdate` -> `prerender` -> `render`) is documented in Scene Events.
