# Skill Test Spec: /phaser-actions-and-utilities

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers the `Phaser.Actions` namespace for performing one-shot batch operations on arrays of game objects (SetX/Y, SetAlpha, SetTint, IncX/Y, GridAlign, PlaceOnCircle, Spread, ShiftPosition, WrapInRectangle, PlayAnimation, AddEffectBloom, etc.), plus `Phaser.Utils.Array`, `Phaser.Utils.Objects`, and `Phaser.Utils.String` helper functions. It triggers when working with batch positioning, grid layout, alignment, distribution, scatter operations, or utility functions like `GetValue`, `GetFastValue`, `DeepCopy`, `StableSort`, and `UUID`.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-actions-and-utilities` and a `description`
- [ ] Description names concrete trigger keywords including `align`, `grid layout`, `actions`, and `set operations`
- [ ] Body contains at least one fenced code example demonstrating `Phaser.Actions.GridAlign`
- [ ] Skill documents both the `Phaser.Actions` namespace tables AND `Phaser.Utils.Array`, `Phaser.Utils.Objects`, and `Phaser.Utils.String` sub-namespaces
- [ ] A Gotchas section exists and mentions that Actions operate on arrays, not Groups directly

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents that every Action's first argument is an array of game objects and that it returns the same array
- [ ] Distinguishes `PropertyValueSet` (sets `value + i*step`) from `PropertyValueInc` (adds `value + i*step`) and explains the `step` parameter semantics
- [ ] Documents the placement geometry actions (`PlaceOnCircle`, `RandomRectangle`, etc.) and notes they require `Phaser.Geom` objects, NOT Game Object shapes, directing users to pass `.geom` for GameObjects
- [ ] Covers the v4-only effect actions: `AddEffectBloom`, `AddEffectShine`, and `AddMaskShape` with their return behavior (arrays of created effects)
- [ ] Covers `FitToRegion` (v4.0.0+) with its `scaleMode` values: 0=stretch, -1=fit inside, 1=cover outside
- [ ] Explains the `step` multiplication formula: item 0 gets `value + 0*step`, item 1 gets `value + 1*step`
- [ ] Documents `Phaser.Utils.Objects.GetValue` (dot-path lookup) vs `GetFastValue` (top-level only, faster) and when to prefer each
- [ ] Documents `Phaser.Utils.Array.StableSort` and notes it uses native sort when stable, merge-sort fallback otherwise
- [ ] Documents `Phaser.Utils.String.UUID` for RFC4122 v4 UUID generation and `Format` for `%1`/`%2` marker replacement
- [ ] Notes that `Spread` with a single item places it at `(min + max) / 2`, not at `min`

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask); flags any API to verify against the installed version
- [ ] `AddEffectBloom`, `AddEffectShine`, `AddMaskShape`, and `FitToRegion` are flagged as v4-only

## Known Gaps / Notes
The skill does not cover `Phaser.Actions.AlignTo` with `Phaser.Display.Align` constants in depth. The `Utils.Array.Matrix` sub-namespace for 2D matrix operations is listed but not elaborated. `Phaser.Utils.Objects.GetAdvancedValue` (random/callback config resolution) is documented but testers should verify it resolves all value formats described in the particles skill.
