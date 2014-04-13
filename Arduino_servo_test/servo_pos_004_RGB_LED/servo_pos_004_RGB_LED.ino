// Pellet Sorter

String version_string = "pellet_sorter";

// Servo stuff
#include <Servo.h> 
 
Servo servo_hi;  // create servo object, upper servo
Servo servo_lo;  // create servo object, lower servo
Servo servo_sep;  // separator
 
int pos_hi = 0;    // variable to store the servo position 
int pos_lo = 0;
int target_hi = 180;
int target_lo = 40;

int target_offset = 20;
int servo_offset = target_offset;

int servo_delay = 5;

int pos_sep = 0;
int target_sep = 128;

// RGB LED pins
int ledR = 13;
int ledG = 12;
int ledB = 11;
const int RGB_delay = 10;

// detector test
int detector_pin = A1;

// analog read pin
const int analogInPin = A0;  // Analog input pin that the potentiometer is attached to


// serial command processor
byte inByte = 0;         // incoming serial byte
byte cmd;                // command (1 character)
long val;                // value
byte val_sig = 1;        // signature


void setup() {
  // initialize RGB LED
  pinMode(ledR, OUTPUT);     
  pinMode(ledG, OUTPUT);     
  pinMode(ledB, OUTPUT);

  // intitalize Servos  
  servo_hi.attach(9);   // attaches the servo on pin 9 to the servo object 
  servo_lo.attach(10);  // attaches the servo on pin 9 to the servo object 
  servo_sep.attach(3);  // attaches the servo on pin 9 to the servo object 

  Serial.begin(9600);
  
  while (move_servo()) {}
  while (move_separator()) {}
} 



void loop() 
{
  if (Serial.available() > 0) {
    // get incoming byte:
    inByte = Serial.read();
    
    if (inByte >= 'a') {
      cmd = inByte;
      val = 0;
      val_sig = 1;
    } else {
      if (inByte == 10)  {
        switch (cmd) {
          case 'h': // upper servo
            target_hi = constrain(val, 0, 255);
            while (move_servo()) {}
            break;
          case 'l': // lower servo
            target_lo = constrain(val, 0, 255);
            while (move_servo()) {}
            break;

          case 'c': // combined movement
            target_lo = calc_lo(pos_hi, servo_offset);
            while (move_servo()) {}

            target_hi = constrain(val, 0, 255);
            move_combined();
            break;

          case 'o':
            // combined movement
            target_lo = calc_lo(pos_hi, servo_offset);
            while (move_servo()) {}

            target_offset = val;
            move_offset();
            break;

          case 's': // lower servo
            target_sep = constrain(val, 0, 255);
            while (move_separator()) {}
            break;


          case 'd': // set delay
            servo_delay = val;
            break;

          case 'w': // wait for val milliseconds
            if (val > 0)
              delay (val);
            break;

          case 'a': // wait & detect for val milliseconds
            {
              int m = millis() + max(val, 0);
              int a = analogRead(detector_pin);
              while((millis() < m) && (a > 200)) {
                a = analogRead(detector_pin);
                delay(1);
              }
              if (a > 200)
                val = 0;
              else
                val = 1;
              //val = a;
            }
            break;

          case 'r': // set delay
            Serial.write('k'); Serial.write(';');
            Serial.write('r'); Serial.write(';');
            analog_to_serial('R', ledR);
            analog_to_serial('G', ledG);
            analog_to_serial('B', ledB);
            break;

          case 'i': // set delay
            Serial.write('k');
            Serial.write(';');
            Serial.print(version_string);
            Serial.write(';');
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
        Serial.println(val);
      } else {
        if (inByte == '-') val_sig = -val_sig;
        if ((inByte >= '0') && (inByte <= '9')) val = val * 10 + (inByte - '0');
      }
    }
  }  
}


boolean move_servo() {
  if ((target_hi == pos_hi) && (target_lo == pos_lo))
    return(false);

  if (target_hi != pos_hi)
    if (target_hi > pos_hi)
      pos_hi ++;
    else
      pos_hi --;
      
  if (target_lo != pos_lo)
    if (target_lo > pos_lo)
      pos_lo ++;
    else
      pos_lo --;
      
  servo_hi.write(pos_hi);              // tell servo to go to position in variable 'pos' 
  servo_lo.write(pos_lo);              // tell servo to go to position in variable 'pos' 
  
  delay(servo_delay);
  return(true);
}


boolean move_separator() {
  if (target_sep == pos_sep)
    return(false);

  if (target_sep > pos_sep)
      pos_sep ++;
    else
      pos_sep --;
      
  servo_sep.write(pos_sep);
  
  delay(servo_delay);
  return(true);
}



boolean move_offset() {
  while (target_offset != servo_offset) {
    if (target_offset > servo_offset)
      servo_offset ++;
    else
      servo_offset --;
      
    pos_lo = calc_lo(pos_hi, servo_offset);
        
    servo_lo.write(pos_lo);              // tell servo to go to position in variable 'pos' 
    
    delay(servo_delay);
  }
  return(true);
}

boolean move_combined() {
  while (target_hi != pos_hi) {
    if (target_hi != pos_hi)
      if (target_hi > pos_hi)
        pos_hi ++;
      else
        pos_hi --;
      
    pos_lo = calc_lo(pos_hi, servo_offset);
        
    servo_hi.write(pos_hi);              // tell servo to go to position in variable 'pos' 
    servo_lo.write(pos_lo);              // tell servo to go to position in variable 'pos' 
    
    delay(servo_delay);
  }
  target_lo = pos_lo;
  return(true);
}


// combined servo move
// hi servo has leading position
// lo servo follows and adds offset
int calc_lo (int h, int offset) {
  // int l = map(h + offset, 44, 180, 160, 60);
  
  int t = (160 - 60) *  (h - 44) / (180 - 44); 
  int l = 160 - t - offset;
  return(l);
}


// choose a color led, read optical sensor and write to serial
void analog_to_serial(char a, int led) {
  digitalWrite(led, HIGH);   // turn the LED on (HIGH is the voltage level)
  Serial.print(a);                       
  delay(RGB_delay);
  Serial.print(analogRead(analogInPin));      
  digitalWrite(led, LOW);    // turn the LED off by making the voltage LOW
  Serial.print(';');
}  


