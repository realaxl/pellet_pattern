`Arduino_linear_motion`
=======================

21.04.2014

* linear motion with stepper and Pololu driver
* stepper library for Arduino: AccelStepper

Cable colors
------------

Stepper --> Pololu

	Red -------> Red -------> Pin 2B
	Brown -----> Blue ------> Pin 2A
	Yellow ----> Black -----> Pin 1A
	Blue ------> Green -----> Pin 1B

Linear motion
-------------

Half steps config

	MS1 ---> VCC
	MS2 ---> GND
	MS3 ---> GND

1000 half steps = 212 mm

--> 0,212mm / step