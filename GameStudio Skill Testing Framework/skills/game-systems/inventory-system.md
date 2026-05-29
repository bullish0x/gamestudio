# Skill Test Spec: /inventory-system

> **Category**: game-systems · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a slot-based inventory system with item stacking, equipment, crafting, and pickup mechanics. `ItemDatabase` stores `ItemDefinition` records keyed by ID, with fields for type (`Consumable`, `Equipment`, `Material`, `Quest`), maxStack, optional `EquipmentSlot`, and stat modifiers. `Inventory` manages a fixed-size `InventorySlot[]`, stacking across existing partial stacks before filling empty slots. `Equipment` maps each `EquipmentSlot` to an item ID, computes total armor and damage from all equipped items, and returns the previously equipped item on swap. `InventorySystem` auto-picks up nearby `ItemPickup` entities within radius, updates `Armor` and `Attack` components from equipment stats, and implements `useItem`, `useConsumable`, `equipItem`, and `dropItem` operations with event bus emissions. `CraftingSystem` validates ingredient availability and consumes/produces items atomically.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: inventory-system` and a `description`
- [ ] Description names trigger keywords (item management, stacking, equipment, inventory UI)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Four named implementation sections are present (Item Definitions, Inventory Components, Inventory System, Crafting System)
- [ ] A `## Checklist` section is present with serialization, UI, and item pickup items
- [ ] A `## Common Pitfalls` section warns about full inventory checks and missing item database

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `ItemType` enum includes `Consumable`, `Equipment`, `Material`, and `Quest`
- [ ] `EquipmentSlot` enum includes at least `Head`, `Chest`, `Legs`, `Weapon`, and `Shield`
- [ ] `Inventory.addItem` stacks into existing partial stacks before placing in empty slots
- [ ] `Inventory.addItem` returns `false` when all slots are full
- [ ] `Inventory.removeItem` removes across multiple stacks if quantity spans them
- [ ] `Equipment.equip` returns the previously equipped item ID (or null) for caller handling
- [ ] `Equipment.getTotalArmor` and `getTotalDamage` iterate all equipped slot item IDs via `itemDb.get`
- [ ] `InventorySystem.useConsumable` applies `healAmount` to `Health` component and then removes the item
- [ ] `InventorySystem.equipItem` adds the previously equipped item back to inventory after the swap
- [ ] `CraftingSystem.craft` removes all ingredients before adding the result, making the operation atomic

## Version Awareness
- [ ] The skill is engine-agnostic ECS; no library version pinning is required. The item and inventory patterns are framework-neutral.

## Known Gaps / Notes
- `Inventory.addItem` with a non-stackable item (`maxStack: 1`) will correctly place each unit in a separate slot, but the stacking loop runs first; for `maxStack: 1` items this harmlessly finds no partial stacks and proceeds to empty slots.
- `InventorySystem.dropItem` creates a world entity at `transform.position + (0, 0.5, 0)` but does not add a visual mesh — integration with the renderer is the caller's responsibility.
