# Skill Test Spec: /phaser-tweens

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers Phaser 4's `TweenManager` (`this.tweens`) for animating object properties over time. Topics include `add()`, `chain()`, `addCounter()`, tween lifecycle (Active → Start → Playing → Yoyo/Repeat → Loop → Complete → auto-destroy), all config properties (`targets`, `duration`, `ease`/`easeParams`, `delay`, `hold`, `repeat`, `repeatDelay`, `yoyo`, `loop`, `loopDelay`, `completeDelay`, `paused`, `persist`, `props`, `interpolation`), per-property config overrides, relative values (`'+=200'`), stagger via `this.tweens.stagger()`, callbacks and events, `TweenChain`, number tweens (`addCounter`), runtime control (`pause`, `stop`, `seek`, `updateTo`, `setTimeScale`), and all easing functions with Power aliases. It triggers on tween, ease, animate, `tweens.add`, chain, or stagger questions.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-tweens` and a `description`
- [ ] Description names trigger keywords: `tween`, `ease`, `animate`, `this.tweens.add`, `tween chain`, `stagger`
- [ ] Body contains a Quick Start `this.tweens.add()` example
- [ ] `TweenBuilderConfig` property table is present with at minimum 15 properties
- [ ] Easing functions table with Power aliases and all type variants is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents that tweens auto-destroy after completion; `persist: true` keeps alive for replay but requires manual `tween.destroy()` when done
- [ ] Documents `repeat` vs `loop` distinction: `repeat` is per-property on TweenData (property plays N+1 times); `loop` restarts the entire tween
- [ ] Documents that `loop: -1` means `onComplete` NEVER fires; use `completeAfterLoop()` to end gracefully
- [ ] Documents properties beginning with `_` are ignored by tweens; cannot tween underscore-prefixed properties
- [ ] Documents `tween.seek(ms)` suppresses events/callbacks by default; pass `true` as third argument to emit during seek
- [ ] Documents stagger forms: `stagger(100)` for uniform delay, `stagger([0, 1000])` for range distribution, `stagger(500, { from: 'center' })` for center-outward, `stagger(200, { grid: [cols, rows] })` for 2D grids
- [ ] Documents Power alias mapping: `Power0`=Linear, `Power1`=Quad.Out, `Power2`=Cubic.Out, `Power3`=Quart.Out, `Power4`=Quint.Out
- [ ] Documents bare ease name defaults to `.Out` variant: `'Quad'` = `Quad.easeOut`; use full string `'Quad.easeIn'` for In variants
- [ ] Documents `updateTo(key, value, startToCurrent?)` for changing end value mid-tween without restarting
- [ ] Documents `TweenChain` `add(tweenConfigs)` for appending tweens dynamically to a running chain

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `TweenManager.setFps(fps)` and `setLagSmooth(limit, skip)` are available in v4; verify in target version

## Known Gaps / Notes
`TweenFrameData` for tweening texture frames (frame-by-frame via tween rather than AnimationState) is in the source file map but not documented in examples. The global `TweenManager.timeScale` multiplies with per-tween `timeScale`: effective speed = `managerTimeScale * tweenTimeScale`. The `isNumberTween` property distinguishes counter tweens from property tweens.
