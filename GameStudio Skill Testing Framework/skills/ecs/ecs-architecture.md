# Skill Test Spec: /ecs-architecture

> **Category**: ecs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill defines the foundational ECS architecture for TypeScript game development. It provides concrete implementations of all four core abstractions: a branded `EntityId` numeric type with an `EntityManager` (create/destroy/exists/getAll), a `ComponentManager` backed by a `Map<ComponentClass, Map<EntityId, Component>>` with type-safe get/has/add/remove/getAll operations, an abstract `System` base class with a typed `query()` helper, and a `World` facade that composes the three managers and drives the system update loop. Four example components (Transform, Velocity, Health, Renderable) and two concrete systems (MovementSystem, RenderSystem) show typical usage, capped by a complete `requestAnimationFrame` game loop.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: ecs-architecture` and a `description`
- [ ] Description names concrete trigger keywords: "Entity Component System", "TypeScript", "game development"
- [ ] Body contains a plain-text architecture diagram (Entity → Components → Systems)
- [ ] Body contains fenced code for all four core classes: `EntityManager`, `ComponentManager`, `System`, `World`
- [ ] Skill has a `## Checklist` section with 10 items
- [ ] Skill has a `## Common Pitfalls` section listing at least 5 anti-patterns
- [ ] Skill has a `## Performance Tips` section

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `EntityId` uses a branded type pattern: `type EntityId = number & { readonly __brand: 'EntityId' }`
- [ ] `EntityManager.create()` casts `this.nextId++ as EntityId` — skill explains why direct cast is needed to satisfy the brand
- [ ] `ComponentManager` stores component data as `Map<ComponentClass<any>, Map<EntityId, Component>>` keyed by constructor reference (not string name)
- [ ] `ComponentManager.getAll<T>()` returns a `Map<EntityId, T>` for iterating all instances of a component type
- [ ] `ComponentManager.removeAllForEntity()` iterates all component maps and deletes the entity's entry — used during entity destruction
- [ ] Abstract `System.query()` iterates `entities.getAll()`, checks each component type, and returns `{ entity, components }` pairs — documents O(entities × componentTypes) complexity
- [ ] `World.destroyEntity()` calls `componentManager.removeAllForEntity` before `entityManager.destroy` (correct order to avoid dangling component data)
- [ ] Example `MovementSystem` updates `transform.x/y/z` by multiplying velocity components with `deltaTime`
- [ ] Example `RenderSystem` has extra `addToScene` / `removeFromScene` methods that manage Three.js scene membership separately from the ECS update cycle
- [ ] The complete usage example converts `deltaTime` from milliseconds to seconds: `(currentTime - lastTime) / 1000`

## Version Awareness
- [ ] For ECS skills: flag any library-specific API to verify against the installed version. This skill is a custom (zero-dependency) ECS implementation — no external library version to pin. Verify that the `as EntityId` cast pattern is valid TypeScript strict mode (it is — casting to a branded intersection type is allowed).

## Known Gaps / Notes
- The `System.query()` implementation allocates a new result array on every call — for hot paths this should use a cached or pooled result set (covered in `ecs-performance`).
- `ComponentManager` uses class constructor references as Map keys, which works in JavaScript but can break with code splitting or module reloading in some bundler configurations — testers should note this risk.
- `World.clear()` sets `this.systems.length = 0` (mutating the array in place) rather than reassigning — testers should verify this is intentional and consistent.
