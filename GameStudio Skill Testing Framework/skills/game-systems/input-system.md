# Skill Test Spec: /input-system

> **Category**: game-systems · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a unified ECS input system abstracting keyboard, mouse, touch, and (optionally) gamepad into a single `Input` component with action states. `InputMapping` objects bind physical inputs (key strings, mouse button indices, or a touch flag) to named action strings. The `Input` component tracks raw key/mouse/touch/gamepad state, computes `actionJustPressed` / `actionJustReleased` deltas each frame, provides `getAxis(action)` for positive/negative key pairs, and maintains an input buffer with a configurable `bufferDuration` for combo detection via `checkCombo(actions[], time)`. `InputSystem` wires DOM event listeners to all `Input` components and clears per-frame delta maps. `PlayerInput` extends `Input` with WASD/arrow/space/mouse defaults. `PlayerMovementSystem` demonstrates normalized diagonal movement and double-jump combo detection.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: input-system` and a `description`
- [ ] Description names trigger keywords (keyboard, mouse, touch, gamepad, action mapping, input buffering)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Four named implementation sections are present (Input Component, Input System, Player Input Component, Player Movement System)
- [ ] A `## Checklist` section is present with action mapping, multi-device, and dispose items
- [ ] A `## Common Pitfalls` section warns about diagonal normalization and missing cleanup

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `Input.registerMapping` appends an `InputMapping` to `this.mappings`
- [ ] `Input.wasActionJustPressed(action)` reads from `actionJustPressed` Map (not `actions`)
- [ ] `Input.getAxis(action)` finds a mapping with `m.axis` set and returns `(positive ? 1 : 0) + (negative ? -1 : 0)`
- [ ] `Input.addToBuffer` filters old entries older than `bufferDuration` on each insertion
- [ ] `Input.checkCombo` scans the buffer backwards matching each action in the combo sequence
- [ ] `InputSystem` registers touch events with `{ passive: false }` to enable `preventDefault()`
- [ ] `InputSystem.update` calls `actionJustPressed.clear()` and `actionJustReleased.clear()` at the start of each frame
- [ ] `PlayerInput` registers at least `moveForward`, `jump`, and `shoot` default mappings including a mouse button binding for shoot
- [ ] `PlayerMovementSystem` normalizes the movement vector with `Math.sqrt(moveX² + moveZ²)` before applying speed
- [ ] `InputSystem.dispose` removes all event listeners added in `setupEventListeners`

## Version Awareness
- [ ] The skill is engine-agnostic; no library version pinning is required. The input buffering and combo detection are framework-neutral. Touch `passive: false` is required by browsers that default to passive for touch events.

## Known Gaps / Notes
- Gamepad polling is referenced in the mapping type (`buttons?: number[]`) but the actual `gamepad` polling loop in `update` is left as `// ... similar logic for gamepad` — the gamepad code path is not implemented.
- `getAxis` uses `this.keys.has(mapping.axis.positive)` which works for keyboard but does not read from `gamepadAxes` for analog sticks.
