Servo Tests for Pellet Sorter
=============================

Servo endpoints
---------------
* `h 180 / l 60`
* `h 44 / l 160`

Serial firmware commands
------------------------
* *Position in servo-steps*
	* **h** *position* --- move upper servo
	* **l** *position* --- move lower servo
	* **c** *position* --- move servos combined with offset
	* **o** *offset* --- set offset
	* **s** *position* --- move separator servo
* *Timing in milliseconds*
	* **d** *millis* --- set delay between servo steps
	* **w** *millis* --- wait
	* **a** *millis* --- wait for pellet detector interruption
* *Misc.*
	* **r** --- read optical sensor<br>--> `R1023;G1023;B1023;k;r;0`
	* **i** --- identify

Finite state machine for test run
---------------------------------
* 001 - to entry pos
* 002 - wait for key
* 003 - to scanner
* 004 - scan
* 005 - to empty pos
* 006 - empty


Versions
--------
* 2014-03-31<br>V0.52 **a** for pellet detector
* 2014-03-16<br>V0.51 **s** separator servo + **w** command
* 2014-03-15<br>V0.50 initial serial communication
