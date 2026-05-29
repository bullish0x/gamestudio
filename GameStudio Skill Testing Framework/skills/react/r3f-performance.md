# Skill Test Spec: /r3f-performance

> **Category**: react · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill is a comprehensive guide to React Three Fiber performance optimization across React, Three.js, and mobile layers. It covers React memoization with custom comparison functions, `InstancedMesh` with pre-computed `Matrix4` transforms, distance-based LOD via `useThree().camera`, adaptive quality through `<PerformanceMonitor>` from drei and `<AdaptiveDpr>`, Suspense + `useGLTF` lazy loading, a `useConditionalFrame` hook with throttle support, manual frustum culling, and in-canvas FPS monitoring via an HTML overlay. Each technique is accompanied by a concrete TypeScript component or hook.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: r3f-performance` and a `description`
- [ ] Description names concrete trigger keywords: "memoization", "instancing", "LOD", "suspense", "mobile-specific optimizations"
- [ ] Body contains fenced code for all listed techniques (memoization, instancing, LOD, adaptive canvas, lazy loading, conditional frame, frustum culling, FPS monitor)
- [ ] Skill has a `## Checklist` section with 12 items
- [ ] Skill has a `## Common Pitfalls` section
- [ ] Skill has a layered `## Performance Tips` section covering React, Three.js, and Mobile subsections plus Profiling

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `MemoizedBox` uses `useMemo` for geometry (no deps) and material (depends on `color`); `SmartMemoBox` uses a custom second argument to `React.memo` that only re-renders on `color` changes, ignoring `position`
- [ ] `InstancedObjects` initializes all `Matrix4` transforms in a `useMemo` and stores rotation state in a `Float32Array` (not React state) to avoid re-renders during animation
- [ ] `LODObject` derives `'high' | 'medium' | 'low'` from `camera.position.distanceTo()` called in `useFrame`, and maps each level to different `<sphereGeometry args={[1, N, N]}>`
- [ ] `AdaptiveCanvas` uses `<PerformanceMonitor onIncline/onDecline>` from drei to adjust `dpr` state, plus `<AdaptiveDpr pixelated />` for automatic sub-frame scaling
- [ ] `LazyLoadedScene` wraps `useGLTF` in `<Suspense>` with a wireframe `LoadingPlaceholder` and includes `<Preload all />` from drei
- [ ] `useConditionalFrame` accepts a `condition` callback and a `throttle` interval in seconds; skips the callback when condition is false or throttle has not elapsed
- [ ] `FrustumCulled` component builds a `Frustum` from `camera.projectionMatrix` × `camera.matrixWorldInverse` each frame and sets React `visible` state accordingly
- [ ] Mobile-specific tips cap DPR at 1–1.5, recommend Lambert over Standard material, and limit draw calls to under 100
- [ ] Three.js tips mention `renderer.info` as a runtime draw-call counter
- [ ] Profiling section names React DevTools Profiler, Chrome DevTools Performance tab, and FPS counter as distinct tools

## Version Awareness
- [ ] For React Three Fiber skills: aligns with pinned R3F 9 / drei 10 / three 0.184. `PerformanceMonitor` was introduced in drei; confirm it is present in drei 10. `useGLTF` hook signature (returns `{ scene }`) should be verified against drei 10.

## Known Gaps / Notes
- `FrustumCulled` creates a `new Frustum()` and `new Matrix4()` each frame, generating GC pressure — testers should flag this and recommend pre-allocated refs.
- The `PerformanceStats` component mutates `lastTime` and `frames` as regular variables inside the component body; they will reset on every re-render. Testers should flag that these should be `useRef` values.
- The LOD implementation uses React `useState` to track LOD level, which triggers re-renders every time distance threshold is crossed. A ref-based approach or drei's built-in `<Lod>` component would be preferable.
