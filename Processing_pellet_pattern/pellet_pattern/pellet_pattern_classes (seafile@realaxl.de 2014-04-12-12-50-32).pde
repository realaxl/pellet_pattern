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
  
  pellet(int iR, int iG, int iB) {
    RGB[0] = iR;
    RGB[1] = iG;
    RGB[2] = iB;
    
    enabled = true;
//    name = "";
    screen_color = color(RGB[0], RGB[1], RGB[2]);
  }
  
  void set_RGB(int iR, int iG, int iB) {
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
