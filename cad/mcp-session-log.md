# CAD MCP Session Log

Status: stub for V5 provenance.

No MCP, SolidWorks, Illustrator, Blender, OpenSCAD, or measurement tooling was
available in this Round 2 lane. No CAD geometry, DXF coordinates, measured
tuning frequencies, renders, or fabrication drawings were created.

| session_id | tool | input_authority | outputs | role | authority_result | review_status | notes |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 2026-05-29-gpt55-xylophone-r2 | none | existing packet docs only | `drawings/per-bar-dxf-authority-register.csv`; `v5-tier1-authority-gates.csv` | authority_scaffold | pending_measurement | unreviewed | Text-only scaffold. Future CAD/DXF work must create a new session row with the actual tool and generated outputs. |
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) + OpenSCAD CLI | family-spec.csv, cut-list.csv (RAIL-L/R, LEG-*), design.md "Frame Layout" | cad/xylophone.scad | cad_authoring | pending_measurement | self_checked | Parametric bar-length-schedule + trestle-frame envelope for all 25 bars. Bar arch/tuning geometry and resonator tubes out of scope. OpenSCAD render check: pass (openscad -o STL, exit 0). |
| fable-v5-refresh-2026-07-01 | claude-code (Fable 5) | xylophone-design-table.xlsx, family-spec.csv, xylophone-starter.wl | visual-output-register.csv | packet_refresh | fabrication | self_checked | V5 refresh pass: provenance rows added for xylophone-design-table.xlsx and family-spec.csv (satisfies V5 fabrication-artifact logging); register row added for the pre-existing xylophone-starter.wl (was unregistered). No dimension changes made to existing tabular packet data. |

## Next Provenance Requirement

Before any SolidWorks or DXF artifact is cited as V5 authority, add a new row
with the real tool session, source inputs, generated files, review status, and
whether the output is fabrication authority, derived preview, concept only, or
still pending measurement.
