# Xylophone Capstone Print Packet

Generated: 2026-05-08
Packet folder: `/mnt/c/Users/Tony/Documents/GitHub/xylophone`

## File Map

| File | Purpose |
| --- | --- |
| `design.md` | Project intent, catalog metadata, assumptions, and validation plan. |
| `bom.csv` | Starter bill of materials with part categories, quantities, drawing refs, and notes. |
| `sourcing.csv` | Supplier/search tracker with specs, price/date fields, lead time, substitutes, and risks. |
| `cut-list.csv` | Rough/final stock sizes, material, grain/orientation, operations, yield, and offcuts. |
| `drawing-brief.md` | Manufacturing drawing and technical product sketch brief. |
| `assembly-manual.md` | Shop-facing sequence, tools, fixtures, safety, tuning, finishing, and maintenance notes. |
| `validation.csv` | Target/measured values, tolerance, environment, result, and tuning/build action log. |
| `supplier-rfq.md` | Supplier email/request-for-quote starter. |
| `visual-bom-brief.md` | Art direction for an image-forward visual BOM. |
| `wolfram-starter.wl` | Wolfram starter for physics, optimization, visualization, and validation. |
| `README.md` | Project artifact. |
| `family-spec.csv` | Project artifact. |
| `jig-decision.md` | Project artifact. |
| `photo-shotlist.md` | Project artifact. |
| `resources.md` | Project artifact. |
| `risks.md` | Project artifact. |

<div class="page-break"></div>

## design.md

Project intent, catalog metadata, assumptions, and validation plan.

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

<div class="page-break"></div>

## bom.csv

Starter bill of materials with part categories, quantities, drawing refs, and notes.

| part_id | part_name | qty | unit | estimated_cost | supplier_candidate | notes |
| --- | --- | --- | --- | --- | --- | --- |
| BAR-STOCK | Padauk 4/4 quartersawn, surfaced 4 sides, KD 6-8% MC | 1 | board-foot-bundle-25 | 180.00 | Bell Forest Products | sized to yield 25 bars 8.3-16.7in long x 1.5in x 7/8in plus 20% waste |
| FRAME-RAIL | Hard maple 8/4 rail blank 24in x 2.5in x 1.5in | 2 | piece | 28.00 | Bell Forest Products | two suspension rails; rough oversize |
| FRAME-LEG | Hard maple 8/4 leg blank 32in x 1.75in x 1.75in | 4 | piece | 18.00 | Bell Forest Products | four legs; rough oversize |
| FRAME-GUSSET | Baltic birch ply 1/2in 12x12 panel | 1 | piece | 14.00 | Lee Valley | two corner gussets per end |
| CORD-NODE | 1/8 inch paracord black 100ft hank | 1 | hank | 9.00 | Lee Valley | node-suspension cord |
| CORD-WASHER | Brass finish washer 1/8in cord 25-pack | 1 | pack | 8.00 | Lee Valley | cord termination |
| SCREW-FRAME | #10 x 2in zinc wood screw 50-pack | 1 | pack | 7.00 | Lee Valley | frame assembly |
| GLUE-FRAME | Titebond III 16oz | 1 | bottle | 12.00 | Lee Valley | frame joinery |
| FINISH-OIL | Tung oil pure 16oz | 1 | bottle | 18.00 | Lee Valley | bar and frame finish |
| FINISH-WAX | Beeswax paste 8oz | 1 | tin | 11.00 | Lee Valley | top coat |
| MALLET-HRD | Hard rubber xylophone mallet pair | 2 | pair | 32.00 | Innovative Percussion | primary mallet for upper octave |
| MALLET-MED | Yarn-wrapped medium mallet pair | 2 | pair | 38.00 | Innovative Percussion | alt mallet for low octave |
| TUNER-CHROMA | Korg OT-120 orchestral tuner | 1 | unit | 140.00 | Sweetwater | validation row 2-8 device of record |
| HYGRO-SHOP | Combo hygrometer-thermometer digital | 1 | unit | 22.00 | Lee Valley | validation env log |
| MOIST-METER | Pin-style moisture meter | 1 | unit | 38.00 | Lee Valley | verify 6-8% MC at glue-up |
| SANDPAPER-KIT | Aluminum oxide grit 80-220 assortment | 1 | kit | 18.00 | Lee Valley | bar surface prep |
| DRILL-BIT-NODE | 1/8in brad-point bit | 2 | piece | 4.50 | Lee Valley | node-hole drilling, jig-mounted |
| RESONATOR-TUBE | Aluminum tube 1.5in OD 36in length | 2 | piece | TBD | McMaster-Carr | deferred to v2 build; sized for resonator option |

<div class="page-break"></div>

## sourcing.csv

Supplier/search tracker with specs, price/date fields, lead time, substitutes, and risks.

| part_id | supplier_candidate | required_spec | search_terms | lead_time_days_est | notes |
| --- | --- | --- | --- | --- | --- |
| BAR-STOCK | Bell Forest Products | African Padauk 4/4 quartersawn KD to 6-8 percent MC surfaced 4 sides | padauk 4/4 quartersawn KD S4S | 7 | primary; ask for low-shake low-pin selection |
| BAR-STOCK | West Penn Hardwoods | African Padauk 4/4 quartersawn KD | padauk 4/4 quartersawn | 10 | backup if Bell is OOS |
| BAR-STOCK | Cook Woods | African Padauk billet selection | padauk billet quartersawn | 14 | third option; pricier but selectable boards |
| FRAME-RAIL | Bell Forest Products | Hard maple 8/4 KD straight grain | hard maple 8/4 straight grain | 7 | two boards 30in min length |
| FRAME-LEG | Bell Forest Products | Hard maple 8/4 KD | hard maple 8/4 | 7 | four leg blanks |
| FRAME-GUSSET | Lee Valley | Baltic birch plywood 1/2in B/BB grade 12x12 | baltic birch 1/2 plywood 12x12 | 5 | or substitute Home Depot if local |
| CORD-NODE | Lee Valley | Type II 1/8in paracord 100ft | paracord 1/8 100ft | 5 | black or natural |
| CORD-WASHER | Lee Valley | Brass finish washer fits 1/8in cord | brass finish washer 1/8 cord | 5 | or McMaster-Carr 91068A350 |
| SCREW-FRAME | Lee Valley | #10 x 2in steel wood screw zinc | wood screw #10 2in zinc | 5 | 50-pack minimum |
| GLUE-FRAME | Lee Valley | Titebond III 16oz | titebond III 16oz | 5 | waterproof PVA, longer open time |
| FINISH-OIL | Lee Valley | Pure tung oil food-safe 16oz | pure tung oil 16oz | 5 | food-safe so the kid players are fine |
| FINISH-WAX | Lee Valley | Beeswax paste furniture finish 8oz | beeswax furniture paste 8oz | 5 | top coat over tung |
| MALLET-HRD | Innovative Percussion | Hard rubber xylophone mallet IP240 or equivalent | IP240 hard rubber xylophone mallet | 7 | alt: Encore EM-1, Vic Firth M134 |
| MALLET-MED | Innovative Percussion | Yarn-wrapped medium marimba mallet | yarn medium marimba mallet pair | 7 | alt: Encore EX-1 |
| TUNER-CHROMA | Sweetwater | Korg OT-120 orchestral tuner | Korg OT-120 orchestral tuner | 3 | or Peterson StroboPlus HD if available |
| HYGRO-SHOP | Lee Valley | Digital hygrometer thermometer combo | digital hygrometer thermometer shop | 5 | target accuracy +/-3% RH |
| MOIST-METER | Lee Valley | Pin-style moisture meter wood | pin moisture meter wood | 5 | or General MM50 |
| SANDPAPER-KIT | Lee Valley | Aluminum oxide sanding sheet variety 80-220 grit | aluminum oxide sandpaper variety pack | 5 | hand-sand bar surfaces post-plane |
| DRILL-BIT-NODE | Lee Valley | Brad point drill bit 1/8in | brad point bit 1/8 inch | 5 | two for spares |
| RESONATOR-TUBE | McMaster-Carr | 6061 aluminum tube 1.5in OD 0.065in wall 36in | aluminum tube 1.5 OD 0.065 wall | 5 | deferred; quote at v2 build time |

