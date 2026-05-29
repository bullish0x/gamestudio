# Skill Test Spec: /react-three-fiber-setup

> **Category**: react · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers complete React Three Fiber project setup for mobile-optimized Three.js games using TypeScript. It provides step-by-step guidance from Vite project scaffolding through Canvas configuration, mobile-adaptive quality tiers, custom game loop hooks, texture utilities, keyboard input hooks, and reusable component primitives (Player, Ground). Core emphasis is on declarative JSX scene authoring, `touch-action: none` CSS, adaptive DPR via `<AdaptiveDpr />`, and performance settings (`performance.min`) to handle low-FPS devices gracefully.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: react-three-fiber-setup` and a `description`
- [ ] Description names concrete trigger keywords: "React Three Fiber", "TypeScript", "mobile-optimized", "Canvas"
- [ ] Body contains at least one fenced code example (bash install block present)
- [ ] Skill has a `## Checklist` section covering setup steps
- [ ] Skill has a `## Common Pitfalls` section
- [ ] Skill has a `## Performance Tips` section
- [ ] Skill references at least one related skill via backtick name

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Includes the exact Vite+TypeScript bootstrap command (`npm create vite@latest ... --template react-ts`) and the three-package install line (`three @react-three/fiber @react-three/drei`)
- [ ] Documents `<Canvas>` props: `dpr={[1, 2]}`, `performance={{ min: 0.5 }}`, `gl.powerPreference: 'high-performance'`, and `shadows`
- [ ] Covers `<AdaptiveDpr pixelated />` and `<AdaptiveEvents />` from `@react-three/drei` for runtime quality scaling
- [ ] Defines a `detectDevice()` / `DeviceInfo` pattern that reads `navigator.deviceMemory` and `navigator.hardwareConcurrency` to assign `'low' | 'medium' | 'high'` tier
- [ ] Documents three quality-tier presets (low/medium/high) with distinct `dpr`, `shadows`, `antialias`, and `performance.min` values
- [ ] Includes a `useGameLoop` hook built on `useFrame` that exposes `deltaTime` and `elapsedTime`
- [ ] Includes a `useGameTexture` hook that disables mipmaps (`generateMipmaps = false`, `LinearFilter`) for mobile
- [ ] Covers `useKeyboard` hook returning an `isPressed(key)` helper via `window.addEventListener('keydown'/'keyup')`
- [ ] CSS snippet sets `touch-action: none` on the container and `canvas { display: block; width: 100%; height: 100% }`
- [ ] Checklist item explicitly mentions testing on actual mobile devices

## Version Awareness
- [ ] For React Three Fiber skills: aligns with pinned R3F 9 / drei 10 / three 0.184. `AdaptiveDpr` and `AdaptiveEvents` exist in drei 10; confirm API has not changed. `@types/three` listed as devDependency — verify still needed with three 0.184 which ships its own declarations.

## Known Gaps / Notes
- The `MobileCanvas` component polls `detectDevice()` twice (once in `useState` initializer and once in `useEffect`) — testers should flag this as redundant.
- `useGameTexture` wraps `useLoader(THREE.TextureLoader, url)` but does not handle texture disposal; testers should verify R3F 9 auto-disposes loaders correctly.
- The `useKeyboard` hook stores keys in React state (`useState<Set<string>>`), which causes re-renders on every keydown/keyup — the spec should note this as a known trade-off vs. a ref-based approach.
