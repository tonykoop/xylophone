# Xylophone — Supplier RFQ

Template — paste into supplier email or web form. The bar-stock RFQ
is the only critical-path RFQ; everything else is COTS from
`sourcing.csv` and does not need a custom quote.

---

**Subject:** Padauk bar-stock quote — 25-bar xylophone build

Hello,

I'm building a 25-bar chromatic xylophone (C5–C7) and I'd like a
quote on Padauk lumber for the bar set. Specs:

- **Species:** African Padauk (*Pterocarpus soyauxii*) — *not*
  Burma Padauk.
- **Form:** 4/4 lumber (15/16" rough, surfaced 4 sides to roughly
  3/4"–7/8" final), or fall-back to S2S if S4S is unavailable.
- **Grain:** **Quartersawn** strongly preferred (radial grain on the
  bar face). Riftsawn acceptable on 25–35% of the order. Flatsawn
  rejected — bars will warp.
- **Moisture content:** **Kiln-dried to 6–8% MC.** Please measure with
  a pin meter at multiple points and confirm in writing.
- **Defect tolerance:** No knots, no shake, no end-checks longer than
  1/2", no insect damage, no sap pockets. Color variation acceptable.
- **Total board feet:** Approximately **15 BF** to yield 25 bars
  (longest 17", shortest 9", at 1.5"×7/8") plus 20% waste.
- **Lengths preferred:** Boards in the 36–48" range. Anything shorter
  than 24" is hard to use.

Please quote:

1. Per-board-foot price for the spec above.
2. Total for 15 BF, FOB your shipping point.
3. Lead time from order to ship.
4. Photographs of two or three representative boards before payment
   so I can confirm grain orientation and color.

If S4S quartersawn is not available at this volume, please quote for
S2S quartersawn at 5/4 thickness instead and I'll mill to 7/8" myself.

Thanks,
Tony Koop
tonykoop@gmail.com

---

## RFQ tracking

| Field             | Value                                         |
|-------------------|-----------------------------------------------|
| RFQ ID            | XYL-RFQ-001                                   |
| Spec sheet        | `bom.csv` row `BAR-STOCK`                     |
| Sourcing options  | `sourcing.csv` rows for `BAR-STOCK`           |
| Sent date         | TBD                                           |
| Quote received    | TBD                                           |
| Decision          | TBD                                           |
| Order placed      | TBD                                           |
| Received in shop  | TBD                                           |
| MC at receipt     | TBD (target 6–8%; measure on arrival)         |

## Decision criteria

Pick the supplier whose quote yields **best (price × delivery × grade
match)**. Bell Forest Products is the default expectation; West Penn
and Cook are the named backups in `sourcing.csv`.

## What to do if no supplier can deliver to spec

Fall-back order: switch the spec's primary species in
`xylophone-design-table.xlsx` from Padauk to Hard Maple (Tier 3 in
`design.md`). Re-run the family table — predicted lengths shift
slightly because Maple's √(E/ρ) is 4229 m/s vs Padauk's 4112. Bars
end up about 1.4% longer. Update `family-spec.csv` and `cut-list.csv`
accordingly.
