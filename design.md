# Xylophone — Design

A 25-bar chromatic xylophone, C5 to C7, in Padauk on a parametric trestle frame.
Free-free flat-bar geometry, 12th-overtone tuning convention, optional
quarter-wave closed-pipe resonators (deferred). Designed deliberately as the
*simpler* sibling of a future marimba sister repo: every place this design
chooses the simpler path, the marimba-equivalent is documented inline so the
marimba scaffold inherits cleanly.

## Intent

Ship a parametric, validator-clean, public-readable Mode A build packet for
a serious wooden tuned-bar idiophone — small enough to build in one shop
session, honest enough about the physics that the predicted frequencies and
the measured frequencies will disagree on first cut and the workflow can
correct them, structured enough that a marimba follow-on can reuse the
family table, the validation rows, the suspension geometry, the SolidWorks
master-layout convention, and the empirical-correction guard rules.

The reader should leave with: (a) a parametric design table whose inputs
are wood species, bar thickness, target pitch, and frame geometry; (b) a
defensible first-order frequency prediction per note; (c) a measured-tuning
workflow that closes the loop on the prediction; (d) a clear "this is what
turns into marimba next" map.

## Governing Model

Free-free Euler-Bernoulli transverse beam vibration, first mode:

    f_1 = 1.028 × (h / L²) × √(E / ρ)

Symbols and units (SI):

- `h` — bar thickness (m)
- `L` — bar length (m)
- `E` — Young's modulus along grain (Pa)
- `ρ` — density (kg/m³)
- `f_1` — first-mode frequency (Hz)

Reference: `acoustic-models.md` Free-Free Beams section. The formula
follows from `K_free_free ≈ 6.36 × K_cantilever` applied to the
cantilever form `f_1 ≈ 0.162 × (h/L²) × √(E/ρ)`. Suspension nodes for
the first free-free mode are at **22.4% and 77.6% of L** — every
cord-hole in `family-spec.csv` is placed there.

**First-order estimate caveat.** Per the `acoustic-models.md`
empirical-correction guard rules, K2 corrections, scale-offset tables,
and end-corrections **do not apply** to bar idiophones. Material
K-constants from the cantilever wood table are species-specific and
only valid for the free-free / fixed-free regime — they propagate to
this packet via the 6.36× factor above. Every predicted frequency in
`family-spec.csv` is flagged as *first-order*; `validation.csv` is the
mechanism that closes the gap with measured data after first prototype.

**Xylophone tuning convention.** Bars are tuned to align the *12th
overtone* (3:1 frequency ratio above the fundamental — actually the
second flexural mode tuned to a perfect 12th of the fundamental in the
concert convention; first-order math reports `f_1` only). Marimba
tunes the second mode to a 4:1 ratio (two octaves) by parabolic arch
undercut. **This packet uses no arch undercut** — bars are flat-bottom
rectangular blanks, end-shaved for fundamental tuning. The
12th-overtone target is documented as a *measurement target* in
`validation.csv`, not a CAD geometry — adjust at the bench.

