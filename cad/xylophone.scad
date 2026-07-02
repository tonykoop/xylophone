// Xylophone parametric master — 25-bar chromatic C5-C7 bar field on a
// trestle frame envelope.
//
// Authority: pending_measurement. NOT fabrication authority until reviewed
// against a measured/tuned prototype (see visual-output-register.csv and
// cad/mcp-session-log.md). cad/README.md keeps the SolidWorks master
// deferred until pilot-bar V2 measurements exist; this OpenSCAD file is a
// planning envelope only, not a replacement for that gate.
//
// SCOPE BOUNDARY: this models the bar LENGTH schedule (flat rectangular
// bars, per-bar length/width/thickness and node-hole positions, all taken
// directly from family-spec.csv) plus a trestle-frame envelope. It does NOT
// model bar arch/tuning geometry (this xylophone is explicitly flat-bottom,
// end-shaved for tuning by hand — "no arch undercut, that's marimba" per
// design.md) and does NOT model resonator tubes (design.md: "computed but
// optional... not fabrication authority in this packet").
//
// Dimension sources (do not edit values without updating the source record):
//   - bar_schedule: family-spec.csv (25 rows) — bar_length_in, bar_width_in,
//     bar_thickness_in, hole_pos_low_in, hole_pos_high_in per note. Formula
//     cited there: free-free Euler-Bernoulli f1 = 1.028*(h/L^2)*sqrt(E/rho),
//     Padauk E=12.6 GPa, rho=745 kg/m3.
//   - frame rail/leg dimensions: cut-list.csv RAIL-L/R, LEG-FL/FR/RL/RR
//     (finished dims column)
//   - bar spacing / fan layout: design.md "Frame Layout" (single bar fan,
//     rail length = max(family-spec L) + 4in margin, rounded to 21in)
//
// Units: inches.

/* [Frame] */
rail_length_in      = 21.000; // cut-list.csv RAIL-L/R finished length
rail_width_in       = 2.250;  // cut-list.csv RAIL-L/R finished width (top face)
rail_thickness_in   = 1.250;  // cut-list.csv RAIL-L/R finished thickness
leg_height_in       = 30.000; // cut-list.csv LEG-* finished length (standing-play height)
leg_side_in         = 1.500;  // cut-list.csv LEG-* finished cross-section (square)
rail_spacing_in     = 16.0;   // ASSUMPTION: distance between rail centerlines along bar length;
                               // not explicitly given in design.md/cut-list.csv beyond node-hole
                               // positions (22.4%/77.6% of bar L) — legs sit inboard of the rail ends.

/* [Bar field layout] */
bar_gap_in          = 0.125;  // ASSUMPTION: visual/clearance gap between adjacent bars in the fan;
                               // not specified in design.md (bars are individually end-shaved and
                               // cord-suspended, not edge-to-edge fixed) — planning spacing only.

/* [Render quality] */
$fn = 48;

// ---------------------------------------------------------------------------
// Bar schedule — family-spec.csv, C5 (first/longest) through C7 (last/shortest)
// [note, target_hz, length_in, width_in, thickness_in, hole_low_in, hole_high_in]
// ---------------------------------------------------------------------------

