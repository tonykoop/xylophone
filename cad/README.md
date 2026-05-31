# Xylophone — CAD

SolidWorks master-layout part lives here once built. The convention
mirrors the **tongue-drum** sister repo (`tongue-drum/cad/`): a single
`*_MasterLayout.SLDPRT` part with all design-table parameters, an
assembly that references the master, and a dimensions-extract macro
that emits a CSV for round-trip validation against the Excel design
table.

## Status: not yet built

The parametric design table is **already** authored in
`xylophone-design-table.xlsx` at the repo root, and the math is
operationalized in `family-spec.csv` and `wolfram-starter.wl`.
Building the SolidWorks model is the next CAD-side step; the
gating row in `validation.csv` is V2 (post-cut measurement) — once
real measured data exists, the model can be built with confidence
that the parametric inputs are calibrated.

Round 33C/D adds `solidworks-master-authority-plan.md` as the CAD release
contract. It names the intended SolidWorks files, extracted-dimension CSV, and
review gates, but it does not add a SolidWorks master or promote any DXF/CAD
artifact to fabrication authority.

## Naming convention (when built)

- `XYL-001_MasterLayout.SLDPRT` — single master part, design table
  inside, all family-table inputs as global variables.
- `XYL-001_Xylophone.SLDASM` — assembly referencing the master, one
  configuration per family member.
- `Extract_Xylophone_Dimensions_AllConfigs.bas` — macro per the
  tongue-drum precedent. Output: `*_dimensions.csv` for ingest by
  `scripts/ingest_dimension_csv.py`.

## Reference

- `tongue-drum/cad/Extract_Dimensions.swp` — binary macro to copy
  and adapt.
- `tongue-drum/cad/TNG-000_MasterLayout.xlsx` — design-table
  layout exemplar.
- `references/solidworks-integration.md` — the three pillars of
  Tony's SW workflow (global equations, design tables, master sketch).
- `xylophone-design-table.xlsx` — the existing input source. Don't
  duplicate; reference.
- `solidworks-master-authority-plan.md` — local gate for future master-layout,
  extracted-dimension, and per-bar DXF release.
- `../drawings/per-bar-dxf-checklist.csv` — per-bar review checklist to complete
  before any generated DXF is treated as shop authority.
