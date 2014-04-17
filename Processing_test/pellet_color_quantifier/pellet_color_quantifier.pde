//
// pellet sorter
// color quantification of RGB measures
// 2014-04-13
//

String CSV_file = "RGB_values.csv";

// pellet config from XML
ArrayList<pellet> pellets;
int max_pellet_id = 0;

// statistics
pellet[] stats; 


void setup () {
  size(1000, 640);
  background (64);

  pellets = new ArrayList<pellet>();
  read_pellet_colors();

  String lines[] = loadStrings(CSV_file);
  println();
  println();
  println("CSV file: Read " + lines.length + " lines (some may be # comments)");
  /*for (int i = 0 ; i < lines.length; i++)
   println(lines[i]);*/

  stats = new pellet[pellets.size()];

  for (int i = 0 ; i < stats.length; i++) {
    stats[i] = new pellet(0, 0, 0);
    stats[i].id = 0;
  }

  // OpenSCAD export file
  String scad[] = loadStrings("3D_diagram_template.scad");
  int scad_custom = scad.length;


  int x = 0, y = 0;
  int p_width = 48;
  int p_inner = p_width - 1;

  textSize(9);
  textAlign(LEFT, CENTER);

  for (int i = 0; i < lines.length; i ++) {
    if (lines[i].charAt(0) != '#') {
      // values received are ';'-separated and in range 0 ... 1024 (10 bit)
      String[] q = splitTokens(lines[i], ";");
      float R = int(q[0]) / 4;
      float G = int(q[1]) / 4;
      float B = int(q[2]) / 4;

      // draw rectangle
      stroke(64);
      fill(R, G, B);
      rect(x, y, p_inner, p_inner);


      // normalization to max. read value
      float m = max(10, max(R, max(G, B)));

      int qcolor = 0;
      float nR = 0, nG = 0, nB = 0;

      if (m == 0) {
        qcolor = 0;
      } 
      else {
        nR = 255 * R / m;
        nG = 255 * G / m;
        nB = 255 * B / m;
      }  

      // text (black or white)
      noStroke();
      if (R + G + B < 300)
        fill(255);
      else
        fill(0);

      int ty = y + 5;
      int tx = x + 3;
      text("R " + int(R), tx, ty);
      text("G " + int(G), tx, ty + 10);
      text("B " + int(B), tx, ty + 20);

      int best_id = 0;
      pellet pixel = new pellet(R, G, B);

      best_id = euclidian_color_match(pixel);      

      text(pellets.get(best_id).name, tx, ty + 35);

      fill(pellets.get(best_id).get_color());
      rect(x + p_inner - 12, y + 1, 12, p_inner - 2);


      // OpenSCAD export file
      color t_color = color(R, G, B);

      // RGB color space
      String scad_accu = "dot(" + scad_tuple_int(R, G, B) + ", ";
      // HSV color space
      // String scad_accu = "dot(" + scad_tuple_int(hue(t_color), saturation(t_color), brightness(t_color)) + ", ";

      scad_accu += "[" + scad_tuple_color(pellets.get(best_id).RGB[0], pellets.get(best_id).RGB[1], pellets.get(best_id).RGB[2]) + "]);";
      scad_accu += " // " + i + " (" + pellets.get(best_id).name + ")"; 

      // add a new element to the array
      if(best_id < 6) {
        scad = expand (scad, scad.length + 1);
        scad[scad.length - 1] = scad_accu;
      }

      // collect statistics
      stats[best_id].id ++; // id is hijacked as counter
      stats[best_id].RGB[0] += R; // sum red
      stats[best_id].RGB[1] += G; // sum red
      stats[best_id].RGB[2] += B; // sum red


      // get next coordinates
      x = x + p_width;
      if (x > width) {
        x = 0;
        y = y + p_width;
      }
    } else {
      // OpenSCAD export file - comment, only
      scad = expand (scad, scad.length + 1);
      scad[scad.length - 1] = "// " + lines[i];
    }
  }


  // statistics
  println();
  println();
  println("# STATISTICS");

  int max_name_len = pellets.get(0).name.length();
  for (int i = 1; i < pellets.size(); i ++)
    max_name_len = max(max_name_len, pellets.get(i).name.length());
  max_name_len += 2;

  for (int i = 0; i < pellets.size(); i ++) {
    print(align_right(pellets.get(i).name, max_name_len));
    print(align_right(stats[i].id + "", 8));
    if (stats[i].id > 0) {
      int sR = int(stats[i].RGB[0] / stats[i].id);
      int sG = int(stats[i].RGB[1] / stats[i].id);
      int sB = int(stats[i].RGB[2] / stats[i].id);
      
      print(align_right(sR + "", 8));
      print(align_right(sG + "", 8));
      print(align_right(sB + "", 8));
      
      // OpenSCAD export file - write marker pos
      scad = expand (scad, scad.length + 1);
      scad[scad.length - 1] = "marker(" + scad_tuple_int((float) sR,  (float) sG, (float) sB) + "); // " + pellets.get(i).name;
    }
    println();
  }


  // DISTANCES
  println();
  println();
  println("# DISTANCES");
  
  float min_distance = sqrt(3 * sq(255)); // theoretical max. distance
  /// headline
  print(align_right("", max_name_len));
  for (int i = 0; i < pellets.size(); i ++)
    print(align_right(pellets.get(i).name, max_name_len));
  println();

  for (int iy = 0; iy < pellets.size(); iy ++) {
    print(align_right(pellets.get(iy).name, max_name_len));
    for (int ix = 0; ix < pellets.size(); ix ++) {
      float d = pellets.get(ix).euclidian_distance(pellets.get(iy));
      print(align_right(int(d) + "", max_name_len));
      
      if (ix != iy)
        min_distance = min(min_distance, d);
    }
    println();
  }
  println();
  println("Minimal distance of markers: " + nf(min_distance, 1, 3));
  println("Quantification radius (proposal): " + nf(int((min_distance - 2) / 2), 1));
  
  // OpenSCAD - write to export file
  saveStrings("data/3D_diagram.scad", scad);
}


