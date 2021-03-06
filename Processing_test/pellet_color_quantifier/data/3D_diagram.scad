// ====================================================
// pellet color recognition - 3D visualization
// ====================================================


// ====================================================
// coordinate system
// ====================================================

translate([-128, -128, -128]) {
	// X = R
	rotate([0, 90, 0])
		arrow(1, 0, 0);
	
	// Y = G
	rotate([-90, 0, 0])
		arrow(0, 1, 0);
	
	// Z = B
		arrow(0, 0, 1);
	
	
	// cube lines 255x255x255
	// 3 vertiacal lines
	translate([255, 0, 0])
		line();
	translate([255, 255, 0])
		line();
	translate([0, 255, 0])
		line();
	
	// 2 bottom lines
	translate([0, 255, 0])
		rotate([0, 90, 0])
			line();
	translate([255, 0, 0])
		rotate([-90, 0, 0])
			line();
	
	// 4 top lines
	translate([0, 0, 255])
		rotate([0, 90, 0])
			line();
	translate([0, 255, 255])
		rotate([0, 90, 0])
			line();
	translate([0, 0, 255])
		rotate([-90, 0, 0])
			line();
	translate([255, 0, 255])
		rotate([-90, 0, 0])
			line();
}

// ====================================================
// sub-modules
// ====================================================

module arrow(R, G, B) {
	dim = .66;
	len = 280;
	head = 20;

	translate([0, 0, len / 2])
		color([R * dim, G * dim, B * dim])
			cylinder(r = 1, h = len, center=true);

	translate([0, 0, len + head / 2])
		color([R * dim, G * dim, B * dim])
			cylinder(r1 = 5, r2 = 0, h = head, center=true);
}


module line() {
	len = 255;

	translate([0, 0, len / 2])
		color([.5,, .5, .5])
			cylinder(r = .33, h = len, center=true);
}


// markers will be moved to -128...
module marker(x, y, z) {
	len = 32;
	sphere_r = 35;

	translate([x - 128, y - 128, z - 128]) {
		color([0,0,0, .33]) {
			cylinder(r = .33, h = len, center=true);
			rotate([-90, 0, 0]) cylinder(r = .33, h = len, center=true);
			rotate([0, 90, 0])  cylinder(r = .33, h = len, center=true);
		}
		color([1, 1, 1, .2])
			sphere(r=sphere_r, center=true);
	}
}


// dots will be moved to -128...
module dot(x, y, z, c) {
	len = 3.33;

	translate([x - 128, y - 128, z - 128])
		color(c)
			sphere(r = len/2, $fn = 12, center=true);
}


// ====================================================
// automated content from Processing script follows ...
// ====================================================

dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 0 (Black)
dot(+246, +246, +202, [+0.965, +0.965, +0.851]); // 1 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 2 (Black)
dot(+246, +240, +002, [+0.737, +0.686, +0.063]); // 3 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 4 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 5 (Black)
dot(+001, +094, +001, [+0.020, +0.427, +0.012]); // 6 (Green)
dot(+001, +000, +000, [+0.000, +0.000, +0.000]); // 7 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 8 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 9 (Black)
dot(+004, +016, +068, [+0.063, +0.110, +0.298]); // 10 (Blue)
dot(+004, +012, +061, [+0.063, +0.110, +0.298]); // 11 (Blue)
dot(+246, +245, +211, [+0.965, +0.965, +0.851]); // 12 (White)
dot(+246, +241, +001, [+0.737, +0.686, +0.063]); // 13 (Yellow)
dot(+001, +100, +000, [+0.020, +0.427, +0.012]); // 14 (Green)
dot(+001, +110, +001, [+0.020, +0.427, +0.012]); // 15 (Green)
dot(+246, +238, +002, [+0.737, +0.686, +0.063]); // 16 (Yellow)
dot(+246, +233, +001, [+0.737, +0.686, +0.063]); // 17 (Yellow)
dot(+246, +238, +002, [+0.737, +0.686, +0.063]); // 18 (Yellow)
dot(+246, +244, +005, [+0.737, +0.686, +0.063]); // 19 (Yellow)
dot(+246, +246, +211, [+0.965, +0.965, +0.851]); // 20 (White)
dot(+246, +246, +228, [+0.965, +0.965, +0.851]); // 21 (White)
dot(+246, +246, +212, [+0.965, +0.965, +0.851]); // 22 (White)
dot(+246, +241, +001, [+0.737, +0.686, +0.063]); // 23 (Yellow)
dot(+246, +228, +001, [+0.737, +0.686, +0.063]); // 24 (Yellow)
dot(+246, +237, +001, [+0.737, +0.686, +0.063]); // 25 (Yellow)
dot(+001, +101, +000, [+0.020, +0.427, +0.012]); // 26 (Green)
dot(+001, +101, +000, [+0.020, +0.427, +0.012]); // 27 (Green)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 28 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 29 (Red)
dot(+244, +000, +001, [+0.886, +0.024, +0.008]); // 30 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 31 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 32 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 33 (Red)
dot(+001, +102, +000, [+0.020, +0.427, +0.012]); // 34 (Green)
dot(+000, +000, +001, [+0.000, +0.000, +0.000]); // 35 (Black)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 36 (Red)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 37 (Black)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 38 (Red)
dot(+246, +241, +001, [+0.737, +0.686, +0.063]); // 39 (Yellow)
dot(+246, +246, +214, [+0.965, +0.965, +0.851]); // 40 (White)
dot(+246, +242, +001, [+0.737, +0.686, +0.063]); // 41 (Yellow)
dot(+246, +240, +001, [+0.737, +0.686, +0.063]); // 42 (Yellow)
dot(+243, +000, +000, [+0.886, +0.024, +0.008]); // 43 (Red)
dot(+246, +246, +209, [+0.965, +0.965, +0.851]); // 44 (White)
dot(+246, +246, +213, [+0.965, +0.965, +0.851]); // 45 (White)
dot(+246, +246, +211, [+0.965, +0.965, +0.851]); // 46 (White)
dot(+246, +246, +211, [+0.965, +0.965, +0.851]); // 47 (White)
dot(+246, +246, +207, [+0.965, +0.965, +0.851]); // 48 (White)
dot(+246, +235, +000, [+0.737, +0.686, +0.063]); // 49 (Yellow)
dot(+246, +246, +207, [+0.965, +0.965, +0.851]); // 50 (White)
dot(+001, +112, +001, [+0.020, +0.427, +0.012]); // 51 (Green)
dot(+001, +107, +000, [+0.020, +0.427, +0.012]); // 52 (Green)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 53 (Black)
dot(+001, +106, +000, [+0.020, +0.427, +0.012]); // 54 (Green)
dot(+246, +240, +001, [+0.737, +0.686, +0.063]); // 55 (Yellow)
dot(+003, +017, +064, [+0.063, +0.110, +0.298]); // 56 (Blue)
dot(+246, +222, +001, [+0.737, +0.686, +0.063]); // 57 (Yellow)
dot(+001, +102, +000, [+0.020, +0.427, +0.012]); // 58 (Green)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 59 (Black)
dot(+002, +012, +061, [+0.063, +0.110, +0.298]); // 60 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 61 (Black)
dot(+004, +018, +071, [+0.063, +0.110, +0.298]); // 62 (Blue)
dot(+003, +017, +071, [+0.063, +0.110, +0.298]); // 63 (Blue)
dot(+001, +000, +000, [+0.000, +0.000, +0.000]); // 64 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 65 (Black)
dot(+246, +246, +209, [+0.965, +0.965, +0.851]); // 66 (White)
dot(+246, +246, +206, [+0.965, +0.965, +0.851]); // 67 (White)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 68 (Red)
dot(+246, +235, +001, [+0.737, +0.686, +0.063]); // 69 (Yellow)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 70 (Red)
dot(+001, +106, +000, [+0.020, +0.427, +0.012]); // 71 (Green)
dot(+002, +012, +066, [+0.063, +0.110, +0.298]); // 72 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 73 (Black)
dot(+246, +240, +000, [+0.737, +0.686, +0.063]); // 74 (Yellow)
dot(+000, +100, +000, [+0.020, +0.427, +0.012]); // 75 (Green)
dot(+001, +094, +000, [+0.020, +0.427, +0.012]); // 76 (Green)
dot(+001, +100, +000, [+0.020, +0.427, +0.012]); // 77 (Green)
dot(+000, +095, +000, [+0.020, +0.427, +0.012]); // 78 (Green)
dot(+001, +098, +000, [+0.020, +0.427, +0.012]); // 79 (Green)
dot(+246, +245, +193, [+0.965, +0.965, +0.851]); // 80 (White)
dot(+246, +236, +000, [+0.737, +0.686, +0.063]); // 81 (Yellow)
dot(+245, +217, +000, [+0.737, +0.686, +0.063]); // 82 (Yellow)
dot(+001, +095, +001, [+0.020, +0.427, +0.012]); // 83 (Green)
dot(+246, +220, +000, [+0.737, +0.686, +0.063]); // 84 (Yellow)
dot(+001, +096, +000, [+0.020, +0.427, +0.012]); // 85 (Green)
dot(+001, +099, +000, [+0.020, +0.427, +0.012]); // 86 (Green)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 87 (Red)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 88 (Black)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 89 (Red)
dot(+245, +209, +000, [+0.737, +0.686, +0.063]); // 90 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 91 (Black)
dot(+246, +245, +203, [+0.965, +0.965, +0.851]); // 92 (White)
dot(+246, +224, +000, [+0.737, +0.686, +0.063]); // 93 (Yellow)
dot(+001, +096, +001, [+0.020, +0.427, +0.012]); // 94 (Green)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 95 (Black)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 96 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 97 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 98 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 99 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 100 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 101 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 102 (Red)
dot(+246, +233, +000, [+0.737, +0.686, +0.063]); // 103 (Yellow)
dot(+246, +230, +000, [+0.737, +0.686, +0.063]); // 104 (Yellow)
dot(+246, +246, +209, [+0.965, +0.965, +0.851]); // 105 (White)
dot(+246, +246, +198, [+0.965, +0.965, +0.851]); // 106 (White)
dot(+246, +245, +198, [+0.965, +0.965, +0.851]); // 107 (White)
dot(+246, +246, +203, [+0.965, +0.965, +0.851]); // 108 (White)
dot(+246, +246, +204, [+0.965, +0.965, +0.851]); // 109 (White)
dot(+246, +245, +205, [+0.965, +0.965, +0.851]); // 110 (White)
dot(+246, +245, +196, [+0.965, +0.965, +0.851]); // 111 (White)
dot(+002, +009, +058, [+0.063, +0.110, +0.298]); // 112 (Blue)
dot(+001, +014, +063, [+0.063, +0.110, +0.298]); // 113 (Blue)
dot(+001, +011, +058, [+0.063, +0.110, +0.298]); // 114 (Blue)
dot(+002, +009, +059, [+0.063, +0.110, +0.298]); // 115 (Blue)
dot(+008, +030, +089, [+0.063, +0.110, +0.298]); // 116 (Blue)
dot(+001, +009, +059, [+0.063, +0.110, +0.298]); // 117 (Blue)
dot(+002, +008, +058, [+0.063, +0.110, +0.298]); // 118 (Blue)
dot(+246, +238, +001, [+0.737, +0.686, +0.063]); // 119 (Yellow)
dot(+002, +013, +067, [+0.063, +0.110, +0.298]); // 120 (Blue)
dot(+002, +012, +061, [+0.063, +0.110, +0.298]); // 121 (Blue)
dot(+246, +246, +214, [+0.965, +0.965, +0.851]); // 122 (White)
dot(+002, +013, +065, [+0.063, +0.110, +0.298]); // 123 (Blue)
dot(+002, +013, +069, [+0.063, +0.110, +0.298]); // 124 (Blue)
dot(+005, +023, +071, [+0.063, +0.110, +0.298]); // 125 (Blue)
dot(+246, +246, +216, [+0.965, +0.965, +0.851]); // 126 (White)
dot(+246, +236, +000, [+0.737, +0.686, +0.063]); // 127 (Yellow)
dot(+004, +016, +075, [+0.063, +0.110, +0.298]); // 128 (Blue)
dot(+001, +009, +058, [+0.063, +0.110, +0.298]); // 129 (Blue)
dot(+002, +013, +065, [+0.063, +0.110, +0.298]); // 130 (Blue)
dot(+002, +018, +068, [+0.063, +0.110, +0.298]); // 131 (Blue)
dot(+002, +014, +064, [+0.063, +0.110, +0.298]); // 132 (Blue)
dot(+002, +011, +062, [+0.063, +0.110, +0.298]); // 133 (Blue)
dot(+246, +246, +211, [+0.965, +0.965, +0.851]); // 134 (White)
dot(+002, +016, +074, [+0.063, +0.110, +0.298]); // 135 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 136 (Black)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 137 (Red)
dot(+001, +112, +000, [+0.020, +0.427, +0.012]); // 138 (Green)
dot(+246, +246, +217, [+0.965, +0.965, +0.851]); // 139 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 140 (Black)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 141 (Red)
dot(+001, +104, +000, [+0.020, +0.427, +0.012]); // 142 (Green)
dot(+000, +100, +000, [+0.020, +0.427, +0.012]); // 143 (Green)
dot(+246, +243, +001, [+0.737, +0.686, +0.063]); // 144 (Yellow)
dot(+001, +102, +000, [+0.020, +0.427, +0.012]); // 145 (Green)
dot(+246, +246, +210, [+0.965, +0.965, +0.851]); // 146 (White)
dot(+246, +241, +000, [+0.737, +0.686, +0.063]); // 147 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 148 (Black)
dot(+246, +246, +210, [+0.965, +0.965, +0.851]); // 149 (White)
dot(+246, +246, +216, [+0.965, +0.965, +0.851]); // 150 (White)
dot(+003, +016, +070, [+0.063, +0.110, +0.298]); // 151 (Blue)
dot(+246, +242, +001, [+0.737, +0.686, +0.063]); // 152 (Yellow)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 153 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 154 (Red)
dot(+244, +001, +000, [+0.886, +0.024, +0.008]); // 155 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 156 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 157 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 158 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 159 (Red)
dot(+001, +100, +000, [+0.020, +0.427, +0.012]); // 160 (Green)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 161 (Red)
dot(+000, +107, +000, [+0.020, +0.427, +0.012]); // 162 (Green)
dot(+001, +106, +001, [+0.020, +0.427, +0.012]); // 163 (Green)
dot(+246, +246, +208, [+0.965, +0.965, +0.851]); // 164 (White)
dot(+000, +104, +001, [+0.020, +0.427, +0.012]); // 165 (Green)
dot(+001, +105, +000, [+0.020, +0.427, +0.012]); // 166 (Green)
dot(+246, +231, +000, [+0.737, +0.686, +0.063]); // 167 (Yellow)
dot(+246, +237, +000, [+0.737, +0.686, +0.063]); // 168 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 169 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 170 (Black)
dot(+001, +107, +001, [+0.020, +0.427, +0.012]); // 171 (Green)
dot(+000, +099, +000, [+0.020, +0.427, +0.012]); // 172 (Green)
dot(+005, +115, +003, [+0.020, +0.427, +0.012]); // 173 (Green)
dot(+012, +032, +087, [+0.063, +0.110, +0.298]); // 174 (Blue)
dot(+245, +002, +000, [+0.886, +0.024, +0.008]); // 175 (Red)
dot(+002, +110, +001, [+0.020, +0.427, +0.012]); // 176 (Green)
dot(+005, +115, +003, [+0.020, +0.427, +0.012]); // 177 (Green)
dot(+003, +114, +002, [+0.020, +0.427, +0.012]); // 178 (Green)
dot(+011, +027, +077, [+0.063, +0.110, +0.298]); // 179 (Blue)
dot(+245, +006, +000, [+0.886, +0.024, +0.008]); // 180 (Red)
dot(+019, +030, +085, [+0.063, +0.110, +0.298]); // 181 (Blue)
dot(+245, +004, +000, [+0.886, +0.024, +0.008]); // 182 (Red)
dot(+009, +026, +076, [+0.063, +0.110, +0.298]); // 183 (Blue)
dot(+011, +027, +080, [+0.063, +0.110, +0.298]); // 184 (Blue)
dot(+005, +119, +004, [+0.020, +0.427, +0.012]); // 185 (Green)
dot(+245, +006, +000, [+0.886, +0.024, +0.008]); // 186 (Red)
dot(+245, +002, +000, [+0.886, +0.024, +0.008]); // 187 (Red)
dot(+245, +005, +000, [+0.886, +0.024, +0.008]); // 188 (Red)
dot(+004, +116, +003, [+0.020, +0.427, +0.012]); // 189 (Green)
dot(+010, +023, +078, [+0.063, +0.110, +0.298]); // 190 (Blue)
dot(+245, +003, +000, [+0.886, +0.024, +0.008]); // 191 (Red)
dot(+021, +039, +097, [+0.063, +0.110, +0.298]); // 192 (Blue)
dot(+006, +114, +005, [+0.020, +0.427, +0.012]); // 193 (Green)
dot(+007, +121, +004, [+0.020, +0.427, +0.012]); // 194 (Green)
dot(+003, +112, +001, [+0.020, +0.427, +0.012]); // 195 (Green)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 196 (Red)
dot(+005, +117, +003, [+0.020, +0.427, +0.012]); // 197 (Green)
dot(+245, +007, +000, [+0.886, +0.024, +0.008]); // 198 (Red)
dot(+018, +039, +088, [+0.063, +0.110, +0.298]); // 199 (Blue)
dot(+015, +033, +090, [+0.063, +0.110, +0.298]); // 200 (Blue)
dot(+006, +117, +004, [+0.020, +0.427, +0.012]); // 201 (Green)
dot(+015, +029, +083, [+0.063, +0.110, +0.298]); // 202 (Blue)
dot(+005, +114, +003, [+0.020, +0.427, +0.012]); // 203 (Green)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 204 (Red)
dot(+006, +113, +003, [+0.020, +0.427, +0.012]); // 205 (Green)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 206 (Red)
dot(+244, +003, +000, [+0.886, +0.024, +0.008]); // 207 (Red)
dot(+245, +003, +000, [+0.886, +0.024, +0.008]); // 208 (Red)
dot(+245, +007, +001, [+0.886, +0.024, +0.008]); // 209 (Red)
dot(+012, +031, +085, [+0.063, +0.110, +0.298]); // 210 (Blue)
dot(+004, +116, +003, [+0.020, +0.427, +0.012]); // 211 (Green)
dot(+003, +108, +001, [+0.020, +0.427, +0.012]); // 212 (Green)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 213 (Red)
dot(+007, +107, +003, [+0.020, +0.427, +0.012]); // 214 (Green)
dot(+006, +114, +004, [+0.020, +0.427, +0.012]); // 215 (Green)
dot(+010, +024, +077, [+0.063, +0.110, +0.298]); // 216 (Blue)
dot(+018, +030, +087, [+0.063, +0.110, +0.298]); // 217 (Blue)
dot(+244, +002, +000, [+0.886, +0.024, +0.008]); // 218 (Red)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 219 (Red)
dot(+009, +023, +073, [+0.063, +0.110, +0.298]); // 220 (Blue)
dot(+011, +024, +081, [+0.063, +0.110, +0.298]); // 221 (Blue)
dot(+009, +025, +077, [+0.063, +0.110, +0.298]); // 222 (Blue)
dot(+003, +104, +001, [+0.020, +0.427, +0.012]); // 223 (Green)
dot(+018, +032, +089, [+0.063, +0.110, +0.298]); // 224 (Blue)
dot(+016, +032, +086, [+0.063, +0.110, +0.298]); // 225 (Blue)
dot(+003, +109, +001, [+0.020, +0.427, +0.012]); // 226 (Green)
dot(+010, +024, +074, [+0.063, +0.110, +0.298]); // 227 (Blue)
dot(+002, +000, +000, [+0.000, +0.000, +0.000]); // 228 (Black)
dot(+006, +127, +006, [+0.020, +0.427, +0.012]); // 229 (Green)
dot(+005, +111, +003, [+0.020, +0.427, +0.012]); // 230 (Green)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 231 (Red)
dot(+014, +031, +086, [+0.063, +0.110, +0.298]); // 232 (Blue)
dot(+005, +118, +004, [+0.020, +0.427, +0.012]); // 233 (Green)
dot(+001, +111, +001, [+0.020, +0.427, +0.012]); // 234 (Green)
dot(+017, +037, +092, [+0.063, +0.110, +0.298]); // 235 (Blue)
dot(+010, +025, +082, [+0.063, +0.110, +0.298]); // 236 (Blue)
dot(+244, +001, +000, [+0.886, +0.024, +0.008]); // 237 (Red)
dot(+004, +114, +002, [+0.020, +0.427, +0.012]); // 238 (Green)
dot(+002, +112, +001, [+0.020, +0.427, +0.012]); // 239 (Green)
dot(+003, +109, +002, [+0.020, +0.427, +0.012]); // 240 (Green)
dot(+245, +003, +000, [+0.886, +0.024, +0.008]); // 241 (Red)
dot(+004, +107, +002, [+0.020, +0.427, +0.012]); // 242 (Green)
dot(+002, +110, +001, [+0.020, +0.427, +0.012]); // 243 (Green)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 244 (Red)
dot(+245, +002, +000, [+0.886, +0.024, +0.008]); // 245 (Red)
dot(+006, +110, +002, [+0.020, +0.427, +0.012]); // 246 (Green)
dot(+016, +030, +081, [+0.063, +0.110, +0.298]); // 247 (Blue)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 248 (Red)
dot(+245, +002, +000, [+0.886, +0.024, +0.008]); // 249 (Red)
dot(+011, +028, +082, [+0.063, +0.110, +0.298]); // 250 (Blue)
dot(+011, +027, +079, [+0.063, +0.110, +0.298]); // 251 (Blue)
dot(+012, +027, +080, [+0.063, +0.110, +0.298]); // 252 (Blue)
dot(+003, +117, +003, [+0.020, +0.427, +0.012]); // 253 (Green)
dot(+010, +025, +083, [+0.063, +0.110, +0.298]); // 254 (Blue)
dot(+011, +024, +077, [+0.063, +0.110, +0.298]); // 255 (Blue)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 256 (Red)
dot(+002, +111, +001, [+0.020, +0.427, +0.012]); // 257 (Green)
dot(+245, +005, +000, [+0.886, +0.024, +0.008]); // 258 (Red)
dot(+004, +109, +002, [+0.020, +0.427, +0.012]); // 259 (Green)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 260 (Red)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 261 (Red)
dot(+012, +028, +084, [+0.063, +0.110, +0.298]); // 262 (Blue)
dot(+002, +112, +002, [+0.020, +0.427, +0.012]); // 263 (Green)
dot(+002, +110, +001, [+0.020, +0.427, +0.012]); // 264 (Green)
marker(+000, +000, +000); // Black
marker(+008, +021, +074); // Blue
marker(+002, +107, +001); // Green
marker(+244, +001, +000); // Red
marker(+245, +234, +000); // Yellow
marker(+246, +245, +208); // White
