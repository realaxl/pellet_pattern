//
// pellet sorter
// color quantification of RGB measures
//

String CSV_file = "RGB_values.csv";



ArrayList<pellet> pellets;
int max_pellet_id = 0;

void setup () {
  size(1000, 600);
  background (64);
  
  pellets = new ArrayList<pellet>();
  read_pellet_colors();
  
  String lines[] = loadStrings(CSV_file);
  println("there are " + lines.length + " lines");
  for (int i = 0 ; i < lines.length; i++) {
    println(lines[i]);
  }
  
  int x = 0, y = 0;
  int p_width = 50;
  int p_inner = p_width - 1;
  
  textSize(9);
  textAlign(LEFT, CENTER);
  
  for (int i = 0; i < lines.length; i ++) {
    if (lines[i].charAt(0) != '#') {
      String[] q = splitTokens(lines[i], ";");
      float R = int(q[0]) / 4;
      float G = int(q[1]) / 4;
      float B = int(q[2]) / 4;

      stroke(64);
      fill(R, G, B);
      rect(x, y, p_inner, p_inner);
      
      noStroke();
      if (R + G + B < 300)
        fill(255);
      else
        fill(0);
            
      // normalization to max. read value
      float m = max(R, max(G, B));
      
      int qcolor = 0;
      float nR = 0, nG = 0, nB = 0;
      
      if (m == 0) {
        qcolor = 0;
      } else {
        nR = 255 * R / m;
        nG = 255 * G / m;
        nB = 255 * B / m;
      }  
      
      int ty = y + 6;
      int tx = x + 6;
      text("R " + nR, tx , ty);
      text("G " + nG, tx , ty + 10);
      text("B " + nB, tx , ty + 20);
      
      int best_id = 0;
      pellet pixel = new pellet(nR, nG, nB);
      
      best_id = euclidian_color_match(pixel);      

      text(pellets.get(best_id).name, tx , ty + 35);
      
      
      x = x + p_width;
      if (x > width) {
        x = 0;
        y = y + p_width;
      }
    }
  }
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
