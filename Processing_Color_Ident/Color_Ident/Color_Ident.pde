/*
  Color-Ident
  2013-10-03 001 @ Processing 2.0b6 (Windows)
  2013-11-11 003 @ Processing 1.5.1 (Linux)
  2014-03-15 004 - send 'r' to read RGB values
  axl@realaxl.de
*/

// Example by Tom Igoe

import processing.serial.*;

int lf = 10;    // Linefeed in ASCII
String myString = null;
Serial myPort;  // The serial port

// output into debug file
PrintWriter output;

void setup() {
  // List all the available serial ports
  println(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.clear();
  // Throw out the first reading, in case we started reading 
  // in the middle of a string from the sender.
  /*myPort.write(byte('r'));
  myPort.write(10);
  myString = myPort.readStringUntil(lf);
  println("INIT: " + myString); */
  myString = null;
  
  state = 0;
  m = millis();
  
  size(200, 200);

  String now_formatted = nf(year(), 4) + "-" + nf(month(), 2) + "-" + nf(day(), 2) + "_" + nf(hour(), 2) + "-" + nf(minute(), 2) + "-" + nf(second(), 2);
  println("now_formatted: " + now_formatted);
  output = createWriter("../RGB_read_" + now_formatted + ".csv");
}

int m = millis();
String [] cmd = {"d5", "c132", "a500", "c84", "w300", "r", "c140", "o0", "w200", "o20", "c140"}; 
final int pos_cmd = 6;   // position for pellet drop
int send = 0;
int state = 0;
int last_RGB = 0;

int read_attempt = 0;

void draw() {
  if ((state == 0) && (millis() - m) > 1000) {
    read_attempt ++;
    println("read attempt ... " + read_attempt);
    myPort.write(cmd[0]);
    myPort.write(10);
    m = millis();
    send = 1;
  } else {
    if (send == 0) {
      if(last_RGB > 0)
        cmd[pos_cmd] = "c150";
      else
        cmd[pos_cmd] = "c100";
        
      myPort.write(cmd[state]);
      myPort.write(10);
      println("OUT: " + cmd[state]);
      send = 1;
    }
  }
}


void serialEvent(Serial p) { 
//  inString = p.readString(); 
    myString = myPort.readStringUntil(lf);
    if ((myString != null) && (myString.charAt(0) == 'k')) {
      myString = trim(myString);
      println("IN : " + myString);

      String[] q = splitTokens(myString, ";");
      if(q[1].equals("r"))
        last_RGB = show_RGB(myString);
        
      // continue or wait?
      /*if (state == 1)
        send = 2;
      else
        send = 0;*/

      send = 0;
      
      if(q[1].equals("a")) {
        println("a found");
        if (q[2].equals("1")) {
          println("1 found");
          state++;
        }
      } else {
        state++;
      }
      
      if (state >= cmd.length)
        state = 1;
    }
}


void keyPressed() {
  if (send == 2)
    send = 0;
  if (keyCode == ESC) {
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
    exit();  // Stops the program
  }
}



int show_RGB(String myString) {
  String[] q = splitTokens(myString, ";");
  int R = 1023 - int(q[2].substring(1));
  int G = 1023 - int(q[3].substring(1));
  int B = 1023 - int(q[4].substring(1));
  
  int max_RGB = max(1, max(R, G, B));
  
  fill(R/4, G/4, B/4);
  noStroke();
  
  rect(0, 0, 200, 200);
  
  if (R + G + B > 1500) fill(0); else fill(255);
  
  textSize(32);
  
  textAlign(CENTER);
  text("R", 20, 32);
  text("G", 20, 64);
  text("B", 20, 96);
  
  textAlign(RIGHT);
  text(R, 110, 32);
  text(G, 110, 64);
  text(B, 110, 96);
  
  textSize(20);
  text(int((R * 100) / max_RGB) + "%", 190, 32);
  text(int((G * 100) / max_RGB) + "%", 190, 64);
  text(int((B * 100) / max_RGB) + "%", 190, 96);
  
  output.println(R + ";" + G + ";" + B + ";");
  
  int val = 0;
  
  if ((R > 100) && (R < 700) && (R > G) && (G > B))
    val = 1;
  if ((R > 800) && (G > 800) && (B > 800))
    val = 1;
 
  
  text(val, 190, 128);
  
  return(val);
}
