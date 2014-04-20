Pellet Color Quantifier
=======================

Inputs
------
* **RGB data in CSV file** (separator is accually ;) files:<br>[`RGB_values.csv`](data/RGB_values.csv)
	* Lines beginning with hash (#) symbol are ignored and treated as comments. They might re-appear in the output files as comment lines.
* **XML config file** for the pellet colors<br>[`pellet_colors.xml`](data/pellet_colors.xml)
* **Body of OpenSCAD script**:<br>[`3D_diagram_template.scad`](data/3D_diagram_template.scad)


Functions
---------
* Finds closest pellet color (minimal euclidian distance)
* Calculate average position in RGB space per color and save it as a marker.


Outputs
-------
* **Source code for OpenSCAD**<br>3D-Visualization in RGB color space, mapping red to X, green to Y and blue to Z:<br>[`3D_diagram.scad`](data/3D_diagram.scad)
* **Marker positions**<br>XML fragment:<br>[`pellet_markers.xml`](data/pellet_markers.xml)
* **Statistics**:
	* Counts
	* Averages
	* Marker infos and minimal distances of markers


----------

* Test Link: [data/3D_diagram_template.scad](data/3D_diagram_template.scad "3D_diagram_template.scad")
* Test Link: 