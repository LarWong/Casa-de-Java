PFont font72; //font class for Processing, must be located in sketch's "data" directory to load successfully
PFont font36;

enemy[] enemies; //list for enemy balloons
int existingEnemyBalls = 0; //initialize # of balloons

tower[] towers; //list for tower's stuff
int existingtowerBalls = 0; //initialize # tower stuff

int health = 100; //initial HP of tower

//int time = millis(); //time since start of program

void setup() {
  /**********************************
   different canvas size and renderer
   must be first thing in setup
   **********************************/
  //size(1000, 500);
  size(1000, 500, P2D); //much faster than default renderer for most tasks, but sacrifices some visual quality for speed

  background(15, 15, 15);

  noStroke();
  frameRate(240); //adjust for developer testing

  /******************************
   creates antialiased font
   allows vector data to be used
   should be a .ttf or .otf file
   ******************************/
  font72 = createFont("Ancient.ttf", 72, true);
  font36 = createFont("Ancient.ttf", 36, true);
  textFont(font72); //sets the current font that will be drawn with text()
  //text("Hello World", 350, 250);
  //text("Woo baby!", width / 2.0, height / 2.0);

  //instantiate enemies
  enemies = new enemy[50];
  for (int i = 0; i < 10; i++) {
    enemies[i] = new enemy(0, 50 * (i + 1), 50);
    existingEnemyBalls++;
  }

  //instantiate tower stuff
  towers = new tower[50];
  for (int i = 0; i < 10; i++) {
    towers[i] = new tower(50 * (i + 1), height - 50);
    existingtowerBalls++;
  }
}

void draw() {  
  clear(); //creates illusion of animation
  
  color c = color(150,150, 150);
  for (int y = 25; y < height; y += 100 ) {
    for ( int j = y; j < y + 50; j++) {
      for (int x = 0; x < width; x++) {
        set(x, j, c);
      }
    }
  }


  //enemies move
  for (int ball = 0; ball < existingEnemyBalls; ball++) {
    enemies[ball].move();
  }

  //tower stuff move
  for (int ball = 0; ball < existingtowerBalls; ball++) {
    towers[ball].run();
  }

  //health status
  textFont(font36);
  //if (millis() - time >= 100) {
  //  time = millis();
  text("Health:" + health, 800, 40);
  //  println(health);
  //}
}

void mouseClicked() {
  towers[existingtowerBalls] = new tower(mouseX, mouseY);
  existingtowerBalls++;
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
