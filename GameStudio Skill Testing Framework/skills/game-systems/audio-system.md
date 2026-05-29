# Skill Test Spec: /audio-system

> **Category**: game-systems · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a complete Web Audio API game audio stack. `AudioManager` owns an `AudioContext`, a master/music/SFX gain node hierarchy, a buffer cache, and a concurrent-sounds cap with oldest-sound eviction. `playSoundAt` creates a `PannerNode` with HRTF model and inverse distance for 3D positional audio and exposes `refDistance`, `maxDistance`, and `rolloffFactor`. `AudioSource` and `AudioListener` ECS components let the `AudioSystem` attach 3D audio to transforms and update the context listener from the camera entity each frame. `MusicManager` handles cross-fade (linear ramp gain), track playlist with shuffle, and playNext/playPrevious. `AudioEventSystem` subscribes to `DamageEvent`, `DeathEvent`, `JumpEvent`, and `CollisionEvent` to trigger spatial sounds with velocity-scaled impact variants.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: audio-system` and a `description`
- [ ] Description names trigger keywords (sound effects, music, spatial audio, Web Audio API)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Five named implementation sections are present (Audio Manager, Audio Components, Audio System, Music Manager, Audio Event System)
- [ ] A `## Checklist` section is present with autoplay restriction and listener setup items
- [ ] A `## Performance Tips` section covers concurrent sound limits and memory optimization

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `AudioManager` creates a master → music/sfx gain node chain, all connected to `context.destination`
- [ ] `playSound` resumes a suspended `AudioContext` before playing (autoplay restriction handling)
- [ ] `playSound` removes the source from `activeSounds` in the `onended` callback
- [ ] `playSoundAt` creates a `PannerNode` with `panningModel: 'HRTF'` and `distanceModel: 'inverse'`
- [ ] `setListener` sets all six positional and orientation AudioParam values on `context.listener`
- [ ] `MusicManager.play` calls `fadeOut` on the current track before starting a new one
- [ ] `fadeOut` uses `linearRampToValueAtTime` and a `setTimeout` to stop the source after the fade duration
- [ ] `AudioEventSystem.onCollision` plays different impact sounds (`impact_heavy`, `impact_medium`, `impact_light`) based on `event.relativeVelocity` magnitude
- [ ] `AudioSystem.updateListener` queries for an entity with both `Transform` and `AudioListener` components and derives `forward`/`up` vectors from its quaternion

## Version Awareness
- [ ] The skill uses the Web Audio API directly (no Three.js audio wrappers). Web Audio API availability is universal in modern browsers. The Battery/performance impact of `HRTF` panning on mobile should be validated on target devices.

## Known Gaps / Notes
- `MusicManager.fadeIn` reconnects the source through a new gain node after `source.disconnect()` — this pattern may break on some browsers if the source was already connected to the default destination; test on target platforms.
- Anti-aliasing of music track end (clicking artifacts) when stopping with `stopSound` is not addressed; a short ramp-to-zero is the recommended fix.
