PFont font72; //font class for Processing, must be located in sketch's "data" directory to load successfully
PFont font36;

enemy[] enemies; //list for enemy balloons
int existingEnemyBalls = 0; //initialize # of balloons

user[] users; //list for user's stuff
int existingUserBalls = 0; //initialize # user stuff

int health = 100; //initial HP of user

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

  //instantiate user stuff
  users = new user[50];
  for (int i = 0; i < 10; i++) {
    users[i] = new user(50 * (i + 1), height - 50);
    existingUserBalls++;
  }
}

void draw() {  
  clear(); //creates illusion of animation

  //enemies move
  for (int ball = 0; ball < existingEnemyBalls; ball++) {
    enemies[ball].move();
  }

  //user stuff move
  for (int ball = 0; ball < existingUserBalls; ball++) {
    users[ball].run();
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
  //creates a new GROWING ball upon click
  //enemies[existingEnemyBalls] = new enemy(0, mouseX, mouseY);
  //existingEnemyBalls++;
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
