# Skill Test Spec: /phaser-time-and-timers

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers Phaser 4's `Clock` plugin (`this.time`) for creating delayed and looping `TimerEvent` objects, plus the `Timeline` sequencer for choreographing ordered actions. Topics include `delayedCall`, `addEvent` with `delay`/`repeat`/`loop`/`startAt`/`args`/`timeScale`, timer progress methods, pausing/resuming the Clock vs individual events, `removeEvent`/`removeAllEvents`, `TimerEvent.reset()` for reuse, `Timeline` with `at`/`from`/`in` timing, `run`/`tween`/`sound`/`set`/`event`/`if`/`once`/`stop` event actions, Timeline looping, time scale, and the full cutscene pattern. It triggers on timer, delay, `delayedCall`, `TimerEvent`, `Clock`, `Timeline`, or time event questions.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-time-and-timers` and a `description`
- [ ] Description names trigger keywords: `timer`, `delay`, `delayedCall`, `TimerEvent`, `Clock`, `time event`
- [ ] Body contains a Quick Start with `delayedCall`, `addEvent` with repeat, and `addEvent` with `loop: true`
- [ ] `TimerEventConfig` property table is present
- [ ] `TimelineEventConfig` property table is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents the `repeat` off-by-one: `repeat: 4` means 5 total fires (1 initial + 4 repeats); common mistake
- [ ] Documents that zero delay with any repeat/loop throws `'TimerEvent infinite loop created via zero delay'`
- [ ] Documents that Timelines start PAUSED; `timeline.play()` must be called after creation
- [ ] Documents `startAt` config property: pre-fills elapsed time so first fire happens sooner than `delay`; e.g. `delay: 2000, startAt: 1900` fires first time at 100ms
- [ ] Documents Timer addition is deferred: `addEvent()` pushes to pending list processed in `preUpdate`; timer not active until next frame
- [ ] Documents `callbackScope` default is the `TimerEvent` itself, NOT the scene; use arrow function or pass `callbackScope: this` explicitly
- [ ] Documents Timeline `timeScale` only scales the timeline's elapsed counter; tweens spawned by the timeline run at their own speed and must have `timeScale` set separately
- [ ] Documents `timeline.once: true` events: spliced out after firing, will NOT reappear on `reset()` or when looping
- [ ] Documents `timer.reset(config)` reinitializes but does NOT re-schedule; must call `this.time.addEvent(timer)` after resetting to use again
- [ ] Documents Timeline `from` chaining: each `from` offset is relative to previous event's resolved time, not the previous `from` value

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `Timeline` with `this.add.timeline()` factory is available in v4; verify `sound` and `set` event actions are in target version

## Known Gaps / Notes
The `Clock.paused = true` vs `timeScale = 0` distinction is documented: `paused` skips the update loop entirely; `timeScale = 0` runs with zero delta. The cutscene example combining callbacks, tweens, sounds, property sets, and custom events in one Timeline is a comprehensive practical example.
