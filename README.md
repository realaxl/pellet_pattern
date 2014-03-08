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
	* **up** = bighter
	* **down** = darker
	* **left** = less contrast
	* **right** = more contrast
	* **r** = reset brightness (0) and contrast (1) 
 
Color quantification
--------------------
* Method #1: [Euclidean color distance](http://en.wikipedia.org/wiki/Euclidean_distance) to get the closes matching pellet color in RGB color space
* Method #2: [Floyd–Steinberg dithering](http://en.wikipedia.org/wiki/Floyd%E2%80%93Steinberg_dithering) for additional error distribution to neighbor pixels

Examples
--------

![data\examples\Mona_Lisa_closest_match](data\examples\Mona_Lisa_closest_match.png?raw=true)

Environment
-----------
* [Processing](http://www.processing.org/) Version 2.1
* Windows 7 (64 bit)

