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

## Round 31 Authority Note

`drawings/template.svg` is a derived preview, not a shop-release drawing.
Before cutting bars from drawings, generate the per-bar SVGs from
`xylophone-design-table.xlsx` / `family-spec.csv`, review the node-hole
positions against the selected pilot-bar measurements, and update
`visual-output-register.csv` so the drawing authority chain remains explicit.

## Round 33C/D DXF Authority Note

`drawings/per-bar-dxf-checklist.csv` is the release checklist for future
per-bar DXF exports. A DXF file is not shop authority until its row is marked
reviewed after:

- the A5 pilot-bar V2/V3 measurement loop is recorded;
- the SolidWorks master or equivalent CAD generator has exported dimensions
  back to CSV;
- the exported dimensions match `family-spec.csv` or a reviewed replacement
  design table;
- the DXF uses inch units and the required `FAB_GEOMETRY`, `DATUM`,
  `DIMENSION`, and `NOTES` layers;
- `visual-output-register.csv` records the released DXF/CAD artifact.

Until those checks close, `drawings/template.svg`, any generated per-bar SVG,
and any future DXF remain previews derived from first-order design-table data,
not measured bar readiness.
