/*
  Color-Ident
  2013-10-03 001 @ Processing 2.0b6 (Windows)
  2013-11-11 003 @ Processing 1.5.1 (Linux)
  2014-03-15 004 - send 'r' to read RGB values
  axl@realaxl.de
*/

// Example by Tom Igoe

import processing.serial.*;

char lf = char(10);    // Linefeed in ASCII
String myString = "";
Serial myPort;  // The serial port

ArrayList<String> RGB_values;

int[] slots = {156, 133, 118, 100, 78, 57};
int slot = 0;

// pellet config
ArrayList<pellet> pellets;
int max_pellet_id = 0;

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
  myString = "";
  
  // initialize RGB values ArrayList
  RGB_values = new ArrayList<String>();

  // initialize pellets and read config file
  pellets = new ArrayList<pellet>();
  read_pellet_colors();
  
  state = 0;
  m = millis();
  
  size(200, 200);
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
      if(state == pos_cmd) {
        cmd[pos_cmd] = "c" + slots[last_RGB];
        slot = slot + 1;
        if (slot >= slots.length)
          slot = 0;
      }
      
      myPort.write(cmd[state]);
      myPort.write(10);
      println("OUT: " + cmd[state]);
      send = 1;
    }
  }
  
  
}


void serialEvent(Serial p) { 
  myString = p.readStringUntil(10); 
    
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
      if (q[2].equals("1")) {
        state++;
      }
    } else {
      state++;
    }
        
    if (state >= cmd.length)
      state = 1;
      
    myString = "";
  }
}


void keyPressed() {
  if (send == 2)
    send = 0;
  if (keyCode == ESC) {
    if (RGB_values.size() > 0) {
      String now_formatted = nf(year(), 4) + "-" + nf(month(), 2) + "-" + nf(day(), 2) + "_" + nf(hour(), 2) + "-" + nf(minute(), 2) + "-" + nf(second(), 2);
      println("now_formatted: " + now_formatted);
      String CSV_file = "../RGB_read_" + now_formatted + ".csv";
      println("CSV_file: " + CSV_file);
  
      // output into debug file
      PrintWriter output;
      output = createWriter(CSV_file);
      for (int i = 0; i < RGB_values.size(); i++)
        output.println(RGB_values.get(i));

      output.flush();  // Writes the remaining data to the file
      output.close();  // Finishes the file
      println("Wrote " + (RGB_values.size() + 1) + " RGB values to CSV file" + CSV_file);
    } else
      println("No RGB values to write to CSV file");
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

/*  
  textSize(20);
  text(int((R * 100) / max_RGB) + "%", 190, 32);
  text(int((G * 100) / max_RGB) + "%", 190, 64);
  text(int((B * 100) / max_RGB) + "%", 190, 96);
*/

  RGB_values.add(new String(R + ";" + G + ";" + B + ";"));
  
  int val = 0;
  
  if ((R > 100) && (R < 700) && (R > G) && (G > B))
    val = 1;
  if ((R > 800) && (G > 800) && (B > 800))
    val = 1;
 
  // normalization to max. read value
  float m = max(50, max(R, max(G, B)));
  
  int qcolor = 0;
  float nR = 0, nG = 0, nB = 0;
  
  if (m > 0) {
    nR = 255 * R / m;
    nG = 255 * G / m;
    nB = 255 * B / m;
  }  

  textSize(20);
  text(int(nR), 190, 32);
  text(int(nG), 190, 64);
  text(int(nB), 190, 96);

 
  int best_id = 0;
  pellet pixel = new pellet(nR, nG, nB);
  
  best_id = euclidian_color_match(pixel);      
 
  text(pellets.get(best_id).name, 190, 128);
  
  return(best_id);
}


int euclidian_color_match(pellet p) {
  float dist = 10000, dist_t;
  int best_id = 0;

  for (int i = 0; i < max_pellet_id; i ++) {
    if (pellets.get(i).enabled) {
      dist_t = p.euclidian_distance(pellets.get(i));
      if (dist_t < dist) {
        best_id = i;
        dist = dist_t;
      }
    }
  }
  return (best_id);
}


