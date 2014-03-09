// --------------------------------------------------------------
// pallet pattern
// 2014-03-03
// Processing 2.x
// --------------------------------------------------------------

// --------------------------------------------------------------
// pellet config
// --------------------------------------------------------------
final String version_string = "0.83";

// --------------------------------------------------------------
// pellet config
// --------------------------------------------------------------
float pellet_D = 5;
int pellet_nx = 48;
int pellet_ny = 48;

String pellet_info = "";

// --------------------------------------------------------------
// color array & defaults / static for 6 colors
// --------------------------------------------------------------
ArrayList<pellet> pellets;
int max_pellet_id = 0;

// defaults
int transparent_id = 2;

float brightness = 0;
float contrast = 1;

// --------------------------------------------------------------
// Images
// --------------------------------------------------------------

final String image_path = "";
final String image_pellet_extension = "_(test)";

final boolean image_overwrite = false;

String[] image_files = {
  "mona_lisa.jpg",
  "William-Shatner-Captain-Kirk.jpg",
  "nice_tree.jpg",
  "einstein.jpg",
  "spock.jpg",
  "HackFFM_Logo.PNG",
  "cute-cats-cats-8477446-600-600.jpg",
  "oshw_product_page.png",
//  "android_logo_480x480.png",
};

int render_image = 4;
int current_image = render_image;

// --------------------------------------------------------------
// Floyd Steinberg Dithering
// http://en.wikipedia.org/wiki/Floyd%E2%80%93Steinberg_dithering
// --------------------------------------------------------------
// [line_x][line_y][RGB]
//int [][][] FSD = new int[pellet_nx + 1][2][3];
pellet [][] FSD; 

void setup() {
  size (1000, 650);
  background(64);
  
  pellets = new ArrayList<pellet>();
  read_pellet_colors();
  
  // Floyd Steinberg Dithering --> initialize error diffusion array
  FSD = new pellet[pellet_nx + 1][2];
  for (int i = 0; i < (pellet_nx + 1); i ++)
    for (int ii = 0; ii < 2; ii ++)
      FSD[i][ii] = new pellet(0, 0, 0);
    
  render_pellets(image_files[current_image]);
}

// --------------------------------------------------------------

void draw() {
  // if (current_image < 1) {  //image_files.length) {
//
//    current_image ++;
//  }

}


void keyPressed() {
  if ((key >= '0') && (key <= ('6'))) {
    int i = keyCode - 48;
    pellets.get(i).toggle();
  }
  
  switch(keyCode) {
    case UP :
      contrast *= 1.1;
      break;
    case DOWN :
      contrast /= 1.1;
      break;
    case LEFT :
      brightness += 12;
      break;
    case RIGHT :
      brightness -= 12;
      break;
  }

  switch(key) {
    case 'r' :
      brightness = 0;
      contrast = 1;
      break;
    case 'a' :
      for (int i = 0; i <  max_pellet_id; i ++)
        pellets.get(i).enable();
      pellets.get(6).disable();
      break;
    case 'b' :
      for (int i = 0; i <  max_pellet_id; i ++)
        pellets.get(i).disable();
      pellets.get(0).enable();
      pellets.get(5).enable();
      break;
    case 'n' :
      current_image ++;
      if (current_image >= image_files.length)
        current_image = 0;
      break;
  }    
  
  render_pellets(image_files[current_image]);
  display_curve();
}


void display_curve() {
  final int mx = int(2 * pellet_D * (pellet_nx + 10));
  final int my = height / 2 - 128;
  
  noStroke();
  fill(192);
  
  rect (mx, my, 255, 255);
  
  for (float i = 0; i < 256; i ++) {
    float y = 128 + ((i - 128) * contrast) + brightness;
    y = max(0, min(255, y));

    stroke(64);
    point(mx + i, my + 255 - i);

    stroke(255, 0, 0);
    point(mx + i, my + 255 - y);
    point(mx + i, my + 254 - y);
  }
}

