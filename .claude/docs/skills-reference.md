# Available Skills (Slash Commands)

130 slash commands organized by phase. Type `/` in Claude Code to access any of them.

## Onboarding & Navigation

| Command | Purpose |
|---------|---------|
| `/start` | First-time onboarding — asks where you are, then guides you to the right workflow |
| `/help` | Context-aware "what do I do next?" — reads current stage and surfaces the required next step |
| `/project-stage-detect` | Full project audit — detect phase, identify existence gaps, recommend next steps |
| `/setup-engine` | Configure engine + version, detect knowledge gaps, populate version-aware reference docs |
| `/adopt` | Brownfield format audit — checks internal structure of existing GDDs/ADRs/stories, produces migration plan |

## Game Design

| Command | Purpose |
|---------|---------|
| `/brainstorm` | Guided ideation using professional studio methods (MDA, SDT, Bartle, verb-first) |
| `/map-systems` | Decompose game concept into systems, map dependencies, prioritize design order |
| `/design-system` | Guided, section-by-section GDD authoring for a single game system |
| `/quick-design` | Lightweight design spec for small changes — tuning, tweaks, minor additions |
| `/review-all-gdds` | Cross-GDD consistency and game design holism review across all design docs |
| `/propagate-design-change` | When a GDD is revised, find affected ADRs and produce an impact report |

## Art & Assets

| Command | Purpose |
|---------|---------|
| `/art-bible` | Guided, section-by-section Art Bible authoring — creates visual identity spec before asset production begins |
| `/asset-spec` | Generate per-asset visual specifications and AI generation prompts from GDDs, level docs, or character profiles |
| `/asset-audit` | Audit assets for naming conventions, file size budgets, and pipeline compliance |

## UX & Interface Design

| Command | Purpose |
|---------|---------|
| `/ux-design` | Guided section-by-section UX spec authoring (screen/flow, HUD, or pattern library) |
| `/ux-review` | Validate UX specs for GDD alignment, accessibility, and pattern compliance |

## Architecture

| Command | Purpose |
|---------|---------|
| `/create-architecture` | Guided authoring of the master architecture document |
| `/architecture-decision` | Create an Architecture Decision Record (ADR) |
| `/architecture-review` | Validate all ADRs for completeness, dependency ordering, and GDD coverage |
| `/create-control-manifest` | Generate flat programmer rules sheet from accepted ADRs |

## Stories & Sprints

| Command | Purpose |
|---------|---------|
| `/create-epics` | Translate GDDs + ADRs into epics — one per architectural module |
| `/create-stories` | Break a single epic into implementable story files |
| `/dev-story` | Read a story and implement it — routes to the correct programmer agent |
| `/sprint-plan` | Generate or update a sprint plan; initializes sprint-status.yaml |
| `/sprint-status` | Fast 30-line sprint snapshot (reads sprint-status.yaml) |
| `/story-readiness` | Validate a story is implementation-ready before pickup (READY/NEEDS WORK/BLOCKED) |
| `/story-done` | 8-phase completion review after implementation; updates story file, surfaces next story |
| `/estimate` | Structured effort estimate with complexity, dependencies, and risk breakdown |

## Reviews & Analysis

| Command | Purpose |
|---------|---------|
| `/design-review` | Review a game design document for completeness and consistency |
| `/code-review` | Architectural code review for a file or changeset |
| `/balance-check` | Analyze game balance data, formulas, and config — flag outliers |
| `/content-audit` | Audit GDD-specified content counts against implemented content |
| `/scope-check` | Analyze feature or sprint scope against original plan, flag scope creep |
| `/perf-profile` | Structured performance profiling with bottleneck identification |
| `/tech-debt` | Scan, track, prioritize, and report on technical debt |
| `/gate-check` | Validate readiness to advance between development phases (PASS/CONCERNS/FAIL) |
| `/consistency-check` | Scan all GDDs against the entity registry to detect cross-document inconsistencies (stats, names, rules that contradict each other) |
| `/security-audit` | Audit the game for security vulnerabilities: save tampering, cheat vectors, network exploits, data exposure, and input validation gaps |

