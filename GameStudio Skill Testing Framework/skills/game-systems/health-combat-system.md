# Skill Test Spec: /health-combat-system

> **Category**: game-systems · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a data-driven health and combat system with six cooperating components and a central `CombatSystem`. `Health` tracks current/max HP, regen rate, and timed invulnerability. `Armor` applies percentage reduction before flat reduction. `Attack` holds damage, range, cooldown, and damage type. `StatusEffect` handles DoT/HoT/stat-modifier effects with per-tick interval, stack count, and `getEffectiveValue()`. `StatusEffects` container refreshes duration and adds stacks on re-application. `DamageResistances` maps damage type strings to 0-1 multipliers. `CombatSystem` coordinates cooldown ticking, invulnerability countdown, range-based auto-attack processing, status effect ticking, health regen, and death detection — all via event bus emissions (`DamageEvent`, `DeathEvent`).

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: health-combat-system` and a `description`
- [ ] Description names trigger keywords (damage, healing, armor, status effects, combat mechanics)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Four named implementation sections are present (Health Components, Status Effects, Combat System, Damage Types System)
- [ ] A `## Checklist` section is present with invulnerability, events, and balance items
- [ ] A `## Common Pitfalls` section warns about hitting multiple times per frame without invulnerability

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `Health.damage(amount)` does nothing when `isInvulnerable` is true
- [ ] `Health.setInvulnerable(duration)` sets both `isInvulnerable = true` and stores `invulnerabilityDuration`
- [ ] `Armor.calculateReduction` applies percentage reduction first, then subtracts flat armor, with `Math.max(0, ...)` floor
- [ ] `Attack.canAttack()` returns `cooldown <= 0` and `startCooldown()` resets to `cooldownTime`
- [ ] `StatusEffectType` enum includes `Poison`, `Burn`, `Freeze`, `Slow`, `Stun`, `Regeneration`, `Strength`, `Weakness`
- [ ] `StatusEffects.add` refreshes `remainingTime` to the max of existing and new duration on re-application
- [ ] `CombatSystem.applyDamage` grants 0.1 s invulnerability after applying damage (`health.setInvulnerable(0.1)`)
- [ ] `CombatSystem.applyStatusEffect` calls `health.damage(value)` for Poison/Burn and `health.heal(value)` for Regeneration
- [ ] `DamageResistances.calculateDamage` multiplies `baseDamage` by the resistance value for the given type
- [ ] `CombatSystem.checkDeaths` sets `entity.active = false` and emits `DeathEvent` when HP reaches 0

## Version Awareness
- [ ] The skill is engine-agnostic ECS; no library version pinning is required. The combat formulas and status effect patterns are framework-neutral.

## Known Gaps / Notes
- Range-based auto-attack in `processAttacks` calls `startCooldown()` after the first in-range target is found and breaks — it will only attack one target per tick even if multiple are in range.
- `DamageResistances.setResistance` uses a string key cast via `as keyof DamageResistance`; invalid type strings would silently be ignored rather than producing a type error.
