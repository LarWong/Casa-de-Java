class tower {

  //============final vars for state=========================

  final static int ALIVE = 0;
  final static int DEAD = 1;
  final static float CHANGE_FACTOR = 0.25; //change in radius

  //=========================================================

  //instance vars (tower stuff info)
  String name;
  int state;
  color c;
  float xCor, yCor;
  float size;

  int existingweaponBalls;
  weapon[] weapons = new weapon[50]; //each ball has weapons

  //default constructor
  tower(float mX, float mY) {
    this.state = ALIVE;
    this.c = color(154, 235, 34);
    this.size = 50;
    this.xCor = this.yCor = this.size;

    existingweaponBalls = 0;
    for (int i = 0; i < 10; i++) {
      weapons[i] = new weapon(0, mX, mY + 20);
      existingweaponBalls++;
    }
    this.xCor = mX;
    this.yCor = mY;
  }

  /*overloaded constructor with mouse coordinates
  tower(int mX, int mY) {
    this();
    this.xCor = mX;
    this.yCor = mY;
  }
  */
  //determines tower stuff activity
  void run() {
    //if collision happens
    collide();

    fill(this.c);
    ellipse(this.xCor, this.yCor, this.size, this.size + 4);

    //tell weapons to move
    for (int ball = 0; ball < existingweaponBalls; ball++) {
      weapons[ball].move();
    }
  }




  //if the tower stuff hits enemy ball, tower stuff shrinks
  void collide() {
    if (this.state != DEAD) { //tower stuff cannot be dead
      for (int other = 0; other < existingEnemyBalls; other++) {
        if (enemies[other].state != DEAD) { //enemy ball cannot be dead

          float distance = pow(this.xCor - enemies[other].xCor, 2) + pow(this.yCor - enemies[other].yCor, 2); //edge of circle to egde of the other circle

          //checks if the radii of the circles are close enough
          if (distance <= CHANGE_FACTOR * pow(this.size + enemies[other].size, 2)) {
            this.size -= 2; //decrease size
            if (this.size <= 0)
              this.state = DEAD; //change state
          }
        }
      }
    }
  }
}
