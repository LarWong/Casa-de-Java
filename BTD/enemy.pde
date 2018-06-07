abstract class enemy {

  //final vars
  protected final static int ALIVE = 0;
  protected final static int DEAD = 1;

  //instance vars
  protected int state = ALIVE;
  protected int HP = 100;
  protected color c;
  protected float xCor, yCor;
  protected float xVel, yVel;
  protected float origXVel;
  protected float size;
  protected int prevDirection;
  //0 = up, 1 = down, 2 = left, 3= right

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

  float getOrigXVel() {
    return origXVel;
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

  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////
  void move() {

    if (state != DEAD) {
      //0 = up, 1 = down, 2 = left, 3= right
      if (checkPath(floor(origXVel), 0) && prevDirection != 2) {
        xCor += origXVel;
        prevDirection = 3;
      } else if (checkPath(floor(-origXVel), 0) && prevDirection != 3) {
        xCor += -origXVel;
        prevDirection = 2;
      } else if (checkPath(0, floor(origXVel)) && prevDirection != 0) {
        yCor += origXVel;
        prevDirection = 1;
      } else if (checkPath(0, floor(-origXVel)) && prevDirection != 1) {
        yCor += -origXVel;
        prevDirection = 0;
      }

      fill(c);
      ellipse(xCor, yCor, 30, 40); //UPDATE THIS LATER TO INCLUDE OTHER SHAPES
      /*
      if (xCor < size || xCor > 800 - size) {
        xVel *= -1;
        origXVel *= -1;
        yCor += 90;
      }
      */
      if (yCor < 450 && yCor > 400 && xCor < 750 && xCor > 700) {
        pop();
      }
    }
  }

  void pop() {
    state = DEAD;
  }

  boolean checkPath(int xAdd, int yAdd) {
    //get the coords of pixle to check
    int checkX = floor(xCor + xAdd);
    int checkY = floor(yCor + yAdd);
    //get the color of pixel
    color nextTile = get(floor(checkX+size), floor(checkY+size));
    //get the path color
    float greenAspect = green(nextTile);

    //check if path color matches shortest path
    if (greenAspect == 100) {
      return true;
    } else {
      return false;
    }
  }
}
