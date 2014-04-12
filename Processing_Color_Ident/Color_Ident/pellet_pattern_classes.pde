// --------------------------------------------------------------
// pallet pattern
// 2014-03-08
// Processing 2.x
// --------------------------------------------------------------

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
// read XML pellet config file
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


