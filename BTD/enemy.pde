abstract class enemy {

  //final vars
  protected final static int ALIVE = 0;
  protected final static int DEAD = 1;

  //instance vars
  protected PImage img = loadImage("Enemy.png");
  protected int state;
  protected int HP = 100;
  protected color c;
  protected float xCor, yCor;
  protected float xVel, yVel;
  protected float size;

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

  color setColor(color newColor) {
    color temp = c;
    c = newColor;
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

  float getXVel() {
    return xVel;
  }

  float setXVel(float newXVel) {
    float temp = xVel;
    xVel = newXVel;
    return temp;
  }

  float getYVel() {
    return yVel;
  }

  float setYVel(float newYVel) {
    float temp = yVel;
    yVel = newYVel;
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

  void move() {
    if (state != DEAD) {
      xCor += xVel;
      yCor += yVel;
      ellipse(xCor, yCor, size, size);
      //image(img, xCor, yCor, size, size);
      if (xCor < size || xCor > width - size) {
        xVel *= -1;
        yCor += 90;
      }
      if (yCor > height) {
        pop();
        localPlayer.setHealth(localPlayer.getHealth() - 1);
      }
    }
  }
  
  //WE DONT NEED COLLIDE. projectile HAS A COLLIDE METHOD ALREADY
  void collide(){
  }

  void pop() {
    state = DEAD;
  }
}



 
  
  