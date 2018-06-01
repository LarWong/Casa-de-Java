import java.util.ArrayList;

//font for size 36 & 72, respectively
PFont font36, font72; //font class for Processing, must be located in sketch's "data" directory to load successfully

player player = new player();
map map = new map();
ArrayList<enemy> enemies; //for all enemies

int milli = millis(); //time since start of program

void setup() {

  /******************************************
   different canvas size and renderer options
   must be first thing in setup
   ******************************************/
  //size(1000, 500);
  size(1000, 500, P2D); //much faster than default renderer for most tasks, but sacrifices some visual quality for speed

  background(15); //not pure black
  //noStroke(); //disables outlines
  //frameRate(240); //adjust for developer testing

  /******************************
   creates antialiased font
   allows vector data to be used
   should be a .ttf or .otf file
   ******************************/
  font72 = createFont("Ancient.ttf", 72, true);
  font36 = createFont("Ancient.ttf", 36, true);
  textFont(font72); //sets the current font that will be drawn with text()

  //instantiate enemies
  enemies = new ArrayList<enemy>();
  for (int i = 0; i < 10; i++) { //creates 10 enemies
    enemies.add(new balloon(50 * (i + 1), 50));
  }
}

void draw() {
  clear(); //creates illusion of animation
  println(milli);
  if (milli <= 50) {
    text("Balloon Tower Defense", 250, 250);
    milli = second();
  }

  //enemies move
  //for (int ball = 0; ball < existingEnemies; ball++) {
  //  enemies[ball].move();
  //}

  //user stuff move
  //for (int ball = 0; ball < existingUserBalls; ball++) {
  //  users[ball].run();
  //}

  //health status
  //textFont(font36);
  //if (millis() - time >= 100) {
  //  time = millis();
  //text("Health:" + health, 800, 40);
  //  println(health);
  //}
}

void mouseClicked() {
  //creates a new GROWING ball upon click
  //enemies[existingEnemies] = new enemy(0, mouseX, mouseY);
  //existingEnemies++;
}

//requires P3D as renderer
void bored() {
  camera(0.0, 0.0, 200.0, 100.0, 50.0, 0.0, 0.0, 1.0, 0.0);
  rotateX(-PI/6);
  rotateY(PI/3);
  for (int i = 0; i < 256; i+=8) {
    for (int j = 0; j < 256; j+=8) {
      for (int k = 0; k < 256; k+=8) {
        stroke(i, j, k);
        point(i, j, k);
      }
    }
  }
}
