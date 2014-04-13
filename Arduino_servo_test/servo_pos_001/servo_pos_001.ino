// Sweep
// by BARRAGAN <http://barraganstudio.com> 
// This example code is in the public domain.


#include <Servo.h> 
 
Servo servo_hi;  // create servo object to control a servo 
Servo servo_lo;  // create servo object to control a servo 
                // a maximum of eight servo objects can be created 
 
int pos_hi = 0;    // variable to store the servo position 
int pos_lo = 0;
int target_hi = 180;
int target_lo = 40;

int target_offset = 20;
int servo_offset = target_offset;

int servo_delay = 15;

// serial command processor
byte inByte = 0;         // incoming serial byte
byte cmd;                // command (1 character)
long val;                // value
byte val_sig = 1;        // signature



void setup() 
{ 
  servo_hi.attach(9);  // attaches the servo on pin 9 to the servo object 
  servo_lo.attach(10);  // attaches the servo on pin 9 to the servo object 

  Serial.begin(9600);
  
  while (move_servo()) {}
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
          case 'h':
            // upper servo
            target_hi = val;
            while (move_servo()) {}
            break;
          case 'l':
            // lower servo
            target_lo = val;
            while (move_servo()) {}
            break;

          case 'c':
            // combined movement
            target_lo = calc_lo(pos_hi, servo_offset);
            while (move_servo()) {}

            target_hi = val;
            move_combined();
            break;

          case 'o':
            // combined movement
            target_lo = calc_lo(pos_hi, servo_offset);
            while (move_servo()) {}

            target_offset = val;
            move_offset();
            break;

          case 'd': // set delay
            servo_delay = val;
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

int calc_lo (int h, int offset) {
  // int l = map(h + offset, 44, 180, 160, 60);
  
  int t = (160 - 60) *  (h - 44) / (180 - 44); 
  int l = 160 - t - offset;
  return(l);
}
