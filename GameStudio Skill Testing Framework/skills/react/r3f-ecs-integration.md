# Skill Test Spec: /r3f-ecs-integration

> **Category**: react · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill explains how to bridge an Entity Component System world with React Three Fiber rendering. It establishes a clear separation of concerns — ECS owns game logic and state while React/R3F handles visual presentation — and demonstrates the wiring through an `ECSProvider` React context, an `ECSGameLoop` component that calls `world.update(delta)` inside `useFrame`, an `EntityCollection` component that polls for renderable entities at 100 ms intervals, and entity-factory hooks (`useCreateEntity`) that build Three.js meshes and attach ECS components in one call. An `EventBus` class bridges ECS events into React state for UI updates.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: r3f-ecs-integration` and a `description`
- [ ] Description names concrete trigger keywords: "Entity Component System", "React Three Fiber", "declarative 3D games", "high-performance"
- [ ] Body contains at least one fenced code example per major concept (context, renderer, game loop, hooks, event bus)
- [ ] Skill has a `## Checklist` section
- [ ] Skill has a `## Common Pitfalls` section listing at least 5 anti-patterns
- [ ] Skill has a `## Performance Tips` section
- [ ] Skill documents the recommended component tree order: `ECSProvider > Canvas > ECSGameLoop + EntityCollection + GameSetup`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `ECSProvider` creates the `World` reference lazily with `useRef` (not `useState`) to avoid re-render on mount, and clears on unmount via `useEffect` cleanup
- [ ] `useECS()` throws a descriptive error when used outside `ECSProvider`
- [ ] `ECSGameLoop` is a render-null component (`return null`) that calls `world.update(delta)` inside `useFrame`
- [ ] `EntityCollection` polls entity list with `setInterval(..., 100)` — spec notes 100 ms as a deliberate trade-off between freshness and re-render cost
- [ ] `useEntity<T>` hook polls at ~16 ms (60fps) and updates React state only when the component reference has changed
- [ ] `useCreateEntity` factory hook exposes `createPlayer` and `createEnemy` using `useCallback` to ensure stable references
- [ ] `EventBus` is typed via a discriminated union (`GameEvent`) with at least `entityCreated`, `entityDestroyed`, `componentAdded`, `componentRemoved` variants
- [ ] `useECSEvent` hook subscribes in `useEffect` and returns the unsubscribe function as the cleanup
- [ ] Performance tip explicitly states: update ECS every frame, sync to React less frequently (100 ms), and keep component count under 1000 for 60 fps
- [ ] Checklist includes profiling with React DevTools Profiler and testing with 1000+ entities

## Version Awareness
- [ ] For React Three Fiber skills: aligns with pinned R3F 9 / drei 10 / three 0.184. `useFrame` and `useThree` API signatures are stable across R3F 8→9; confirm `primitive` JSX element still valid in R3F 9.

## Known Gaps / Notes
- The `EntityCollection` polling approach (`setInterval`) is explicitly noted as a simpler alternative to an event-based approach; testers should verify the skill acknowledges the event-driven alternative.
- `useEntity` polling at 16 ms still creates a new `setInterval` per entity per component — for large entity counts this is expensive; the spec recommends a single world-level subscription instead.
- The skill does not demonstrate Three.js object disposal when an entity's `Renderable` component is removed; testers should flag this as a gap for memory management.
