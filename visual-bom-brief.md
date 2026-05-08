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
