import java.util.ArrayList;

/***********************************************************************
 fonts for size 36 & 72, respectively
 PFont is font clsass for Processing
 fonts must be located in sketch's "data" directory to load successfully
 ***********************************************************************/
PFont font24, font72;

/*************************************************************************************
 shapes used in program
 before a shape is used, must be loaded with loadShape() or created with createShape()
 *************************************************************************************/
PShape tower, freezer, freezerInner, freezerOuter, tackshooter, tackshooterCircle, tackshooterLeft, tackshooterRight, tackshooterUp, tackshooterDown;

//*************colors**************
color crimson = color(220, 20, 60);
color sapphire = color(8, 37, 103);
color moss = color(173, 223, 173);
color rose = color(255, 85, 163);
color ice = color(212, 240, 255);
color gold = color(212, 175, 55);
color silver = color(192);
//*********************************

int time = 0; //stores milliseconds since start of run
boolean paused = true; //determines whether gameplay takes place



boolean beginning = true; //whether program is in the beginning

//title display vars
boolean displayTitle; //whether to display title, defaults to false
int titleDisplayed; //whether title has been displayed -- 0 is false, any other # is true
int titleStartTime; //time when title appeared
final int TITLE_TIME = 2000; //how long to display title, 2s

//instructions display vars
boolean displayInstructions = true; //whether to display instrutions, defaults to true
int instructionsDisplayed; //whether instructions has been displayed -- 0 is false, any other # is true



//game objects
player localPlayer = new player();
map map = new map();
ArrayList<enemy> enemies; //here lies all enemies

//vars for buying system
final int TOWER = 1;
final int FREEZER = 2;
final int TACKSHOOTER = 3;

//default weapon state
int weaponState = TOWER;



//==================================================================================

void setup() {

  /******************************************
   different canvas size and renderer options
   must be first thing in setup
   ******************************************/
  //size(1000, 500);
  size(1000, 500, P2D); //faster than default renderer for most tasks, but sacrifices some visual quality for speed

  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  background(15); //not pure black
  //noStroke(); //disables outlines
  //frameRate(240); //for developer testing


  /******************************
   creates antialiased font
   allows vector data to be used
   should be a .ttf or .otf file
   ******************************/
  font72 = createFont("Ancient.ttf", 72, true); //fancy little font
  font24 = createFont("San Francisco.ttf", 24, true);

  /*************
   creates tower
   *************/
  tower = createShape();
  tower.beginShape();
  tower.fill(180);
  tower.vertex(-18, 20);
  tower.vertex(22, 20);
  tower.vertex(22, -20);
  tower.vertex(14, -20);
  tower.vertex(14, -10);
  tower.vertex(6, -10);
  tower.vertex(6, -20);
  tower.vertex(-2, -20);
  tower.vertex(-2, -10);
  tower.vertex(-8, -10);
  tower.vertex(-8, -20);
  tower.vertex(-18, -20);
  tower.endShape(CLOSE);

  /***************
   creates freezer
   ***************/
  freezer = createShape(GROUP);
  freezerInner = createShape(ELLIPSE, 0, 0, 20, 20);
  freezerInner.setFill(ice);
  freezerOuter = createShape(ELLIPSE, 0, 0, 40, 40);
  freezerOuter.setFill(sapphire);
  freezer.addChild(freezerOuter);
  freezer.addChild(freezerInner);

  /*******************
   creates tackshooter
   *******************/
  tackshooter = createShape(GROUP);
  tackshooterLeft = createShape(RECT, -20, -5, 10, 10);
  tackshooterLeft.setFill(rose);
  tackshooterRight = createShape(RECT, 10, -5, 10, 10);
  tackshooterRight.setFill(rose);
  tackshooterUp = createShape(RECT, -5, -20, 10, 10);
  tackshooterUp.setFill(rose);
  tackshooterDown = createShape(RECT, -5, 10, 10, 10);
  tackshooterDown.setFill(rose);
  tackshooterCircle = createShape(ELLIPSE, 0, 0, 30, 30);
  tackshooterCircle.setFill(rose);
  tackshooter.addChild(tackshooterLeft);
  tackshooter.addChild(tackshooterRight);
  tackshooter.addChild(tackshooterUp);
  tackshooter.addChild(tackshooterDown);
  tackshooter.addChild(tackshooterCircle);

  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //creates 20 enemies
  enemies = new ArrayList<enemy>();
  for (int i = 0; i < 20; i++) {
    enemies.add(new bloon(50 * (i + 1), 50));
  }
}

