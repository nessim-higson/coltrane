# COLTRANE — STATE

*Living status doc — last updated 2026-06-17 (initial fork). The overview of where
the project is. When this and the code disagree, the code wins — update this.*

---

## TL;DR

**Coltrane** is an orchestration of sound and image — a standalone fork of the
UNIQLOCK V2 orchestra work, set up to keep playing with **two directions side by
side**. Generative Web Audio, IAAH imagery, a tempo fader, mode switches.

- **`movement-v2/`** ★ — the **shader cut** (V.2). Same six-movement track, but the DOM field is
  replaced by one WebGL surface the music *deforms*: bass warps the pixels, highs split them chromatic,
  images melt via a noise dissolve, the drop/climax smear into feedback light + a kaleidoscope fold.
  *The current lead direction.*
- **`movement/`** — the original CSS cut (V.a): six movements conduct a full-bleed CSS image field
  (track-as-conductor, sound→image in correspondence). Kept as the reference baseline.
- **`breathe/`** — the grid *breathes* with the music.
- **`breathe-only/`** — the breath focused + enhanced (varied movement sources).
- **`refine/`** — the refined collage with a **RIGID / REFRAME** switch.
- **`index.html`** — a hub linking them all.

**Live:** https://nessim-higson.github.io/coltrane/ · **Repo:** github.com/nessim-higson/coltrane

---

## The builds

### movement-v2/  ★ the shader cut (V.2) — the image is the instrument
The **shader treatment** the V.a build was missing. Same generative six-movement track + lookahead
scheduler, but the visual is a single **Three.js fullscreen quad + ShaderMaterial** with a **ping-pong
feedback** buffer. The music drives the pixels directly:
- **Bass / kick → domain-warp** — the low end noise-warps the UVs, so the image breathes and heaves.
- **Highs / kick → chromatic split** — R/G/B sampled along diverging offsets; the drop rainbows the edges.
- **Warp-dissolve morph** — images don't crossfade, they *melt* into each other through a noise threshold
  (`uMix` swept 0→1; hard-cut on kicks in DROP/CLIMAX, slow melt in INTRO/BREAKDOWN).
- **Per-movement look** (CPU-set uniforms): INTRO/BREAKDOWN posterize + desaturate (graphic, few tones),
  GROOVE/BUILD full colour, DROP heavy **feedback trails**, CLIMAX adds a **kaleidoscope fold**.
- AnalyserNode (fftSize 128) → live `uBass`/`uHigh`; kicks fire a decaying `uKick` impulse.
- Three r0.160 from CDN; imagery loaded as `THREE.Texture`, cover-fit in-shader by aspect uniform.
- **Verified:** runs the full arc INTRO→…→CLIMAX, no GL/console errors; climax = kaleido + chromatic + trails.

### movement/  the original cut (V.a) — a piece that performs itself
The reframe: **the conductor is the track, not a metronome.** Press play and a developing
generative track runs **six movements** — intro / groove / build / drop / breakdown / climax —
and the arrangement choreographs the image field. This is "the site plays a track and the
visuals come to life in correspondence."
- **Modes → movements.** Each section sets the visual behavior: INTRO = one dim image, slow
  crossfades; GROOVE = two panels, cuts on the kick; BUILD = three panels, faster, brightening;
  DROP = one full-frame image + a big scale hit; BREAKDOWN = one image, near-silence; CLIMAX =
  three panels, rapid cuts. The layout *is* the arrangement.
- **Composed correspondence** (not FFT-reactive-lag): because the audio is generative we know
  every event ahead of time, so **kicks cut + punch** the imagery on the frame, section changes
  reshape the panels, and an **AnalyserNode** drives a continuous **breath** (bass → scale) +
  **grain/vignette** (energy). No tempo fader — the piece drives itself; a ▶ play + replay.
- Self-contained generative synth (kick/sub/pad/pluck/hat/snare) + a lookahead step scheduler +
  a Dm–Bb–F–C progression, ~94s. CSS-only visual treatment (filters, grain, panels) — no WebGL yet.
- **Next:** tune the arrangement + the hit choreography; try WebGL/shaders for the treatment;
  bring REFRAME's morph into the panels; find *the* Coltrane track/sound.

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
