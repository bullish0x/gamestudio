# Skill Test Spec: /threejs-animation-systems

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Teaches the Three.js `AnimationMixer` / `AnimationAction` system for character animation: an `AnimationManager` that maps model→mixer and name→action, cross-fading logic, a state-machine (`AnimationStateMachine`) with typed states and transition durations, a full `CharacterAnimationController` with idle/walk/run/jump/attack states, an `AnimationBlender` for weight and additive blending, and a `ProceduralAnimation` helper for path-following, bounce, and continuous rotation. Triggered when animating 3D characters, playing GLTF/FBX clips, blending locomotion states, or creating animation state machines.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-animation-systems` and a `description`
- [ ] Description names AnimationMixer, clips, blending, and skeletal animation
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has a checklist that includes delta-time updates and mixer disposal
- [ ] Body has a "Performance Tips" section about skipping inactive mixers

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `mixer.update(deltaTime)` is called every frame with delta in seconds
- [ ] `action.crossFadeTo(toAction, duration, warpBoolean)` is used for smooth transitions
- [ ] `action.setLoop(THREE.LoopRepeat, Infinity)` and `THREE.LoopOnce` are both demonstrated
- [ ] `action.clampWhenFinished = true` is set for one-shot animations (attack)
- [ ] `mixer.uncacheRoot(mixer.getRoot())` is called in `dispose()` to release mixer memory
- [ ] `AnimationStateMachine` prevents redundant transitions by checking `currentState === newState`
- [ ] `CharacterAnimationController` uses `setTimeout` to return from jump/attack based on clip duration
- [ ] `AdditiveAnimationBlendMode` is set on the additive layer in `AnimationBlender`

## Version Awareness
- [ ] Aligns with pinned three 0.184 (`GLTFLoader` import path is `three/addons/loaders/GLTFLoader.js` in the loaders skill but `three/examples/jsm/loaders/GLTFLoader` here — verify consistency with installed package structure)

## Known Gaps / Notes
- `setTimeout` for animation completion is fragile (no clock synchronisation); consider `mixer.addEventListener('finished', ...)` instead.
- No IK (inverse kinematics) is covered; see `threejs-skeletal-animation` if it exists.
