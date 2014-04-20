Pellet Color Quantifier
=======================

Inputs
------
* CSV (separator is accually ;) files:<br>`RGB_values.csv`
	* Lines beginning with hash (#) symbol are ignored and treated as comments. They might re-appear in the output files as comment lines.
* XML config file for the pellet colors .
* Body of OpenSCAD script:<br>`3D_diagram_template.scad`

Test Link: [data/3D_diagram_template.scad](data/3D_diagram_template.scad "3D_diagram_template.scad")


Functions
---------
* Finds closest pellet color (minimal euclidian distance)


Outputs
-------
* Source code for OpenSCAD<br>3D-Visualization in RGB color space, mapping red to X, green to Y and blue to Z:<br>`3D_diagram.scad`
* XML fragment with marker positions:<br>`pellet_colors.xml` 