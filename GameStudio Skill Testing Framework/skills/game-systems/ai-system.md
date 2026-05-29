# Skill Test Spec: /ai-system

> **Category**: game-systems · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Provides a full AI architecture for game entities using two complementary decision models. The `StateMachine` class supports named states with `onEnter`/`onUpdate`/`onExit` hooks and data-driven `Transition` predicates. The Behavior Tree implementation provides `SequenceNode`, `SelectorNode`, `ParallelNode`, `InverterNode`, and `RepeaterNode` composites plus `ActionNode` and `ConditionNode` leaves, all returning a `NodeStatus` enum. `AIController` and `Steering` components hold perception ranges, patrol points, and per-frame steering force accumulators. `AIDecisionSystem` runs at 10 Hz, handles perception (sight range, field-of-view cone check), and delegates to FSM or behavior tree. `SteeringSystem` applies and normalizes combined seek/flee/arrive/wander forces, with static helper methods for each behavior. A `FlockingSystem` demonstrates separation, alignment, and cohesion.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: ai-system` and a `description`
- [ ] Description names trigger keywords (behavior trees, finite state machines, steering behaviors, decision making)
- [ ] Body contains at least one fenced `typescript` code block
- [ ] Five named implementation sections are present (Finite State Machine, Behavior Tree, AI Components, AI Decision System, Steering Behaviors System)
- [ ] A `## Checklist` section is present with AI architecture, perception, and debug visualization items
- [ ] A `## Performance Tips` section includes AI update frequency and LOD guidance

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `StateMachine.update` checks all transitions for the current state and calls `start` on the first matching one
- [ ] `NodeStatus` enum defines `Success`, `Failure`, and `Running`
- [ ] `SequenceNode` resets and returns `Failure` on the first child failure; advances the index on `Success`
- [ ] `SelectorNode` resets and returns `Success` on the first child success; advances on `Failure`
- [ ] `ParallelNode` accepts a `successThreshold` parameter to allow partial success
- [ ] `RepeaterNode` runs the child `maxCount` times and returns `Running` until complete
- [ ] `AIController` component has `sightRange`, `fieldOfView`, `patrolPoints`, `alertLevel`, and `target` fields
- [ ] `AIDecisionSystem` tick rate is 10 Hz (interval system at 10)
- [ ] Perception check uses `Math.acos(forward.dot(toTarget))` to compute angle to target and compares against `fieldOfView / 2`
- [ ] `SteeringSystem.arrive` slows velocity proportionally when within `slowingRadius`
- [ ] `SteeringSystem.wander` updates `wanderAngle` with a random delta and projects onto a circle ahead of the agent

## Version Awareness
- [ ] The skill is engine-agnostic ECS; no library version pinning is required. The behavior tree and steering patterns are framework-neutral and work with any ECS implementation.

## Known Gaps / Notes
- Line-of-sight raycasting is noted as `TODO` in the perception code — the actual raycast call is deferred to the `collision-system` skill.
- `AIDecisionSystem` extends `IntervalSystem` which is not defined in this skill — it is assumed from the ECS system patterns layer.