> Marimba-equivalent: replace the flat-bottom geometry with a parabolic
> CNC arch on the underside (`acoustic-models.md`:
> `center_thickness = edge_thickness × (target_freq / flat_bar_freq)²`,
> minimum center 0.25"). Replace the 12th-overtone target with the
> 4:1 octave-and-a-fifth target. Replace the optional resonators with
> mandatory tuned tubes.

## Family Plan

Two octaves chromatic, C5 to C7, 25 bars. Family geometry held
constant: bar width `W = 1.500"`, bar thickness `h = 0.875"` (7/8"
flat stock). Only `L` varies — solved per note from the governing
model. See `family-spec.csv` for the full table.

Predicted lengths run from **16.683" at C5** to **8.342" at C7**.
These are noticeably longer than a concert xylophone of the same
range because the design has no arch undercut — the arch is what
lets a concert xylo hit the same pitch with a 10–12" bar. The
flat-bar tradeoff is honest, parametric, and easier to first-cut.

Width and thickness are constants in this v1 family. Production
xylophones often taper width across the range; that's a deferred
optimization, called out in Open Assumptions.

> Marimba-equivalent: keep width constant within an octave but step
> width up at register boundaries (low marimba bars are wider). Add an
> arch-depth column. Add a resonator-tube-bore column.

## Wood Species

Three-tier shortlist; **Padauk is the spec's primary** because it is
sustainably sourced, has predictable acoustic properties, machines
cleanly, and is widely available in 4/4 quartersawn:

| Tier              | Species             | E (GPa) | ρ (kg/m³) | √(E/ρ) (m/s) | Notes                                              |
|-------------------|---------------------|---------|-----------|--------------|----------------------------------------------------|
| Primary           | African Padauk      | 12.6    | 745       | 4112         | Spec default. Stable, predictable, sustainable.    |
| Traditional       | Honduras Rosewood   | 14.1    | 1000      | 3756         | Concert standard. **CITES II** — sourcing risk.    |
| Educational/budget| Hard Maple          | 12.6    | 705       | 4229         | Cheapest, most available, dampest sound.           |

Switching the primary requires a single edit in
`xylophone-design-table.xlsx` (input cell `wood_species`); the family
table re-solves automatically. The validator runs on the table's
current state, not on a hardcoded snapshot.

> Marimba-equivalent: same shortlist, but most concert marimbas use
> Padauk or Honduras Rosewood; Birch is the educational tier.

## Tuning Workflow

The validation loop has eight rows in `validation.csv`. Two are
prediction-only; six require a tuner and a chromatic environment log:

1. Rough-cut prediction (paper, before any cut).
2. Post-cut fundamental measurement (immediately after bandsaw + plane).
3. Post-shave measurement (after end-shaving for fundamental tune).
4. Post-finish measurement (after oil/wax — finish adds mass, drops pitch).
5. Post-resonator-install measurement (when resonators are installed; deferred).
6. 30-day moisture re-measure (drift after first shop cycle).
7. 60-day moisture re-measure (drift after a full season cycle).
8. Full-octave evenness check (every C across both octaves on the same day).

Each row carries `tuner_make_model`, `temp_F`, `humidity_RH_percent`,
and `cents_target` columns matching `record_measurement.py`'s schema.
A measured Hz feeds `record_measurement.py --packet . --note-id <X>
--measured-hz <f>` and the per-family corrections database absorbs
the delta.

## Resonator Decision

**Optional, deferred to v2 build.** The L-per-note math is computed
in `family-spec.csv` (column `resonator_l_in_optional`) using the
quarter-wave closed-pipe formula with end correction:

    L_resonator = c / (4 f) − 0.82 × bore

with `c = 343 m/s` and `bore = 1.500"`. Lengths run from **5.22" at
C5** down to **0.38" at C7**. The high-end values are too short to
build practically — the production decision will be: tune resonators
on bars at C5 through approximately G5 (lengths > 3"), and skip
resonators on the upper octave. This decision is made when resonators
are installed, not now.

> Marimba-equivalent: resonators are mandatory; the bore is bigger
> (typically 2.0–3.0"); each tube is plugged at the bottom and tuned
> at the top end. Marimba tubes are also typically *not* trimmed by
> the 0.82×bore end-correction directly — they're trimmed by ear at
> the bench.

## Frame Layout

4-leg parametric trestle frame, two suspension rails running the full
length of the bar fan. Rail length sized to `max(family-spec L) +
4" margin = 16.683 + 4 = 20.683"` rounded up to **21"**. Leg
height **30"** (standard standing-play height; sit-down play needs
a swap to 24"). Cord suspension with `1/8"` paracord through the
node holes; cord termination at the rail ends with a tied-loop and
finish washer.

Frame parts are CNC candidates (rails, leg blanks, gussets) — see
`cnc/operations.csv`. Bars are explicitly out of CNC scope: bandsaw
to rough → surface plane to thickness → drum-sand surfaces → drill
node holes (jig) → end-shave for tuning (manual). The CNC plan
states this exclusion in the setup sheet.

> Marimba-equivalent: longer frame (4-octave marimba is 5+ feet),
> resonator wells underneath each bar pair, height-adjustable legs,
> traveling-cart casters.

## Mallets

Hard rubber → lexan → rosewood-head shortlist. Hard mallets are
appropriate for xylophone (the percussive, glassy attack is part of
the instrument's voice). They are **harder than marimba mallets**
and *can* crack a softer-wood bar — see `risks.md` entry
`bar-cracking-from-hard-mallets`. Standard practice: yarn-wrapped
mallets for low octave, lexan/rubber for upper. v1 packet ships with
hard rubber as the recommended starter; lexan and rosewood are
swap-ins.

> Marimba-equivalent: yarn-wrapped soft mallets across the entire
> range. The bars are softer (Honduras Rosewood is a hardwood but
> with arch undercut the center is thin); soft mallets prevent
> cracking and produce a warmer overtone profile.

## Marimba-Equivalent Hooks (summary map)

| Decision               | Xylophone (this packet)               | Marimba (sister repo, deferred)        |
|------------------------|---------------------------------------|----------------------------------------|
| Bar geometry           | Flat-bottom rectangular               | Parabolic arch undercut on underside   |
| Tuning ratio target    | 12th overtone (3:1)                   | 4:1 (two octaves)                      |
| Resonators             | Optional, deferred                    | Mandatory, tuned per bar               |
| Bar width policy       | Constant 1.500" across range          | Step up at register boundaries         |
| Mallet hardness        | Hard rubber → lexan → rosewood        | Yarn-wrapped soft → medium             |
| Suspension cord        | 1/8" paracord                         | 3/16" or 1/4" (heavier bars)           |
| Frame length           | 21" rail                              | 60"+ rail, multi-octave                |
| Wood primary           | Padauk                                | Padauk or Honduras Rosewood            |

A future `marimba/` repo can `cp -r xylophone/* marimba/` and edit
exactly these eight rows in the design table to bootstrap.

## Open Assumptions

1. **No measured data yet.** Every frequency in `family-spec.csv` is a
   first-order prediction. First measurement after first prototype is
   the single most important next step. (`validation.csv` row 2.)
2. **Wood species.** Padauk is the primary by spec choice; Honduras
   Rosewood and Hard Maple swap in by changing one cell in the
   workbook. CITES sourcing for HR is not analyzed in this packet.
3. **Family range.** C5–C7 chromatic is the chosen default. F4–F6
   diatonic and G4–G6 diatonic remain documented alternatives — they
   trade range for shorter bar stock and a smaller frame.
4. **Bar thickness held constant at 7/8".** A real production xylo
   often steps thickness up in the low octave to keep bars from being
   absurdly long. This packet keeps thickness constant for parametric
   simplicity and accepts the 16.7" C5 bar.
5. **Resonator strategy.** The L-per-note math is computed but
   resonators are not specified in the BOM. Adding them is additive,
   not breaking — the frame design leaves vertical clearance.
6. **CAD.** SolidWorks master-layout part is deferred; the
   `cad/` folder has a stub README pointing at the tongue-drum
   convention and the existing `xylophone-design-table.xlsx`.
7. **Mallet supplier.** v1 lists generic hard-rubber mallets; specific
   supplier (Innovative Percussion vs Encore vs Vic Firth) is not
   selected.

These eight rows are exactly the assumptions the handoff report
flags. Each becomes a `validation.csv` or `bom.csv` line item once
the gating decision is made.
