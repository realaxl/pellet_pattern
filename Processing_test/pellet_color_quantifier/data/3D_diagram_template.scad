// pellet 3D debug diagram

// coordinate system


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

	translate([x - 128, y - 128, z - 128]) {
		color([0,0,0, .33]) {
			cylinder(r = .33, h = len, center=true);
			rotate([-90, 0, 0]) cylinder(r = .33, h = len, center=true);
			rotate([0, 90, 0])  cylinder(r = .33, h = len, center=true);
		}
		color([1, 1, 1, .1])
			sphere(r=30, center=true);
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

