# Skill Test Spec: /phaser-loading-assets

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers Phaser 4's Loader plugin (`this.load`) for queuing and loading all external assets in `preload()` or dynamically via `load.start()`. Topics include all file types (image, spritesheet, atlas, atlasXML, multiatlas, aseprite, svg, audio, audioSprite, video, font, bitmapFont, json, xml, tilemapTiledJSON, tilemapCSV, pack, script, plugin), URL resolution via `baseURL`/`path`/`prefix`, global cache system (`this.textures`, `this.cache.json`, etc.), load events (progress, filecomplete, loaderror), progress bar pattern, Scene payload for pre-preload loading, mid-load file chaining via `filecomplete-json-key`, and pack file manifests. It triggers on any asset loading, spritesheet, atlas, or load progress scenario.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-loading-assets` and a `description`
- [ ] Description names trigger keywords: `preload`, `this.load`, `asset loading`, `spritesheet`, `atlas`, `load progress`
- [ ] Body contains a preload → create lifecycle code example using `this.load.image` and `this.add.image`
- [ ] Load events table with at minimum `progress`, `filecomplete`, `filecomplete-{type}-{key}`, `loaderror`, and `complete` is present
- [ ] The event lifecycle order (start → fileprogress → load → filecomplete-key → filecomplete → progress → postprocess → complete) is documented

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents that loading outside `preload()` requires manual `this.load.start()` call and a `complete` event listener
- [ ] Documents URL resolution formula: `baseURL + path + filename`; absolute URLs bypass path and baseURL
- [ ] Distinguishes `spritesheet()` (fixed frame sizes, indexed) from `atlas()` (packed, named frames); common source of confusion
- [ ] Documents `filecomplete-{type}-{key}` event pattern for per-file completion: `'filecomplete-image-hero'`
- [ ] Documents that assets are stored in global caches shared across all Scenes; loaded in one scene = available in all
- [ ] Documents `this.load.setPrefix(key)` effect: prefixed key must be used when referencing the asset (e.g. `'MENU.bg'`)
- [ ] Documents Scene payload (`pack` in constructor config) for loading assets before `preload()` runs — needed for progress bar images
- [ ] Documents mid-load chaining: listen for `filecomplete-json-level1` inside `preload()` to add more files based on the loaded JSON data
- [ ] Documents `maxRetries` default of 2 (changed from v3's default of 0)
- [ ] Documents cache removal for memory management: `this.textures.remove('key')` and `this.cache.audio.remove('key')`

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `loader.maxRetries` default changed to 2 in v4; `this.load.font()` for web fonts loading is available in v4; verify in target version
- [ ] `imageLoadType: 'XHR'` vs `'HTMLImageElement'` config option is available in v4

## Known Gaps / Notes
The skill references `references/REFERENCE.md` for the complete source file map and Cache API reference — these details are not inline in SKILL.md. Compressed texture loading (`this.load.texture()`) is listed in the file types reference but not elaborated. The `localSchemes` property for `file://` and `capacitor://` handling is documented in Gotchas.
