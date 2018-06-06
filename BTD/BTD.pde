import java.util.ArrayList;

/***********************************************************************
 fonts for size 36 & 72, respectively
 PFont is font class for Processing
 fonts must be located in sketch's "data" directory to load successfully
 ***********************************************************************/
PFont font24, font72;

/*************************************************************************************
 shapes used in program
 before a shape is used, must be loaded with loadShape() or created with createShape()
 *************************************************************************************/
PShape tower, freezer, freezerInner, freezerOuter;

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



boolean displayTitle; //whether to display title, defaults to false
int titleDisplayed; //whether title has been displayed -- 0 is false, any other # is true
int titleStartTime; //time when title appeared
final int TITLE_TIME = 2000; //how long to display title, 2s
boolean beginning = true; //whether program is in the beginning



//game objects
player localPlayer = new player();
map map = new map();
ArrayList<enemy> enemies; //here lies all enemies

//instance vars for buying system
final int TOWER = 1;
final int FREEZER = 2;
final int TACKSHOOTER = 3;

//default state is TOWER
int state = TOWER;



//==================================================================================

void setup() {

  /******************************************
   different canvas size and renderer options
   must be first thing in setup
   ******************************************/
  //size(1200, 500);
  size(1200, 500, P2D); //faster than default renderer for most tasks, but sacrifices some visual quality for speed

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

  freezer = createShape(GROUP);
  freezerInner = createShape(ELLIPSE, 0, 0, 20, 20);
  freezerInner.setFill(ice);
  freezerOuter = createShape(ELLIPSE, 0, 0, 40, 40);
  freezerOuter.setFill(sapphire);
  freezer.addChild(freezerOuter);
  freezer.addChild(freezerInner);


  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //creates 10 enemies
  enemies = new ArrayList<enemy>();
  for (int i = 0; i < 10; i++) {
    enemies.add(new bloon(50 * (i + 1), 50));
  }
}

void draw() {

  clear(); //creates illusion of animation

  if (beginning) {
    if (displayTitle) { //shall I display title?
      fill(gold);
      textFont(font72); //sets the current font that will be drawn with text()
      text("Bloon Tower Defense", 320, 270);
      if (time - titleStartTime > TITLE_TIME) { //has it been on screen for 2s?
        beginning = displayTitle = false; //stop displaying title
      }
    }
  } else {


    //side panel for UI
    fill(150);
    rect(1001, 0, 1200, 800);
    fill(256, 0, 0);
    rect(1025, 5, 150, 70); //panel for buying
    fill(0, 256, 0);
    rect(1025, 100, 150, 70);
    fill(0,0,256);
    rect(1025,195,150,70);

    //temp path
    fill(0, 0, 256);
    rect(50, 25, 900, 50);
    rect(50, 115, 900, 50);
    rect(50, 205, 900, 50);
    rect(50, 295, 900, 50);
    rect(50, 385, 900, 50);


    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //enemies move
    for (enemy enemy : enemies)
      enemy.move();


    localPlayer.play();
  }


  //health status
  textFont(font24);
  if (millis() - time >= 10) { //updates every 10ms
    time = millis();
    fill(255);
    text("Health:" + localPlayer.getHealth(), 850, 30);
    text("Money:" + localPlayer.getMoney(), 850, 60);
    text("Buy Tower", 1075, 50);
    text("Buy Freezer", 1075, 150);
    text("Buy Tack Shooter", 1075, 250);
    //println("Health: " + localPlayer.getHealth() + " Money: " + localPlayer.getMoney()); //prints to console
  }
}

void mouseClicked() {

  //for title displaying
  if (displayTitle == false && titleDisplayed == 0) {
    displayTitle = true;
    titleStartTime = millis();
    titleDisplayed += 1; //this prevents title from being displayed more than once
  } else {

    if (mouseX > 1000) {
      if (mouseX > 1025 && mouseY > 5 && mouseY < 75) {
        state = TOWER;
        println("Click a part of the map to buy a TOWER");
      } else if (mouseX > 1025 && mouseY > 100 && mouseY < 170) {
        state = FREEZER;
        println("Click a part of the map to buy a FREEZER");
      }
      else if(mouseX > 1025 && mouseY > 195 && mouseY < 265){
       state = TACKSHOOTER;
       println("Click a part of the map to buy a TACK SHOOTER");
      }
    }
    //creates a new tower upon click if player has enough money
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
      }
      else{
       localPlayer.buy(mouseX, mouseY, state); 
      }
    }


    //creates a new bloon upon click
    //enemies.add(new bloon(mouseX, mouseY));
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
