pellet_D = 6;
hole_D = pellet_D + 1;

W = 20;
D = 12;
H = 16;


difference() {
	#cube([W, D, H], center=true); 
	sphere (r=hole_D/2, $fn=20, center=true);
	translate([0, 0, H/4])
		cylinder (r1=hole_D/2, r2=pellet_D/2, h=H/2+0.2, $fn=20, center=true);
	
	translate([0, D/4, 0]) rotate([90, 0, 0])
		cylinder (r1=(hole_D + 2)/2, r2=hole_D/2, h=D/2+0.2, $fn=20, center=true);
}


