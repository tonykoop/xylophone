# Xylophone SolidWorks Master Authority Plan

Current status: `authority_plan_only`.

No SolidWorks master part, assembly, drawing package, DXF export, or extracted
dimension CSV exists in this repo yet. This document defines the gate for that
future work; it is not CAD authority by itself.

## Authority Chain

The current dimensional authority remains:

1. `xylophone-design-table.xlsx`
2. `family-spec.csv`

Those files are first-order planning authority only. They are not bench
validated and do not make the packet build-ready. The SolidWorks master may be
promoted only after it is proven to reproduce those table values and the pilot
bar measurement loop has closed enough to justify per-bar drawing release.

## Required Master Files

When built, the CAD set should follow the existing idiophone convention:

| Planned file | Required status before release |
| --- | --- |
| `cad/XYL-001_MasterLayout.SLDPRT` | Design-table driven master part with one bar configuration per `family-spec.csv` note. |
| `cad/XYL-001_Xylophone.SLDASM` | Assembly referencing the master layout plus non-authoritative frame context. |
| `cad/Extract_Xylophone_Dimensions_AllConfigs.bas` | Macro that exports every configuration to a CSV dimension report. |
| `cad/XYL-001_dimensions.csv` | Extracted dimensions compared back to `family-spec.csv` before any DXF release. |

Do not add these files as fabrication authority until the review rows below are
complete and `visual-output-register.csv` has been updated with the released
CAD/DXF artifacts.

## Master Parameters

Each bar configuration must expose these values as global variables or
design-table columns:

| Parameter | Source | Review rule |
| --- | --- | --- |
| `note` | `family-spec.csv` | Configuration name and title block must match. |
| `target_hz` | `family-spec.csv` | Reference only; not a dimension. |
| `bar_length_in` | `family-spec.csv` | Must match extracted CAD dimension within 0.001 in before release. |
| `bar_width_in` | `family-spec.csv` | Must match extracted CAD dimension within 0.001 in before release. |
| `bar_thickness_in` | `family-spec.csv` | Must match extracted CAD dimension within 0.001 in before release. |
| `hole_pos_low_in` | `family-spec.csv` | Must match extracted CAD dimension within 0.001 in before release. |
| `hole_pos_high_in` | `family-spec.csv` | Must match extracted CAD dimension within 0.001 in before release. |
| `node_hole_dia_in` | `drawing-brief.md` | `0.125 in`; confirm against the selected suspension cord before release. |
| `edge_roundover_in` | `drawing-brief.md` | `0.0625 in`; review after pilot-bar machining. |

## Release Gates

- Cut and measure the A5 pilot bar through `validation.csv` rows V2 and V3.
- Decide whether the first measured correction changes the family table before
  per-bar DXF export.
- Build the SolidWorks master from the table, then export all configuration
  dimensions to CSV.
- Compare extracted CAD dimensions against `family-spec.csv`; resolve every
  mismatch before release.
- Generate per-bar DXF drawings only after the comparison passes.
- Complete `drawings/per-bar-dxf-checklist.csv` for all 25 bars.
- Update `visual-output-register.csv` with any released CAD/DXF artifacts and
  keep previews marked `derived_preview`.

## Explicit Non-Claims

- This plan does not create measured bar evidence.
- This plan does not release per-bar DXF files.
- This plan does not authorize CNC, laser, bandsaw, drill, or router toolpaths.
- This plan does not promote the packet past `L1_packet -> measurement_required`.
- Preview images and SVGs remain non-authoritative unless their source CAD,
  DXF, or design-table record is named in the visual authority register.
