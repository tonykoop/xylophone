# Xylophone — CNC Setup Sheet

Pre-CAM operator-facing setup notes. Generates four operation groups
on the Maker Nexus ShopBot. **Bar work is explicitly out of scope** —
bars are bandsaw → plane → manual end-shave, never CNC.

## Machine

- **Machine:** Maker Nexus ShopBot 96"×60" CNC router.
- **Spoilboard:** 3/4" MDF, surfaced flat at session start.
- **Vacuum table:** Available for plywood operations only.

## Datum

Lower-left corner of stock for X/Y, top of stock for Z. **Same datum
for all four operation groups** — no re-zeroing between operations.
Use a touch plate for Z; manual probe to a corner pin for X/Y.

## Tooling

| Tool ID | Type                              | RPM    | Used in        |
|---------|-----------------------------------|--------|----------------|
| T01     | 1/4" 2-flute upcut compression    | 16000  | OP1, OP4       |
| T02     | 1/8" 2-flute upcut                | 18000  | OP2            |
| T03     | 1/2" 2-flute upcut                | 14000  | OP3            |

Confirm bit length and stickout against the rail thickness (1.250")
before OP2 — a too-short bit will not clear the dado depth, a
too-long bit will gouge.

## Workholding

- **OP1 rails (hard maple, 22"×2.5"×1.5"):** Two toggle clamps and
  an L-fence on the back-left corner. Two through-holes per rail
  blank for safety screws into the spoilboard at the unused end.
- **OP2 rail-dado:** Same clamps as OP1 — do not break setup.
- **OP3 legs (hard maple, 32"×1.75"×1.75"):** One toggle clamp at
  each end; the legs are short enough that an L-fence is sufficient.
  Set fence parallel to X-axis.
- **OP4 gussets (Baltic birch, 12"×12"×0.5"):** Vacuum table only.
  Plywood is too thin to clamp without distortion. Confirm seal
  before any cut.

## Operation order

1. **OP1-rails** — outline both rails to final 21.0×2.25×1.25". Four
   passes at 0.3" per pass. Feed 90 in/min, RPM 16000.
2. **OP2-rail-dado** — keep T01 setup, swap to T02. Run a 0.125"-wide
   dado 0.250" deep along the inside top edge of each rail, full
   length, for the cord-stop pin to seat into. Feed 60 in/min, RPM
   18000.
3. **OP3-legs** — re-fixture for legs. Two 1.0"×0.5"×0.5" mortises
   per leg, top face, spaced to match the gusset edge. Feed 50
   in/min, RPM 14000.
4. **OP4-gussets** — vacuum table; one operation cuts all four
   gussets from one 12"×12" plywood blank. Each gusset is a
   45° right triangle with 6" legs.

## Per-operation release checks

Before pressing Cycle Start on each operation:

- [ ] Tool ID and offset matches the program.
- [ ] Stock dimensions verified at four corners with calipers.
- [ ] Datum (X0/Y0/Z0) verified by manual jog and feeler.
- [ ] Dry-run at Z+0.5" completed; toolpath visualizes correctly.
- [ ] Hold-down verified: clamps tight, or vacuum sealed.
- [ ] Dust collection on.
- [ ] Spotter present for first cut of each new operation.

After the first part of each batch:

- [ ] Pause the program.
- [ ] Measure critical dimensions (rail length, dado depth, mortise
      width, gusset hypotenuse) with calipers.
- [ ] Within ±0.005"? Resume. Else stop and re-cam.

## Pre-CAM assumptions

These four assumptions are stamped into the plan. If any one is
false on the day, **stop and re-plan** before cutting:

1. Stock thickness arrives within ±1/64" of nominal.
2. Hard maple is straight-grained and free of knots in the cutter
   path.
3. Plywood is B/BB or better with no voids in the cutter path.
4. Vacuum table seals on the 12×12 plywood blank without aux clamps.

## Post-CNC handoff

All four operation groups produce raw-cut parts. Hand-sand to 220
grit and break all edges 1/16" before frame glue-up. The frame
assembly continues at `assembly-manual.md` Step 8.

## Why no G-code yet

This is a pre-CAM plan. Actual G-code generation should run from a
CAM program (VCarve Pro is what Maker Nexus uses) against the
operation graph above plus the dimensioned drawings in `drawings/`.
The plan deliberately stops short of G-code so the operator catches
errors at CAM time, not at the spindle.
