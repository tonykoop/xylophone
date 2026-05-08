# Xylophone — v4.3 Root-Mode Packet Handoff Report

**Date:** 2026-05-08
**Skill:** instrument-maker-v4 (v4.3 release candidate)
**Mode:** A (root-mode), Mode A repo at `C:\Users\Tony\Documents\GitHub\xylophone`

## 1. Validator status

**`scripts/validate_packet.py --mode root --json` → `ok: true`, zero findings.**

```json
{
  "layout": "root",
  "pass_1_findings": [],
  "fixes_applied": [],
  "pass_2_findings": null,
  "findings": [],
  "ok": true
}
```

All Tier 1 deliverables present: `design.md`, `bom.csv`,
`sourcing.csv`, `cut-list.csv`, `validation.csv`, `assembly-manual.md`,
`supplier-rfq.md`, `drawing-brief.md`, `visual-bom-brief.md`,
`wolfram-starter.wl`, `risks.md`, `capstone-deck.md`,
`capstone-deck.pptx`, `print-packet.md`, `print-packet.html`,
`print-packet.pdf`, `capstone-manifest.json`, `README.md`.

v4.3 adjuncts present: `family-spec.csv`, `photo-shotlist.md`,
`resources.md`, `jig-decision.md`, `cnc/cnc-plan.json`,
`cnc/operations.csv`, `cnc/setup-sheet.md`, `cad/README.md`,
`jigs/README.md`, `drawings/template.svg`, `site/index.html`,
`images/xylophone-hero-placeholder.svg`.

**Smoke checks (independent of validator):**

- `README.md` = 6,493 bytes (≥2,000 byte threshold).
- `family-spec.csv` = 26 lines (header + 25 chromatic notes C5–C7).
- `design.md` `## Intent` heading present (deck regex hit).
- `risks.md` has 7 risk entries spanning all five required categories.
- `capstone-deck.md` has 14 slides (≥12 threshold).
- `capstone-manifest.json` parses cleanly.
- `site/index.html` is valid HTML with `<title>Xylophone — Design — Tony Koop's Build Log</title>`.
- `capstone-deck.pptx` 48.7 KB, `print-packet.pdf` 90.6 KB — both
  generated end-to-end (python-pptx and reportlab were already
  installed in this env, so the planned degradation case did not
  trigger).

## 2. Unresolved assumptions

| Assumption                       | Status   | What would resolve it                                                              |
|----------------------------------|----------|------------------------------------------------------------------------------------|
| No measured tuning data          | Open     | First prototype build → measure post-cut frequencies → run `record_measurement.py` |
| Wood species (Padauk default)    | Open     | Confirm sustainable Padauk supplier or switch in HR / Hard Maple in xlsx           |
| Family range C5–C7 chromatic     | Confirmed| User-selected during plan-mode intake; F4–F6 / G4–G6 documented as alternatives    |
| Bar thickness held constant 7/8" | Open     | Production xylo often steps thickness up at low octave — re-examine post v1 build  |
| Resonator strategy               | Deferred | Optional in v1; tube-installation flow lives in `validation.csv` row V5            |
| CAD master                       | Deferred | Build SolidWorks master per tongue-drum convention after first measured build      |
| Mallet supplier choice           | Open     | RFQ to Innovative Percussion / Encore / Vic Firth; no pick yet                     |

The biggest of these by far is **no measured data**. Every Hz in
`family-spec.csv` is a first-order Euler-Bernoulli prediction with the
*first-order estimate* caveat baked into the design.md, the wolfram
package, and the validation.csv. Closing this assumption requires
shop time, not desk time.

## 3. Jig and frame decisions

From `jig-decision.md`:

- **Node-hole drilling jig — BUILD.** 50 holes total at ±1/32" tolerance;
  flip-stop fixture pays back on bar #4–5.
- **Bar-end-shaving sled — BUILD.** Shaving must be square and
  parallel; a shooting sled makes both automatic.
