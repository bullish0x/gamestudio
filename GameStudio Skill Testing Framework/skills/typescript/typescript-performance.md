# Skill Test Spec: /typescript-performance

> **Category**: typescript · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Covers TypeScript performance optimization across three axes: compilation speed (incremental builds, `skipLibCheck`, project references for monorepos), runtime efficiency (typed arrays, object pooling, inline type guards, symbol-keyed private properties), and bundle size (tree shaking via type-only imports, manual chunk splitting in Vite/webpack, dynamic imports). The skill provides ready-to-use `tsconfig.json` and bundler config snippets and documents the performance cost of complex conditional types and large union types.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: typescript-performance` and a `description`
- [ ] Description names trigger keywords (compilation settings, type checking, runtime performance patterns)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Six numbered implementation sections are present (tsconfig, Project References, Type-Only Imports, Efficient Type Patterns, Runtime Performance, Build Optimization)
- [ ] A `## Checklist` section with incremental compilation, tree shaking, and bundle size items is present
- [ ] Three distinct tips sub-sections exist under `## Performance Tips` (Compilation, Runtime, Bundle)

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `tsconfig.json` shows `"incremental": true` and `"tsBuildInfoFile"` together
- [ ] `skipLibCheck: true` is recommended with an explanation (skip checking `.d.ts` files)
- [ ] `moduleResolution: "bundler"` is cited as fastest for bundler setups
- [ ] `import type` syntax is demonstrated and contrasted with a plain `import`
- [ ] Complex recursive conditional type is shown as an anti-pattern alongside a simpler alternative
- [ ] `TypeCache<K, V>` class with `hits`/`misses` counters demonstrates runtime caching
- [ ] `PackedTransforms` using `Float32Array` with a `stride` constant illustrates typed-array packing
- [ ] `VectorPool` with `acquire()` / `release()` demonstrates object pooling to avoid allocations
- [ ] Vite config shows `manualChunks` splitting `three`, `vendor`, and `ecs` into separate chunks
- [ ] `transpileOnly: true` option in ts-loader is noted with the trade-off (skips type checking)

## Version Awareness
- [ ] Vite config references `target: 'es2022'` and `minify: 'esbuild'`; verify these match the project's installed Vite version. Webpack config uses `mode: 'production'` — verify webpack version compatibility if applicable.

## Known Gaps / Notes
- The `ComponentRegistry` usage example calls `this.cache.get(name, () => undefined as any)` as a lookup which returns `undefined as any` — this is acknowledged as a simplification and the `as any` should be flagged in a real code review.
- Mobile-specific bundle tips (lazy load heavy features, code splitting by route) are listed in Performance Tips but not demonstrated with code examples.
