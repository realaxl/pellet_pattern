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
// automated content follows
// ====================================================

// # File: RGB_read_2014-04-07_20-13-15.csv
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 1 (Black)
dot(+242, +226, +000, [+0.737, +0.686, +0.063]); // 2 (Yellow)
dot(+242, +242, +227, [+0.965, +0.965, +0.851]); // 3 (White)
dot(+000, +007, +059, [+0.063, +0.110, +0.298]); // 5 (Blue)
dot(+240, +000, +000, [+0.886, +0.024, +0.008]); // 6 (Red)
dot(+240, +000, +000, [+0.886, +0.024, +0.008]); // 7 (Red)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 8 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 9 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 10 (Black)
dot(+242, +237, +000, [+0.737, +0.686, +0.063]); // 12 (Yellow)
dot(+242, +242, +198, [+0.965, +0.965, +0.851]); // 13 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 14 (Black)
dot(+243, +243, +242, [+0.965, +0.965, +0.851]); // 15 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 16 (Black)
dot(+000, +102, +000, [+0.020, +0.427, +0.012]); // 17 (Green)
dot(+000, +119, +000, [+0.020, +0.427, +0.012]); // 18 (Green)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 19 (Black)
dot(+242, +239, +000, [+0.737, +0.686, +0.063]); // 20 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 21 (Black)
dot(+000, +011, +063, [+0.063, +0.110, +0.298]); // 22 (Blue)
dot(+000, +099, +000, [+0.020, +0.427, +0.012]); // 23 (Green)
dot(+000, +008, +057, [+0.063, +0.110, +0.298]); // 24 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 25 (Black)
dot(+000, +116, +000, [+0.020, +0.427, +0.012]); // 26 (Green)
dot(+000, +011, +060, [+0.063, +0.110, +0.298]); // 27 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 28 (Black)
dot(+242, +239, +000, [+0.737, +0.686, +0.063]); // 30 (Yellow)
dot(+000, +106, +000, [+0.020, +0.427, +0.012]); // 31 (Green)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 32 (Black)
dot(+000, +013, +066, [+0.063, +0.110, +0.298]); // 34 (Blue)
dot(+242, +242, +225, [+0.965, +0.965, +0.851]); // 35 (White)
dot(+242, +242, +206, [+0.965, +0.965, +0.851]); // 37 (White)
dot(+240, +000, +000, [+0.886, +0.024, +0.008]); // 39 (Red)
dot(+242, +242, +221, [+0.965, +0.965, +0.851]); // 41 (White)
dot(+242, +239, +000, [+0.737, +0.686, +0.063]); // 42 (Yellow)
dot(+242, +242, +222, [+0.965, +0.965, +0.851]); // 43 (White)
dot(+240, +000, +000, [+0.886, +0.024, +0.008]); // 44 (Red)
dot(+242, +242, +202, [+0.965, +0.965, +0.851]); // 45 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 50 (Black)
dot(+242, +242, +218, [+0.965, +0.965, +0.851]); // 51 (White)
dot(+240, +000, +000, [+0.886, +0.024, +0.008]); // 52 (Red)
dot(+242, +242, +208, [+0.965, +0.965, +0.851]); // 53 (White)
dot(+241, +242, +195, [+0.965, +0.965, +0.851]); // 54 (White)
dot(+242, +242, +225, [+0.965, +0.965, +0.851]); // 55 (White)
dot(+001, +010, +060, [+0.063, +0.110, +0.298]); // 56 (Blue)
dot(+240, +000, +000, [+0.886, +0.024, +0.008]); // 57 (Red)
dot(+242, +242, +228, [+0.965, +0.965, +0.851]); // 58 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 60 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 61 (Black)
dot(+242, +242, +212, [+0.965, +0.965, +0.851]); // 62 (White)
dot(+242, +242, +212, [+0.965, +0.965, +0.851]); // 63 (White)
dot(+000, +010, +061, [+0.063, +0.110, +0.298]); // 64 (Blue)
dot(+240, +000, +000, [+0.886, +0.024, +0.008]); // 65 (Red)
dot(+000, +009, +059, [+0.063, +0.110, +0.298]); // 66 (Blue)
dot(+241, +242, +199, [+0.965, +0.965, +0.851]); // 67 (White)
dot(+242, +240, +000, [+0.737, +0.686, +0.063]); // 68 (Yellow)
dot(+000, +008, +056, [+0.063, +0.110, +0.298]); // 71 (Blue)
dot(+000, +104, +000, [+0.020, +0.427, +0.012]); // 73 (Green)
dot(+242, +239, +000, [+0.737, +0.686, +0.063]); // 76 (Yellow)
dot(+242, +238, +000, [+0.737, +0.686, +0.063]); // 77 (Yellow)
dot(+240, +000, +000, [+0.886, +0.024, +0.008]); // 78 (Red)
dot(+000, +103, +000, [+0.020, +0.427, +0.012]); // 79 (Green)
dot(+242, +239, +000, [+0.737, +0.686, +0.063]); // 80 (Yellow)
dot(+000, +010, +056, [+0.063, +0.110, +0.298]); // 81 (Blue)
// # File: RGB_read_2014-04-07_20-19-24.csv
dot(+242, +239, +000, [+0.737, +0.686, +0.063]); // 83 (Yellow)
// # File: RGB_read_2014-04-07_20-28-58.csv
dot(+240, +000, +000, [+0.886, +0.024, +0.008]); // 103 (Red)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 104 (Black)
dot(+242, +242, +217, [+0.965, +0.965, +0.851]); // 105 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 106 (Black)
dot(+001, +017, +072, [+0.063, +0.110, +0.298]); // 109 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 110 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 111 (Black)
dot(+242, +242, +227, [+0.965, +0.965, +0.851]); // 112 (White)
dot(+035, +013, +002, [+0.000, +0.000, +0.000]); // 113 (Black)
dot(+000, +104, +000, [+0.020, +0.427, +0.012]); // 114 (Green)
dot(+242, +240, +000, [+0.737, +0.686, +0.063]); // 115 (Yellow)
dot(+000, +016, +069, [+0.063, +0.110, +0.298]); // 116 (Blue)
dot(+242, +239, +000, [+0.737, +0.686, +0.063]); // 117 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 119 (Black)
dot(+000, +011, +064, [+0.063, +0.110, +0.298]); // 120 (Blue)
dot(+240, +000, +000, [+0.886, +0.024, +0.008]); // 121 (Red)
dot(+242, +240, +001, [+0.737, +0.686, +0.063]); // 122 (Yellow)
dot(+242, +242, +213, [+0.965, +0.965, +0.851]); // 123 (White)
dot(+242, +242, +223, [+0.965, +0.965, +0.851]); // 124 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 126 (Black)
dot(+000, +114, +000, [+0.020, +0.427, +0.012]); // 127 (Green)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 128 (Black)
dot(+242, +242, +207, [+0.965, +0.965, +0.851]); // 130 (White)
dot(+000, +010, +062, [+0.063, +0.110, +0.298]); // 134 (Blue)
dot(+242, +236, +000, [+0.737, +0.686, +0.063]); // 135 (Yellow)
dot(+242, +242, +200, [+0.965, +0.965, +0.851]); // 136 (White)
dot(+242, +238, +000, [+0.737, +0.686, +0.063]); // 137 (Yellow)
// # File: RGB_read_2014-04-12_15-06-21.csv
dot(+245, +010, +003, [+0.886, +0.024, +0.008]); // 139 (Red)
dot(+246, +246, +215, [+0.965, +0.965, +0.851]); // 140 (White)
dot(+030, +042, +095, [+0.063, +0.110, +0.298]); // 141 (Blue)
dot(+001, +000, +000, [+0.000, +0.000, +0.000]); // 142 (Black)
dot(+245, +019, +011, [+0.886, +0.024, +0.008]); // 143 (Red)
dot(+001, +000, +000, [+0.000, +0.000, +0.000]); // 144 (Black)
dot(+245, +016, +008, [+0.886, +0.024, +0.008]); // 145 (Red)
dot(+033, +046, +093, [+0.063, +0.110, +0.298]); // 146 (Blue)
dot(+002, +000, +000, [+0.000, +0.000, +0.000]); // 147 (Black)
dot(+245, +020, +011, [+0.886, +0.024, +0.008]); // 148 (Red)
dot(+245, +018, +011, [+0.886, +0.024, +0.008]); // 149 (Red)
dot(+246, +246, +243, [+0.965, +0.965, +0.851]); // 150 (White)
dot(+246, +244, +034, [+0.737, +0.686, +0.063]); // 151 (Yellow)
dot(+034, +048, +093, [+0.063, +0.110, +0.298]); // 152 (Blue)
dot(+246, +246, +235, [+0.965, +0.965, +0.851]); // 153 (White)
dot(+246, +244, +038, [+0.737, +0.686, +0.063]); // 154 (Yellow)
dot(+246, +243, +034, [+0.737, +0.686, +0.063]); // 155 (Yellow)
dot(+034, +042, +090, [+0.063, +0.110, +0.298]); // 156 (Blue)
// # File: RGB_read_2014-04-12_15-08-45.csv
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 158 (Black)
dot(+245, +012, +005, [+0.886, +0.024, +0.008]); // 159 (Red)
dot(+011, +115, +008, [+0.020, +0.427, +0.012]); // 160 (Green)
dot(+246, +245, +032, [+0.737, +0.686, +0.063]); // 161 (Yellow)
dot(+011, +105, +006, [+0.020, +0.427, +0.012]); // 162 (Green)
dot(+013, +129, +011, [+0.020, +0.427, +0.012]); // 163 (Green)
dot(+246, +246, +231, [+0.965, +0.965, +0.851]); // 164 (White)
dot(+024, +034, +084, [+0.063, +0.110, +0.298]); // 165 (Blue)
dot(+011, +116, +007, [+0.020, +0.427, +0.012]); // 166 (Green)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 167 (Black)
dot(+246, +246, +222, [+0.965, +0.965, +0.851]); // 168 (White)
dot(+007, +107, +004, [+0.020, +0.427, +0.012]); // 169 (Green)
dot(+246, +246, +213, [+0.965, +0.965, +0.851]); // 170 (White)
dot(+246, +246, +217, [+0.965, +0.965, +0.851]); // 171 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 172 (Black)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 173 (Red)
dot(+246, +236, +012, [+0.737, +0.686, +0.063]); // 174 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 175 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 176 (Black)
dot(+245, +238, +009, [+0.737, +0.686, +0.063]); // 177 (Yellow)
dot(+246, +236, +011, [+0.737, +0.686, +0.063]); // 178 (Yellow)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 179 (Red)
dot(+246, +246, +207, [+0.965, +0.965, +0.851]); // 180 (White)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 181 (Red)
dot(+004, +112, +002, [+0.020, +0.427, +0.012]); // 182 (Green)
dot(+016, +028, +078, [+0.063, +0.110, +0.298]); // 183 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 184 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 185 (Black)
dot(+246, +239, +012, [+0.737, +0.686, +0.063]); // 186 (Yellow)
dot(+246, +246, +215, [+0.965, +0.965, +0.851]); // 187 (White)
dot(+006, +114, +003, [+0.020, +0.427, +0.012]); // 188 (Green)
dot(+015, +023, +068, [+0.063, +0.110, +0.298]); // 189 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 190 (Black)
dot(+003, +101, +001, [+0.020, +0.427, +0.012]); // 191 (Green)
dot(+014, +023, +073, [+0.063, +0.110, +0.298]); // 192 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 193 (Black)
dot(+004, +104, +001, [+0.020, +0.427, +0.012]); // 194 (Green)
dot(+246, +246, +212, [+0.965, +0.965, +0.851]); // 195 (White)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 196 (Red)
dot(+246, +246, +216, [+0.965, +0.965, +0.851]); // 197 (White)
dot(+246, +231, +008, [+0.737, +0.686, +0.063]); // 198 (Yellow)
dot(+004, +111, +001, [+0.020, +0.427, +0.012]); // 199 (Green)
dot(+246, +246, +221, [+0.965, +0.965, +0.851]); // 200 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 201 (Black)
dot(+246, +245, +185, [+0.965, +0.965, +0.851]); // 202 (White)
dot(+246, +246, +221, [+0.965, +0.965, +0.851]); // 203 (White)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 204 (Red)
dot(+246, +246, +211, [+0.965, +0.965, +0.851]); // 205 (White)
dot(+013, +025, +074, [+0.063, +0.110, +0.298]); // 206 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 207 (Black)
// # File: RGB_read_2014-04-12_15-14-34.csv
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 209 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 210 (Black)
dot(+001, +000, +000, [+0.000, +0.000, +0.000]); // 211 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 212 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 213 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 214 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 215 (Black)
dot(+246, +246, +222, [+0.965, +0.965, +0.851]); // 216 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 217 (Black)
dot(+246, +246, +203, [+0.965, +0.965, +0.851]); // 218 (White)
dot(+024, +037, +086, [+0.063, +0.110, +0.298]); // 219 (Blue)
dot(+246, +246, +220, [+0.965, +0.965, +0.851]); // 220 (White)
dot(+009, +114, +005, [+0.020, +0.427, +0.012]); // 221 (Green)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 222 (Black)
dot(+246, +242, +023, [+0.737, +0.686, +0.063]); // 223 (Yellow)
dot(+245, +008, +001, [+0.886, +0.024, +0.008]); // 224 (Red)
dot(+026, +034, +077, [+0.063, +0.110, +0.298]); // 225 (Blue)
dot(+027, +039, +087, [+0.063, +0.110, +0.298]); // 226 (Blue)
dot(+246, +246, +221, [+0.965, +0.965, +0.851]); // 227 (White)
dot(+245, +008, +003, [+0.886, +0.024, +0.008]); // 228 (Red)
dot(+246, +243, +023, [+0.737, +0.686, +0.063]); // 229 (Yellow)
dot(+245, +014, +006, [+0.886, +0.024, +0.008]); // 230 (Red)
dot(+017, +116, +013, [+0.020, +0.427, +0.012]); // 231 (Green)
dot(+246, +244, +033, [+0.737, +0.686, +0.063]); // 232 (Yellow)
dot(+247, +247, +243, [+0.965, +0.965, +0.851]); // 233 (White)
dot(+246, +243, +030, [+0.737, +0.686, +0.063]); // 234 (Yellow)
dot(+246, +246, +227, [+0.965, +0.965, +0.851]); // 235 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 236 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 237 (Black)
dot(+011, +111, +007, [+0.020, +0.427, +0.012]); // 238 (Green)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 239 (Black)
dot(+246, +246, +233, [+0.965, +0.965, +0.851]); // 240 (White)
dot(+246, +246, +237, [+0.965, +0.965, +0.851]); // 241 (White)
dot(+246, +246, +222, [+0.965, +0.965, +0.851]); // 242 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 243 (Black)
dot(+025, +038, +087, [+0.063, +0.110, +0.298]); // 244 (Blue)
dot(+246, +246, +228, [+0.965, +0.965, +0.851]); // 245 (White)
dot(+246, +246, +230, [+0.965, +0.965, +0.851]); // 246 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 247 (Black)
dot(+245, +013, +005, [+0.886, +0.024, +0.008]); // 248 (Red)
dot(+028, +040, +087, [+0.063, +0.110, +0.298]); // 249 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 250 (Black)
dot(+015, +107, +008, [+0.020, +0.427, +0.012]); // 251 (Green)
dot(+246, +246, +227, [+0.965, +0.965, +0.851]); // 252 (White)
dot(+246, +243, +021, [+0.737, +0.686, +0.063]); // 253 (Yellow)
dot(+018, +026, +075, [+0.063, +0.110, +0.298]); // 254 (Blue)
dot(+246, +246, +220, [+0.965, +0.965, +0.851]); // 255 (White)
dot(+246, +246, +206, [+0.965, +0.965, +0.851]); // 256 (White)
dot(+246, +246, +224, [+0.965, +0.965, +0.851]); // 257 (White)
dot(+002, +100, +000, [+0.020, +0.427, +0.012]); // 258 (Green)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 259 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 260 (Black)
dot(+010, +022, +071, [+0.063, +0.110, +0.298]); // 261 (Blue)
dot(+002, +102, +001, [+0.020, +0.427, +0.012]); // 262 (Green)
dot(+011, +019, +065, [+0.063, +0.110, +0.298]); // 263 (Blue)
dot(+246, +241, +008, [+0.737, +0.686, +0.063]); // 264 (Yellow)
dot(+009, +016, +061, [+0.063, +0.110, +0.298]); // 265 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 266 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 267 (Black)
dot(+246, +246, +202, [+0.965, +0.965, +0.851]); // 268 (White)
dot(+002, +107, +001, [+0.020, +0.427, +0.012]); // 269 (Green)
dot(+246, +246, +213, [+0.965, +0.965, +0.851]); // 270 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 271 (Black)
dot(+246, +246, +203, [+0.965, +0.965, +0.851]); // 272 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 273 (Black)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 274 (Red)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 275 (Black)
dot(+246, +246, +212, [+0.965, +0.965, +0.851]); // 276 (White)
dot(+246, +246, +209, [+0.965, +0.965, +0.851]); // 277 (White)
dot(+002, +104, +000, [+0.020, +0.427, +0.012]); // 278 (Green)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 279 (Black)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 280 (Red)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 281 (Black)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 282 (Red)
dot(+244, +000, +000, [+0.886, +0.024, +0.008]); // 283 (Red)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 284 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 285 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 286 (Black)
dot(+246, +246, +187, [+0.965, +0.965, +0.851]); // 287 (White)
dot(+002, +101, +000, [+0.020, +0.427, +0.012]); // 288 (Green)
dot(+246, +246, +216, [+0.965, +0.965, +0.851]); // 289 (White)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 290 (Red)
dot(+246, +246, +196, [+0.965, +0.965, +0.851]); // 291 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 292 (Black)
dot(+246, +231, +003, [+0.737, +0.686, +0.063]); // 293 (Yellow)
dot(+008, +018, +065, [+0.063, +0.110, +0.298]); // 294 (Blue)
dot(+003, +120, +002, [+0.020, +0.427, +0.012]); // 295 (Green)
dot(+247, +244, +009, [+0.737, +0.686, +0.063]); // 296 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 297 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 298 (Black)
dot(+246, +247, +230, [+0.965, +0.965, +0.851]); // 299 (White)
dot(+245, +005, +000, [+0.886, +0.024, +0.008]); // 300 (Red)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 301 (Black)
dot(+008, +024, +075, [+0.063, +0.110, +0.298]); // 302 (Blue)
dot(+246, +247, +227, [+0.965, +0.965, +0.851]); // 303 (White)
dot(+246, +246, +210, [+0.965, +0.965, +0.851]); // 304 (White)
dot(+246, +246, +211, [+0.965, +0.965, +0.851]); // 305 (White)
dot(+246, +246, +205, [+0.965, +0.965, +0.851]); // 306 (White)
dot(+246, +246, +202, [+0.965, +0.965, +0.851]); // 307 (White)
dot(+246, +233, +005, [+0.737, +0.686, +0.063]); // 308 (Yellow)
dot(+246, +246, +211, [+0.965, +0.965, +0.851]); // 309 (White)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 310 (Red)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 311 (Black)
dot(+007, +018, +067, [+0.063, +0.110, +0.298]); // 312 (Blue)
dot(+007, +019, +066, [+0.063, +0.110, +0.298]); // 313 (Blue)
dot(+002, +105, +000, [+0.020, +0.427, +0.012]); // 314 (Green)
dot(+246, +229, +003, [+0.737, +0.686, +0.063]); // 315 (Yellow)
dot(+247, +246, +229, [+0.965, +0.965, +0.851]); // 316 (White)
dot(+001, +096, +000, [+0.020, +0.427, +0.012]); // 317 (Green)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 318 (Red)
dot(+246, +241, +005, [+0.737, +0.686, +0.063]); // 319 (Yellow)
dot(+002, +107, +000, [+0.020, +0.427, +0.012]); // 320 (Green)
dot(+007, +021, +072, [+0.063, +0.110, +0.298]); // 321 (Blue)
dot(+246, +246, +212, [+0.965, +0.965, +0.851]); // 322 (White)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 323 (Red)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 324 (Red)
dot(+246, +241, +005, [+0.737, +0.686, +0.063]); // 325 (Yellow)
dot(+246, +242, +006, [+0.737, +0.686, +0.063]); // 326 (Yellow)
dot(+246, +246, +203, [+0.965, +0.965, +0.851]); // 327 (White)
dot(+246, +246, +210, [+0.965, +0.965, +0.851]); // 328 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 329 (Black)
dot(+246, +246, +216, [+0.965, +0.965, +0.851]); // 330 (White)
dot(+246, +246, +210, [+0.965, +0.965, +0.851]); // 331 (White)
dot(+002, +107, +000, [+0.020, +0.427, +0.012]); // 332 (Green)
dot(+007, +019, +070, [+0.063, +0.110, +0.298]); // 333 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 334 (Black)
dot(+002, +105, +000, [+0.020, +0.427, +0.012]); // 335 (Green)
dot(+001, +110, +000, [+0.020, +0.427, +0.012]); // 336 (Green)
dot(+246, +225, +004, [+0.737, +0.686, +0.063]); // 337 (Yellow)
dot(+006, +017, +066, [+0.063, +0.110, +0.298]); // 338 (Blue)
dot(+246, +246, +217, [+0.965, +0.965, +0.851]); // 339 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 340 (Black)
dot(+247, +247, +230, [+0.965, +0.965, +0.851]); // 341 (White)
dot(+246, +246, +222, [+0.965, +0.965, +0.851]); // 342 (White)
dot(+011, +023, +070, [+0.063, +0.110, +0.298]); // 343 (Blue)
dot(+010, +022, +073, [+0.063, +0.110, +0.298]); // 344 (Blue)
dot(+246, +246, +207, [+0.965, +0.965, +0.851]); // 345 (White)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 346 (Black)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 347 (Red)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 348 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 349 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 350 (Black)
dot(+008, +020, +068, [+0.063, +0.110, +0.298]); // 351 (Blue)
dot(+246, +241, +006, [+0.737, +0.686, +0.063]); // 352 (Yellow)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 353 (Red)
dot(+246, +246, +216, [+0.965, +0.965, +0.851]); // 354 (White)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 355 (Red)
dot(+246, +246, +220, [+0.965, +0.965, +0.851]); // 356 (White)
dot(+248, +248, +246, [+0.965, +0.965, +0.851]); // 357 (White)
dot(+246, +243, +012, [+0.737, +0.686, +0.063]); // 358 (Yellow)
dot(+015, +030, +083, [+0.063, +0.110, +0.298]); // 359 (Blue)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 360 (Black)
dot(+246, +241, +014, [+0.737, +0.686, +0.063]); // 361 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 362 (Black)
dot(+020, +033, +087, [+0.063, +0.110, +0.298]); // 363 (Blue)
dot(+245, +001, +000, [+0.886, +0.024, +0.008]); // 364 (Red)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 365 (Black)
dot(+007, +122, +005, [+0.020, +0.427, +0.012]); // 366 (Green)
dot(+247, +244, +020, [+0.737, +0.686, +0.063]); // 367 (Yellow)
dot(+246, +237, +017, [+0.737, +0.686, +0.063]); // 368 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 369 (Black)
dot(+246, +246, +216, [+0.965, +0.965, +0.851]); // 370 (White)
dot(+246, +246, +212, [+0.965, +0.965, +0.851]); // 371 (White)
dot(+004, +109, +002, [+0.020, +0.427, +0.012]); // 372 (Green)
dot(+246, +221, +008, [+0.737, +0.686, +0.063]); // 373 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 374 (Black)
dot(+002, +113, +001, [+0.020, +0.427, +0.012]); // 375 (Green)
dot(+245, +000, +000, [+0.886, +0.024, +0.008]); // 376 (Red)
// # File: RGB_read_2014-04-12_16-28-43.csv
dot(+246, +246, +209, [+0.965, +0.965, +0.851]); // 378 (White)
// # File: RGB_read_2014-04-12_17-51-02.csv
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 470 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 471 (Black)
dot(+245, +213, +000, [+0.737, +0.686, +0.063]); // 472 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 473 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 474 (Black)
dot(+246, +210, +000, [+0.737, +0.686, +0.063]); // 475 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 476 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 477 (Black)
dot(+246, +226, +000, [+0.737, +0.686, +0.063]); // 478 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 479 (Black)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 480 (Black)
dot(+245, +205, +000, [+0.737, +0.686, +0.063]); // 481 (Yellow)
dot(+246, +217, +000, [+0.737, +0.686, +0.063]); // 482 (Yellow)
dot(+246, +229, +000, [+0.737, +0.686, +0.063]); // 483 (Yellow)
dot(+000, +000, +000, [+0.000, +0.000, +0.000]); // 484 (Black)
marker(+000, +000, +000); // Black
marker(+011, +022, +072); // Blue
marker(+004, +108, +002); // Green
marker(+243, +003, +001); // Red
marker(+239, +228, +012); // Yellow
marker(+244, +245, +216); // White
