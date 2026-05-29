# Skill Test Spec: /pixi-scene-gif

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-scene-gif` skill teaches how to display animated GIFs in PixiJS v8 using `GifSprite`. It covers the required `import 'pixi.js/gif'` side-effect registration, `Assets.load` returning a `GifSource` (not a `Texture`), `GifSpriteOptions` (`source`, `autoPlay`, `loop`, `animationSpeed`, `autoUpdate`, `fps`, `onComplete`, `onLoop`, `onFrameChange`), playback control (`play`, `stop`, `currentFrame`, `progress`, `totalFrames`, `duration`), loading options via `data` (`fps`, `scaleMode`, `resolution`), sharing one `GifSource` across multiple sprites, `clone()`, manual `autoUpdate: false` mode with `gif.update(ticker)`, and proper destroy semantics (`gif.destroy(true)` vs `Assets.unload`). Triggers on: GifSprite, GifSource, pixi.js/gif, animationSpeed, currentFrame, autoPlay, onComplete, onFrameChange.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-scene-gif` and a `description`
- [ ] Description names concrete trigger keywords (GifSprite, GifSource, pixi.js/gif, animationSpeed, currentFrame, autoPlay)
- [ ] Body contains at least one fenced code example showing `import 'pixi.js/gif'`, `await Assets.load('animation.gif')`, and `new GifSprite({ source })`
- [ ] Contains a performance note recommending `AnimatedSprite` + spritesheet over `GifSprite` for performance-critical animations
- [ ] Contains a "Common Mistakes" section with [HIGH] severity for missing `pixi.js/gif` import
- [ ] Contains an "API Reference" section linking to `GifSprite`, `GifSpriteOptions`, `GifSource`, `GifAsset`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Covers both import forms: `import 'pixi.js/gif'` side-effect and `import { GifSprite } from 'pixi.js/gif'` (named export also triggers the side effect)
- [ ] Explains that `Assets.load` on a GIF returns `GifSource`, not a `Texture`, and shows the correct `new GifSprite({ source })` pattern
- [ ] Documents all `GifSpriteOptions`: `source`, `autoPlay`, `loop`, `animationSpeed`, `autoUpdate`, `fps`, `onComplete`, `onLoop`, `onFrameChange`
- [ ] Notes that `scaleMode` in constructor options is deprecated since 8.13.0 — should be passed via `Assets.load(..., { data: { scaleMode } })`
- [ ] Covers bare `GifSource` as sole constructor argument shorthand: `new GifSprite(source)`
- [ ] Covers playback control: `gif.play()`, `gif.stop()`, `gif.currentFrame`, `gif.playing`, `gif.progress`, `gif.totalFrames`, `gif.duration`
- [ ] Covers `GifSource` sharing across multiple `GifSprite` instances (independent playback state)
- [ ] Covers `gif.destroy(true)` to destroy sprite AND source, vs `gif.destroy()` which preserves source for shared use

## Version Awareness
- [ ] Aligns with PixiJS v8 — `GifSprite` and `GifSource` are exported from `pixi.js/gif` not the main `pixi.js` bundle; verify against installed version as the API is newer

## Known Gaps / Notes
The skill notes GIFs decode every frame into a separate canvas texture, making them memory-heavier than spritesheets. The `fps` loading option provides a fallback frame rate for GIFs that don't specify per-frame delays. The `data:image/gif` URI loading support is noted but not widely documented — testers should verify this still works.
