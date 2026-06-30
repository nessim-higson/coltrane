# COLTRANE — STATE

*Living status doc — last updated 2026-06-17 (initial fork). The overview of where
the project is. When this and the code disagree, the code wins — update this.*

---

## TL;DR

**Coltrane** is an orchestration of sound and image — a standalone fork of the
UNIQLOCK V2 orchestra work, set up to keep playing with **two directions side by
side**. Generative Web Audio, IAAH imagery, a tempo fader, mode switches.

- **`breathe/`** — the grid *breathes* with the music.
- **`refine/`** — the refined collage with a **RIGID / REFRAME** switch.
- **`index.html`** — a hub linking both.

**Live:** https://nessim-higson.github.io/coltrane/ · **Repo:** github.com/nessim-higson/coltrane

---

## The builds

### breathe-only/  (the breath, focused + enhanced)
The breathe direction on its own — mode locked to breathe, the subdivide/repack chips
gone. The grid breathes with the music and **the movement comes from a different place
each beat**, cycling through enabled **gestures** (toggle chips, keys 1–4):
- **CROSS** — the firing block bulges (its column + row swell ×1.5/1.45); source moves
  with the voice→block binding.
- **INHALE** — the whole grid breathes in together (×1.16); the communal breath.
- **BAND** — a full row swells (×1.6), cycling rows; a horizontal band.
- **WAVE** — the breath travels left→right across the columns (×1.6, staggered).
Bigger amplitude + fast-in / slow-out easing than the original r50 breath. The breath
engine cycles only the *enabled* gestures (round-robin), so you dial where the motion
comes from. (`doBreathe` + `breathTimers`/`gridTo`/`breathRelease`.)

## The base builds (forked from uniqlock-v2)

### breathe/  (forked from uniqlock-v2 · r50-crna-css)
Three modes — **subdivide / repack / breathe**. The signature is BREATHE: on each
strong beat the grid's *tracks* swell and settle together, so the whole composition
pulses in time with the music. (This is the original whole-grid breath, before it
was later "cracked" into a calmer local version and then tabled in the uniqlock line.)
The lead transition here is the early crna (pure-CSS four-side pull-back).

### refine/  (forked from uniqlock-v2 · r66-rigid-reframe-switch)
Two modes — **subdivide / repack** — with a **RIGID / REFRAME** switch on repack
(the `#styleChip`, or key `r`):
- **RIGID** — native-AR tiles packed on a module grid; they relocate by **fading**
  in/out (never sliding), big black negative space, tile size scales with tempo.
- **REFRAME** — dynamic columns that **re-roll every bar** and morph/slide, a
  staggered masonry that fills the viewport.
The lead (PULSE) does the **crna four-side pull-back**; a single beat (low BPM) is
**one full-screen image**; subdivide stays the favored tiled layout.

---

## How it works (shared)

- **Audio** — fully generative Web Audio (AudioContext / oscillators / filters /
  convolver reverb). No pre-rendered tracks. Starts on the tap-to-enter gesture.
  On iPhone, flip the ring/mute switch off (iOS routes Web Audio through it).
- **Imagery** — `assets/imagery/` (40 IAAH stills + `manifest.json`), loaded via
  `js/data.js` (`loadImageryManifest`); paths resolve relative to `js/data.js`.
- **Tempo** — a BPM fader; ~1 beat ≈ 1 second. The engine is rAF-driven, so motion
  pauses in a backgrounded tab.
- **Type** — a mobile media query bumps the UI type up on phones.

---

## Workflow

- **Versioning:** `./snapshot.sh <name> [commit]` freezes both builds (HTML+JS) into
  `versions/<name>/`, sharing the live `assets/` pool via a `UQ_ASSET_ROOT` override
  (kilobytes per snapshot). Regenerates `versions/index.html` (newest first, each
  links to its hub). **Snapshot every round.**
- **Deploy:** GitHub Pages from `main` / root. After a deploying push, reply with the
  cache-busted live link (`?v=<sha>`).
- **Dev server:** served at **port 4197** (`coltrane` launch config). Open
  http://localhost:4197/.

---

## Open directions / next steps

1. **What's the through-line** — do breathe and refine converge into one piece, or
   stay two explorations? Possibly bring BREATHE in as a third option in `refine/`.
2. **Breathe refinement** — the original whole-grid breath is bold but can read as
   jitter; explore a version that breathes *with* the repack collage rather than the
   old grid-track swell.
3. **Sound** — which generative palette is *the* Coltrane sound (it's named for a
   reason); the engine currently carries the STRATA/Tectonic voices from uniqlock.
4. **Imagery** — swap the IAAH pool for a Coltrane-specific set when the direction
   firms up.
5. Carry-overs from uniqlock: shareable `?seed=` permutation URL; the "hourly special."
