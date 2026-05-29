# Skill Test Spec: /threejs-animation

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
A Quick-Start-first reference for the Three.js `AnimationClip` / `AnimationMixer` / `AnimationAction` triad: all `KeyframeTrack` types (Number, Vector, Quaternion, Color, Boolean, String), interpolation modes, mixer events, action playback controls (loop modes, time scale, weight, fade in/out, crossfade), GLTF animation loading and clip lookup, skeletal animation (bones, `SkeletonHelper`, bone attachments), morph targets, weight-based blending (idle/walk/run), additive blending via `AdditiveAnimationBlendMode`, animation utilities (`subclip`, `makeClipAdditive`), and procedural patterns (smooth damping, spring physics, oscillation). Triggered when animating objects, playing GLTF clips, creating procedural motion, or blending animations.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-animation` and a `description`
- [ ] Description names keyframe animation, skeletal animation, morph targets, and animation mixing
- [ ] Body contains a Quick Start with a `THREE.Clock`-based animation loop
- [ ] Body has a "Performance Tips" section including `clip.optimize()` and pausing off-screen mixers
- [ ] Body covers all three major animation system components in separate sections

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `mixer.update(clock.getDelta())` is required every frame and shown in the animation loop
- [ ] `THREE.QuaternionKeyframeTrack` stores quaternion components as flat `[x, y, z, w, ...]` arrays
- [ ] `action.loop = THREE.LoopOnce` and `action.clampWhenFinished = true` are shown for one-shot clips
- [ ] `action.crossFadeTo(action2, 0.5, true)` (warp=true) is used for smooth crossfades
- [ ] `mixer.addEventListener('finished', callback)` is shown for clip-completion detection
- [ ] `mesh.morphTargetDictionary['smile']` maps target names to influence indices
- [ ] `THREE.AnimationUtils.makeClipAdditive(clip)` prepares a clip for additive layering
- [ ] `action.blendMode = THREE.AdditiveAnimationBlendMode` is set on additive actions
- [ ] `THREE.AnimationClip.findByName(clips, 'Walk')` is used for name-based lookup after GLTF load

## Version Awareness
- [ ] Aligns with pinned three 0.184; `GLTFLoader` import uses `three/examples/jsm/loaders/GLTFLoader.js` — inconsistent with `threejs-loaders` skill which uses `three/addons/`; flag and normalise to `three/addons/`

## Known Gaps / Notes
- `smoothDamp` in the Procedural section references an `undefined` `delta` variable (should be `clock.getDelta()` captured before the function); spec tests should flag this as a code bug.
- No `AnimationObjectGroup` (shared mixer for multiple objects) is covered.
