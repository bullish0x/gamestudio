# Skill Test Spec: /phaser-tilemaps

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers Phaser 4's tilemap system: loading Tiled JSON/CSV maps, the `Tilemap` data container vs `TilemapLayer`/`TilemapGPULayer` rendered game objects, `addTilesetImage()` with tileset name matching, all collision setup methods (`setCollision`, `setCollisionBetween`, `setCollisionByProperty`, `setCollisionByExclusion`, `setCollisionFromCollisionGroup`), Arcade Physics tilemap colliders, tile queries (`getTileAt`, `filterTiles`, `forEachTile`), runtime tile manipulation (`putTileAt`, `fill`, `randomize`, `weightedRandomize`), Tiled object layers (`createFromObjects`), animated tiles, coordinate conversion, isometric/hexagonal maps, and the v4 `TilemapGPULayer` (single quad shader, orthographic only, `generateLayerDataTexture()` required after edits). It triggers on tilemap, Tiled, layer collision, or tile properties questions.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-tilemaps` and a `description`
- [ ] Description names trigger keywords: `Tilemap`, `Tiled`, `tilemap layer`, `tile collision`, `tile properties`
- [ ] Body contains a Quick Start code block showing full flow: `tilemapTiledJSON` → `addTilesetImage` → `createLayer` → `setCollision`
- [ ] `TilemapLayerBase` collision and tile query method tables are present
- [ ] `Tile` class key properties are documented

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents that `addTilesetImage(tilesetName, key)` first argument must match the tileset name in Tiled exactly; mismatch returns `null` with warning
- [ ] Documents that each layer can only be created once; second `createLayer()` with same ID returns `null` with warning
- [ ] Documents `TilemapGPULayer` (v4): pass `gpu: true` as 5th argument to `createLayer()`; single tileset only; orthographic only; requires `generateLayerDataTexture()` after `putTileAt()` calls
- [ ] Documents `TilemapGPULayer` max limits: 4096x4096 tiles, 2^23 unique tile IDs
- [ ] Documents Tiled "Collection of Images" tilesets are NOT supported; all tiles must be in a single tileset image
- [ ] Documents `tile.index === -1` means empty; many methods return `null` for empty tiles; pass `nonNull: true` for a Tile with `index -1` instead of null
- [ ] Documents `insertNull: true` tilemap factory option: stores `null` for empty tiles instead of Tile objects; saves memory for sparse maps but prevents `putTileAt` in empty cells
- [ ] Documents tile property collision: `setCollisionByProperty({ collides: true })` supports arrays: `{ type: ['wall', 'rock'] }`
- [ ] Documents tile callbacks require active physics: `setTileIndexCallback` fires only when a physics collider/overlap between body and layer is active
- [ ] Documents `createFromObjects(layerName, config)` for converting Tiled object layers to Sprites; config can match by `id`, `gid`, `name`, or `type`; supports `classType` for custom classes

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `TilemapGPULayer` is v4-only; `TilemapLayerBase` `ElapseTimer` mixin for animated tiles is v4

## Known Gaps / Notes
Layer position defaulting to Tiled-defined offset (not 0,0) when `x`/`y` not specified in `createLayer` is documented. Multi-tileset layers (CPU layer only, pass array to `createLayer`) are documented. The `weightedRandomize` with `{ index, weight }` array for biased randomization is covered.
