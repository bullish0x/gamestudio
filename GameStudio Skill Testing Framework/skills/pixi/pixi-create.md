# Skill Test Spec: /pixi-create

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-create` skill teaches how to scaffold a new PixiJS v8 project using the `create pixi.js` CLI or add PixiJS to an existing project with `npm install pixi.js`. It covers the interactive and non-interactive CLI flows, the `--` separator required on npm 7+, the full table of available templates (`bundler-vite`, `bundler-webpack`, `bundler-esbuild`, `bundler-import-map`, `creation-web`, `framework-react`, `extension-default` and their `-js` variants), post-scaffold dev commands, and the Vite top-level-await production build gotcha. Triggers on: create pixi.js, npm create, scaffold, template, bundler-vite, framework-react, new project, getting started.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-create` and a `description`
- [ ] Description names concrete trigger keywords (create pixi.js, scaffold, bundler-vite, framework-react, existing project)
- [ ] Body contains at least one fenced bash code block showing `npm create pixi.js@latest`
- [ ] Contains a template table listing all available presets with descriptions
- [ ] Contains a "Common Mistakes" section covering the npm `--` separator and Vite top-level await
- [ ] Contains an "API Reference" section linking to the `create-pixi` GitHub repo

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Covers npm/yarn/pnpm/bun command syntax differences (npm requires `--` before flags, others do not)
- [ ] Covers `npm install pixi.js` as the correct approach for adding PixiJS to an existing project
- [ ] Covers using `.` as the project name to scaffold into the current directory
- [ ] Lists `bundler-vite` as the recommended starting point for most new projects
- [ ] Documents the `creation-web` template as a batteries-included platform-tailored starter with AssetPack and scene routing
- [ ] Documents the `framework-react` template as React + TypeScript + PixiJS via `@pixi/react`
- [ ] Covers the post-scaffold flow: `cd`, `npm install`, `npm run dev`
- [ ] Documents the Vite top-level `await app.init()` production build bug and the async IIFE workaround

## Version Awareness
- [ ] Aligns with PixiJS v8 and Node 18+ requirement; flags that some templates require newer Node versions

## Known Gaps / Notes
The skill states templates are maintained in the `create-pixi` repo and the interactive menu shows the current list. Testers should run `npm create pixi.js@latest` interactively to confirm template availability matches the documented table. The `bundler-import-map` template (no-bundler) is useful for quick demos but may not suit production — this nuance is not explicitly noted.
