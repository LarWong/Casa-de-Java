PFont font; //font class for Processing
//font must be located in the sketch's "data" directory to load successfully

enemy[] enemies;
ally[] allies;
int existingEnemyBalls = 0;
int existingAllyBalls = 0;
int health = 100;

void setup() {
  //size(1000, 500);
  size(1000, 500, P2D); //substantially faster than default renderer for most tasks, but sacrifices some visual quality for speed
  //fullScreen(P2D);

  background(15, 15, 15);
  //noStroke();

  //creates antialiased font
  //allows vector data to be used
  //should be a .ttf or .otf file
  font = createFont("Ancient.ttf", 72, true);
  textFont(font); //sets the current font that will be drawn with text()
  //text("Hello World", 350, 250);
  //text("Woo baby!", width / 2.0, height / 2.0);

  enemies = new enemy[100];
  allies = new ally[100];

  for (int i = 0; i < 1; i++) {
    enemies[i] = new enemy(0);
    existingEnemyBalls++;
  }
  for (int i = 0; i < 1; i++) {
    allies[i] = new ally(0);
    existingAllyBalls++;
  }
}

void draw() {  
  clear();
  for (int ball = 0; ball < existingEnemyBalls; ball++) {
    enemies[ball].move();
  }
  for (int ball = 0; ball < existingAllyBalls; ball++) {
    allies[ball].move();
  }
  //health status
  font = createFont("Ancient.ttf", 36, true);
  textFont(font);
  text("Health: " + health, 800, 40);
}

void mouseClicked() {
  //creates a new GROWING ball upon click
  //enemies[existingEnemyBalls] = new enemy(0, mouseX, mouseY);
  //existingEnemyBalls++;
}

void bored() { //requires P3D as renderer
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