<div class="page-break"></div>

## cut-list.csv

Rough/final stock sizes, material, grain/orientation, operations, yield, and offcuts.

| part_id | part_name | qty | rough_dimensions_in | final_dimensions_in | grain_orientation | notes |
| --- | --- | --- | --- | --- | --- | --- |
| BAR-C5 | Bar C5 | 1 | 18.0 x 1.625 x 1.0 | 16.683 x 1.500 x 0.875 | longitudinal-quarter | longest bar; cut from longest blank |
| BAR-Cs5 | Bar C#5 | 1 | 17.5 x 1.625 x 1.0 | 16.208 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-D5 | Bar D5 | 1 | 17.0 x 1.625 x 1.0 | 15.747 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-Ds5 | Bar D#5 | 1 | 16.5 x 1.625 x 1.0 | 15.299 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-E5 | Bar E5 | 1 | 16.0 x 1.625 x 1.0 | 14.863 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-F5 | Bar F5 | 1 | 15.5 x 1.625 x 1.0 | 14.440 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-Fs5 | Bar F#5 | 1 | 15.0 x 1.625 x 1.0 | 14.029 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-G5 | Bar G5 | 1 | 15.0 x 1.625 x 1.0 | 13.630 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-Gs5 | Bar G#5 | 1 | 14.5 x 1.625 x 1.0 | 13.242 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-A5 | Bar A5 | 1 | 14.0 x 1.625 x 1.0 | 12.865 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-As5 | Bar A#5 | 1 | 13.5 x 1.625 x 1.0 | 12.498 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-B5 | Bar B5 | 1 | 13.5 x 1.625 x 1.0 | 12.143 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-C6 | Bar C6 | 1 | 13.0 x 1.625 x 1.0 | 11.797 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-Cs6 | Bar C#6 | 1 | 12.5 x 1.625 x 1.0 | 11.461 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-D6 | Bar D6 | 1 | 12.5 x 1.625 x 1.0 | 11.135 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-Ds6 | Bar D#6 | 1 | 12.0 x 1.625 x 1.0 | 10.818 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-E6 | Bar E6 | 1 | 11.5 x 1.625 x 1.0 | 10.510 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-F6 | Bar F6 | 1 | 11.5 x 1.625 x 1.0 | 10.211 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-Fs6 | Bar F#6 | 1 | 11.0 x 1.625 x 1.0 | 9.920 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-G6 | Bar G6 | 1 | 10.5 x 1.625 x 1.0 | 9.638 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-Gs6 | Bar G#6 | 1 | 10.5 x 1.625 x 1.0 | 9.363 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-A6 | Bar A6 | 1 | 10.0 x 1.625 x 1.0 | 9.097 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-As6 | Bar A#6 | 1 | 9.5 x 1.625 x 1.0 | 8.838 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-B6 | Bar B6 | 1 | 9.5 x 1.625 x 1.0 | 8.586 x 1.500 x 0.875 | longitudinal-quarter |  |
| BAR-C7 | Bar C7 | 1 | 9.0 x 1.625 x 1.0 | 8.342 x 1.500 x 0.875 | longitudinal-quarter |  |
| RAIL-L | Suspension rail left | 1 | 22.0 x 2.5 x 1.5 | 21.000 x 2.250 x 1.250 | longitudinal | both rails identical |
| RAIL-R | Suspension rail right | 1 | 22.0 x 2.5 x 1.5 | 21.000 x 2.250 x 1.250 | longitudinal |  |
| LEG-FL | Front-left leg | 1 | 32.0 x 1.75 x 1.75 | 30.000 x 1.500 x 1.500 | longitudinal | chamfer top edge for cord clearance |
| LEG-FR | Front-right leg | 1 | 32.0 x 1.75 x 1.75 | 30.000 x 1.500 x 1.500 | longitudinal |  |
| LEG-RL | Rear-left leg | 1 | 32.0 x 1.75 x 1.75 | 30.000 x 1.500 x 1.500 | longitudinal |  |
| LEG-RR | Rear-right leg | 1 | 32.0 x 1.75 x 1.75 | 30.000 x 1.500 x 1.500 | longitudinal |  |
| GUSSET | Corner gusset | 4 | 7.0 x 7.0 x 0.5 | 6.000 x 6.000 x 0.500 | plywood-9-ply | 45-degree triangle gussets at leg-to-rail joint |

<div class="page-break"></div>

## drawing-brief.md

Manufacturing drawing and technical product sketch brief.

# Xylophone — Drawing Brief

What the SVG and CAD drawings need to show, in priority order. The
drawings live in `drawings/` (per-family-member SVGs and a frame
elevation/plan); the CAD master lives in `cad/` once built.

## DR-01: Bar template (parametric)

A single dimensioned drawing template that varies per family member.
**Critical dimensions:**

- Bar length `L` (from `family-spec.csv` per note).
- Bar width `W = 1.500"`.
- Bar thickness `h = 0.875"` (section view).
- Node-hole positions: low-side at `0.224 × L`, high-side at
  `0.776 × L`. Hole diameter `1/8"`.
- Strike line at center (`L/2`) — annotation only, not a feature.
- Edge round-over `1/16"` on all four long edges.

Title block must show: drawing ID, note name, family `XYL`, scale
(1:2 reads cleanly for the long bars), revision, date, designer,
material, finish.

The drawing template's only variable is `L` and the two derived hole
positions. A generator should be able to produce 25 SVGs from the
family table by string substitution alone.

## DR-02: Frame elevation

Side view of the assembled frame (no bars). Shows:

- Two suspension rails, `21.000" × 2.250" × 1.250"`, mounted on top
  of the legs.
- Four legs, `30.000" × 1.500" × 1.500"`. Chamfered top edge.
- Corner gussets, `6.000 × 6.000 × 0.500"` plywood, on the inside
  face of each leg-rail joint.
- Cord-suspension geometry — schematic, not dimensioned.
- Overall envelope: 21" wide, 30" tall.

## DR-03: Frame plan

Top view of the frame with bars laid in suspension. Shows:

- Both rails parallel, 6.5" inside-to-inside.
- 25 bar positions in the family-table order, lowest at the left.
- Inter-bar gap: 0.250" minimum.
- Total bar-array length: ~17" (driven by the longest bar plus
  gaps).
- Cord routing: alternating side-to-side through node holes.

## DR-04: Mallet detail

Three-view of the recommended hard-rubber mallet (from `bom.csv`).
Shaft length, head diameter, head shape. **Reference only** — the
mallets are purchased, not built. Goes on the visual BOM, not in
the build instructions.

## Style notes

- All dimensions in inches. Decimal, three places (`16.683`),
  consistent with `family-spec.csv` and `cut-list.csv`.
- Datum chain: bar drawings reference left bar end; frame drawings
  reference left-rear leg base.
- Tolerances: bars ±1/64", frame ±1/32" (frame loose on purpose —
  bars do the precision work).
- File names: `drawings/DR-01-bar-<note>.svg` per bar (or a single
  `drawings/template.svg` until the per-bar instances are
  generated). Frame drawings: `drawings/DR-02-frame-elevation.svg`,
  `drawings/DR-03-frame-plan.svg`. Mallet: `drawings/DR-04-mallet.svg`.

## Generator hookup

A future invocation of `scripts/generate_drawings.py` against this
packet will populate `drawings/DR-01-bar-*.svg` from `family-spec.csv`.
Until that runs, `drawings/template.svg` is the placeholder showing
the title-block layout and the datum chain so the generator's output
matches in style.

