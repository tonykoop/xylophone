# Xylophone — Risks Register

Five categories, at least one entry each, every entry with an
attached verification *test* per the v4 red-team specialist contract.

## Acoustic

### bar-cracking-from-hard-mallets
**Risk.** Hard rubber and lexan mallets, especially struck near the
bar end rather than at the strike line, can crack a flat-bar Padauk
bar within months. Hard mallets are appropriate for xylophone — but
the failure mode is real and accelerates with low ambient humidity.

**Test.** Strike test: with the C5 bar (longest, most stress) clamped
in the suspension cord, strike 100 times near the strike line and
50 times deliberately near the end with a hard rubber mallet. Inspect
for hairline cracks under raking light. Repeat after 30 days at
shop ambient. Pass = no visible cracks; fail = any crack.

### first-mode-vs-second-mode-misalignment
**Risk.** First-order math predicts only `f_1`. The 12th-overtone
xylophone tuning convention asks for the second flexural mode to
sit at a 3:1 ratio, which a flat bar does **not** naturally do —
the unpinched second-mode ratio of a free-free Euler-Bernoulli
beam is closer to 2.756. Means players will hear the second mode
"out of tune" with the fundamental.

**Test.** Spectrum-analyzer measurement (free phone app like
SpectroidPro): pluck/strike the bar, capture the spectrum, identify
the fundamental and the strongest second peak, compute the ratio.
Pass = ratio between 2.7 and 3.0 (unundercut bars cluster around
2.756); fail = ratio outside that band. Document. The marimba sister
repo will fix this with arch undercut; the xylophone v1 packet
*accepts* the natural ratio and notes it on the validation sheet.

## Structural

### moisture-retune-drift
**Risk.** Padauk at 6–8% MC at glue-up will move when the shop ambient
changes. A 4% MC swing across a humid summer to a dry winter can shift
fundamentals by 5–15 cents. Not a structural failure, but a tuning
failure that compounds across all 25 bars.

**Test.** Record temp/RH at every measurement row in `validation.csv`
(rows V2 through V8). Re-measure every bar at 30 and 60 days
(rows V6, V7). Pass = drift within ±5 cents on all bars at both
checkpoints; fail = drift exceeds ±5 cents — flag the bar in
`record_measurement.py`, update the per-family corrections database.

### cord-hole-tear-out
**Risk.** 1/8" node holes drilled near the bar's high-stress mode
zone. Repeated player force on the cord at the hole can tear out the
hole, especially if grain runs across it.

**Test.** Pull-test on the longest bar (C5): tie the suspension cord
through both holes, suspend the bar, hang a 5-lb weight from the
center of the bar, hold for 60 seconds. Inspect holes for cracking
or elongation. Pass = no visible damage; fail = elongation, splitting,
or cord chafing. If fail, drill a slightly larger hole and chamfer
both ends.

## Ergonomic

### frame-tipping-on-uneven-floor
**Risk.** 4-leg trestle frame with a 21" rail and 30" leg height can
tip if a player strikes near the rail end with a heavy two-handed
attack on an uneven floor.

**Test.** Place frame on a 5° tilted board. Have a player strike
the C5 bar (rail end) with full two-handed force using yarn-wrapped
medium mallets. Frame should not tip. Pass = stable; fail = tips.
Mitigation if fail: add 6" leg-foot crossbraces or weight the bottom
of each leg.

## Supply

### honduras-rosewood-cites-lead-time
**Risk.** If a player overrides the Padauk default and chooses
Honduras Rosewood, the species is **CITES Appendix II** as of
2017. Sourcing with proper documentation is slow (60–120 days)
and expensive (~3× Padauk).

**Test.** If HR is selected, validate before order: supplier provides
CITES export permit number; cross-check against the CITES species
database. Pass = permit number valid and product description matches;
fail = no permit or mismatch — reject the order, fall back to Padauk.

## Fit/Finish

### tung-oil-finish-darkening-padauk
**Risk.** Padauk is naturally bright orange-red but oxidizes to a
deeper brown over months. Tung oil accelerates the oxidation. After
6–12 months bars look noticeably darker than at first build —
visual mismatch if a single bar is replaced later.

**Test.** Cut a 2"×2" Padauk swatch at the same time as the bars.
Apply same finish schedule. Store with the bars. After 30, 60, 180
days, photograph swatch under controlled light. Pass = expected
gradual darkening, no spotting or blooming; fail = uneven oxidation
patches — switch to a UV-blocking topcoat.
