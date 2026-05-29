# Skill Test Spec: /typescript-game-types

> **Category**: typescript · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides type-safe patterns for TypeScript game development, covering branded types for entity and resource IDs, discriminated unions for game states and events, type-safe component registries with mapped types, immutable vector/AABB math interfaces, const-asserted configuration objects, and runtime type guards for deserializing dynamic data. The skill targets compile-time safety without runtime overhead and recommends a strict `tsconfig.json` baseline.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: typescript-game-types` and a `description`
- [ ] Description names trigger keywords (type-safe, branded types, strict null checks, performance-focused type design)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Seven numbered implementation sections are present (Branded Types, Discriminated Unions, Event System, Component Type Safety, Vector and Math Types, Configuration, Type Guards)
- [ ] A `## TypeScript Configuration` section is present with a `tsconfig.json` fenced block
- [ ] A `## Checklist` section is present with actionable items

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Branded type utility `Branded<T, Brand>` is defined and an `EntityId` example is shown
- [ ] Factory function `createEntityId` and type guard `isEntityId` are demonstrated
- [ ] `GameState` discriminated union covers at least 4 states (`loading`, `menu`, `playing`, `paused`, `gameOver`)
- [ ] Exhaustiveness check using `never` in a switch default branch is present
- [ ] `EventBus.on` uses `Extract<GameEvent, { type: T }>` to narrow the listener parameter type
- [ ] `ComponentRegistry` interface maps `ComponentType` string keys to concrete component classes
- [ ] `as const` assertion is demonstrated for a `GameConfig` object and a `ComponentTypes` object
- [ ] `isVector3` type guard checks `x`, `y`, `z` as `number` properties
- [ ] `tsconfig.json` enables `strictNullChecks`, `noUncheckedIndexedAccess`, and `exactOptionalPropertyTypes`
- [ ] Common pitfalls section warns against using `any` and recommends `unknown` instead

## Version Awareness
- [ ] The skill is engine-agnostic TypeScript; assertions are framework-neutral. No library version pinning is required, but verify the TypeScript version installed supports `exactOptionalPropertyTypes` (TS 4.4+) and inline type imports (TS 4.5+).

## Known Gaps / Notes
- The `Renderable` and `Health` component classes are referenced in `ComponentRegistry` but not fully defined in the skill body — implementations are assumed to live in companion files.
- `Vector3` is defined as an interface; in hot-path code the skill recommends using it as a plain object rather than a class instance.
