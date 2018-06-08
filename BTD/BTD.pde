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
color wood = color(222, 184, 135);
color rose = color(255, 85, 163);
color ice = color(212, 240, 255);
color gold = color(212, 175, 55);
color silver = color(192);
//*********************************

int time = 0; //stores # of milliseconds since start of run
boolean paused = true; //determines whether battle takes place defaults to false



boolean beginning = true; //whether program is in the beginning, defaults to true
boolean mapCreation; //whether user is in map creation stage, defaults to false

//title display vars
boolean displayTitle = true; //whether to display title, defaults to true
int titleAppeared; //whether title has appeared or not -- 0 is false, any other # is true
int titleStartTime; //time when title appeared
final int TITLE_TIME = 5000; //how long to display title, 5s

//instructions display vars
boolean displayInstructions; //whether to display instrutions, defaults to false
int instructionsAppeared; //whether instructions has been displayed -- 0 is false, any other # is true



//vars for buying system
final int TOWER = 1;
final int FREEZER = 2;
final int TACKSHOOTER = 3;

//default weapon state
int weaponState = TOWER;



//***************game objects***************
Player localPlayer = new Player();

CreateMap world = new CreateMap(500, 800, 50);

//background tiles
Square[][] backgroundPixels;

//enemies
ArrayList<Enemy> enemies = new ArrayList<Enemy>(); //here lies all enemies
int numEnemies = (int) (20 * log(localPlayer.getLevel()) + 5); //# of enemies based on user level, log is in base e
int enemyAppeared; //time since last enemy appeared



void setup() {

  /******************************************
   different canvas size and renderer options
   must be first thing in setup
   ******************************************/
  //size(1000, 500);
  size(1000, 500, P2D); //faster than default renderer for most tasks, but sacrifices some visual quality for speed
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
}

void draw() {

  clear(); //creates illusion of animation
  if(localPlayer.getHealth() == 0){
   println("YOU LOST");
    
  }
  
  
  if (beginning) {

    if (titleAppeared == 0) {
      titleStartTime = millis();
      titleAppeared++;
    }

    if (displayTitle) { //shall I display title?

      fill(gold);
      textFont(font72); //sets the current font that will be drawn with text()
      text("Bloon Tower Defense", 220, 180);
      textFont(font24);
      text("Created by Kevin Wang, Larry Wong, Alvin Ye", 260, 300);
      //has it been on screen for 5s?
      if (time - titleStartTime > TITLE_TIME) displayTitle = false; //stop displaying title
      time = millis();
    } else if (displayTitle == false) { //shall I display instructions?

      fill(silver);
      textFont(font24);
      text("How to play", 10, 30);
      text("First you have to use the map creator to make a custom map for the bloons.", 10,60);
      text("You have a task - to survive against waves of enemy bloons as much as you can.", 10, 90);
      text("Using your allotted money, purchase weapons.", 10, 120);
      text("Popping bloons will earn you money.", 10, 150);
      text("Interact with the icons on the side panel that will appear to purchase, get more info, & upgrade.", 10, 180);
      text("Look at the console for any messages that will appear during the game.", 10, 210);
      text("Good luck!", 10, 240);

      text("Press any key to start.", 10, 270);
      if (keyPressed) {
        beginning = displayInstructions = false; //stop displaying instructions, end beginning
      }
    }
  } else if (!mapCreation) { //map creation process

    //print out instructions
    println("Press the yellow box to clear.");
    println("Press the cyan to submit.");

    //create map
    mapCreation = world.creationProcess();
  } else {

    //side panel for UI
    fill(150);
    rect(801, 0, 1000, 500);
    shape(tower, 851, 100);
    shape(freezer, 950, 100);
    shape(tackshooter, 851, 150);

    //start button
    fill(10, 150, 10);
    rect(801, 450, 199, 50);

    //print path of map in green
    world.printMap();

    //gameplay is taking place
    if (!paused) {

      //spawn the enemies
      createEnemies();

      //enemies move
      for (Enemy enemy : enemies)
        enemy.move();
    }
    localPlayer.play();

    //health status
    textFont(font24);
    if (millis() - time >= 10) { //updates every 10ms
      time = millis();
      fill(255);
      text("Health:" + localPlayer.getHealth(), 840, 30);
      text("Money:" + localPlayer.getMoney(), 840, 60);

      text("Start", 875, 480);

      //println("Health: " + localPlayer.getHealth() + " Money: " + localPlayer.getMoney()); //prints to console
    }
  }
}

void mouseClicked() {

  if (!mapCreation) {
    world.mapClick(mouseX, mouseY);
  } else if (!beginning && mapCreation) {

    if (mouseX > 800) { //the click is within the side panel
      if (mouseX >= 832 && mouseX <= 872 && mouseY >= 80 && mouseY <= 120) {
        weaponState = TOWER;
        println("place your tower");
        println("======Tower======\nAttack Speed: Medium\nCost: 30\nShoots vertical projectiles across the screen");
      } else if (mouseX >= 930 && mouseX <= 970 && mouseY >= 80 && mouseY <= 120) {
        weaponState = FREEZER;
        println("place your freezer");
        println("======Freezer======\nAttack Speed: Infinite\nCost: 70\nSlows down bloons that come near it");
      } else if (mouseX >= 832 && mouseX <= 872 && mouseY >= 130 && mouseY <= 170) {
        weaponState = TACKSHOOTER;
        println("place your tack shooter");
        println("======Tack Shooter======\nAttack Speed: Slow\nCost: 100\nShoots 6 projectiles across the screen");
      } else if (mouseX >= 801 && mouseX <= 1000 && mouseY >= 450 && mouseY <= 500) {
        paused = false;
      }
    } 

    //creates a new weapon upon click if player has enough money
    else { 
      //if it's on enemy path
      if (get(mouseX, mouseY) == color(0,100,0))
        println("INVALID PLACEMENT");
      else {
        if (weaponState == TOWER) {
          if (localPlayer.getMoney() < 30) return;
        } else if (weaponState == FREEZER) {
          if (localPlayer.getMoney() < 70) return;
        } else if (weaponState == TACKSHOOTER) {
          if (localPlayer.getMoney() < 100) return;
        }
        localPlayer.buy(mouseX, mouseY, weaponState);
      }
    }
  }
}

void keyPressed() {
  if (instructionsAppeared == 0) {
    instructionsAppeared++; //this prevents instructions from being displayed more than once
  }
}

void createEnemies() {
  if (numEnemies != 0) {
    if (millis() - enemyAppeared >= 800) {

      int rand = (int) random(20, 24);
      if (rand == 20) enemies.add(new Bloon(75, 75, crimson)); //crimson bloon
      else if (rand == 21) enemies.add(new Bloon(75, 75, sapphire)); //sapphire bloon
      else if (rand == 22) enemies.add(new Bloon(75, 75, moss)); //moss bloon
      else if (rand == 23) enemies.add(new Bloon(75, 75, wood)); //wooden bloon
      enemyAppeared = millis();
      numEnemies--;
    }
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