<div class="page-break"></div>

## assembly-manual.md

Shop-facing sequence, tools, fixtures, safety, tuning, finishing, and maintenance notes.

# Xylophone — Assembly Manual

14 shop steps, in order. Checkboxes are blank for shop use; tick them
off as you go. Estimated total bench time: **3 working days** with
overnight glue cures.

## Materials and tools required

Read `bom.csv` and `sourcing.csv` end-to-end before starting. The
critical-path items: Padauk bar stock at 6–8% MC, Korg OT-120 tuner,
1/8" brad-point bit, Titebond III, tung oil, and the two jigs from
`jig-decision.md` (node-hole drilling jig, end-shaving sled).

## Step 1 — Verify moisture content

- [ ] Pin-meter the Padauk bar stock at three points along each
  board. Target 6.0–8.0% MC.
- [ ] Log temp + RH in the shop in `validation.csv` row V1.
- [ ] If MC > 8%: stack with stickers in the shop for two weeks and
  remeasure. **Do not proceed until MC is 6–8%.**

## Step 2 — Mill blanks to rough cut-list dimensions

- [ ] Cross-cut each bar blank to its `rough_dimensions_in[0]` length
  (per `cut-list.csv`). Add 1" to the longest blanks for safety.
- [ ] Rip to 1.625" rough width.
- [ ] Joint one face and one edge.
- [ ] Plane to 1.0" rough thickness.

## Step 3 — Final mill bars

- [ ] Plane to **0.875"** final thickness.
- [ ] Rip to **1.500"** final width.
- [ ] Cross-cut to the `final_dimensions_in[0]` length per
  `cut-list.csv`. **Cut long by 1/16"** — final length is set in
  the tuning step.

## Step 4 — Surface prep

- [ ] Drum-sand or hand-sand each bar 80 → 120 → 180 → 220.
- [ ] Ease all four long edges with a 1/16" round-over.
- [ ] Mark each bar's note name on the underside in pencil.

## Step 5 — Drill node holes (jig)

- [ ] Set up the node-hole drilling jig from `jig-decision.md`.
- [ ] For each bar: set both flip-stops to the bar's
  `hole_pos_low_in` and `hole_pos_high_in` from `family-spec.csv`.
- [ ] Drill the low-side hole, flip stops, drill the high-side hole.
- [ ] Chamfer both holes ~0.5mm with a countersink to prevent cord
  chafing.

## Step 6 — First measurement

- [ ] Suspend each bar from a piece of test-cord through both node
  holes.
- [ ] Strike with the hard rubber mallet, measure with the Korg
  OT-120.
- [ ] Log result for each bar in `validation.csv` row V2.
- [ ] **Expected outcome:** bars read 5–25 cents *low* of target.
  This is normal — final length is shaved in the next step.

## Step 7 — Tune by end-shaving

- [ ] On the end-shaving sled: shave equal amounts from each bar end
  in 1/64" increments. Symmetric shaving keeps the node positions
  centered.
- [ ] After each pass, re-suspend, re-strike, re-measure. Stop when
  cents-actual is within ±2 cents of target.
- [ ] Log result in `validation.csv` row V3.
- [ ] If a bar overshoots (reads sharp): **do not add material**.
  Either accept the +cents or scrap the bar.

## Step 8 — Mill frame parts

- [ ] Mill the two suspension rails to `21.000 × 2.250 × 1.250"`.
- [ ] Mill four legs to `30.000 × 1.500 × 1.500"`. Chamfer the top
  edge of each leg to clear the suspension cord.
- [ ] Cut four corner gussets from 1/2" Baltic birch plywood at
  `6.000 × 6.000"`, hypotenuse to hypotenuse (i.e., 45-degree
  triangles).

## Step 9 — Frame dry-fit

- [ ] Dry-assemble the frame: legs into rails via the gussets.
- [ ] Verify rail-to-rail spacing is 6.5" inside-to-inside (matches
  the bar width plus suspension margin).
- [ ] Verify legs are square to rails.

## Step 10 — Frame glue-up

- [ ] Apply Titebond III to all gusset-to-frame joints.
- [ ] Drive #10 × 2" wood screws through pilot holes (Padauk and
  hard maple both want pilots).
- [ ] Clamp 24 hours. Do not flex the frame during cure.

## Step 11 — Apply finish

- [ ] Wipe each bar with mineral spirits to remove sanding dust.
- [ ] Apply pure tung oil with a lint-free rag, three coats. Each
  coat dries 24 hours; sand lightly between coats with 320.
- [ ] Apply finish to the frame the same way (two coats is enough).
- [ ] **24 hours after the last bar coat:** re-measure each bar.
  Log in `validation.csv` row V4. Expected drift: −2 to −4 cents
  from finish mass loading. If drift exceeds −5 cents, end-shave
  again to compensate.

## Step 12 — Top-coat and cure

- [ ] Apply beeswax paste over the cured tung oil; buff out.
- [ ] Allow seven days at shop ambient before play-testing.

## Step 13 — Suspend bars

- [ ] Cut paracord to length: rail length × 2 + 12" tail per rail.
- [ ] Tie a stopper knot at each rail end.
- [ ] Thread cord through node holes in C5–C7 order, alternating
  bar-to-cord-to-bar.
- [ ] Terminate at the second rail with brass finish washers and a
  tied loop.

## Step 14 — Final validation

- [ ] Photograph the finished assembly per `photo-shotlist.md`
  shots 1, 2, 4, 5, 6, 7, 10.
- [ ] Run validation row V8 (full-octave evenness): measure C5, C6,
  C7 in one session. Document spread.
- [ ] Schedule validation rows V6 (30-day) and V7 (60-day) on the
  shop calendar.
- [ ] Mark this packet as `built` in the master catalog.

<div class="page-break"></div>

## validation.csv

Target/measured values, tolerance, environment, result, and tuning/build action log.

| row_id | note_id | phase | target_hz | measured_hz | cents_target | cents_actual | tuner_make_model | temp_F | humidity_RH_percent | environment_notes | date | result |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| V1 | ALL | prediction-paper | per family-spec |  | 0 |  | N/A | 68 | 45 | design table, pre-cut |  | first-order Euler-Bernoulli prediction; logged from family-spec.csv |
| V2 | A5 | post-cut | 880.00 |  | 0 |  | Korg OT-120 | 68 | 45 | shop bench, immediately after surface plane |  | first measurement; expected to read low if length over rough |
| V3 | A5 | post-shave | 880.00 |  | 0 |  | Korg OT-120 | 68 | 45 | shop bench, after end-shaving for fundamental |  | shave 1/64 in increments; recheck |
| V4 | A5 | post-finish | 880.00 |  | -3 to 0 |  | Korg OT-120 | 68 | 45 | shop bench, 24 hours after final tung-oil coat |  | finish adds mass; expected drift -2 to -4 cents |
| V5 | A5 | post-resonator-install | 880.00 |  | 0 |  | Korg OT-120 | 68 | 45 | shop, with resonator tube installed at quarter-wave length |  | deferred to v2 build |
| V6 | ALL | 30-day-moisture | per family-spec |  | within +/-5 |  | Korg OT-120 | TBD | TBD | 30 days post-finish; log temp and RH |  | retune any bar drifting beyond +/-5 cents |
| V7 | ALL | 60-day-moisture | per family-spec |  | within +/-5 |  | Korg OT-120 | TBD | TBD | 60 days post-finish; log temp and RH |  | second moisture check; if stable retire moisture rows |
| V8 | C5-C6-C7 | full-octave-evenness | 523.25, 1046.50, 2093.00 |  | within +/-5 across the three Cs |  | Korg OT-120 | 68 | 45 | all three Cs measured in one session for evenness |  | if greater than 10 cents spread, escalate to design review |

