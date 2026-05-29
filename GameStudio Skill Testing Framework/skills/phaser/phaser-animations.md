# Skill Test Spec: /phaser-animations

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers sprite animation in Phaser 4 using the global `AnimationManager` (`this.anims`) and per-sprite `AnimationState` (`sprite.anims`). Topics include creating animations from spritesheets with `generateFrameNumbers` and atlases with `generateFrameNames`, playing/pausing/chaining, yoyo and repeat, per-frame duration, reverse playback, animation mixing (`addMix`), staggered playback, Aseprite support, JSON export/import, and all animation events. It triggers whenever a developer needs to create, play, or control sprite frame-based animations.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-animations` and a `description`
- [ ] Description names trigger keywords: `sprite animation`, `spritesheet`, `play animation`, `animation frames`
- [ ] Body contains at least one fenced code example calling `this.anims.create()` and `sprite.play()`
- [ ] A table or comparison distinguishing `AnimationManager` (global, `this.anims`) from `AnimationState` (per-sprite, `sprite.anims`) is present
- [ ] A Gotchas section exists

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Explains local vs global animation priority: local animation on a sprite overrides global AnimationManager lookup by the same key
- [ ] Documents `generateFrameNumbers` config properties: `start`, `end` (default -1 = last frame), `first`, `frames` (explicit array)
- [ ] Documents `generateFrameNames` config properties: `prefix`, `suffix`, `start`, `end`, `zeroPad`, `frames`
- [ ] Explains `frameRate` vs `duration` priority: if `frameRate` is set it wins; set only `duration` (leave `frameRate` null) to control total length
- [ ] Documents per-frame `duration` as additive to base `msPerFrame`, not a replacement
- [ ] Documents `yoyo: true` behavior: plays forward then backward, full cycle counts as one play
- [ ] Documents animation mixing via `addMix(animA, animB, delay)` and notes mixes only apply with `play()`, not `playAfterDelay`/`playAfterRepeat`
- [ ] Documents `staggerPlay(key, children, stagger, staggerFirst?)` for offsetting animation start across multiple sprites
- [ ] Documents the `animationcomplete-{key}` key-specific event pattern and notes `repeat: -1` never fires `animationcomplete`
- [ ] Documents Aseprite support via `this.load.aseprite` + `this.anims.createFromAseprite(key, tags?)`

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask); flags any API to verify against the installed version
- [ ] Notes that `AnimationState` convenience methods (`sprite.play()`, `sprite.chain()`, etc.) wrap `sprite.anims.*` and are available in v4

## Known Gaps / Notes
The skill does not elaborate on `PlayAnimationConfig.startFrame` or `getProgress()`/`setProgress()` for seeking mid-animation, though they appear in the API reference table. The `showBeforeDelay`, `showOnStart`, and `hideOnComplete` config flags are documented but not shown in a complete example.
