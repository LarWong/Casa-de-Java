class enemy {

  //============final vars for state=========================

  final static int ALIVE = 0;
  final static int DEAD = 1;
  final static float CHANGE_FACTOR = 0.25; //change in radius

  //=========================================================

  //vars (ball info & movement)
  int state;
  color c;
  float xCor, yCor;
  float xVel, yVel;
  float size;

  //constructor with state var
  enemy(int stateVar) {
    this.state = stateVar;
    this.xVel = 5;
    this.yVel = 0;
    this.c = color(255, 0, 0);
    this.size = 50;
    this.xCor = this.yCor = this.size;
  }

  //overloaded constructor with state var and mouse coordinates
  enemy(int stateVar, int mX, int mY) {
    this(stateVar);
    this.xCor = mX;
    this.yCor = mY;
  }

  //determines ball movement
  void move() {
    //each ball checks for collision
    collide();

    //if enemy ball does not collide with ally ball
    if (this.state == ALIVE) {
      if (this.xCor > width - this.size || this.xCor < this.size) { //move in a zigzag pattern 
        this.xVel *= -1;
        yCor += 100;
      }
      if (this.yCor > height - this.size) {
        health--; //tower loses health
        this.state = DEAD;
      }

      //normal moving
      this.xCor += this.xVel;
      this.yCor += this.yVel;
    }

    //the ball is dead, emulate a dead ball
    if (this.state == DEAD) this.size = 0;

    fill(this.c);
    ellipse(this.xCor, this.yCor, this.size, this.size + 4);
  }

  //if enemy ball touches ally ball, enemy shrinks
  void collide() {
    if (this.state != DEAD) { //enemy ball cannot be dead
      for (int other = 0; other < existingtowerBalls; other++) {
        if (towers[other].state != DEAD) {

          float distance = pow(this.xCor - towers[other].xCor, 2) + pow(this.yCor - towers[other].yCor, 2); //edge of circle to egde of the other circle

          //checks if the radii of the circles are close enough
          if (distance <= CHANGE_FACTOR * pow(this.size + towers[other].size, 2)) {
            this.size -= 2; //decrease size
            if (this.size <= 0)
              this.state = DEAD; //state change
          }
        }

        for (int otherweapon = 0; otherweapon < towers[other].existingweaponBalls; otherweapon++) {
          if (towers[other].weapons[otherweapon].state != DEAD) {

            float distance = pow(this.xCor - towers[other].weapons[otherweapon].xCor, 2) + pow(this.yCor - towers[other].weapons[otherweapon].yCor, 2); //edge of circle to egde of the other circle

            //checks if the radii of the circles are close enough
            if (distance <= CHANGE_FACTOR * pow(this.size + towers[other].weapons[otherweapon].size, 2)) {
              this.size -= 1; //decrease size
              if (this.size <= 0)
                this.state = DEAD; //state change
            }
          }
        }
      }
    }
  }
}