<div class="page-break"></div>

## supplier-rfq.md

Supplier email/request-for-quote starter.

# Xylophone — Supplier RFQ

Template — paste into supplier email or web form. The bar-stock RFQ
is the only critical-path RFQ; everything else is COTS from
`sourcing.csv` and does not need a custom quote.

---

**Subject:** Padauk bar-stock quote — 25-bar xylophone build

Hello,

I'm building a 25-bar chromatic xylophone (C5–C7) and I'd like a
quote on Padauk lumber for the bar set. Specs:

- **Species:** African Padauk (*Pterocarpus soyauxii*) — *not*
  Burma Padauk.
- **Form:** 4/4 lumber (15/16" rough, surfaced 4 sides to roughly
  3/4"–7/8" final), or fall-back to S2S if S4S is unavailable.
- **Grain:** **Quartersawn** strongly preferred (radial grain on the
  bar face). Riftsawn acceptable on 25–35% of the order. Flatsawn
  rejected — bars will warp.
- **Moisture content:** **Kiln-dried to 6–8% MC.** Please measure with
  a pin meter at multiple points and confirm in writing.
- **Defect tolerance:** No knots, no shake, no end-checks longer than
  1/2", no insect damage, no sap pockets. Color variation acceptable.
- **Total board feet:** Approximately **15 BF** to yield 25 bars
  (longest 17", shortest 9", at 1.5"×7/8") plus 20% waste.
- **Lengths preferred:** Boards in the 36–48" range. Anything shorter
  than 24" is hard to use.

Please quote:

1. Per-board-foot price for the spec above.
2. Total for 15 BF, FOB your shipping point.
3. Lead time from order to ship.
4. Photographs of two or three representative boards before payment
   so I can confirm grain orientation and color.

If S4S quartersawn is not available at this volume, please quote for
S2S quartersawn at 5/4 thickness instead and I'll mill to 7/8" myself.

Thanks,
Tony Koop
tonykoop@gmail.com

---

## RFQ tracking

| Field             | Value                                         |
|-------------------|-----------------------------------------------|
| RFQ ID            | XYL-RFQ-001                                   |
| Spec sheet        | `bom.csv` row `BAR-STOCK`                     |
| Sourcing options  | `sourcing.csv` rows for `BAR-STOCK`           |
| Sent date         | TBD                                           |
| Quote received    | TBD                                           |
| Decision          | TBD                                           |
| Order placed      | TBD                                           |
| Received in shop  | TBD                                           |
| MC at receipt     | TBD (target 6–8%; measure on arrival)         |

## Decision criteria

Pick the supplier whose quote yields **best (price × delivery × grade
match)**. Bell Forest Products is the default expectation; West Penn
and Cook are the named backups in `sourcing.csv`.

## What to do if no supplier can deliver to spec

Fall-back order: switch the spec's primary species in
`xylophone-design-table.xlsx` from Padauk to Hard Maple (Tier 3 in
`design.md`). Re-run the family table — predicted lengths shift
slightly because Maple's √(E/ρ) is 4229 m/s vs Padauk's 4112. Bars
end up about 1.4% longer. Update `family-spec.csv` and `cut-list.csv`
accordingly.

<div class="page-break"></div>

## visual-bom-brief.md

Art direction for an image-forward visual BOM.

# Xylophone — Visual BOM Brief

Brief for the visual BOM (the recruiter-facing assembly plate). One
page, every line in `bom.csv` represented by a thumbnail and a
two-line label.

## Page layout

- **Header.** Project name + version + quote date + total cost.
- **Hero strip** at top: `images/01-hero.jpg` (or the placeholder
  SVG until captured), full-width.
- **Three columns** of part rows below the hero, top-to-bottom:
  bar stock + finishing on the left, frame stock + hardware in the
  middle, mallets + tuning + measurement gear on the right.
- **Footer.** Total cost, link to the GitHub repo, license note.

## Part-row anatomy

Each row:

```
[thumbnail 60×60]  PART_ID — Part Name
                   Qty • Unit • Estimated cost • Supplier
                   One-line spec summary
```

Thumbnails are pulled from `images/` by part-id slug. When an image
is missing, fall back to a category placeholder (a square with the
part-id text centered, no decoration).

## Mapping bom.csv → visual BOM

| bom.csv part_id      | Image slug                          | Notes for plate                          |
|----------------------|-------------------------------------|------------------------------------------|
| BAR-STOCK            | `images/02-bar-fan.jpg`             | top-left, biggest cell                   |
| FRAME-RAIL           | `images/04-frame-elevation.jpg`     | use frame photo cropped to rails         |
| FRAME-LEG            | `images/04-frame-elevation.jpg`     | crop to legs                             |
| FRAME-GUSSET         | placeholder square                  | small detail, use category placeholder   |
| CORD-NODE            | `images/06-suspension-cord.jpg`     | cord visible against bars                |
| CORD-WASHER          | placeholder square                  |                                          |
| SCREW-FRAME          | placeholder square                  |                                          |
| GLUE-FRAME           | placeholder square                  |                                          |
| FINISH-OIL           | placeholder square                  |                                          |
| FINISH-WAX           | placeholder square                  |                                          |
| MALLET-HRD           | `images/05-mallet-trio.jpg`         | crop to hard-rubber mallet               |
| MALLET-MED           | `images/05-mallet-trio.jpg`         | crop to medium yarn mallet               |
| TUNER-CHROMA         | `images/07-tuner-on-bar.jpg`        | OT-120 mid-measurement                   |
| HYGRO-SHOP           | placeholder square                  |                                          |
| MOIST-METER          | `images/09-moisture-meter.jpg`      | meter on Padauk end-grain                |
| SANDPAPER-KIT        | placeholder square                  |                                          |
| DRILL-BIT-NODE       | placeholder square                  |                                          |
| RESONATOR-TUBE       | placeholder square — deferred       | grey out the row; v2 build               |

## Style

- Black text on white background. No decorative shading.
- Font: Inter or system-ui. Body 9pt, headings 11pt, totals 13pt.
- Print target: US Letter portrait, 0.5" margins. The visual BOM is
  the one page that must be printable in a shop.

## Output

The visual BOM is rendered as part of the print packet
(`print-packet.html` and `print-packet.pdf`). The HTML is the
source of truth; the PDF is generated from it. When optional PDF
deps are missing, the HTML alone is shippable.

<div class="page-break"></div>

## wolfram-starter.wl

Wolfram starter for physics, optimization, visualization, and validation.

