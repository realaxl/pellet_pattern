// linear motion for pellet sorter
// 2014-04


// 2012-12-26 axl@realaxl.de
// Arduino 1.0.1

// based on AccelStepper / Bounce.pde
// -*- mode: C++ -*-
//
// Copyright (C) 2012 Mike McCauley
// $Id: Random.pde,v 1.1 2011/01/05 01:51:01 mikem Exp mikem $

// Define a stepper and the pins it will use
// AccelStepper stepper; // Defaults to AccelStepper::FULL4WIRE (4 pins) on 2, 3, 4, 5
#include <AccelStepper.h>
AccelStepper stepper(1, 9, 8);

long p = 0;                 // position [steps]
float s_speed = 1500;       // steps / sec
float s_acceleration = 800; // steps / sec / sec

// serial command processor
byte inByte = 0;         // incoming serial byte
byte cmd;                // command (1 character)
long val;                // value
boolean val_sig = true;  // signature

// program finite state machine
byte state = 0;

// input read test
const int buttonPin = 2;     // the number of the pushbutton pin
const int ledPin =  13;      // the number of the LED pin
int buttonState = 0;         // variable for reading the pushbutton status


void setup()
{
  // setup the stepper object
  stepper.setMaxSpeed(s_speed);
  stepper.setAcceleration(s_acceleration);
  stepper.moveTo(p);
  
  // input read test
  pinMode(buttonPin, INPUT);
  pinMode(ledPin, OUTPUT);

  // start serial port at 9600 bps and wait for port to open:
  Serial.begin(9600);
}


void loop()
{
  // If at the end of travel go to the other end
  stepper.run();

  if (stepper.distanceToGo() == 0) {
    if (state == 1) {
      Serial.write('d');
      Serial.write(';');
      Serial.write(cmd);
      Serial.write(';');
      Serial.println(p);
      state = 0;
    }
  }


  buttonState = digitalRead(buttonPin);

  // check if the pushbutton is pressed.
  // if it is, the buttonState is HIGH:
  if (buttonState == HIGH) {     
    // turn LED on:    
    digitalWrite(ledPin, HIGH);  
  } 
  else {
    // turn LED off:
    digitalWrite(ledPin, LOW); 
  }

  
  if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();
    
    if (inByte >= 'a') {
      cmd = inByte;
      val = 0;
      val_sig = true;
    } else {
      if (inByte == 10)  {
        switch (cmd) {
          case 'h':
            //stepper.stop();
            p = stepper.currentPosition();
            stepper.moveTo(p);
            while (stepper.distanceToGo() != 0)
              stepper.run();
            p = stepper.currentPosition();
            break;
          case 'i':
            p = stepper.currentPosition();
            stepper.moveTo(p);
            while (stepper.distanceToGo() != 0)
              stepper.run();
            stepper.setCurrentPosition(p);
            p = 0;
            break;

          case 'm': // move to step
            p = val;
            if (!val_sig)
              p = -p;
            stepper.moveTo(p);
            state = 1;
            break;
          case 'd': // move to degree
            p = val * 32;
            if (!val_sig)
              p = -p;
            stepper.moveTo(p);
            state = 1;
            break;
            
          case 's': // set speed [steps/sec]
            s_speed = (float) val;
            stepper.setMaxSpeed(s_speed);
            break;
          case 'a': // set acceleration [steps/sec/sec]
            s_acceleration = (float) val;
            stepper.setAcceleration(s_acceleration);
            break;
  
          case 'w': // wait [msec]
            delay(max(1000, val));
            state = 1;
            break;

          default: 
            // if nothing else matches, do the default
            // default is optional
            break;
        }
        Serial.write('k');
        Serial.write(';');
        Serial.write(cmd);
        Serial.write(';');
        Serial.println(p);
      } else {
        if (inByte == '-') val_sig = !val_sig;
        if ((inByte >= '0') && (inByte <= '9')) val = val * 10 + (inByte - '0');
      }
    }
  }
}