## QA & Testing

| Command | Purpose |
|---------|---------|
| `/qa-plan` | Generate a QA test plan for a sprint or feature |
| `/smoke-check` | Run critical path smoke test gate before QA hand-off |
| `/soak-test` | Generate a soak test protocol for extended play sessions |
| `/regression-suite` | Map test coverage to GDD critical paths, identify fixed bugs without regression tests |
| `/test-setup` | Scaffold the test framework and CI/CD pipeline for the project's engine |
| `/test-helpers` | Generate engine-specific test helper libraries for the test suite |
| `/test-evidence-review` | Quality review of test files and manual evidence documents |
| `/test-flakiness` | Detect non-deterministic (flaky) tests from CI run logs |
| `/skill-test` | Validate skill files for structural compliance and behavioral correctness |
| `/skill-improve` | Improve a skill using a test-fix-retest loop — diagnose, propose fix, rewrite, verify |

## Production

| Command | Purpose |
|---------|---------|
| `/milestone-review` | Review milestone progress and generate status report |
| `/retrospective` | Run a structured sprint or milestone retrospective |
| `/bug-report` | Create a structured bug report |
| `/bug-triage` | Read all open bugs, re-evaluate priority vs. severity, assign owner and label |
| `/reverse-document` | Generate design or architecture docs from existing implementation |
| `/playtest-report` | Generate a structured playtest report or analyze existing playtest notes |

## Release

| Command | Purpose |
|---------|---------|
| `/release-checklist` | Generate and validate a pre-release checklist for the current build |
| `/launch-checklist` | Complete launch readiness validation across all departments |
| `/changelog` | Auto-generate changelog from git commits and sprint data |
| `/patch-notes` | Generate player-facing patch notes from git history and internal data |
| `/hotfix` | Emergency fix workflow with audit trail, bypassing normal sprint process |
| `/day-one-patch` | Prepare a focused day-one patch for known issues discovered after gold master but before or at public launch |

## Creative & Content

| Command | Purpose |
|---------|---------|
| `/prototype` | Concept prototype — throwaway build right after brainstorm to validate core idea (Phase 1) |
| `/vertical-slice` | Pre-Production validation — production-quality end-to-end build before committing to Production (Phase 4) |
| `/onboard` | Generate contextual onboarding document for a new contributor or agent |
| `/localize` | Localization workflow: string extraction, validation, translation readiness |

## Team Orchestration

Coordinate multiple agents on a single feature area:

| Command | Coordinates |
|---------|-------------|
| `/team-combat` | game-designer + gameplay-programmer + ai-programmer + technical-artist + sound-designer + qa-tester |
| `/team-narrative` | narrative-director + writer + world-builder + level-designer |
| `/team-ui` | ux-designer + ui-programmer + art-director + accessibility-specialist |
| `/team-release` | release-manager + qa-lead + devops-engineer + producer |
| `/team-polish` | performance-analyst + technical-artist + sound-designer + qa-tester |
| `/team-audio` | audio-director + sound-designer + technical-artist + gameplay-programmer |
| `/team-level` | level-designer + narrative-director + world-builder + art-director + systems-designer + qa-tester |
| `/team-live-ops` | live-ops-designer + economy-designer + community-manager + analytics-engineer |
| `/team-qa` | qa-lead + qa-tester + gameplay-programmer + producer |

## Web Game Development

57 skills feeding the web engine agents (Three.js, React Three Fiber, PixiJS). Invocable like any other skill.

### 3D Rendering (Three.js)

