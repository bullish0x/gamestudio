# Skill Test Spec: /level-system

> **Category**: game-systems · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a character progression system with XP-based leveling, stat allocation, skill trees, and achievements. `Experience` implements an exponential XP curve (`100 * level^1.5`), accumulates XP, detects multi-level-up sequences, and returns newly gained levels. `Stats` separates base and bonus values for four stats (strength, agility, intelligence, vitality) with `availablePoints` for player allocation. `LevelSystem` grants XP, fires `LevelUpEvent`, awards 5 stat points per level, fully restores health on level-up, and derives combat stats from totals (vitality → max HP, strength → attack damage). `SkillTree` enforces prerequisites, level requirements, cost deduction, and per-skill rank caps. `AchievementManager` tracks unlock state and numeric progress, grants XP rewards on unlock, and integrates with event bus listeners. Three progression curve helpers (linear, exponential, logarithmic) and a `PrestigeSystem` are also provided.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: level-system` and a `description`
- [ ] Description names trigger keywords (experience, leveling, skill trees, stat progression)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Four named implementation sections are present (Experience and Level Components, Level System, Skill Tree System, Achievement System)
- [ ] A `## Checklist` section is present with serialization, balance, and UI items
- [ ] A `## Common Pitfalls` section warns against unbalanced curves and missing serialization

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `Experience.getRequiredXP(level)` computes `Math.floor(100 * Math.pow(level, 1.5))`
- [ ] `Experience.addXP` loops until XP < required for current level, accumulating `levelsGained` and capping at `maxLevel`
- [ ] `Stats.getTotal(stat)` returns `base[stat] + bonuses[stat]`
- [ ] `Stats.addPoint(stat)` decrements `availablePoints` and returns `false` if none remain
- [ ] `LevelSystem.grantXP` calls `experience.addXP`, emits `XPGainedEvent`, and calls `onLevelUp` for each gained level
- [ ] `LevelSystem.onLevelUp` grants 5 stat points, emits `LevelUpEvent`, and fully heals the entity
- [ ] `SkillTree.canUnlock` checks `requiredLevel`, `cost <= availablePoints`, current rank < `maxRank`, and all prerequisites unlocked
- [ ] `Skills.unlockSkill` deducts the skill's `cost` from `this.points` before calling `tree.unlock`
- [ ] `AchievementManager.unlock` grants `rewards.xp` via `experience.addXP` and emits `AchievementUnlockedEvent`
- [ ] `ProgressionCurve` provides static `linear`, `exponential`, and `logarithmic` helper functions

## Version Awareness
- [ ] The skill is engine-agnostic ECS; no library version pinning is required. Progression curve formulas are pure math with no library dependencies.

## Known Gaps / Notes
- `AchievementManager.setProgress` checks `if (progress >= 1)` but does not call `unlock` — the actual unlock-on-complete logic is left as a comment stub for the caller to implement.
- `PrestigeSystem.prestige` resets `experience.level` directly without going through `LevelSystem`, bypassing the level-up event chain; callers should wire this manually.
