# Skill Test Spec: /pixi-events

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-events` skill teaches the PixiJS v8 federated event system for pointer, mouse, touch, and wheel input. It covers the five `eventMode` values (`none`, `passive`, `auto`, `static`, `dynamic`), the full event type inventory (pointer, mouse, touch, global move, container lifecycle), three listening styles (`.on()`, `addEventListener`, property handlers), capture phase, propagation control, `hitArea` shapes, `interactiveChildren`, custom cursor styles, drag patterns using `globalpointermove`, `FederatedPointerEvent` properties, `eventFeatures` toggles, and performance tips. Triggers on: eventMode, FederatedPointerEvent, pointerdown, click, globalpointermove, drag, hitArea, cursor, stopPropagation.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-events` and a `description`
- [ ] Description names concrete trigger keywords (eventMode, FederatedPointerEvent, pointerdown, globalpointermove, drag, hitArea, cursor)
- [ ] Body contains at least one fenced code example showing `sprite.eventMode = 'static'` and a pointer event listener
- [ ] Contains a drag example using `globalpointermove` with `pointerdown`/`pointerup`/`pointerupoutside`
- [ ] Contains a "Common Mistakes" section with [HIGH] severity for default `eventMode` being `'passive'`
- [ ] Contains an "API Reference" section linking to `EventSystem`, `FederatedEvent`, `FederatedPointerEvent`, `FederatedWheelEvent`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents all five `eventMode` values with use-case guidance (`'static'` for buttons, `'dynamic'` only for animated objects under stationary cursor)
- [ ] Covers `isInteractive()` method for checking effective interactivity
- [ ] Documents all pointer/mouse/touch/global event names and explains that `globalpointermove` fires everywhere (replaces v7 canvas-wide move)
- [ ] Covers all three listening styles: `.on()`, `addEventListener({once: true})`, property handler `sprite.onclick`
- [ ] Covers capture phase by appending `capture` to event name and `stopImmediatePropagation`
- [ ] Covers `hitArea` with Rectangle, Circle, Polygon, and custom `contains()` implementations
- [ ] Documents `FederatedPointerEvent` key properties: `global`, `client`, `target`, `currentTarget`, `pointerType`, `pointerId`, `isPrimary`, `pressure`, `button`, `buttons`, `nativeEvent`
- [ ] Covers `eventFeatures` at `app.init` and `app.renderer.events.features` for disabling event categories
- [ ] Covers [HIGH] mistake: `buttonMode` removed in v8; use `cursor = 'pointer'`

## Version Awareness
- [ ] Aligns with PixiJS v8 federated events; flags that `pointermove` only fires over the object in v8 (not canvas-wide as in v7), requiring `globalpointermove` for drag operations

## Known Gaps / Notes
The skill notes that `event.offset` (position relative to target in world space) is "not supported at the moment." Testers should verify this limitation has not been resolved in the installed version. Container lifecycle events (`added`, `removed`, `destroyed`, `visibleChanged`) require no `eventMode` — this is a subtle distinction worth verifying in the skill text.
