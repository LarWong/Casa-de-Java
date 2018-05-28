PFont font; //font class for Processing
//font must be located in the sketch's "data" directory to load successfully

void setup() {
  size(1000, 500);
  background(15, 15, 15);
  noStroke();
  //creates antialiased font
  //allows vector data to be used
  //should be a .ttf or .otf file
  font = createFont("Ancient", 72, true);
  textFont(font); //sets the current font that will be drawn with text()
  text("Hello World", 350, 250);
}

void draw() {
}
