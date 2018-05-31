class minion {

  //============final vars for state=========================

  final static int ALIVE = 0;
  final static int DEAD = 1;
  final static float CHANGE_FACTOR = 0.25; //change in radius

  //=========================================================

  //instance vars (ball info & movement)
  int state;
  color c;
  float xCor, yCor;
  float xVel, yVel;
  float size;

  //constructor with state var
  minion(int stateVar) {
    this.state = stateVar;
    this.c = color(0, 0, 150);
    this.size = 30;
    this.xVel = 0;
    this.yVel = -0.5;
    this.xCor = this.yCor = this.size;
  }

  //overloaded constructor with state var and mouse coordinates
  minion(int stateVar, int mX, int mY) {
    this(stateVar);
    this.xCor = mX;
    this.yCor = mY;
  }

  //determines ball movement
  void move() {
    //each ball checks for collision
    collide();

    //normal movement
    if (this.state == ALIVE) {
      this.xCor += this.xVel;
      this.yCor += this.yVel;
    }

    //the ball is dead, emulate a dead ball
    if (this.state == DEAD) this.size = 0;

    fill(this.c);
    ellipse(this.xCor, this.yCor, this.size, this.size + 4);
  }

  //if the minion ball hits enemy ball, minion ball shrinks
  void collide() {
    if (this.state != DEAD) { //minion ball cannot be dead
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