void render_pellets(String filename) {
  int[] stat_pellets = new int [max_pellet_id];
  int stat_pellet_sum = 0;
  for (int i = 0; i < max_pellet_id; i ++)
    stat_pellets[i] = 0;
    
  background(64);
  println("Rendering " + filename + " ...");

  noStroke(); fill(255);
  textAlign(LEFT, BOTTOM);

  text("Pellet rendering / Version " + version_string, 8, 16);
  text("Image filename: " + filename, 8, 32);
  text(pellet_nx + " x " + pellet_ny + " = " + pellet_nx * pellet_ny + " pellets", 8, 48);
  
  //text(pellet_info, pellet_D * (pellet_nx + 4), 16);
  
  PImage photo, photo_2;
  
  photo = loadImage(image_path + filename);
  
  photo.resize(pellet_nx, pellet_ny);

  photo_2 = loadImage(image_path + filename);
  photo_2.resize(100, 100);
  //photo_2.resize(int(pellet_nx * pellet_D), int(pellet_ny * pellet_D));
//  image(photo_2,  int(pellet_D), int(pellet_D));
  
  photo.loadPixels();
  
  // Floyd Steinberg Dithering --> reset distortion array
  for (int x = 0; x < (pellet_nx + 1); x ++) {
    FSD[x][0].set_RGB(0, 0, 0);
    FSD[x][1].set_RGB(0, 0, 0);
  } 

  // RGB array for pixel components
  int comp[] = new int [3];
  pellet pixel = new pellet(0, 0, 0);

  for (int y = 0; y < pellet_ny; y ++) {
    int scr_y = height - int(pellet_D * (y + 1));
    
    for (int x = 0; x < pellet_nx; x ++) {
      int scr_x = int(pellet_D * (x + 1));
      
      int pos = (pellet_ny - 1 - y) * pellet_nx + x;
      
      color c = photo.pixels[pos];
      int best_id = 0;

      // --------------------------------------------------------------
      // original pixel color
      // --------------------------------------------------------------

      fill(red(c), green(c), blue(c));
      ellipse (scr_x, scr_y - pellet_D * (pellet_ny + 4), pellet_D, pellet_D);


      // --------------------------------------------------------------
      // best color match
      // --------------------------------------------------------------
      pixel.set_color(c);
      pixel.set_brightness_and_contrast(brightness, contrast);

      best_id = euclidian_color_match(pixel);
      
      fill(pellets.get(best_id).get_color());
      ellipse (scr_x, scr_y, pellet_D, pellet_D);
      stat_pellets[best_id] ++;

      
      // --------------------------------------------------------------
      // Floyd Steinberg Dithering --> fill error diffusion array
      // --------------------------------------------------------------
      pixel.set_color(c);
      pixel.set_brightness_and_contrast(brightness, contrast);
      pixel.add_color(FSD[x][0]);

      best_id = euclidian_color_match(pixel);

      fill(pellets.get(best_id).get_color());
      ellipse (scr_x + pellet_D * (pellet_nx + 10), scr_y, pellet_D, pellet_D);

      // distribute color quantization error to neighbor pixels
      for (int i = 0; i < 3; i ++) {
        float quant_error = pixel.RGB[i] - pellets.get(best_id).RGB[i];
        
        FSD[x + 1][0].RGB[i] += (quant_error * 7) / 16;
        FSD[x + 0][1].RGB[i] += (quant_error * 5) / 16;
        FSD[x + 1][1].RGB[i] += (quant_error * 1) / 16;
        if (x > 0)
          FSD[x - 1][1].RGB[i] += (quant_error * 3) / 16;
      }
    }

    // Floyd Steinberg Dithering --> shift error diffusion array for next line
    for (int x = 0; x < (pellet_nx + 1); x ++) {
      for (int i = 0; i < 3; i ++) 
        FSD[x][0].RGB[i] = FSD[x][1].RGB[i];
      FSD[x][1].set_RGB(0, 0, 0);
    } 
  }

  stat_pellet_sum = 0;
  for (int i = 0; i < max_pellet_id; i ++)
    stat_pellet_sum += stat_pellets[i];
    
  for (int i = 0; i < max_pellet_id; i ++) {
    print(align_right(pellets.get(i).name + " | ", 12));
    print(align_right(stat_pellets[i] + " | ", 12));
    print(align_right(round(100 * stat_pellets[i] / stat_pellet_sum) + " %", 7));
    println();
  }
  println("-----");
  textAlign(RIGHT, BOTTOM);
  fill(255); noStroke();
  for (int i = 0; i < max_pellet_id; i ++) {
    int y2 = 16 * (i + 1);
    text(pellets.get(i).name, width / 2, y2);
    text(stat_pellets[i], width / 2 + 100, y2);
    text(round(100 * stat_pellets[i] / stat_pellet_sum) + " %", width / 2 + 200, y2);
  }
  
  String[] t = splitTokens(filename, ".");
  t[t.length - 2] += image_pellet_extension;
  String screenshot = join(t, ".");
  
  //screenshot = image_path + screenshot;
  screenshot = screenshot;
  if ((image_overwrite) || (!fileExists("rendering_output/" + screenshot))) {
    println("Saving " + screenshot + " ...");
    save("data/rendering_output/" + screenshot);
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


boolean fileExists(String filename) {
  File file = new File(dataPath(filename));

  if(!file.exists())
    return false;
  else 
    return true;
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
    
    pellets.add(new pellet(red, green, blue));
  
    // color display name 
    pellets.get(max_pellet_id).set_name(children[i].getContent());
    
    if (enable == 0)
      pellets.get(max_pellet_id).disable();

    println(id + " " + hex(red)+ " " + hex(green)+ " " + hex(blue) + " / "+ name);
    pellet_info += id + " " + hex(red)+ " " + hex(green)+ " " + hex(blue) + " / "+ name + "\n";
      
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


// output functions
String align_right(String s, int r) {
  while (s.length() < r)
    s = " " + s;
  return(s);
}
