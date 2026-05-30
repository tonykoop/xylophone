# Agent Record

Round: 2 idiophone recovery
Date: 2026-05-29
Lane: gpt-5.5 `isla-xylophone-6`
Branch: `gpt55/xylophone-r2`
Issue: #6

## Contract

- Network blocked: no `gh`, no `git push`.
- Local branch and local commit only.
- No fabricated CAD geometry, DXF coordinates, measured partials, or tuning frequencies.
- Add SolidWorks and per-bar DXF authority structure with pending/concept authority only.

## qmd Step 0

Commands run from this repo:

- `timeout 20 qmd query "xylophone tuning packet"`
  - Crashed in Bun/node-llama-cpp after GPU fallback and rerank startup.
  - No authoritative result was used from the query path.
- `timeout 20 qmd search "xylophone" -c instrument-builds`
  - Found `qmd://instrument-builds/skills/v4/instrument-maker-v4/references/solidworks-templates/xylophone.md`.
  - Found `qmd://instrument-builds/skills/v4/instrument-maker-v4/references/solidworks-templates/readme.md`.
  - Found `qmd://instrument-builds/docs/openscad-sources/readme.md`.
  - Found an older acoustic-model reference noting xylophone as a free-free beam idiophone.

## Work Completed

- Added `drawings/per-bar-dxf-authority-register.csv` with one pending row per bar.
- Added `v5-tier1-authority-gates.csv` for SolidWorks, extracted dimensions, DXF release, visual register, and measurement gates.
- Added `cad/mcp-session-log.md` as an explicit no-tool/no-output provenance stub.

## Honesty Boundary

This lane does not create CAD, DXF, measured tuning data, per-bar coordinates,
or shop-release geometry. The per-bar register names intended configurations
and future output paths only; all authority stays `pending_measurement`.
