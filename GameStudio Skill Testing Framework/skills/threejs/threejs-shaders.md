# Skill Test Spec: /threejs-shaders

> **Category**: threejs · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
A comprehensive GLSL / ShaderMaterial reference for Three.js: `ShaderMaterial` vs `RawShaderMaterial` and their built-in uniform/attribute injections; all uniform types (float, vec2/3/4, Color, mat3/4, sampler2D, samplerCube, arrays); varyings for UV/normal/position; common patterns (texture sampling, vertex displacement, Fresnel effect, noise functions, gradients, rim lighting, dissolve); `onBeforeCompile` for extending built-in materials; GLSL built-in functions reference; instanced-attribute shaders; shader debugging techniques; and performance tips (prefer `mix/step` over `if/else`). Triggered when creating custom visual effects, modifying vertices, writing fragment shaders, or extending built-in materials.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: threejs-shaders` and a `description`
- [ ] Description names GLSL, ShaderMaterial, uniforms, and custom effects
- [ ] Body contains a Quick Start section with minimal `ShaderMaterial` example
- [ ] Body has a separate section comparing `ShaderMaterial` vs `RawShaderMaterial`
- [ ] Body has a "Performance Tips" section with `mix/step` anti-branching advice

## Content Coverage Assertions (`/skill-test spec`)
- [ ] `ShaderMaterial` automatically provides `projectionMatrix`, `modelViewMatrix`, `normalMatrix`, `cameraPosition` uniforms without declaration
- [ ] `RawShaderMaterial` requires explicit `precision highp float;` and all built-in uniform declarations
- [ ] The Fresnel effect uses `cameraPosition` (auto-provided) and `pow(1.0 - dot(viewDir, vNormal), 3.0)`
- [ ] `material.onBeforeCompile` stores `shader` in `material.userData.shader` for later uniform updates
- [ ] Vertex displacement pattern uses `#include <begin_vertex>` injection point
- [ ] `InstancedBufferAttribute` is used to pass per-instance `offset` attribute
- [ ] `renderer.debug.checkShaderErrors = true` is shown for development debugging
- [ ] GLSL `discard` keyword is used in the dissolve effect to clip fragments
- [ ] `glslVersion: THREE.GLSL3` is shown for WebGL2 features

## Version Awareness
- [ ] Aligns with pinned three 0.184; GLSL 1.0 `texture2D` vs GLSL 3.0 `texture()` difference is documented; verify `THREE.GLSL3` constant exists in installed version

## Known Gaps / Notes
- No `NodeMaterial` / TSL (Three.js Shader Language) is covered; this is the WebGPU-forward path in r170+.
- The noise function is value noise; Perlin / simplex noise (often preferred) is not provided.