```wolfram
(* ::Package:: *)

(* Xylophone — instrument-model.wl                                          *)
(* Free-free Euler-Bernoulli flat-bar idiophone. First-mode prediction,     *)
(* node positions, optional quarter-wave closed-pipe resonator, validation  *)
(* plot scaffolding, audio preview.                                         *)
(*                                                                          *)
(* Read references/wolfram-workflow.md before extending this file.          *)

(* ::Section:: *)
(* Parameters *)

(* Wood species shortlist — Padauk is the spec primary. Override by editing. *)
woodPadauk = <| "name" -> "African Padauk", "EGPa" -> 12.6, "rhoKg" -> 745. |>;
woodHondurasRosewood = <| "name" -> "Honduras Rosewood", "EGPa" -> 14.1, "rhoKg" -> 1000. |>;
woodHardMaple = <| "name" -> "Hard Maple", "EGPa" -> 12.6, "rhoKg" -> 705. |>;

(* Active wood — the only switch that matters at the top of the file. *)
woodActive = woodPadauk;

(* Bar geometry constants (held constant within a family in v1). *)
barWidthIn = 1.5;
barThickIn = 0.875;
inToM = 0.0254;

(* Resonator geometry. *)
resonatorBoreIn = 1.5;
soundSpeedAir = 343.0;            (* m/s at ~20 C *)
endCorrectionFactor = 0.82;        (* per acoustic-models.md, quarter-wave closed pipe *)

(* ::Section:: *)
(* Governing model *)

(* Free-free Euler-Bernoulli first mode:
       f1 = 1.028 * (h / L^2) * Sqrt[E/rho]
   Reference: acoustic-models.md, Free-Free Beams section.
   First-order only — K2 and end-corrections do not apply to bar idiophones. *)

soundSpeedSolid[E_, rho_] := Sqrt[(E*10.^9) / rho];

f1FromGeometry[L_, h_, E_, rho_] :=
  1.028 * (h / L^2) * soundSpeedSolid[E, rho];

lengthFromTarget[fTarget_, h_, E_, rho_] :=
  Sqrt[1.028 * h * soundSpeedSolid[E, rho] / fTarget];

resonatorLength[fTarget_, boreIn_] := Module[{boreM, lM},
  boreM = boreIn * inToM;
  lM = soundSpeedAir / (4 * fTarget) - endCorrectionFactor * boreM;
  lM / inToM
];

(* ::Section:: *)
(* Family table generation *)

chromaticC5toC7Notes = {
  {"C5",523.25},{"C#5",554.37},{"D5",587.33},{"D#5",622.25},
  {"E5",659.26},{"F5",698.46},{"F#5",739.99},{"G5",783.99},
  {"G#5",830.61},{"A5",880.00},{"A#5",932.33},{"B5",987.77},
  {"C6",1046.50},{"C#6",1108.73},{"D6",1174.66},{"D#6",1244.51},
  {"E6",1318.51},{"F6",1396.91},{"F#6",1479.98},{"G6",1567.98},
  {"G#6",1661.22},{"A6",1760.00},{"A#6",1864.66},{"B6",1975.53},
  {"C7",2093.00}
};

familyRow[note_String, fHz_?NumericQ] := Module[{Lm, Lin, holeLo, holeHi, Lres},
  Lm  = lengthFromTarget[fHz, barThickIn * inToM, woodActive["EGPa"], woodActive["rhoKg"]];
  Lin = Lm / inToM;
  holeLo = 0.224 * Lin;
  holeHi = 0.776 * Lin;
  Lres   = resonatorLength[fHz, resonatorBoreIn];
  <| "note" -> note, "fHz" -> fHz, "LIn" -> Lin,
     "holeLoIn" -> holeLo, "holeHiIn" -> holeHi,
     "resonatorLIn" -> Lres |>
];

familyTable := familyRow @@@ chromaticC5toC7Notes;

(* ::Section:: *)
(* Manipulate — interactive bar-length explorer *)

(* The Manipulate lets you sweep wood/L/h and see f1 in real time.
   Useful for sanity-checking first-order predictions and for showing
   players the why-bigger-is-lower-pitched relationship.            *)

manipulateBar := Manipulate[
  With[{
    fHz = f1FromGeometry[
      LIn * inToM, hIn * inToM, EChoice, rhoChoice]},
    Column[{
      Style[
        StringForm["f1 = `` Hz", NumberForm[fHz, {6, 2}]],
        Bold, 18],
      Plot[
        f1FromGeometry[L * inToM, hIn * inToM, EChoice, rhoChoice],
        {L, 4, 24}, AxesLabel -> {"L (in)", "f1 (Hz)"},
        PlotRange -> {0, 3000},
        GridLines -> {{LIn}, {fHz}}
      ]
    }]],
  {{LIn, 12.0, "bar length L (in)"}, 4.0, 24.0, 0.05},
  {{hIn, 0.875, "bar thickness h (in)"}, 0.5, 1.5, 0.01},
  {{EChoice, 12.6, "Young's modulus E (GPa)"}, 8.0, 16.0, 0.1},
  {{rhoChoice, 745.0, "density rho (kg/m^3)"}, 600.0, 1100.0, 5.0},
  ControlPlacement -> Top
];

(* ::Section:: *)
(* Audio preview *)

(* Synthesizes a 0.6-second pluck of the predicted fundamental for each
   note in the chromatic table. First-order only — not the actual modal
   spectrum of a real bar, just a confirmation of the predicted f1.   *)

audioForNote[fHz_?NumericQ] :=
  AudioPad[
    Sound[SoundNote[None, 0.0]] /. _ ->
      AudioGenerator["Sin", 0.6, "Frequency" -> fHz, SampleRate -> 44100],
    {0, 0.05}
  ];

playFamily := AudioJoin @@ (audioForNote[#[[2]]] & /@ chromaticC5toC7Notes);

(* ::Section:: *)
(* Validation plot scaffold *)

(* Compare predicted f1 (column 1) to measured Hz (column 2) once the
   shop log fills in. Until measurements exist, the plot just shows
   the predicted line and a residual band. Wire to validation.csv via
   record_measurement.py.                                              *)

predictedVsMeasuredPlot[predicted_List, measured_List] :=
  ListPlot[
    {predicted, measured},
    PlotStyle -> {{Thick, Blue}, {PointSize[0.012], Red}},
    PlotLegends -> {"predicted", "measured"},
    AxesLabel -> {"note index (low → high)", "f1 (Hz)"},
    PlotRange -> All,
    GridLines -> Automatic
  ];

centsErrorPlot[predicted_List, measured_List] :=
  ListPlot[
    1200. * Log[2., measured / predicted],
    Filling -> Axis,
    PlotRange -> {-30, 30},
    AxesLabel -> {"note index", "cents error (measured − predicted)"},
    GridLines -> {None, {-5, 0, 5}}
  ];

(* ::Section:: *)
(* Document entry point *)

(* CreateDocument call lives in the notebook layer, not here. Open this
   .wl in Wolfram Desktop, evaluate manipulateBar, then evaluate
   playFamily to hear the predicted family.                             *)

(* End of file *)
```

<div class="page-break"></div>

## README.md

Project artifact.

# Xylophone

![Xylophone hero — 25-bar chromatic in Padauk on a parametric trestle frame (placeholder)](images/xylophone-hero-placeholder.svg)

