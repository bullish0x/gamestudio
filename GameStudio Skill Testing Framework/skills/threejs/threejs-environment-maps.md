# Skill Test Spec: /threejs-environment-maps

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
Covers environment mapping and image-based lighting (IBL): an `EnvironmentMapManager` that loads HDR/EXR files via `RGBELoader`/`EXRLoader`, generates PMREM, and sets `scene.environment` / `scene.background`; a `ReflectionProbe` using `THREE.CubeCamera` + `WebGLCubeRenderTarget` for dynamic reflections; a `SkyboxBuilder` for gradient, procedural (Rayleigh scattering stub), and cube-map skyboxes; an `EnvironmentPresets` catalogue; and a `ReflectionSystem` for round-robin multi-probe updates. Triggered when creating realistic reflections, IBL, skyboxes, or dynamic mirror/water surfaces.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-environment-maps` and a `description`
- [ ] Description names HDR loading, skyboxes, reflection probes, and IBL
- [ ] Body contains at least one fenced TypeScript code example
- [ ] Body has a resolution-by-platform recommendation table
- [ ] Body has external references to PMREMGenerator docs and HDRI sources

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `PMREMGenerator.compileEquirectangularShader()` is called before loading
- [ ] After PMREM generation `hdrTexture.dispose()` is called to free the raw texture
- [ ] `scene.environment = envMap` applies IBL to all PBR materials automatically
- [ ] `scene.backgroundBlurriness` is set when using the env map as a background
- [ ] `scene.environmentIntensity` is set to control IBL strength
- [ ] `ReflectionProbe` uses `THREE.CubeCamera` with a `WebGLCubeRenderTarget`
- [ ] `ReflectionProbe.excludeObject()` hides objects during the cube-camera render pass
- [ ] `SkyboxBuilder.createGradientSky` uses `THREE.BackSide` on a sphere with a custom `ShaderMaterial`
- [ ] `ReflectionSystem.update()` updates exactly one probe per `updateInterval` (round-robin)

## Version Awareness
- [ ] Aligns with pinned three 0.184; `RGBELoader` and `EXRLoader` import from `three/addons/loaders/` — verify path; `scene.backgroundBlurriness` and `scene.environmentIntensity` were added in r155+ — confirm availability at 0.184

## Known Gaps / Notes
- `SkyboxBuilder.createProceduralSky` is a simplified stub (basic Rayleigh colour, not full scattering); production should use the `Sky` addon from `three/addons/objects/Sky.js`.
- `EnvironmentPresets` references hardcoded `/textures/env/` paths that consumers must provide.