| Command | Purpose |
|---------|---------|
| `/threejs-scene-setup` | Set up a Three.js scene with best practices for performance, organization, and maintainability |
| `/threejs-geometry-management` | Efficient geometry creation, management, and optimization including BufferGeometry, instancing, and custom geometry for mobile performance |
| `/threejs-material-systems` | Comprehensive material management including all Three.js material types, custom shaders, material pooling, and mobile optimization |
| `/threejs-texture-management` | Texture loading, compression, atlasing, and memory optimization for mobile Three.js applications |
| `/threejs-raycasting` | Mouse and touch interaction using raycasting for object picking, collision detection, and UI interaction in Three.js |
| `/threejs-animation-systems` | Three.js animation implementation with AnimationMixer, clips, actions, blending, and skeletal animation for characters |
| `/threejs-model-loading` | Load and optimize 3D models in GLTF, FBX, and OBJ formats with compression, progressive loading, and mobile optimization |
| `/threejs-camera-controls` | Camera systems for Three.js including orbit controls, first-person, third-person, and cinematic cameras |
| `/threejs-lighting` | Comprehensive lighting systems for Three.js including ambient, directional, point, spot, and hemisphere lights with optimization strategies |
| `/threejs-shadows` | Shadow configuration and optimization for Three.js including shadow maps, CSM, PCFSS, and mobile shadow strategies |
| `/threejs-post-processing` | Post-processing effects for Three.js including bloom, SSAO, DOF, tone mapping, and custom shader passes |
| `/threejs-particles` | Particle systems for Three.js including GPU particles, instanced particles, particle emitters, and effects |
| `/threejs-performance-profiling` | Performance profiling and optimization for Three.js including FPS monitoring, draw call analysis, memory profiling, and bottleneck identification |
| `/threejs-pbr-materials` | Physically-Based Rendering materials in Three.js including metalness-roughness workflow, clear coat, transmission, and material optimization |
| `/threejs-math-utilities` | Essential math utilities for Three.js game development including vector operations, quaternions, interpolation, curves, and collision helpers |
| `/threejs-fog` | Fog and atmospheric effects in Three.js including linear fog, exponential fog, distance-based fading, and custom atmospheric shaders |
| `/threejs-environment-maps` | Environment mapping and IBL (Image-Based Lighting) in Three.js including HDRI loading, skyboxes, reflection probes, and dynamic environment maps |
| `/threejs-instancing-advanced` | Advanced instancing techniques in Three.js including InstancedMesh, dynamic updates, LOD instancing, frustum culling, and custom attributes |
| `/threejs-sprites` | Sprites and billboards in Three.js including sprite materials, texture atlases, sprite animation, and particle sprites |
| `/threejs-best-practices` | Comprehensive best practices for Three.js development including optimization, architecture, debugging, and production deployment |
| `/threejs-loaders` | Three.js asset loading - GLTF, textures, images, models, async patterns. Use when loading 3D models, textures, HDR environments, or managing loading progress. |
| `/threejs-shaders` | Three.js shaders - GLSL, ShaderMaterial, uniforms, custom effects. Use when creating custom visual effects, modifying vertices, writing fragment shaders, or extending built-in materials. |
| `/threejs-postprocessing` | Three.js post-processing - EffectComposer, bloom, DOF, screen effects. Use when adding visual effects, color grading, blur, glow, or creating custom screen-space shaders. |
| `/threejs-animation` | Three.js animation - keyframe animation, skeletal animation, morph targets, animation mixing. Use when animating objects, playing GLTF animations, creating procedural motion, or blending animations. |

### React Three Fiber

| Command | Purpose |
|---------|---------|
| `/react-three-fiber-setup` | Complete React Three Fiber setup for mobile-optimized Three.js games with TypeScript, performance configuration, and best practices |
| `/r3f-ecs-integration` | Integrate Entity Component System architecture with React Three Fiber for high-performance declarative 3D games |
| `/r3f-component-patterns` | Advanced React Three Fiber component patterns including reusable components, hooks, composition, and performance optimization |
| `/r3f-performance` | React Three Fiber performance optimization with memoization, instancing, LOD, suspense, and mobile-specific optimizations |
| `/r3f-state-management` | State management in React Three Fiber using Zustand, React Context, and global stores for game state |
| `/r3f-mobile-patterns` | Mobile-specific React Three Fiber patterns including touch controls, device adaptation, battery optimization, and responsive layouts |

