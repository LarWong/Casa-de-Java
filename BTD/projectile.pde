abstract class projectile {

  protected final static int ALIVE = 0;
  protected final static int DEAD = 1;

  //instance vars
  protected int state;
  protected int HP = 100;
  protected color c;
  protected float xCor, yCor;
  protected float size;
  protected int atck;
  protected int speed;

  int getState() {
    return state;
  }

  int setState(int newState) {
    int temp = state;
    state = newState;
    return temp;
  }

  int getHP() {
    return HP;
  }

  int setHP(int newHP) {
    int temp = HP;
    HP = newHP;
    return temp;
  }

  color getColor() {
    return c;
  }

  color setColor(color newC) {
    color temp = c;
    c = newC;
    return temp;
  }

  float getXCor() {
    return xCor;
  }

  float setXCor(float newXCor) {
    float temp = xCor;
    xCor = newXCor;
    return temp;
  }

  float getYCor() {
    return yCor;
  }

  float setYCor(float newYCor) {
    float temp = yCor;
    yCor = newYCor;
    return temp;
  }

  float getSize() {
    return size;
  }

  float setSize(float newSize) {
    float temp = size;
    size = newSize;
    return temp;
  }

  int getAtck() {
    return atck;
  }

  int setAtck(int newAtck) {
    int temp = atck;
    atck = newAtck;
    return temp;
  }

  int getSpeed() {
    return speed;
  }

  int setSpeed(int newSpeed) {
    int temp = speed;
    speed = newSpeed;
    return temp;
  }


  void atck(enemy enemy) {
    enemy.setHP(enemy.getHP() - atck);
  }

  void upgrade() {
  }

  void collide() {
    if (this.state != DEAD) { //projectile ball cannot be dead
      for (enemy enemy : enemies) {
        if (enemy.getState() != DEAD) { //enemy ball cannot be dead

          float distance = pow(this.xCor - enemy.getXCor(), 2) + pow(this.yCor - enemy.getYCor(), 2); //edge of circle to egde of the other circle

          //checks if the radii of the circles are close enough
          if (distance <= 0.25 * pow(size + enemy.getSize(), 2)) {
            state = DEAD; //change state

            enemy.setSize(enemy.getSize() - 5); //decrease size of enemy that is hit

            if (enemy.getSize() == 0) {
              enemy.setState(DEAD);
            }
          }
        }
      }
    }
  }


  void move() {

    collide();

    ellipse(xCor, yCor, size, size);
    if (state == ALIVE) {
      yCor -= speed;
    }
    if (yCor > height || yCor < 0) {
      state = DEAD; 
      size = 0;
    }
  }
}