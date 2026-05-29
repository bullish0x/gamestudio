# Skill Test Spec: /pixi-accessibility

> **Category**: pixi · **Skill type**: knowledge/reference · **Spec written**: 2026-05-29

## Skill Summary
The `/pixi-accessibility` skill teaches how to add screen reader and keyboard navigation support to PixiJS v8 applications via `AccessibilitySystem`. It covers the shadow DOM overlay mechanism, per-container accessible properties (`accessible`, `accessibleTitle`, `accessibleHint`, `accessibleText`, `accessibleType`, `tabIndex`, `accessibleChildren`, `accessiblePointerEvents`), `accessibilityOptions` in `app.init`, runtime enable/disable via `setAccessibilityEnabled`, mobile touch-hook activation, and the requirement to `import 'pixi.js/accessibility'` in custom builds. Triggers on: accessibility, a11y, screen reader, ARIA, keyboard navigation, tab order, AccessibilitySystem, accessibleTitle, tabIndex.

## Static Assertions (`/skill-test static`)
- [ ] Frontmatter has `name: pixi-accessibility` and a `description`
- [ ] Description names concrete trigger keywords (accessibility, a11y, AccessibilitySystem, accessibleTitle, tabIndex)
- [ ] Body contains at least one fenced code example demonstrating `accessible = true`, `accessibleTitle`, and `eventMode = 'static'`
- [ ] Contains a "Common Mistakes" section with severity tags (MEDIUM)
- [ ] Contains an "API Reference" section with links to `AccessibilitySystem`, `AccessibilitySystemOptions`

## Content Coverage Assertions (`/skill-test spec`)
- [ ] Covers all per-container accessible properties: `accessible`, `accessibleTitle`, `accessibleHint`, `accessibleText`, `accessibleType`, `tabIndex`, `accessibleChildren`, `accessiblePointerEvents`
- [ ] Covers `accessibilityOptions` in `app.init` with all four options: `enabledByDefault`, `debug`, `activateOnTab`, `deactivateOnMouseMove`
- [ ] Covers `app.renderer.accessibility.setAccessibilityEnabled(true)` for runtime activation
- [ ] Covers `AccessibilitySystem.defaultOptions` static configuration
- [ ] Explains that `tabIndex` is only forwarded when `eventMode` is `'static'` or `'dynamic'`
- [ ] Explains default "activate on Tab" behavior and why `enabledByDefault: true` is needed for automated testing
- [ ] Covers the limitation that `AccessibilitySystem` is not available in Web Workers
- [ ] Explains the side-effect import `import 'pixi.js/accessibility'` required for custom builds with `skipExtensionImports: true`

## Version Awareness
- [ ] Aligns with PixiJS v8 (`await Application.init`, `app.renderer.accessibility` not `app.renderer.plugins.accessibility`); no v7 `InteractionManager` references

## Known Gaps / Notes
The skill does not cover screen-reader announcements via ARIA live regions — only the static shadow DOM overlay. Testers should confirm the skill clearly explains that shadow DOM events (`click`, `pointertap`, `tap`, `mouseover`, `mouseout`) are dispatched when accessibility is active.
