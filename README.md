Pellet Rendering
================

An approach to render bitmap graphics into the limited color space of airgun pellets.

Keyboard
--------
* *pellet selection*
	* **0** - **9** = toggle usage of pellet by id
	* **b** = black and white, only
	* **a** = standard palette 
* *brightness and contrast transformations*
	* **up** = less contrast
	* **down** = more contrast
	* **left** = brighter
	* **right** = darker
	* **r** = reset brightness (0) and contrast (1) 
* *image options*
	* **n** - next image (cycle through image list) 
Color quantification
--------------------
* Method #1: [Euclidean color distance](http://en.wikipedia.org/wiki/Euclidean_distance) to get the closes matching pellet color in RGB color space
* Method #2: [Floyd–Steinberg dithering](http://en.wikipedia.org/wiki/Floyd%E2%80%93Steinberg_dithering) for additional error distribution to neighbor pixels

Examples
--------

![Mona Lisa](data/examples/Mona_Lisa_closest_match.png)
![Spock](data/examples/Spock_B+W.png)

Environment
-----------
* [Processing](http://www.processing.org/) Version 2.1
* Windows 7 (64 bit)

Version history
---------------
* 0.83 / 2014-03-08 - Floyd–Steinberg dithering with pellet objects