# Skill Test Spec: /pixi-assets

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-assets` skill teaches the PixiJS v8 `Assets` singleton for loading, caching, and unloading resources. It covers `Assets.init` (basePath, manifest, texturePreference, preferences), `Assets.load` with URL/alias/array/UnresolvedAsset forms, the `parser` field for extension-less URLs, bundles and manifests, background loading, `onProgress`/`onError`/`strategy`/`retryCount`, per-asset `data` options for each loader type, `Assets.get`, `Assets.unload`/`Assets.unloadBundle`, `Assets.reset`, and the full table of supported file types. Triggers on: Assets, Assets.load, Assets.init, loadBundle, manifest, backgroundLoad, Spritesheet, Cache, parser, loadParser.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-assets` and a `description`
- [ ] Description names concrete trigger keywords (Assets, Assets.load, Assets.init, manifest, backgroundLoad, Spritesheet, parser)
- [ ] Body contains at least one fenced code example showing `await Assets.load(url)` and `new Sprite(texture)`
- [ ] Contains a supported file types table mapping extensions to parser IDs
- [ ] Contains a "Common Mistakes" section with [CRITICAL] severity for `Texture.from(url)`
- [ ] Contains a topics/reference table linking to sub-reference files (spritesheet.md, fonts.md, bundles.md, manifests.md, etc.)

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Covers `Assets.init({ basePath, manifest, texturePreference, preferences, loadOptions })` options
- [ ] Covers `Assets.load(url)`, `Assets.load([urls])`, `Assets.load({ alias, src, data, parser })` forms
- [ ] Covers the top-level `parser` field for extension-less/signed-CDN URLs with examples for `'texture'`, `'json'`, `'web-font'`, `'video'`
- [ ] Explains that `loadParser` is deprecated in v8 and `parser` should be used instead
- [ ] Covers `LoadOptions` second argument: `onProgress`, `onError`, `strategy: 'throw'|'skip'|'retry'`, `retryCount`, `retryDelay`
- [ ] Covers per-asset `data` options for at least texture (`scaleMode`, `resolution`), web-font (`family`), video (`autoPlay`, `muted`)
- [ ] Covers `Assets.get(alias)` for cache lookup and `Assets.unload` / `Assets.unloadBundle` for cleanup
- [ ] Covers the [CRITICAL] mistake: `Texture.from(url)` only reads cache in v8; must `await Assets.load` first

## Version Awareness
- [ ] Aligns with PixiJS v8 unified `Assets` API; flags that positional `Assets.add('key', url)` was removed in v8 and `Assets.add({ alias, src })` is required

## Known Gaps / Notes
The skill uses reference sub-files for deep topics (spritesheet, video, fonts, gif, bundles, manifests, caching, background, progress, compressed-textures, svg, resolution). A tester should verify at least one of these reference files exists. The skill does not cover the `Resolver` or `Loader` classes directly — those are internal details.
