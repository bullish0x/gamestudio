# Skill Test Spec: /r3f-component-patterns

> **Category**: react · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill catalogs advanced React Three Fiber component patterns for building structured, reusable 3D scenes. It covers six distinct architectural patterns: basic mesh components with `useFrame` animation, compound components that group multiple meshes into a single hierarchy, container/scene components that inject shared lighting and environment, the render-props pattern for hover/pointer state delegation, higher-order components that inject physics behavior, and performance patterns using `React.memo`, `useMemo` for geometry/material caching, and `instancedMesh` for rendering 100+ identical objects in a single draw call.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: r3f-component-patterns` and a `description`
- [ ] Description names concrete trigger keywords: "reusable 3D components", "hooks", "composition", "performance optimization"
- [ ] Body contains fenced code examples for each named pattern (basic, compound, container, render-props, HOC, instanced)
- [ ] Skill has a `## Checklist` section
- [ ] Skill has a `## Common Pitfalls` section
- [ ] Skill has a `## Performance Tips` section
- [ ] Skill lists at least 4 related skills

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Basic `Box` component accepts typed props (`position`, `color`, `scale`, `rotationSpeed`, `onClick`) and animates via `useFrame` using `delta` (not elapsed time directly)
- [ ] Compound `Player` component wraps multiple meshes in a `<group>` with a `useRef<Group>` for group-level transforms
- [ ] Container `Scene` component accepts `children: ReactNode` and configures `<Environment preset>` from drei, listing valid preset string literals
- [ ] Render-props `WithHover` component calls `e.stopPropagation()` in both `onPointerOver` and `onPointerOut` handlers and passes typed `ThreeEvent<PointerEvent>` to consumers
- [ ] `withPhysics` higher-order component wraps a generic component type `P` and strips its own `velocity`/`gravity` props before forwarding the rest
- [ ] `OptimizedMesh` uses `React.memo` at the export site and memoizes geometry and material independently via `useMemo` with correct dependency arrays
- [ ] `InstancedBoxes` uses `<instancedMesh ref={...} args={[undefined, undefined, count]}>` JSX form and calls `instanceMatrix.needsUpdate = true` after batch updates
- [ ] `useAnimation` hook takes `duration`, `loop`, and `easing` config and tracks `startTimeRef` as a `useRef` to avoid re-renders
- [ ] `useFollowTarget` hook uses `Vector3.lerp` each frame to smooth camera follow and calls `camera.lookAt(target.position)` explicitly
- [ ] Performance tips recommend `<Instances>` from drei as a higher-level alternative to manual `instancedMesh`

## Version Awareness
- [ ] For React Three Fiber skills: aligns with pinned R3F 9 / drei 10 / three 0.184. `instancedMesh` JSX intrinsic (`<instancedMesh>`) is available in R3F without explicit `extend()`; confirm this is still true in R3F 9. `Environment preset` string list should match drei 10's accepted values.

## Known Gaps / Notes
- `InstancedBoxes` initializes transforms in a `useMemo` that references `meshRef.current` — this may be `null` on first render; testers should flag the ordering issue and recommend `useEffect` or splitting initialization into a separate pass.
- `useFollowTarget` does not export a way to set the initial camera position, which may cause a visible snap on first mount.
- The HOC `withPhysics` contains a `useFrame` with a comment placeholder for physics logic — the skill does not provide a concrete implementation, which testers should note as an incomplete example.
