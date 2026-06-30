# COLTRANE

An orchestration of sound and image — forked from the **UNIQLOCK V2** orchestra work to keep playing with two directions side by side.

## Builds

- **`breathe/`** — the grid *breathes* with the music. On each strong beat the grid tracks swell and settle together, the whole composition pulsing in time. Forked from `uniqlock-v2` **r50-crna-css**. Modes: subdivide / repack / breathe.
- **`refine/`** — the refined collage with a **RIGID / REFRAME** switch. RIGID = native-AR tiles in a module grid that relocate by fading (big black negative space). REFRAME = morphing columns that re-roll every bar and slide to fill the viewport. The lead does the crna four-side pull-back; a single beat is one full-screen image. Forked from `uniqlock-v2` **r66-rigid-reframe-switch**. Modes: subdivide / repack (rigid/reframe).

`index.html` is a hub linking to both.

## Shared

- `js/data.js` — imagery manifest loader (paths resolve relative to this file).
- `assets/imagery/` — 40 IAAH stills + `manifest.json`.
- Audio is **generative Web Audio** (AudioContext / oscillators / convolver reverb) — no pre-rendered tracks. Sound starts on the tap-to-enter gesture. On iPhone, flip the ring/mute switch off.
- The "Uniqlo" display font loads from a CDN.

## Run

```
python3 -m http.server 4197
```
or use the `coltrane` launch config. Open http://localhost:4197/.

## Deploy

GitHub Pages from `main` / root (once a remote is set up).

## Notes

- 1 beat ≈ 1 second of tempo; the engine is rAF-driven, so motion pauses in a backgrounded tab.
- Lineage: this is a snapshot fork of two uniqlock-v2 builds. The originals keep evolving in that repo; Coltrane is where these two get played with independently.
