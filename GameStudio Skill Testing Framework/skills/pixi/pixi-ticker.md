# Skill Test Spec: /pixi-ticker

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-ticker` skill teaches the PixiJS v8 `Ticker` for per-frame callbacks and render loop control. It covers the three time units (`deltaTime` as dimensionless ~1.0 at 60fps, `deltaMS` as speed-scaled milliseconds, `elapsedMS` as raw uncapped milliseconds), `UPDATE_PRIORITY` ordering (INTERACTION > HIGH > NORMAL > LOW > UTILITY; `app.render()` at LOW), `add`/`addOnce`/`remove` with context binding for class methods, `maxFPS`/`minFPS` capping, `speed` scaling, `Ticker.shared` vs `Ticker.system` vs `new Ticker()`, the per-object `onRender` hook, `app.start()`/`app.stop()`, and manual rendering with `autoStart: false`. Triggers on: Ticker, UPDATE_PRIORITY, deltaTime, deltaMS, onRender, app.ticker, maxFPS, Ticker.shared.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-ticker` and a `description`
- [ ] Description names concrete trigger keywords (Ticker, UPDATE_PRIORITY, deltaTime, deltaMS, onRender, maxFPS, Ticker.shared)
- [ ] Body contains at least one fenced code example showing `app.ticker.add((ticker) => { ... ticker.deltaTime ... })`
- [ ] Contains a time units table with `deltaTime`, `deltaMS`, `elapsedMS` columns showing type, speed scaling, and use case
- [ ] Contains a "Common Mistakes" section with [CRITICAL] severity for treating the callback arg as a delta number
- [ ] Contains an "API Reference" section linking to `Ticker`, `TickerPlugin`, `TickerPluginOptions`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents all five `UPDATE_PRIORITY` levels: `INTERACTION (50)`, `HIGH (25)`, `NORMAL (0)`, `LOW (-25)`, `UTILITY (-50)` with `app.render()` at LOW
- [ ] Covers context binding: `app.ticker.add(system.update, system)` and matching `remove(fn, context)` requirement
- [ ] Explains `deltaTime` semantics: dimensionless scalar ~1.0 at 60fps, ~2.0 at 30fps; NOT milliseconds
- [ ] Covers `maxFPS` (frame skip ceiling) vs `minFPS` (deltaTime/deltaMS cap to prevent huge delta spikes)
- [ ] Covers `Ticker.shared` (singleton, protected from destroy) vs `Ticker.system` (separate background task instance) vs `new Ticker()` (custom, `autoStart: false` by default)
- [ ] Covers `ticker.speed` for slow motion (`0.5`) and fast forward (`2.0`); notes `speed` affects `deltaTime`/`deltaMS` but NOT `elapsedMS`
- [ ] Covers `sprite.onRender` as the per-object per-frame hook replacing v7's `updateTransform`
- [ ] Covers `autoStart: false` + manual `app.ticker.update()` + `app.render()` pattern

## Version Awareness
- [ ] Aligns with PixiJS v8; flags the [CRITICAL] v8 callback signature change: `add((ticker) => { ticker.deltaTime })` not `add((dt) => { dt })`; flags `updateTransform` removed, replaced by `onRender`

## Known Gaps / Notes
The skill notes a "tension" about `deltaTime` naming — it is a dimensionless scalar, not time. This is a common source of bugs and testers should confirm the warning is prominent. `ticker.FPS` and `ticker.count` (measured frame rate and listener count) are read-only properties mentioned but not demonstrated with examples.
