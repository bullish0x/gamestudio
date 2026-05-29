# Skill Test Spec: /typescript-ecs-types

> **Category**: typescript · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides advanced TypeScript type patterns specifically for Entity Component Systems: `ComponentConstructor<T>` / `ComponentInstance<T>` utility types, a `TypedEntity` builder that accumulates component types through chained `addComponent` calls, `QueryComponents<T>` mapped tuple types that drive strongly typed system callbacks, an abstract `TypedSystem` base class with generic component constraints, a bidirectional `TypedRegistry`, a `TypedEventBus` using `Extract` for per-event handler types, and utility types such as `Immutable<T>`, `DeepPartial<T>`, and template-literal `Archetype` strings.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: typescript-ecs-types` and a `description`
- [ ] Description names trigger keywords (type-safe queries, component types, system patterns)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Seven numbered implementation sections are present (Core Component Types, Type-Safe Entity, Type-Safe Queries, System Type Patterns, Component Registry, Event Type Patterns, Advanced Type Utilities)
- [ ] A `## Checklist` section is present with items covering type inference, type guards, and testing
- [ ] A `## Performance Tips` section covering type inference over explicit types is present

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `ComponentConstructor<T>` and `ComponentInstance<T>` utility types are defined using `infer`
- [ ] `TypedEntity.addComponent` returns a widened `TypedEntity<TComponents & ...>` to accumulate types via method chaining
- [ ] `QueryComponents<T>` is defined as a mapped type over a readonly `ComponentConstructor` tuple
- [ ] `TypedQuery.iterate` yields `QueryResult<T>` where each component slot is the correct concrete type
- [ ] `TypedSystem<TComponents>` uses `updateEntity(entity, components, deltaTime)` where `components` is `QueryComponents<TComponents>`
- [ ] `MovementSystem` example destructures `[transform, velocity]` directly in the method signature
- [ ] `StrictRegistry` restricts keys to the `ComponentName` string literal union, producing a compile error for unrecognised names
- [ ] `TypedEventBus.on` uses `Extract<GameEvent, { type: T }>` for handler narrowing, mirroring the pattern in `typescript-game-types`
- [ ] `Immutable<T>` and `DeepPartial<T>` utility types are defined recursively
- [ ] `ComponentMixin` pattern using higher-order class functions (`WithId`, `WithName`) is demonstrated

## Version Awareness
- [ ] The skill is engine-agnostic TypeScript; no library version pinning is required. Verify that the TypeScript version supports `as const` tuple assertions and conditional `infer` (TS 3.7+).

## Known Gaps / Notes
- `TypedEntity.addComponent` uses `this as any` internally to handle the widening — the skill acknowledges this is a deliberate trade-off and warns against overusing `as any` in the Common Pitfalls section.
- `ArchetypeComponents` is a template-literal recursive type that may cause slow type-checking in large worlds; the Performance Tips section notes this.