void draw() {

  clear(); //creates illusion of animation

  if (beginning) {

    if (displayInstructions) { //shall I display instructions?

      fill(silver);
      textFont(font24); //sets the current font that will be drawn with text()
      text("How to play", 10, 30);
      text("This is a game", 10, 60);
      if (keyPressed) displayInstructions = false; //stop displaying instructions
    } else if (displayInstructions == false) { //shall I display title?

      fill(gold);
      textFont(font72);
      text("Bloon Tower Defense", 220, 255);
      //has it been on screen for 2s?
      if (time - titleStartTime > TITLE_TIME) beginning = displayTitle = false; //stop displaying title
      time = millis();
    }
  } else {

    //side panel for UI
    fill(150);
    rect(801, 0, 1000, 500);
    shape(tower, 851, 100);
    shape(freezer, 950, 100);
    shape(tackshooter, 851, 150);

    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //temp path
    fill(0, 0, 255);
    rect(50, 25, 700, 50);
    rect(50, 115, 700, 50);
    rect(50, 205, 700, 50);
    rect(50, 295, 700, 50);
    rect(50, 385, 700, 50);


    //if (paused) {
      //////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////
      //enemies move
      for (enemy enemy : enemies)
        enemy.move();


      localPlayer.play();
    //}


    //health status
    textFont(font24);
    if (millis() - time >= 10) { //updates every 10ms
      time = millis();
      fill(255);
      text("Health:" + localPlayer.getHealth(), 840, 30);
      text("Money:" + localPlayer.getMoney(), 840, 60);
      //text("buy tower", 875, 50);
      //text("buy freezer", 875, 150);
      //text("buy tack shooter", 875, 250);
      //println("Health: " + localPlayer.getHealth() + " Money: " + localPlayer.getMoney()); //prints to console
    }
  }
  //println(mouseX + " " + mouseY); location of mouse
}

void mouseClicked() {

  //for title displaying
  if (displayTitle == false && titleDisplayed == 0) {
    displayTitle = true;
    titleDisplayed++; //this prevents title from being displayed more than once
  } else {

    if (mouseX > 800) {
      if (mouseX >= 832 && mouseX <= 872 && mouseY >= 80 && mouseY <= 120) {
        weaponState = TOWER;
        println("place your tower");
      } else if (mouseX >= 930 && mouseX <= 970 && mouseY >= 80 && mouseY <= 120) {
        weaponState = FREEZER;
        println("place your freezer");
      }//////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////
      //////////////////////////////////////////////////////////
      else if (mouseX > 825 && mouseY > 195 && mouseY < 265) {
        weaponState = TACKSHOOTER;
        println("place your tack shooter");
      }
    }

    //creates a new weapon upon click if player has enough money
    //if (localPlayer.getMoney() >= 30) {
    else { 
      //temp variables for the path Y-coordinates
      int a = 25;
      int b = 115;
      int c = 205;
      int d = 295;
      int e = 385;

      //if it's on enemy path
      if ((mouseY > a && mouseY < a + 50) ||
        (mouseY > b && mouseY < b + 50) ||
        (mouseY > c && mouseY < c + 50) ||
        (mouseY > d && mouseY < d + 50) || 
        (mouseY > e && mouseY < e + 50)) {
        println("INVALID PLACEMENT");
      } else {
        localPlayer.buy(mouseX, mouseY, weaponState);
      }
    }


    //creates a new bloon upon click
    //enemies.add(new bloon(mouseX, mouseY));


    paused = false;
  }
}

void keyPressed() {
  if (instructionsDisplayed == 0) {
    titleStartTime = millis(); //start time for displaying title
    instructionsDisplayed++; //this prevents instructions from being displayed more than once
  }
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
