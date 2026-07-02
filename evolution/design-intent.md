# Design Intent — xylophone rev A

- Master CAD: `cad/xylophone.scad` (sha256: bffea1571ad04a29865a15cf72456fba2f012f93da7229aa9ad8fb3eb6ef3918), driven by `xylophone-design-table.xlsx` (sha256: 01b4556e8925f5cd1ec137b044a481305ed52c24df1608c4a3ef1d7126a91e23)
- Function: 25-bar chromatic xylophone, C5 (523.25 Hz) to C7 (2093.00 Hz), African Padauk flat-bottom bars on a 4-leg parametric trestle frame. Free-free Euler-Bernoulli transverse beam vibration (`f1 = 1.028*(h/L^2)*sqrt(E/rho)`); 1/8" paracord suspension through node holes at the free-free first mode's node fractions (22.4%/77.6% of bar length); 12th-overtone tuning convention is a measurement target, not CAD geometry (design.md).
- Environment: struck idiophone, indoor/studio use; end-shaving is the production tuning method (manual, post-cut).
- Target qty: 1 (prototype, deliberately simpler sibling of a planned marimba repo). Deadline: TBD. Budget/unit ceiling: TBD.

## Critical dimensions (carry tolerances)

| Feature | Nominal | Tolerance | Why critical | Source |
| --- | --- | --- | --- | --- |
| Bar cross section | 1.500 x 0.875 in (constant across family) | held constant | sets predicted f1 via Euler-Bernoulli formula | family-spec.csv (design.md) |
| Bar length (per note, 25 rows) | 16.683 in (C5) down to 8.342 in (C7) | measurement_required — pilot bar V2 gate | primary pitch-setting dimension | family-spec.csv `bar_length_in` |
| Node hole positions (per bar) | 22.4% / 77.6% of bar length | measurement_required | suspension nodes for the first free-free mode; wrong position kills sustain | family-spec.csv `hole_pos_low_in`/`hole_pos_high_in` |
| Rail length | 21.000 in | fixed (= max bar L + 4in margin, rounded) | frame must span the longest (C5) bar | design.md "Frame Layout" / cut-list.csv RAIL-L/R |
| Leg height | 30.000 in | standing-play height (24in swap for sit-down) | ergonomics | design.md "Frame Layout" / cut-list.csv LEG-* |

## Incidental (free for DFM)

- Frame corner gusset shape, finish/oil sheen, bar edge chamfer cosmetic profile, cord color.

## Must-nots (DFM may never violate)

- Do not treat any predicted_f1_hz value in family-spec.csv as tuned — it is a first-order Euler-Bernoulli estimate; end-shaving against a tuner is the actual tuning step (design.md, validation.csv).
- Do not add an arch/undercut to the bar profile — this is explicitly the flat-bar "simpler sibling"; arch tuning is out of scope and reserved for the planned marimba repo (design.md "Marimba-Equivalent Hooks").
- Do not promote resonator lengths (family-spec.csv `resonator_l_in_optional`) to fabrication authority — resonators are deferred to v2 and explicitly not fabrication authority in this packet (design.md).
- Bars are explicitly out of CNC scope (bandsaw → plane → sand → drill node holes via jig → hand end-shave) — do not route/CNC-cut the bars themselves (design.md "Frame Layout").

## Material intent

- Bars: African Padauk (E=12.6 GPa, rho=745 kg/m3), 4/4 quartersawn. Documented swap-ins: Honduras Rosewood, Hard Maple.
- Frame: Hard maple rails/legs, Baltic-birch plywood corner gussets.
- Forbidden: none recorded.

## Stage status

Stage 0 intake complete 2026-07-01. Gate A (Alpha shop compile) NOT yet run — no concessions logged, nothing presented as shippable.
