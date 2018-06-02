import java.util.ArrayList;

/***********************************************************************
 fonts for size 36 & 72, respectively
 PFont is font class for Processing
 fonts must be located in sketch's "data" directory to load successfully
 ***********************************************************************/
PFont font24, font72;

//*************colors**************
color crimson = color(220, 20, 60);
color moss = color(173, 223, 173);
color sapphire = color(8, 37, 103);
color rose = color(255, 85, 163);
color ice = color(212, 240, 255);
color gold = color(212, 175, 55);
color silver = color(192);
//*********************************

int time = 0; //stores milliseconds since start of program



boolean displayTitle; //whether to display title, defaults to false
int titleDisplayed; //whether title has been displayed -- 0 is false, any other # is true
int titleStartTime; //time when title appeared
final int TITLE_TIME = 2000; //how long to display title, 2s



//game objects
player localPlayer = new player();
map map = new map();
ArrayList<enemy> enemies; //here lies all enemies



void setup() {

  /******************************************
   different canvas size and renderer options
   must be first thing in setup
   ******************************************/
  //size(1000, 500);
  size(1000, 500, P2D); //faster than default renderer for most tasks, but sacrifices some visual quality for speed

  background(15); //not pure black
  //noStroke(); //disables outlines
  //frameRate(240); //adjust for developer testing


  /******************************
   creates antialiased font
   allows vector data to be used
   should be a .ttf or .otf file
   ******************************/
  font72 = createFont("Ancient.ttf", 72, true); //fancy little font
  font24 = createFont("San Francisco.ttf", 24, true);


  //create 10 enemies
  enemies = new ArrayList<enemy>();
  for (int i = 0; i < 10; i++) {
    enemies.add(new balloon(50 * (i + 1), 50));
  }
}

void draw() {

  clear(); //creates illusion of animation


  if (displayTitle) { //shall I display title?
    textFont(font72); //sets the current font that will be drawn with text()
    text("Balloon Tower Defense", 200, 250);
    if (time - titleStartTime > TITLE_TIME) { //has it been on screen for 2s?
      displayTitle = false; //stop displaying title
    }
  }
  

  //enemies move
  for (enemy enemy : enemies)
    enemy.move();


  //user stuff move
  //for (int ball = 0; ball < existingUserBalls; ball++) {
  //  users[ball].run();
  //}


  //health status
  textFont(font24);
  if (millis() - time >= 10) { //updates every 10ms
    time = millis();
    text("Health:" + localPlayer.getHealth(), 880, 30);
    //println(localPlayer.getHealth()); //prints to console
  }
}

void mouseClicked() {

  //for title displaying
  if (displayTitle == false && titleDisplayed == 0) {
    displayTitle = true;
    titleStartTime = millis();
    titleDisplayed += 1; //this prevents title from being displayed more than once
  }


  //creates a new balloon upon click
  //enemies.add(new balloon(mouseX, mouseY));
}

//requires P3D as renderer
void whenImBored() {
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
