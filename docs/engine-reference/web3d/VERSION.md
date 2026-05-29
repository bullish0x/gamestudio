# Web 3D (Three.js / React Three Fiber) — VERSION

Reference versions for the web 3D stack, verified **2026-05-29**. When a project
installs specific versions, update the table to match — the web 3D agents
(`threejs-specialist`, `webgl-shader-specialist`, `web3d-asset-pipeline`) read
this file to verify APIs against the installed release rather than relying on
training data.

| Package | Reference version | Verified |
| ------- | ----------------- | -------- |
| `three` | `0.184.0` | 2026-05-29 |
| `@react-three/fiber` | `9.6.1` | 2026-05-29 |
| `@react-three/drei` | `10.7.7` | 2026-05-29 |
| loaders/decoders (`GLTFLoader`, `DRACOLoader`, `KTX2Loader`, `MeshoptDecoder`) | ship with `three` (`three/addons/...`) | 2026-05-29 |

## Knowledge-gap window

The model's training cutoff vs the pinned `three` release defines the gap window.
Three.js deprecates APIs aggressively across releases — within this window treat
any Three.js / R3F API you are unsure about as **verify-before-use**.

## Agent instructions

`threejs-specialist`, `webgl-shader-specialist`, and `web3d-asset-pipeline` must:

1. Read this file to confirm the versions in use.
2. Flag any API they are not certain exists in the pinned version.
3. Prefer the project's installed-version docs over memory.

## Notable cross-version gotchas to watch

- Color management / color space API changes across recent `three` releases.
- `WebGLRenderer` option and output color space changes.
- Build-system import paths for `examples/jsm` vs `addons` modules.
- React Three Fiber v8 → v9 changes in event/loop APIs (this stack is on v9).
