# Skill Test Spec: /ecs-events

> **Category**: ecs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill implements a complete event-driven communication layer for ECS. It defines a `BaseEvent` abstract class with `timestamp`, a `cancelled` flag, and a `cancel()` method. The core `EventBus` queues events via `emit()`, swaps queues atomically in `processEvents()` to handle events-emitting-events safely, and dispatches immediately via `emitImmediate()`. Specialized variants include a `PriorityEventBus` with handler priorities, an `EntityEventBus` for per-entity subscriptions, and an `EventRecorder` for replay/debug. An `EventDrivenSystem` base class auto-tracks subscriptions for cleanup. Seven usage examples show typed event handling, input bridging, sound reactions, event chains, filtering, aggregation, and cancellation.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: ecs-events` and a `description`
- [ ] Description names concrete trigger keywords: "event buses", "typed events", "event queues", "event-based system communication"
- [ ] Body contains fenced code for: `BaseEvent`, `EventBus`, `EventDrivenSystem`, `PriorityEventBus`, `EntityEventBus`, `EventRecorder`, and 7 usage examples
- [ ] Skill has a `## Checklist` section (10 items)
- [ ] Skill has a `## Common Pitfalls` section (7 items)
- [ ] Skill has a `## Performance Tips` section with optimization, memory, and debugging subsections
- [ ] Skill references Observer pattern, event sourcing, Unity Event System, and reactive programming in a References section

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `BaseEvent.type` is a getter that returns `this.constructor.name` — no hardcoded string required in subclasses
- [ ] `EventBus.emit()` always pushes to `this.eventQueue` regardless of whether `isProcessing` is true — new events emitted during dispatch go to the next frame's queue (the `isProcessing` branch is effectively dead code; testers should flag this)
- [ ] `EventBus.processEvents()` swaps queue references (`this.processingQueue = this.eventQueue; this.eventQueue = []`) before processing — correctly handles events emitted during dispatch
- [ ] `EventBus.dispatchEvent()` breaks early from the handler loop when `event.cancelled` is true
- [ ] `EventDrivenSystem.subscribe<T>()` wraps `eventBus.on()` and pushes the returned unsubscribe function to `this.unsubscribers`; `cleanup()` calls all unsubscribers
- [ ] `HealthSystem` example emits a `EntityDestroyedEvent` from within a `DamageEvent` handler — demonstrating safe cross-event emission
- [ ] `EntityEventBus.emitFrom()` dispatches to entity-specific listeners first (checking `cancelled` after), then falls through to global `this.emit()` for global listeners
- [ ] `EventRecorder.startRecording()` monkey-patches `eventBus.emit` to clone events into `this.recordings` before calling the original `emit`
- [ ] Event chain pattern shows `DeathEvent` triggering both `LootDropEvent` and `ExplosionEvent` from within the same `DeathEvent` handler — skill notes events are queued (not immediate) so no stack overflow risk
- [ ] Cancellation pattern shows an armor component check in a `DamageEvent` handler that calls `event.cancel()` — preventing further handlers from seeing the event

## Version Awareness
- [ ] For ECS skills: flag any library-specific API to verify against the installed version. Custom implementation — no external library. The `EventRecorder` uses `Object.assign(Object.create(Object.getPrototypeOf(event)), event)` to clone events — verify this correctly preserves getter-based properties like `type`.

## Known Gaps / Notes
- The dead-code branch in `EventBus.emit()` (`if (this.isProcessing) { this.eventQueue.push(event); } else { this.eventQueue.push(event); }`) does the same thing in both branches — testers should flag as a bug/confusion.
- `PriorityEventBus.dispatchEvent()` is marked `protected` but the base `EventBus.dispatchEvent()` is `private` — TypeScript will disallow overriding a private method; this is a compilation error that testers should flag.
- The `EventAggregator` example collects `DamageEvent` instances into an array but the array is not bounded — a burst of damage events could accumulate unboundedly before `update()` is called.
