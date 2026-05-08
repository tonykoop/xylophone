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