- **Frame-rail miter sled — NO BUILD.** 8 miters total; the existing
  miter saw with a sharp 80T blade is enough.

**Frame:** parametric 4-leg trestle, 21" wide × 30" tall, hard-maple
rails and legs with Baltic-birch corner gussets. Rationale: simplest
shape that resolves all four xylophone constraints (longest bar
clearance, standard standing-play height, suspension cord termination,
shop-buildable in one session).

## 4. Measured-validation needs

`validation.csv` defines eight rows that need shop time to close out:

| Row | Phase                          | Note(s)        | Trigger                    |
|-----|--------------------------------|----------------|----------------------------|
| V1  | prediction-paper               | ALL            | already done (in spec)     |
| V2  | post-cut                       | A5 representative | first prototype bandsaw + plane |
| V3  | post-shave                     | A5             | end-shave to fundamental   |
| V4  | post-finish                    | A5             | 24h after final tung-oil   |
| V5  | post-resonator-install         | A5             | deferred to v2 build       |
| V6  | 30-day-moisture                | ALL            | 30 days post-finish        |
| V7  | 60-day-moisture                | ALL            | 60 days post-finish        |
| V8  | full-octave-evenness           | C5, C6, C7     | one-session evenness check |

The closure workflow per row: capture Hz with the Korg OT-120, log
`temp_F` + `humidity_RH_percent`, then run

```bash
python3 scripts/record_measurement.py \
  --packet /mnt/c/Users/Tony/Documents/GitHub/xylophone \
  --note-id A5 --measured-hz <observed> \
  --tuner "Korg OT-120" --environment "shop, 68F, 45% RH"
```

The script computes cents error vs the prediction, appends to the
per-family corrections database, and flags any sibling packets in the
same family whose predictions just shifted by more than 2 cents — at
launch the only sibling that will exist is the future marimba repo,
which means xylophone measurements will start *seeding* the marimba
predictions before marimba is even built.

## 5. Marimba stepping-stone fitness — confidence: HIGH

This packet was deliberately authored as the marimba repo's scaffold.
Three concrete hooks:

1. **Same governing model.** Free-free Euler-Bernoulli with the
   `K_free_free ≈ 6.36 × K_cantilever` factor. Marimba's only physics
   addition is the **arch undercut** geometry (parabolic CNC cut on
   the underside, formula explicitly cited in `design.md`'s
   "Marimba-equivalent" callout under Bar Geometry). The undercut
   *modifies* the predicted f₁ — it doesn't replace the model.
2. **Same family-spec contract.** `family-spec.csv` columns
   (`note,target_hz,bar_length_in,bar_width_in,bar_thickness_in,
   hole_pos_low_in,hole_pos_high_in,predicted_f1_hz,predicted_f1_source,
   wood_species,resonator_l_in_optional,mass_oz_est,notes`) all
   transfer to marimba. Marimba adds two columns:
   `arch_center_thickness_in` and `resonator_l_in_required`.
3. **Same validation workflow.** The eight-row schema in
   `validation.csv`, including the 30/60-day moisture rows, the
   tuner spec, and the `record_measurement.py` flow — all
   inherited verbatim. Marimba's only addition is a `post-arch-cut`
   measurement row between V2 and V3.

The `Marimba-Equivalent Hooks` table in `design.md` is the explicit
delta map: 8 rows, each one a single editable cell that turns the
xylophone packet into a marimba scaffold. A `cp -r xylophone/* marimba/`
followed by edits to those 8 rows + adding the arch-undercut math
section is the smallest viable bootstrap path.

**Recommendation:** before starting `marimba/`, build at least the V2
and V3 rows of this packet's `validation.csv` on a real Padauk bar.
That measurement ratio (predicted vs measured for a flat free-free
bar) is the *empirical anchor* both repos will share, and it should
exist before the marimba repo's predictions are computed against it.
