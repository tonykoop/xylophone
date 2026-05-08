# Xylophone — Assembly Manual

14 shop steps, in order. Checkboxes are blank for shop use; tick them
off as you go. Estimated total bench time: **3 working days** with
overnight glue cures.

## Materials and tools required

Read `bom.csv` and `sourcing.csv` end-to-end before starting. The
critical-path items: Padauk bar stock at 6–8% MC, Korg OT-120 tuner,
1/8" brad-point bit, Titebond III, tung oil, and the two jigs from
`jig-decision.md` (node-hole drilling jig, end-shaving sled).

## Step 1 — Verify moisture content

- [ ] Pin-meter the Padauk bar stock at three points along each
  board. Target 6.0–8.0% MC.
- [ ] Log temp + RH in the shop in `validation.csv` row V1.
- [ ] If MC > 8%: stack with stickers in the shop for two weeks and
  remeasure. **Do not proceed until MC is 6–8%.**

## Step 2 — Mill blanks to rough cut-list dimensions

- [ ] Cross-cut each bar blank to its `rough_dimensions_in[0]` length
  (per `cut-list.csv`). Add 1" to the longest blanks for safety.
- [ ] Rip to 1.625" rough width.
- [ ] Joint one face and one edge.
- [ ] Plane to 1.0" rough thickness.

## Step 3 — Final mill bars

- [ ] Plane to **0.875"** final thickness.
- [ ] Rip to **1.500"** final width.
- [ ] Cross-cut to the `final_dimensions_in[0]` length per
  `cut-list.csv`. **Cut long by 1/16"** — final length is set in
  the tuning step.

## Step 4 — Surface prep

- [ ] Drum-sand or hand-sand each bar 80 → 120 → 180 → 220.
- [ ] Ease all four long edges with a 1/16" round-over.
- [ ] Mark each bar's note name on the underside in pencil.

## Step 5 — Drill node holes (jig)

- [ ] Set up the node-hole drilling jig from `jig-decision.md`.
- [ ] For each bar: set both flip-stops to the bar's
  `hole_pos_low_in` and `hole_pos_high_in` from `family-spec.csv`.
- [ ] Drill the low-side hole, flip stops, drill the high-side hole.
- [ ] Chamfer both holes ~0.5mm with a countersink to prevent cord
  chafing.

## Step 6 — First measurement

- [ ] Suspend each bar from a piece of test-cord through both node
  holes.
- [ ] Strike with the hard rubber mallet, measure with the Korg
  OT-120.
- [ ] Log result for each bar in `validation.csv` row V2.
- [ ] **Expected outcome:** bars read 5–25 cents *low* of target.
  This is normal — final length is shaved in the next step.

## Step 7 — Tune by end-shaving

- [ ] On the end-shaving sled: shave equal amounts from each bar end
  in 1/64" increments. Symmetric shaving keeps the node positions
  centered.
- [ ] After each pass, re-suspend, re-strike, re-measure. Stop when
  cents-actual is within ±2 cents of target.
- [ ] Log result in `validation.csv` row V3.
- [ ] If a bar overshoots (reads sharp): **do not add material**.
  Either accept the +cents or scrap the bar.

## Step 8 — Mill frame parts

- [ ] Mill the two suspension rails to `21.000 × 2.250 × 1.250"`.
- [ ] Mill four legs to `30.000 × 1.500 × 1.500"`. Chamfer the top
  edge of each leg to clear the suspension cord.
- [ ] Cut four corner gussets from 1/2" Baltic birch plywood at
  `6.000 × 6.000"`, hypotenuse to hypotenuse (i.e., 45-degree
  triangles).

## Step 9 — Frame dry-fit

- [ ] Dry-assemble the frame: legs into rails via the gussets.
- [ ] Verify rail-to-rail spacing is 6.5" inside-to-inside (matches
  the bar width plus suspension margin).
- [ ] Verify legs are square to rails.

## Step 10 — Frame glue-up

- [ ] Apply Titebond III to all gusset-to-frame joints.
- [ ] Drive #10 × 2" wood screws through pilot holes (Padauk and
  hard maple both want pilots).
- [ ] Clamp 24 hours. Do not flex the frame during cure.

## Step 11 — Apply finish

- [ ] Wipe each bar with mineral spirits to remove sanding dust.
- [ ] Apply pure tung oil with a lint-free rag, three coats. Each
  coat dries 24 hours; sand lightly between coats with 320.
- [ ] Apply finish to the frame the same way (two coats is enough).
- [ ] **24 hours after the last bar coat:** re-measure each bar.
  Log in `validation.csv` row V4. Expected drift: −2 to −4 cents
  from finish mass loading. If drift exceeds −5 cents, end-shave
  again to compensate.

## Step 12 — Top-coat and cure

- [ ] Apply beeswax paste over the cured tung oil; buff out.
- [ ] Allow seven days at shop ambient before play-testing.

## Step 13 — Suspend bars

- [ ] Cut paracord to length: rail length × 2 + 12" tail per rail.
- [ ] Tie a stopper knot at each rail end.
- [ ] Thread cord through node holes in C5–C7 order, alternating
  bar-to-cord-to-bar.
- [ ] Terminate at the second rail with brass finish washers and a
  tied loop.

## Step 14 — Final validation

- [ ] Photograph the finished assembly per `photo-shotlist.md`
  shots 1, 2, 4, 5, 6, 7, 10.
- [ ] Run validation row V8 (full-octave evenness): measure C5, C6,
  C7 in one session. Document spread.
- [ ] Schedule validation rows V6 (30-day) and V7 (60-day) on the
  shop calendar.
- [ ] Mark this packet as `built` in the master catalog.