### Entity Component System

| Command | Purpose |
|---------|---------|
| `/ecs-architecture` | Design and implement Entity Component System architecture with TypeScript for game development |
| `/ecs-component-patterns` | Advanced ECS component design patterns including tag components, singleton components, shared data, and component pools |
| `/ecs-system-patterns` | Common system patterns in ECS including update systems, reactive systems, interval systems, and system priorities |
| `/ecs-queries` | Efficient entity queries in ECS including archetype-based queries, filtered queries, cached queries, and query optimization |
| `/ecs-events` | Event-driven architecture in ECS including event buses, typed events, event queues, and event-based system communication |
| `/ecs-serialization` | Serializing and deserializing ECS worlds including save/load systems, component serialization, entity prefabs, and network synchronization |
| `/ecs-performance` | Performance optimization for ECS including archetype optimization, memory pooling, cache-friendly data structures, and profiling techniques |

### Mobile Optimization

| Command | Purpose |
|---------|---------|
| `/mobile-performance` | Comprehensive mobile optimization strategies for Three.js games including device detection, quality scaling, thermal throttling, and battery management |
| `/touch-input-handling` | Comprehensive touch input system for mobile Three.js games including gestures, virtual joystick, and multi-touch support |
| `/battery-optimization` | Mobile battery optimization techniques including adaptive quality, power-efficient rendering, and background behavior |
| `/memory-management` | Mobile memory management including resource disposal, memory pooling, texture management, and leak prevention |

### TypeScript

| Command | Purpose |
|---------|---------|
| `/typescript-game-types` | Type-safe patterns for game development with TypeScript, including branded types, strict null checks, and performance-focused type design |
| `/typescript-performance` | TypeScript performance optimization including compilation settings, type checking, and runtime performance patterns |
| `/typescript-ecs-types` | TypeScript type patterns for Entity Component Systems including type-safe queries, component types, and system patterns |

### Game Systems

| Command | Purpose |
|---------|---------|
| `/ai-system` | AI system for game entities including behavior trees, finite state machines, steering behaviors, and decision making |
| `/audio-system` | Audio system for games including sound effects, music, spatial audio, and audio management with Web Audio API |
| `/camera-system` | Camera system for games including follow camera, orbit controls, shake effects, and cinematic cameras |
| `/collision-system` | ECS collision detection system with spatial partitioning, broadphase/narrowphase, AABB, and sphere collision for mobile games |
| `/health-combat-system` | Health and combat system including damage, healing, armor, status effects, and combat mechanics |
| `/input-system` | Unified input system for ECS games supporting keyboard, mouse, touch, and gamepad with action mapping and input buffering |
| `/inventory-system` | Inventory system for games including item management, stacking, equipment, and inventory UI |
| `/level-system` | Level and progression system including experience, leveling, skill trees, and stat progression |
| `/physics-system` | Physics simulation system for ECS including rigid body dynamics, forces, constraints, and integration with physics engines |
| `/spawn-system` | Spawn system for games including entity spawning, spawn pools, waves, and spawn points |
| `/ui-system` | UI system for games including HUD elements, menus, health bars, damage numbers, and UI state management |

### Foundations & 2D

| Command | Purpose |
|---------|---------|
| `/web-game-foundations` | Set browser-game architecture before implementation. Use when the user needs engine choice, simulation and render boundaries, input model, asset organization, or save/debug/performance strategy. |
| `/phaser-2d-game` | Implement 2D browser games with Phaser. Use when the user wants a Phaser, TypeScript, and Vite stack for scenes, gameplay systems, cameras, sprite animation, and DOM-overlay HUD patterns. |
