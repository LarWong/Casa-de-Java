class ally {

  //============final vars=========================

  final static int MOVING = 0;
  final static int DEAD = 1;
  final static float CHANGE_FACTOR = 0.25; //change in radius
  final static int MAX_RADIUS = 100;

  //===============================================

  //vars (ball info & movement)
  int state;
  color c;
  float xCor;
  float yCor;
  float xVel;
  float yVel;
  float size;

  //constructor with state var

  ally(int sVar) {
    this.state = sVar;
    this.xVel = 0;
    this.yVel = 0;
    this.c = color(random(0, 256), random(0, 256), random(0, 256));
    this.size = 50;//random(5, 50);
    this.xCor = random(width / 2.0 + this.size, width - this.size);
    this.yCor = random(this.size, height - this.size);
  }

  //overloaded constructor with state var and mouse coordinates

  ally(int sVar, int mX, int mY) {
    this(sVar);
    this.xCor = mX;
    this.yCor = mY;
  }

  //determines what the ball does
  void move() {
    //each ball checks for collision
    collide();

    //if the ball does not collide with growing/shrinking ball
    if (this.state == MOVING) {
      //law of reflection
      if (this.xCor > width - this.size || this.xCor < this.size) this.xVel = -this.xVel;
      if (this.yCor > height - this.size || this.yCor < this.size) this.yVel = -this.yVel;
      //normal moving
      this.xCor += this.xVel;
      this.yCor += this.yVel;
    }

    //the ball is dead
    if (this.state == DEAD)
      this.size = 0; //emulates a dead ball

    fill(this.c);
    ellipse(this.xCor, this.yCor, this.size, this.size);
  }

  //if the ally ball hits enemy ball, ally ball shrinks
  void collide() {
    //ally ball cannot be dead
    if (this.state == MOVING) {
      for (int other = 0; other < existingEnemyBalls; other++) {
        if (enemies[other].state != DEAD) {
          //from edge of circle to egde of the other circles
          float distance = pow(this.xCor - enemies[other].xCor, 2) + pow(this.yCor - enemies[other].yCor, 2);
          //checks if the radii of the circles are close enough
          if (distance <= CHANGE_FACTOR * pow(this.size + enemies[other].size, 2)) {
            this.size -= 2;
            if (this.size <= 0)
              this.state = DEAD; //change state
          }
        }
      }
    }
  }
}