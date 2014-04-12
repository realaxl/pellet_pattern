main_disk_D = 80;
main_disk_h = 3;

main_disk_hole_D = 7;

main_disk_hole_offset = (main_disk_D / 2) - main_disk_hole_D;

pellet_D = 6;
pellet_h = 30;

pellet_Z = 0;

	pellet_Z = pellet_h - (($t ) * pellet_h);

gen_main_disk(-main_disk_h, 0);
gen_main_disk(-main_disk_h + pellet_D, $t*20);

translate([0, 0, pellet_Z]) color("red")
	sphere(r = pellet_D / 2, $fn = 20, center = true);

$vpr = $t;

module gen_main_disk(distance_Z, a) {
	translate([0, 0, distance_Z]) rotate([0, 0, a]) difference() {
		cylinder(h = main_disk_h, r=main_disk_D / 2, center=true);
		translate([main_disk_hole_offset,0,0])
			cylinder(h = main_disk_h + 0.1, r=main_disk_hole_D / 2, center=true);
	}
}
