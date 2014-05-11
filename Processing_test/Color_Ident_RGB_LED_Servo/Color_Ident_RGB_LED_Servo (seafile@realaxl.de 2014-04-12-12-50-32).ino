/*
  Color-Ident
  2013-10-03 @ Arduino 1.0.5
  axl@realaxl.de
*/
 
// RGB LED pins
int ledR = 13;
int ledG = 12;
int ledB = 11;

const int RGB_delay = 33;

// analog read pin
const int analogInPin = A0;  // Analog input pin that the potentiometer is attached to

#include <Servo.h> 
 
Servo myservo;  // create servo object to control a servo 
                // a maximum of eight servo objects can be created 
 
int pos = 0;    // variable to store the servo position 
int servo_dir = 1;

void setup() {                
  // initialize RGB LED
  pinMode(ledR, OUTPUT);     
  pinMode(ledG, OUTPUT);     
  pinMode(ledB, OUTPUT);

  myservo.attach(9);  // attaches the servo on pin 9 to the servo object 

  Serial.begin(9600); 
}

// the loop routine runs over and over again forever:
void loop() {
  digitalWrite(ledR, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(RGB_delay);               // wait for a second
  analog_to_serial('R');
  digitalWrite(ledR, LOW);    // turn the LED off by making the voltage LOW

  digitalWrite(ledG, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(RGB_delay);               // wait for a second
  analog_to_serial('G');
  digitalWrite(ledG, LOW);    // turn the LED off by making the voltage LOW

  digitalWrite(ledB, HIGH);   // turn the LED on (HIGH is the voltage level)
  delay(RGB_delay);               // wait for a second
  analog_to_serial('B');
  digitalWrite(ledB, LOW);    // turn the LED off by making the voltage LOW
  Serial.println();
  
  pos = pos + servo_dir;
  if (pos >= 50)    servo_dir = -1;
  if (pos <= 0)      servo_dir = +1;
  myservo.write(pos);
}

void analog_to_serial(char a) {
  Serial.print(a);                       
  Serial.print(analogRead(analogInPin));      
  Serial.print(';');
}  


