Arduino_linear_motion
=====================

21.04.2014

* linear motion with stepper and Pololu driver
* stepper library for Arduino: AccelStepper<br>http://www.airspayce.com/mikem/arduino/AccelStepper/
* linear drive taken from Canon *BJC-85 / K10190* Bubble Jet printer<br>http://www.usa.canon.com/cusa/support/consumer/printers_multifunction/bjc_series/bjc_85

Cable colors
------------
* from Canon *BJC-85 / K10190* Bubble Jet printer to Pulolu driver

|Stepper|-       |-       |Pulolu|Pin|
|------:|--------|--------|:-----|:-:|
|Red    |![][102]|![][102]|Red   |2B |
|Brown  |![][101]|![][106]|Blue  |2A |
|Yellow |![][104]|![][100]|Black |1A |
|Blue   |![][106]|![][105]|Green |1B |


Linear motion - Half step config
--------------------------------

MS1|MS2|MS3|Microstep Resolution|Excitation Mode 
:-:|:-:|:-:|--------------------|---------------
L|L|L|Full Step|2 Phase
H|L|L|**Half Step**|1-2 Phase
L|H|L|Quarter Step|W1-2 Phase
H|H|L|Eighth Step|2W1-2 Phase
H|H|H|Sixteenth Step|4W1-2 Phase


Motion resolution
-----------------

in half step mode: 1000 (half) steps = 212 mm

--> 0,212 mm/step / 4,717 steps/mm / ~120 steps/inch


Arduino simple command firmware
-------------------------------

command |parameter | function
--------|----------|---------
i |- |initialize
s |long |set speed [steps / sec]
a |long |set acceleration [steps / sec / sec]
m |long |move to step [steps]
d |long |move to degree [degrees]
h |- |halt immediately
w |long |wait [msec]
'0' - '9' |- |adds to the parameter (val = val * 10 + new)
- |- |negative parameter (val = -val)
LF |- |execute at line end (line feed, char(10))

----------

2014-04-21 --- initial version in _Github_ Markdown / https://help.github.com/articles/github-flavored-markdown


----------

| Left-Aligned  | Center Aligned  | Right Aligned |
| :------------ |:---------------:| -----:|
| col 3 is      | some wordy text | $1600 |
| col 2 is      | centered        |   $12 |
| zebra stripes | are neat        |    $1 |


```
Red -------> Red -------> Pin 2B
Brown -----> Blue ------> Pin 2A
Yellow ----> Black -----> Pin 1A
Blue ------> Green -----> Pin 1B
```


  [100]: http://www.realaxl.de/static/pix/color_gadgets/square_16_black.png
  [101]: http://www.realaxl.de/static/pix/color_gadgets/square_16_brown.png
  [102]: http://www.realaxl.de/static/pix/color_gadgets/square_16_red.png
  [103]: http://www.realaxl.de/static/pix/color_gadgets/square_16_orange.png
  [104]: http://www.realaxl.de/static/pix/color_gadgets/square_16_yellow.png
  [105]: http://www.realaxl.de/static/pix/color_gadgets/square_16_green.png
  [106]: http://www.realaxl.de/static/pix/color_gadgets/square_16_blue.png
  [107]: http://www.realaxl.de/static/pix/color_gadgets/square_16_purple.png
  [108]: http://www.realaxl.de/static/pix/color_gadgets/square_16_grey.png
  [109]: http://www.realaxl.de/static/pix/color_gadgets/square_16_white.png
  [110]: http://www.realaxl.de/static/pix/color_gadgets/square_16_gold.png  