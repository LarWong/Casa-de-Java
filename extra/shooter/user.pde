class user {

  //============final vars for state=========================

  final static int ALIVE = 0;
  final static int DEAD = 1;
  final static float CHANGE_FACTOR = 0.25; //change in radius

  //=========================================================

  //instance vars (user stuff info)
  String name;
  int state;
  color c;
  float xCor, yCor;
  float size;

  int existingMinionBalls;
  minion[] minions = new minion[50]; //each ball has minions

  //default constructor
  user(float mX, float mY) {
    this.state = ALIVE;
    this.c = color(154, 235, 34);
    this.size = 50;
    this.xCor = this.yCor = this.size;

    existingMinionBalls = 0;
    for (int i = 0; i < 10; i++) {
      minions[i] = new minion(0, mX, mY + 20);
      existingMinionBalls++;
    }
    this.xCor = mX;
    this.yCor = mY;
  }

  /*overloaded constructor with mouse coordinates
  user(int mX, int mY) {
    this();
    this.xCor = mX;
    this.yCor = mY;
  }
  */
  //determines user stuff activity
  void run() {
    //if collision happens
    collide();

    fill(this.c);
    ellipse(this.xCor, this.yCor, this.size, this.size + 4);

    //tell minions to move
    for (int ball = 0; ball < existingMinionBalls; ball++) {
      minions[ball].move();
    }
  }




  //if the user stuff hits enemy ball, user stuff shrinks
  void collide() {
    if (this.state != DEAD) { //user stuff cannot be dead
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