bar_schedule = [
    ["C5",   523.25, 16.683, 1.500, 0.875,  3.737, 12.946],
    ["C#5",  554.37, 16.208, 1.500, 0.875,  3.631, 12.578],
    ["D5",   587.33, 15.747, 1.500, 0.875,  3.527, 12.220],
    ["D#5",  622.25, 15.299, 1.500, 0.875,  3.427, 11.872],
    ["E5",   659.26, 14.863, 1.500, 0.875,  3.329, 11.534],
    ["F5",   698.46, 14.440, 1.500, 0.875,  3.235, 11.205],
    ["F#5",  739.99, 14.029, 1.500, 0.875,  3.142, 10.886],
    ["G5",   783.99, 13.630, 1.500, 0.875,  3.053, 10.577],
    ["G#5",  830.61, 13.242, 1.500, 0.875,  2.966, 10.275],
    ["A5",   880.00, 12.865, 1.500, 0.875,  2.882,  9.983],
    ["A#5",  932.33, 12.498, 1.500, 0.875,  2.800,  9.699],
    ["B5",   987.77, 12.143, 1.500, 0.875,  2.720,  9.423],
    ["C6",  1046.50, 11.797, 1.500, 0.875,  2.643,  9.154],
    ["C#6", 1108.73, 11.461, 1.500, 0.875,  2.567,  8.894],
    ["D6",  1174.66, 11.135, 1.500, 0.875,  2.494,  8.641],
    ["D#6", 1244.51, 10.818, 1.500, 0.875,  2.423,  8.395],
    ["E6",  1318.51, 10.510, 1.500, 0.875,  2.354,  8.156],
    ["F6",  1396.91, 10.211, 1.500, 0.875,  2.287,  7.923],
    ["F#6", 1479.98,  9.920, 1.500, 0.875,  2.222,  7.698],
    ["G6",  1567.98,  9.638, 1.500, 0.875,  2.159,  7.479],
    ["G#6", 1661.22,  9.363, 1.500, 0.875,  2.097,  7.266],
    ["A6",  1760.00,  9.097, 1.500, 0.875,  2.038,  7.059],
    ["A#6", 1864.66,  8.838, 1.500, 0.875,  1.980,  6.858],
    ["B6",  1975.53,  8.586, 1.500, 0.875,  1.923,  6.663],
    ["C7",  2093.00,  8.342, 1.500, 0.875,  1.869,  6.473],
];

// ---------------------------------------------------------------------------
// Frame — 4-leg trestle, two suspension rails
// ---------------------------------------------------------------------------

module rail(x_offset_in) {
    translate([0, x_offset_in, leg_height_in])
        cube([rail_length_in, rail_thickness_in, rail_width_in]);
}

module leg(x_in, y_in) {
    translate([x_in, y_in, 0])
        cube([leg_side_in, leg_side_in, leg_height_in]);
}

module frame() {
    // Two rails running the length of the bar fan (X axis), spaced along Y.
    rail(0);
    rail(rail_spacing_in);
    // Four legs near the rail ends.
    leg(leg_side_in / 2, -leg_side_in / 2);
    leg(rail_length_in - leg_side_in * 1.5, -leg_side_in / 2);
    leg(leg_side_in / 2, rail_spacing_in + rail_thickness_in - leg_side_in / 2);
    leg(rail_length_in - leg_side_in * 1.5, rail_spacing_in + rail_thickness_in - leg_side_in / 2);
}

// ---------------------------------------------------------------------------
// Bar field — flat rectangular bars, node-hole markers, laid out in fan order
// ---------------------------------------------------------------------------

bar_top_z_in = leg_height_in + rail_width_in; // bars rest on top of the rails

module bar(length_in, width_in, thickness_in, hole_low_in, hole_high_in) {
    difference() {
        cube([length_in, width_in, thickness_in]);
        // Node holes for 1/8" paracord suspension, at the free-free first-mode
        // node fractions (~22.4% / 77.6% of length), positions from family-spec.csv.
        translate([hole_low_in, width_in / 2, -0.1])
            cylinder(h = thickness_in + 0.2, d = 0.125);
        translate([hole_high_in, width_in / 2, -0.1])
            cylinder(h = thickness_in + 0.2, d = 0.125);
    }
}

module bar_field() {
    y_cursor = 0;
    for (i = [0:len(bar_schedule) - 1]) {
        b = bar_schedule[i];
        length_in = b[2];
        width_in = b[3];
        thickness_in = b[4];
        hole_low_in = b[5];
        hole_high_in = b[6];
        // Center each bar's length over the rail span; step across Y by bar width + gap.
        y_pos = i * (width_in + bar_gap_in);
        x_pos = (rail_length_in - length_in) / 2;
        translate([x_pos, y_pos, bar_top_z_in])
            bar(length_in, width_in, thickness_in, hole_low_in, hole_high_in);
    }
}

// ---------------------------------------------------------------------------
// Top-level assembly
// ---------------------------------------------------------------------------

module xylophone_master() {
    frame();
    bar_field();
}

xylophone_master();