A 25-bar chromatic xylophone, **C5 to C7**, in African Padauk on a
parametric trestle frame. Free-free flat-bar geometry, 12th-overtone
tuning convention, optional quarter-wave closed-pipe resonators
(deferred to v2). This repo is a v4.3 root-mode build packet from the
[`tonykoop/instrument-maker`](https://github.com/tonykoop/instrument-maker)
catalogue, designed deliberately as the *simpler sibling* of a future
`tonykoop/marimba` repo.

## Background

The xylophone is the higher-pitched cousin of the marimba: same
physics (free-free Euler-Bernoulli transverse beam vibration), harder
mallets, shorter bars, and a different second-mode tuning convention.
This packet ships the bar physics, the wood-species shortlist, the
suspension geometry, the validation workflow, and the build process
end-to-end. It deliberately *defers* the things that make a marimba
hard — the parabolic arch undercut, the mandatory tuned resonators,
the multi-octave frame — so the xylophone build is feasible in one
shop session and so the marimba follow-on can inherit a clean
scaffold rather than starting from scratch.

The root-of-truth design table is `xylophone-design-table.xlsx` at
the repo root. Every length, hole position, and resonator length in
`family-spec.csv` is solved from the parametric inputs there.

## Design overview

- **Family:** 25 bars, C5 (523.25 Hz) through C7 (2093.00 Hz), chromatic.
- **Bar geometry:** flat-bottom rectangular, **1.500" × 0.875" cross
  section** held constant across the family. Length varies per note;
  see [`family-spec.csv`](family-spec.csv).
- **Wood:** **African Padauk** (sustainable, predictable acoustic
  properties, available in 4/4 quartersawn). Honduras Rosewood and
  Hard Maple are documented swap-ins.
- **Suspension:** 1/8" paracord through node holes drilled at 22.4%
  and 77.6% of bar length — the first free-free mode's nodes.
- **Tuning:** 12th-overtone convention noted as a *measurement
  target* on the validation sheet, not a CAD geometry. End-shaving
  is the production tuning method (no arch undercut — that's marimba).
- **Frame:** parametric 4-leg trestle, 21" wide × 30" tall, hard
  maple rails and legs with Baltic-birch corner gussets.
- **Resonators:** computed but optional. The L-per-note math is in
  `family-spec.csv` so adding resonators in v2 is additive.

## Family-table preview (first and last)

| Note | Target Hz | Bar L (in) | Hole low (in) | Hole high (in) | Resonator L (in) | Mass (oz) |
|------|-----------|------------|---------------|----------------|------------------|-----------|
| C5   | 523.25    | 16.683     | 3.737         | 12.946         | 5.22             | 9.43      |
| A4 * | 440.00    | n/a        | n/a           | n/a            | n/a              | n/a       |
| A5   | 880.00    | 12.865     | 2.882         | 9.983          | 2.61             | 7.27      |
| C7   | 2093.00   | 8.342      | 1.869         | 6.473          | 0.38             | 4.71      |

\* A4 = 440 Hz is the standard tuning reference; the family ranges
from C5 upward, so A4 itself is not a member.

Full table: [`family-spec.csv`](family-spec.csv).

## Why this packet exists

This is the v4.3 challenge run for the
[`instrument-maker-v4`](https://github.com/tonykoop/instrument-maker)
skill, exercising the **root-mode** packet contract end-to-end on a
new wooden-idiophone family. Specifically:

1. Validates the v4.3 root-mode validator (`validate_packet.py
   --mode root`) against a fresh Mode A repo.
2. Demonstrates the bar-idiophone branch of `acoustic-models.md`'s
   Free-Free Beams section with first-order honesty about K2 and
   end-correction guard rules.
3. Builds the design template that the marimba sister repo will
   inherit — every "marimba-equivalent: …" callout in
   [`design.md`](design.md) is a hook for the marimba build.

## Sister repos and references

- [`tonykoop/instrument-maker`](https://github.com/tonykoop/instrument-maker)
  — parent catalogue, the v4 skill source, references and scripts.
- [`tonykoop/tongue-drum`](https://github.com/tonykoop/tongue-drum) —
  closest sister repo: another wooden idiophone, free-free / cantilever
  beam math, SolidWorks master-layout convention, magazine-baseline
  attribution. The xylophone README borrows its structure.
- `tonykoop/marimba` *(planned)* — the natural follow-on; this
  packet's `design.md` calls out exactly what each marimba decision
  has to swap in (`Marimba-Equivalent Hooks` table).

## Repo layout

```
xylophone/
├── README.md                     ← this file
├── design.md                     ← governing model, family plan, decisions
├── family-spec.csv               ← parametric per-note table (25 rows)
├── bom.csv, sourcing.csv         ← parts and supplier candidates
├── cut-list.csv                  ← shop cut list (bars + frame)
├── validation.csv                ← measured-tuning workflow (8 rows)
├── assembly-manual.md            ← 14-step shop manual
├── supplier-rfq.md               ← bar-stock RFQ template
├── drawing-brief.md              ← what the SVG drawings must show
├── visual-bom-brief.md           ← printable visual BOM brief
├── wolfram-starter.wl            ← parametric Wolfram source
├── risks.md                      ← red-team risk register
├── resources.md                  ← citations and references
├── jig-decision.md               ← three jig build/no-build calls
├── photo-shotlist.md             ← ten-shot photo plan
├── capstone-deck.md / .pptx      ← recruiter-facing slide deck
├── print-packet.md / .html / .pdf ← shop-printable packet
├── capstone-manifest.json        ← deck-and-packet manifest
├── xylophone-design-table.xlsx   ← parametric source of truth
├── images/                       ← hero, build photos
├── drawings/                     ← per-bar SVGs + frame elevation/plan
├── cad/                          ← SolidWorks master (deferred)
├── cnc/                          ← cnc-plan.json + setup-sheet.md
├── jigs/                         ← jig sketches (deferred)
└── site/                         ← static build-log site
```

## License

[CC BY 4.0](LICENSE) — see LICENSE for details.

<div class="page-break"></div>

## family-spec.csv

Project artifact.

| note | target_hz | bar_length_in | bar_width_in | bar_thickness_in | hole_pos_low_in | hole_pos_high_in | predicted_f1_hz | predicted_f1_source | wood_species | resonator_l_in_optional | mass_oz_est | notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| C5 | 523.25 | 16.683 | 1.500 | 0.875 | 3.737 | 12.946 | 523.25 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 5.22 | 9.43 | solved L from target_hz |
| C#5 | 554.37 | 16.208 | 1.500 | 0.875 | 3.631 | 12.578 | 554.37 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 4.86 | 9.16 | solved L from target_hz |
| D5 | 587.33 | 15.747 | 1.500 | 0.875 | 3.527 | 12.220 | 587.33 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 4.52 | 8.90 | solved L from target_hz |
| D#5 | 622.25 | 15.299 | 1.500 | 0.875 | 3.427 | 11.872 | 622.25 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 4.20 | 8.65 | solved L from target_hz |
| E5 | 659.26 | 14.863 | 1.500 | 0.875 | 3.329 | 11.534 | 659.26 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 3.89 | 8.40 | solved L from target_hz |
| F5 | 698.46 | 14.440 | 1.500 | 0.875 | 3.235 | 11.205 | 698.46 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 3.60 | 8.16 | solved L from target_hz |
| F#5 | 739.99 | 14.029 | 1.500 | 0.875 | 3.142 | 10.886 | 739.99 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 3.33 | 7.93 | solved L from target_hz |
| G5 | 783.99 | 13.630 | 1.500 | 0.875 | 3.053 | 10.577 | 783.99 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 3.08 | 7.70 | solved L from target_hz |
| G#5 | 830.61 | 13.242 | 1.500 | 0.875 | 2.966 | 10.275 | 830.61 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 2.83 | 7.48 | solved L from target_hz |
| A5 | 880.00 | 12.865 | 1.500 | 0.875 | 2.882 | 9.983 | 880.00 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 2.61 | 7.27 | solved L from target_hz |
| A#5 | 932.33 | 12.498 | 1.500 | 0.875 | 2.800 | 9.699 | 932.33 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 2.39 | 7.06 | solved L from target_hz |
| B5 | 987.77 | 12.143 | 1.500 | 0.875 | 2.720 | 9.423 | 987.77 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 2.19 | 6.86 | solved L from target_hz |
| C6 | 1046.50 | 11.797 | 1.500 | 0.875 | 2.643 | 9.154 | 1046.50 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 2.00 | 6.67 | solved L from target_hz |
| C#6 | 1108.73 | 11.461 | 1.500 | 0.875 | 2.567 | 8.894 | 1108.73 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 1.81 | 6.48 | solved L from target_hz |
| D6 | 1174.66 | 11.135 | 1.500 | 0.875 | 2.494 | 8.641 | 1174.66 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 1.64 | 6.29 | solved L from target_hz |
| D#6 | 1244.51 | 10.818 | 1.500 | 0.875 | 2.423 | 8.395 | 1244.51 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 1.48 | 6.11 | solved L from target_hz |
| E6 | 1318.51 | 10.510 | 1.500 | 0.875 | 2.354 | 8.156 | 1318.51 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 1.33 | 5.94 | solved L from target_hz |
| F6 | 1396.91 | 10.211 | 1.500 | 0.875 | 2.287 | 7.923 | 1396.91 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 1.19 | 5.77 | solved L from target_hz |
| F#6 | 1479.98 | 9.920 | 1.500 | 0.875 | 2.222 | 7.698 | 1479.98 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 1.05 | 5.61 | solved L from target_hz |
| G6 | 1567.98 | 9.638 | 1.500 | 0.875 | 2.159 | 7.479 | 1567.98 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 0.92 | 5.45 | solved L from target_hz |
| G#6 | 1661.22 | 9.363 | 1.500 | 0.875 | 2.097 | 7.266 | 1661.22 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 0.80 | 5.29 | solved L from target_hz |
| A6 | 1760.00 | 9.097 | 1.500 | 0.875 | 2.038 | 7.059 | 1760.00 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 0.69 | 5.14 | solved L from target_hz |
| A#6 | 1864.66 | 8.838 | 1.500 | 0.875 | 1.980 | 6.858 | 1864.66 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 0.58 | 5.00 | solved L from target_hz |
| B6 | 1975.53 | 8.586 | 1.500 | 0.875 | 1.923 | 6.663 | 1975.53 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 0.48 | 4.85 | solved L from target_hz |
| C7 | 2093.00 | 8.342 | 1.500 | 0.875 | 1.869 | 6.473 | 2093.00 | free-free Euler-Bernoulli f1=1.028(h/L^2)sqrt(E/rho); first-order; Padauk E=12.6GPa rho=745kg/m3 | Padauk | 0.38 | 4.71 | solved L from target_hz |

<div class="page-break"></div>

## jig-decision.md

Project artifact.

# Xylophone — Jig Decisions

Three jig decisions, each with build/no-build recommendation, the
break-even calculation that drives it, and a one-paragraph build
sketch when the answer is build.

## 1. Node-hole drilling jig — **BUILD**

**Decision.** Build a fixed-fence drilling jig with two adjustable
stops keyed to the 22.4% / 77.6% positions of the bar length.

**Rationale.** 25 bars × 2 holes = 50 holes. Each hole must land
within ±1/32" of the node position or the bar's first mode picks up
audible damping. Hand-marking 50 holes from a tape measure is
unreliable at this tolerance. A jig with two flip-stops set against
the bar end pays back the build time on bar #4 or #5.

**Sketch.** Plywood base 22"×6"×1/2", drill press fence along the
back edge, two T-track flip-stops in a pair of 6" T-tracks routed
flush. Each bar's two stop positions get pre-marked on a strip
sticker per note — operator slides the bar against the front stop
for the low-side hole, drills, flips the front stop down and the
back stop up, drills the high-side hole. The stops are positioned
from the bar's actual length, not a percent, so the operator never
does math at the drill press.

## 2. Bar-end-shaving sled — **BUILD**

**Decision.** Build a low-angle hand-plane shooting sled sized to
the longest bar.

**Rationale.** Tuning happens by removing material from the bar
ends — *not* the underside (xylophone has no arch). End-shaving
needs to be square to the bar's long axis and parallel to the
opposite end, otherwise the bar develops a wedge that affects both
the fundamental tuning and the cord-hole alignment. A shooting sled
makes both square and parallel automatic.

**Sketch.** Hardwood base 20"×6", 90° fence along one long edge,
a stop block at the right end and a clamp wedge at the left. The
bar slides against the fence; the plane runs along the base; the
stop block prevents over-running the cut. A piece of 220 paper
glued to the fence prevents skating. Build the fence dead-square
to the base — measure with a machinist square before glue-up.

## 3. Frame-rail miter sled — **NO BUILD; use existing miter saw**

**Decision.** Cut the rail-to-leg miters on the existing sliding
compound miter saw. No jig.

**Rationale.** Eight 45° miters total (four leg ends × two each).
A standard miter saw with a sharp 80T blade lands every miter at
±0.25° easily, and the joints are reinforced by gusset plates
anyway. Building a miter sled would cost a half-day and pay back
nothing for an 8-cut job.

**Note for marimba sister repo.** A multi-octave marimba has 60+
miter cuts in the resonator-tube wells alone. The marimba repo
should re-evaluate this decision and likely build a dedicated
sled.

<div class="page-break"></div>

## photo-shotlist.md

Project artifact.

# Xylophone — Photo Shotlist

Ten shots that the build-log site, capstone deck, and visual BOM all
draw from. Tied to the repo-level `docs/photo-pipeline.md` rules
(neutral background, 5500K key light, sensor at instrument plane,
no flash, JPEG + RAW). When a photo is captured, drop it under
`images/` with the slug filename listed below — the deck and site
templates will pick them up.

## 1. Hero — `images/01-hero.jpg`

Full instrument on a clean dark-grey background, three-quarter angle
from above-right, both mallets resting at the keyboard end of the
frame. Lens normal-to-wide (35–50mm full frame). This is the README
hero swap — until captured, `images/xylophone-hero-placeholder.svg`
stands in.

## 2. Bar fan — `images/02-bar-fan.jpg`

All 25 bars laid out flat on a white seamless, shortest-to-longest,
1/2" gap between each. Top-down. This image goes on the deck's
"Family Plan" slide.

## 3. Node-hole detail — `images/03-node-hole-detail.jpg`

Macro of the 1/8" node hole on the C5 bar with paracord threaded
through. Lens 100mm macro. Light raking from one side to bring out
the cord texture and the hole chamfer. Goes on the assembly-manual's
node-suspension step.

## 4. Frame elevation — `images/04-frame-elevation.jpg`

Side-on, eye-level, frame only (no bars), centered. Shot far enough
back to be free of perspective distortion (~85mm full frame).
Used in `drawing-brief.md` as the dimension reference photo.

## 5. Mallet trio — `images/05-mallet-trio.jpg`

Hard rubber, lexan, and rosewood-head mallets laid parallel on a
white seamless, heads aligned at the top. Top-down. Used in the
`bom.csv`-driven visual BOM.

## 6. Suspension cord — `images/06-suspension-cord.jpg`

Three-quarter view of one full bar suspended on the cord at both
node holes, with the cord ends terminating at the rail with the brass
finish washers. Shows the geometry without the rest of the bars in
frame. Used on the build-log site's "How the bars are suspended"
section.

## 7. Tuner on bar — `images/07-tuner-on-bar.jpg`

The Korg OT-120 displayed mid-measurement on the A5 bar, mallet just
having struck. Captures the validation workflow in one frame. Used
on the validation slide of the deck.

## 8. Resonator stub — `images/08-resonator-stub.jpg` (deferred)

A single quarter-wave aluminum tube cut to the C5 resonator length
(5.22"), held against the underside of the suspended C5 bar. Shot
when v2 build adds resonators. Until then, this slot stays blank.

## 9. Moisture meter — `images/09-moisture-meter.jpg`

Pin meter inserted into the end-grain of a Padauk blank pre-glue-up,
display showing 6.5–7.5% MC. Goes on the assembly-manual's
"Verify moisture" step.

## 10. Finished assembly — `images/10-finished-assembly.jpg`

Three-quarter wide-angle of the finished xylophone in a play-ready
position (mallets in player's hands, bars attached, frame on a
real floor). Eye-level standing. The "this thing works" portrait
that closes the build-log site.

<div class="page-break"></div>

## resources.md

Project artifact.

# Xylophone — Resources

Citations, references, and the source-of-truth pointers that this
packet relies on. Where the packet states a number, this file says
*where the number came from*.

## Acoustic physics

- **Fletcher, Neville H., and Thomas D. Rossing.** *The Physics of
  Musical Instruments,* 2nd ed., Springer, 1998. Chapter 19 (Bars,
  Plates, and Membranes) — the canonical free-free Euler-Bernoulli
  derivation. Equations 19.7–19.13 yield the `K_free_free / K_cantilever
  = (4.730/1.875)² ≈ 6.36` factor used throughout this packet.
- **Bork, Ingolf.** "Practical Tuning of Xylophone Bars and Resonators,"
  *Applied Acoustics* 46 (1995): 103–127. Source for the 12th-overtone
  tuning convention and the bar-end-shaving correction shape. Bork's
  measured-vs-flat-bar second-mode ratio (~2.756) is the basis for the
  `first-mode-vs-second-mode-misalignment` risk.
- **Suits, B. H.** "Basic Physics of Xylophone and Marimba Bars."
  *American Journal of Physics* 69(7) (2001): 743–750. Clean
  derivation of the arch-undercut math the marimba sister repo will
  inherit; **explicitly cited** here as the "deferred-to-marimba"
  reference.
- **`acoustic-models.md`** (instrument-maker-v4 skill,
  `references/acoustic-models.md`). Free-Free Beams section is the
  primary citation — it both consolidates the formula in Tony's house
  units (h, L, E, ρ) and carries the empirical-correction guard rules
  that govern when K-constants do and do not apply.

## Material constants

- **Wood Database** (Eric Meier, https://www.wood-database.com/). E
  and ρ values for African Padauk (E ≈ 12.6 GPa, ρ ≈ 745 kg/m³),
  Honduras Rosewood (E ≈ 14.1 GPa, ρ ≈ 1000 kg/m³), and Hard Maple
  (E ≈ 12.6 GPa, ρ ≈ 705 kg/m³). Cross-checked against the K-constant
  table in `acoustic-models.md`.

## Tuning workflow / measurement

- **`record_measurement.py`** (instrument-maker-v4 skill,
  `scripts/record_measurement.py`). Schema for `validation.csv` and
  the per-family corrections database. The `tuner_make_model`,
  `temp_F`, `humidity_RH_percent`, and `cents_target` columns in
  this packet's `validation.csv` map 1:1 to the script's CLI flags.
- **Korg OT-120** orchestral chromatic tuner. ±0.1 cent accuracy in
  the C5–C7 range. Listed as the device of record in `bom.csv`.

## Empirical-correction guard rules

- **`acoustic-models.md`** "Empirical-correction guard rules" section.
  Cited in `design.md`'s Governing Model and in every prediction line
  of `family-spec.csv`. The summary in shop-friendly terms: K2 and
  end-corrections **do not apply** to bar idiophones; cantilever
  K-constants apply to free-free via the 6.36× factor; everything is
  *first-order* until measured.

## Repository conventions

- **`tongue-drum/README.md`** (sister repo). README structure,
  cross-repo link block, magazine-baseline attribution pattern. This
  packet's `README.md` rewrites in the same shape.
- **`tongue-drum/cad/`** (sister repo). SolidWorks master-layout
  convention for parametric design tables. Cited in `cad/README.md`
  as the model the xylophone CAD will follow when built.
- **`golden-examples.md`** (instrument-maker-v4 skill,
  `references/golden-examples.md`). Mode A root-mode layout exemplar
  — every file in this packet sits at the repo root because that
  reference says so.

## Marimba/xylophone difference summary

The single best one-page summary of how xylophone and marimba differ:
**Suits 2001** (above). The salient points the packet operationalizes:

- Xylophone tunes the second mode to a 12th (3:1 ratio) above the
  fundamental; marimba tunes to two octaves (4:1).
- Xylophone bars are typically rosewood or padauk, smaller cross-section,
  often without arch undercut in low-end / educational instruments.
- Xylophone resonators (when present) are shorter quarter-wave tubes;
  marimba resonators are tuned at the bench by ear.
- Mallets are harder for xylophone; bars consequently must be harder
  wood and well-supported at the nodes.

Every "marimba-equivalent" callout in `design.md` traces back to this
section.

<div class="page-break"></div>

## risks.md

Project artifact.

# Xylophone — Risks Register

Five categories, at least one entry each, every entry with an
attached verification *test* per the v4 red-team specialist contract.

## Acoustic

### bar-cracking-from-hard-mallets
**Risk.** Hard rubber and lexan mallets, especially struck near the
bar end rather than at the strike line, can crack a flat-bar Padauk
bar within months. Hard mallets are appropriate for xylophone — but
the failure mode is real and accelerates with low ambient humidity.

**Test.** Strike test: with the C5 bar (longest, most stress) clamped
in the suspension cord, strike 100 times near the strike line and
50 times deliberately near the end with a hard rubber mallet. Inspect
for hairline cracks under raking light. Repeat after 30 days at
shop ambient. Pass = no visible cracks; fail = any crack.

### first-mode-vs-second-mode-misalignment
**Risk.** First-order math predicts only `f_1`. The 12th-overtone
xylophone tuning convention asks for the second flexural mode to
sit at a 3:1 ratio, which a flat bar does **not** naturally do —
the unpinched second-mode ratio of a free-free Euler-Bernoulli
beam is closer to 2.756. Means players will hear the second mode
"out of tune" with the fundamental.

**Test.** Spectrum-analyzer measurement (free phone app like
SpectroidPro): pluck/strike the bar, capture the spectrum, identify
the fundamental and the strongest second peak, compute the ratio.
Pass = ratio between 2.7 and 3.0 (unundercut bars cluster around
2.756); fail = ratio outside that band. Document. The marimba sister
repo will fix this with arch undercut; the xylophone v1 packet
*accepts* the natural ratio and notes it on the validation sheet.

## Structural

### moisture-retune-drift
**Risk.** Padauk at 6–8% MC at glue-up will move when the shop ambient
changes. A 4% MC swing across a humid summer to a dry winter can shift
fundamentals by 5–15 cents. Not a structural failure, but a tuning
failure that compounds across all 25 bars.

**Test.** Record temp/RH at every measurement row in `validation.csv`
(rows V2 through V8). Re-measure every bar at 30 and 60 days
(rows V6, V7). Pass = drift within ±5 cents on all bars at both
checkpoints; fail = drift exceeds ±5 cents — flag the bar in
`record_measurement.py`, update the per-family corrections database.

### cord-hole-tear-out
**Risk.** 1/8" node holes drilled near the bar's high-stress mode
zone. Repeated player force on the cord at the hole can tear out the
hole, especially if grain runs across it.

**Test.** Pull-test on the longest bar (C5): tie the suspension cord
through both holes, suspend the bar, hang a 5-lb weight from the
center of the bar, hold for 60 seconds. Inspect holes for cracking
or elongation. Pass = no visible damage; fail = elongation, splitting,
or cord chafing. If fail, drill a slightly larger hole and chamfer
both ends.

## Ergonomic

### frame-tipping-on-uneven-floor
**Risk.** 4-leg trestle frame with a 21" rail and 30" leg height can
tip if a player strikes near the rail end with a heavy two-handed
attack on an uneven floor.

**Test.** Place frame on a 5° tilted board. Have a player strike
the C5 bar (rail end) with full two-handed force using yarn-wrapped
medium mallets. Frame should not tip. Pass = stable; fail = tips.
Mitigation if fail: add 6" leg-foot crossbraces or weight the bottom
of each leg.

## Supply

### honduras-rosewood-cites-lead-time
**Risk.** If a player overrides the Padauk default and chooses
Honduras Rosewood, the species is **CITES Appendix II** as of
2017. Sourcing with proper documentation is slow (60–120 days)
and expensive (~3× Padauk).

**Test.** If HR is selected, validate before order: supplier provides
CITES export permit number; cross-check against the CITES species
database. Pass = permit number valid and product description matches;
fail = no permit or mismatch — reject the order, fall back to Padauk.

## Fit/Finish

### tung-oil-finish-darkening-padauk
**Risk.** Padauk is naturally bright orange-red but oxidizes to a
deeper brown over months. Tung oil accelerates the oxidation. After
6–12 months bars look noticeably darker than at first build —
visual mismatch if a single bar is replaced later.

**Test.** Cut a 2"×2" Padauk swatch at the same time as the bars.
Apply same finish schedule. Store with the bars. After 30, 60, 180
days, photograph swatch under controlled light. Pass = expected
gradual darkening, no spotting or blooming; fail = uneven oxidation
patches — switch to a UV-blocking topcoat.
