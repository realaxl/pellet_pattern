// pellet 3D debug diagram

// coordinate system


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


module dot(x, y, z, c) {
	len = 3.33;

	translate([x, y, z])
		color(c)
			sphere(r = len/2, center=true);
}


// ====================================================
// automated content follows
// ====================================================

