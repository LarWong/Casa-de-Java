class user {

  //============final vars for state=========================

  final static int MOVING = 0;
  final static int DEAD = 1;
  final static float CHANGE_FACTOR = 0.25; //change in radius
  final static int MAX_RADIUS = 100;

  //=========================================================

  //vars (ball info & movement)
  int state;
  color c;
  float xCor;
  float yCor;
  float xVel;
  float yVel;
  float size;

  //constructor with state var
  user(int stateVar) {
    this.state = stateVar;
    this.c = color(154, 235, 34);
    this.size = 50;
    this.xVel = this.yVel = 0;
    this.xCor = this.yCor = this.size;
  }

  //overloaded constructor with state var and mouse coordinates
  user(int stateVar, int mX, int mY) {
    this(stateVar);
    this.xCor = mX;
    this.yCor = mY;
  }

  //determines ball movement
  void move() {
    //each ball checks for collision
    collide();

    //normal movement
    if (this.state == MOVING) {
      this.xCor += this.xVel;
      this.yCor += this.yVel;
    }

    //the ball is dead, emulate a dead ball
    if (this.state == DEAD) this.size = 0;

    fill(this.c);
    ellipse(this.xCor, this.yCor, this.size, this.size + 4);
  }

  //if the user ball hits enemy ball, user ball shrinks
  void collide() {
    if (this.state != DEAD) { //user ball cannot be dead
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