String align_right(String s, int a) {
  s += ";";
  while (s.length () < a)
    s = " " + s;
  return(s);
}

// OpenSCAD export file - nicer number formats
String scad_tuple_int(float f1, float f2, float f3) {
  return(int_nfp(f1) + ", " + int_nfp(f2) + ", " + int_nfp(f3));
}

// scale colors down to range 0 ... 1 (OpenSCAD)
String scad_tuple_color(float f1, float f2, float f3) {
  return(dot_nfp(f1 / 255) + ", " + dot_nfp(f2 / 255) + ", " + dot_nfp(f3 / 255));
}

String dot_nfp(float f) {
  return(nfp(f, 1, 3).replaceAll(",", "."));
}

String int_nfp(float f) {
  return(nfp(int(f), 3));
}


// closest distance to color
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






// --------------------------------------------------------------
// pellet class
// --------------------------------------------------------------

class pellet {
  int id;
  boolean enabled;
  float[] RGB = new float[3];

  String name;
  color screen_color;
  char symbol;

  pellet(float iR, float iG, float iB) {
    RGB[0] = iR;
    RGB[1] = iG;
    RGB[2] = iB;

    enabled = true;
    //    name = "";
    screen_color = color(RGB[0], RGB[1], RGB[2]);
  }

  void set_RGB(float iR, float iG, float iB) {
    RGB[0] = iR;
    RGB[1] = iG;
    RGB[2] = iB;
  }

  void set_color(color col) {
    RGB[0] = red(col);
    RGB[1] = green(col);
    RGB[2] = blue(col);
  }

  void set_name(String iname) {
    name = iname;
  }

  void set_symbol(char c) {
    symbol = c;
  }

  void set_brightness_and_contrast(float brightness, float contrast) {
    for (int i = 0; i < 3; i ++) {
      RGB[i] = 128 + ((RGB[i] - 128) * contrast) + brightness;
    }
  }

  float euclidian_distance(pellet p) {
    float dist = sqrt(sq(RGB[0] - p.RGB[0]) + sq(RGB[1] - p.RGB[1]) + sq(RGB[2] - p.RGB[2]));
    return(dist);
  }

  color get_color() {
    color c;
    //c = color (max(0, min(255, int(RGB[0]))), max(0, min(255, int(RGB[1]))), max(0, min(255, int(RGB[2]))));
    c = color (RGB[0], RGB[1], RGB[2]);
    return(c);
  }

  // add color components of another pellet
  void add_color(pellet p) {
    for (int i = 0; i < 3; i ++)
      RGB[i] += p.RGB[i];
  }

  void enable() {
    enabled = true;
  } 

  void disable() {
    enabled = false;
  } 

  void toggle() {
    enabled = !enabled;
  }
}







// --------------------------------------------------------------
// read XML config file
// --------------------------------------------------------------

void read_pellet_colors() {
  XML xml;
  xml = loadXML("pellet_colors.xml");

  XML[] palette = xml.getChildren("palette");
  String palette_name = palette[0].getContent();
  println(palette_name);

  XML[] children = xml.getChildren("pellet");

  for (int i = 0; i < children.length; i++) {
    int enable  = get_pellet_byte(children[i].getString("enable"));
    int id      = get_pellet_byte(children[i].getString("id"));
    int red     = get_pellet_byte(children[i].getString("red"));
    int green   = get_pellet_byte(children[i].getString("green"));
    int blue    = get_pellet_byte(children[i].getString("blue"));
    String name = children[i].getContent();
    char symbol = children[i].getString("symbol").charAt(0);

    pellets.add(new pellet(red, green, blue));

    // color display name 
    pellets.get(max_pellet_id).set_name(name);
    pellets.get(max_pellet_id).set_symbol(symbol);

    if (enable == 0)
      pellets.get(max_pellet_id).disable();

    println(id + " " + hex(red)+ " " + hex(green)+ " " + hex(blue) + " / "+ name + "(" + symbol + ")");

    max_pellet_id ++;
  }
}


// get XML parameter --> 1 unsigned byte, supports $xx hex format
int get_pellet_byte(String s) {
  int i = 0;

  if (s.length() > 0) {
    if (s.charAt(0) == '$')
      i = unhex(s.substring(1));
    else
      i = int(s);

    i = min(255, i);
    i = max(0, i);
  }    
  return (i);
}

