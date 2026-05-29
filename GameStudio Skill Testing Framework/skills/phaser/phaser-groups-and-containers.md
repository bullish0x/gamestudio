# Skill Test Spec: /phaser-groups-and-containers

> **Category**: phaser · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
This skill covers three grouping mechanisms in Phaser 4: `Group` (logical collection, object pooling, no transform), `Container` (visual parent with inherited position/rotation/scale/alpha), and `Layer` (render-order bucket with shared alpha/blend/mask but no position). It covers Group config (`classType`, `maxSize`, `runChildUpdate`), `GroupCreateConfig` for batch creation with `setXY`/`gridAlign`, the object pooling API (`get`, `getFirstDead`, `killAndHide`), Container child management and nested transforms, Layer depth ordering, and the critical differences between all three. It triggers when working with groups, object pools, containers, or render layers.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: phaser-groups-and-containers` and a `description`
- [ ] Description names trigger keywords: `Group`, `Container`, `object pool`, `getFirstDead`, `children`
- [ ] Body contains a comparison table of Group vs Container vs Layer covering purpose, display list membership, transform, pooling, and physics
- [ ] Object pooling pattern with `get(x, y)` + `killAndHide()` is shown in code
- [ ] A Gotchas section exists covering at minimum 5 items

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Documents that Group is NOT on the display list; its children are on the Scene's display list individually; moving a Group does nothing visually
- [ ] Documents Group exclusivity: a game object can be in multiple Groups simultaneously (non-exclusive by default)
- [ ] Documents Container is exclusive by default: adding a child removes it from its previous Container; `setExclusive(false)` to override
- [ ] Documents `Container.origin` is always `(0, 0)` and cannot be changed; position children relative to (0, 0)
- [ ] Documents `Container.setScrollFactor(x, y, updateChildren)`: must pass `true` as third argument to propagate to children
- [ ] Documents that `Container` needs `setSize(width, height)` before `setInteractive()` works; Container has no implicit size
- [ ] Documents that `group.create()` adds children to the Scene display list but `group.add()` does NOT unless second argument is `true`
- [ ] Documents `Group.get(x, y)` is shorthand for `getFirst(false, true, x, y)` — finds inactive or creates; contrasts with `getFirst(state)` which defaults to finding inactive without auto-creating
- [ ] Documents Layer limitations: no position, rotation, scale, scroll factor; cannot go inside a Container (Containers CAN go inside Layers)
- [ ] Documents that physics bodies on Container children will be offset if Container is not at (0, 0)

## Version Awareness
- [ ] Aligns with pinned Phaser 4 (WebGL default / Canvas deprecated; RenderNodes replaced v3 pipelines; FX+Masks unified into Filters; removed Point/Mesh/BitmapMask)
- [ ] `Layer` includes `Filters` and `RenderSteps` mixins in v4; verify these are present in the target version

## Known Gaps / Notes
`createMultiple` with array of configs for generating two different sets in one call is documented. The stepping API on Group (`setX(100, 50)` for incremental positioning) is documented. `GroupCreateConfig.yoyo` flag for frame stepping is in the reference but not elaborated. Physics groups are referenced to the arcade physics skill.
