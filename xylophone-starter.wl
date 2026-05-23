(* ::Package:: *)

(* Xylophone — xylophone-starter.wl                                         *)
(* Free-free Euler-Bernoulli flat-bar idiophone. First-mode prediction,     *)
(* node positions, optional quarter-wave closed-pipe resonator, validation  *)
(* plot scaffolding, audio preview.                                         *)
(*                                                                          *)
(* Read references/wolfram-workflow.md before extending this file.          *)

(* ::Section:: *)
(* Parameters *)

(* Wood species shortlist — Padauk is the spec primary. Override by editing. *)
woodPadauk = <| "name" -> "African Padauk", "EGPa" -> 12.6, "rhoKg" -> 745. |>;
woodHondurasRosewood = <| "name" -> "Honduras Rosewood", "EGPa" -> 14.1, "rhoKg" -> 1000. |>;
woodHardMaple = <| "name" -> "Hard Maple", "EGPa" -> 12.6, "rhoKg" -> 705. |>;

(* Active wood — the only switch that matters at the top of the file. *)
woodActive = woodPadauk;

(* Bar geometry constants (held constant within a family in v1). *)
barWidthIn = 1.5;
barThickIn = 0.875;
inToM = 0.0254;

(* Resonator geometry. *)
resonatorBoreIn = 1.5;
soundSpeedAir = 343.0;            (* m/s at ~20 C *)
endCorrectionFactor = 0.82;        (* per acoustic-models.md, quarter-wave closed pipe *)

(* ::Section:: *)
(* Governing model *)

(* Free-free Euler-Bernoulli first mode:
       f1 = 1.028 * (h / L^2) * Sqrt[E/rho]
   Reference: acoustic-models.md, Free-Free Beams section.
   First-order only — K2 and end-corrections do not apply to bar idiophones. *)

soundSpeedSolid[E_, rho_] := Sqrt[(E*10.^9) / rho];

f1FromGeometry[L_, h_, E_, rho_] :=
  1.028 * (h / L^2) * soundSpeedSolid[E, rho];

lengthFromTarget[fTarget_, h_, E_, rho_] :=
  Sqrt[1.028 * h * soundSpeedSolid[E, rho] / fTarget];

resonatorLength[fTarget_, boreIn_] := Module[{boreM, lM},
  boreM = boreIn * inToM;
  lM = soundSpeedAir / (4 * fTarget) - endCorrectionFactor * boreM;
  lM / inToM
];

(* ::Section:: *)
(* Family table generation *)

chromaticC5toC7Notes = {
  {"C5",523.25},{"C#5",554.37},{"D5",587.33},{"D#5",622.25},
  {"E5",659.26},{"F5",698.46},{"F#5",739.99},{"G5",783.99},
  {"G#5",830.61},{"A5",880.00},{"A#5",932.33},{"B5",987.77},
  {"C6",1046.50},{"C#6",1108.73},{"D6",1174.66},{"D#6",1244.51},
  {"E6",1318.51},{"F6",1396.91},{"F#6",1479.98},{"G6",1567.98},
  {"G#6",1661.22},{"A6",1760.00},{"A#6",1864.66},{"B6",1975.53},
  {"C7",2093.00}
};

familyRow[note_String, fHz_?NumericQ] := Module[{Lm, Lin, holeLo, holeHi, Lres},
  Lm  = lengthFromTarget[fHz, barThickIn * inToM, woodActive["EGPa"], woodActive["rhoKg"]];
  Lin = Lm / inToM;
  holeLo = 0.224 * Lin;
  holeHi = 0.776 * Lin;
  Lres   = resonatorLength[fHz, resonatorBoreIn];
  <| "note" -> note, "fHz" -> fHz, "LIn" -> Lin,
     "holeLoIn" -> holeLo, "holeHiIn" -> holeHi,
     "resonatorLIn" -> Lres |>
];

familyTable := familyRow @@@ chromaticC5toC7Notes;

(* ::Section:: *)
(* Manipulate — interactive bar-length explorer *)

(* The Manipulate lets you sweep wood/L/h and see f1 in real time.
   Useful for sanity-checking first-order predictions and for showing
   players the why-bigger-is-lower-pitched relationship.            *)

manipulateBar := Manipulate[
  With[{
    fHz = f1FromGeometry[
      LIn * inToM, hIn * inToM, EChoice, rhoChoice]},
    Column[{
      Style[
        StringForm["f1 = `` Hz", NumberForm[fHz, {6, 2}]],
        Bold, 18],
      Plot[
        f1FromGeometry[L * inToM, hIn * inToM, EChoice, rhoChoice],
        {L, 4, 24}, AxesLabel -> {"L (in)", "f1 (Hz)"},
        PlotRange -> {0, 3000},
        GridLines -> {{LIn}, {fHz}}
      ]
    }]],
  {{LIn, 12.0, "bar length L (in)"}, 4.0, 24.0, 0.05},
  {{hIn, 0.875, "bar thickness h (in)"}, 0.5, 1.5, 0.01},
  {{EChoice, 12.6, "Young's modulus E (GPa)"}, 8.0, 16.0, 0.1},
  {{rhoChoice, 745.0, "density rho (kg/m^3)"}, 600.0, 1100.0, 5.0},
  ControlPlacement -> Top
];

(* ::Section:: *)
(* Audio preview *)

(* Synthesizes a 0.6-second pluck of the predicted fundamental for each
   note in the chromatic table. First-order only — not the actual modal
   spectrum of a real bar, just a confirmation of the predicted f1.   *)

audioForNote[fHz_?NumericQ] :=
  AudioPad[
    Sound[SoundNote[None, 0.0]] /. _ ->
      AudioGenerator["Sin", 0.6, "Frequency" -> fHz, SampleRate -> 44100],
    {0, 0.05}
  ];

playFamily := AudioJoin @@ (audioForNote[#[[2]]] & /@ chromaticC5toC7Notes);

(* ::Section:: *)
(* Validation plot scaffold *)

(* Compare predicted f1 (column 1) to measured Hz (column 2) once the
   shop log fills in. Until measurements exist, the plot just shows
   the predicted line and a residual band. Wire to validation.csv via
   record_measurement.py.                                              *)

predictedVsMeasuredPlot[predicted_List, measured_List] :=
  ListPlot[
    {predicted, measured},
    PlotStyle -> {{Thick, Blue}, {PointSize[0.012], Red}},
    PlotLegends -> {"predicted", "measured"},
    AxesLabel -> {"note index (low → high)", "f1 (Hz)"},
    PlotRange -> All,
    GridLines -> Automatic
  ];

centsErrorPlot[predicted_List, measured_List] :=
  ListPlot[
    1200. * Log[2., measured / predicted],
    Filling -> Axis,
    PlotRange -> {-30, 30},
    AxesLabel -> {"note index", "cents error (measured − predicted)"},
    GridLines -> {None, {-5, 0, 5}}
  ];

(* ::Section:: *)
(* Document entry point *)

(* CreateDocument call lives in the notebook layer, not here. Open this
   .wl in Wolfram Desktop, evaluate manipulateBar, then evaluate
   playFamily to hear the predicted family.                             *)

(* End of file *)
