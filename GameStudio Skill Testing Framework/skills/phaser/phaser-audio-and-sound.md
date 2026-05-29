# Skill Test Spec: /phaser-audio-and-sound

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers audio playback in Phaser 4 using the unified `SoundManager` (`this.sound`), which abstracts over WebAudio API and HTML5 Audio. Topics include loading audio with format fallbacks, fire-and-forget vs retained-reference playback, volume/rate/detune/pan/loop, audio sprites and markers, spatial audio (`PannerNode`, listener position, `follow`), muting, browser autoplay policy and the unlock flow, `decodeAudio`, and the full event set for both sound instances and the manager. It triggers when a developer needs sound, music, volume control, or spatial audio.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-audio-and-sound` and a `description`
- [ ] Description names trigger keywords: `sound`, `audio`, `music`, `volume`, `mute`
- [ ] Body contains a Quick Start code block loading audio in `preload` and playing it in `create`
- [ ] Skill distinguishes WebAudioSoundManager from HTML5AudioSoundManager, including which features each supports
- [ ] An events reference table lists at minimum `PLAY`, `COMPLETE`, `LOOPED`, `STOP`, and `UNLOCKED`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Explains fire-and-forget (`this.sound.play(key)` auto-destroys on complete) vs retained reference (`this.sound.add(key)` for ongoing control)
- [ ] Documents the effective playback rate formula: `sound.rate * manager.rate * detuneRate` where `detuneRate` uses `Math.pow(1.0005777895065548, detune)`
- [ ] Documents `StereoPannerNode` limitation: pan has no audible effect on iOS/Safari; events still fire
- [ ] Documents audio sprite loading (`this.load.audioSprite(key, json, urls)`) and the `spritemap` JSON format with `name`, `start`, `duration`, `loop`
- [ ] Documents manual marker API: `addMarker`, `updateMarker`, `removeMarker` on BaseSound
- [ ] Documents spatial audio `source` config properties: `x`, `y`, `refDistance`, `maxDistance`, `rolloffFactor`, `distanceModel`, `panningModel`, `follow` (auto-track game object x/y)
- [ ] Notes that spatial audio is WebAudio only and silently ignored by HTML5 Audio
- [ ] Documents HTML5 Audio `instances` parameter for simultaneous playback: `this.load.audio(key, url, { instances: 4 })`
- [ ] Explains browser autoplay policy handling: `locked` property, `UNLOCKED` event, and recommended pattern of checking `locked` before playing
- [ ] Documents `this.sound.context` access for building `AnalyserNode` for frequency visualization (WebAudio only)

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask); flags any API to verify against the installed version
- [ ] Notes that `setAudioContext(newContext)` is available in v4 for SPA context reuse

## Known Gaps / Notes
The skill notes that `SoundManager` is a single shared instance per game, meaning sounds are not automatically cleaned up on scene shutdown. The `pauseOnBlur` default behavior (true) is documented. The iOS 17/18+ audio interruption workaround via `context.suspend()`/`context.resume()` on the VISIBLE game event is mentioned but may need version verification.
