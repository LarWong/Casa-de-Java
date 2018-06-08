abstract class Enemy {

  //final vars
  protected final static int ALIVE = 0;
  protected final static int DEAD = 1;

  //instance vars
  protected int state = ALIVE;
  protected color c;
  protected float xCor, yCor;
  protected float speed;
  protected float oSpeed;
  protected int prevDirection = -1; //0 is up, 1 is down, 2 is left, 3 is right
  protected boolean slowed;

  int getState() {
    return state;
  }

  int setState(int newState) {
    int temp = state;
    state = newState;
    return temp;
  }

  float getXCor() {
    return xCor;
  }

  float getYCor() {
    return yCor;
  }

  float getSpeed() {
    return speed;
  }

  float setSpeed(float newSpeed) {
    float temp = speed;
    speed = newSpeed;
    return temp;
  }

  float getOSpeed() {
    return oSpeed;
  }

  boolean getSlowed() {
    return slowed;
  }

  boolean setSlowed(boolean newSlowed) {
    boolean temp = slowed;
    slowed = newSlowed;
    return temp;
  }

  void move() {

    if (state != DEAD) {
      if (checkPath() == 0) {
        if (abs(xCor - (int) (50 * floor((xCor - 75) / 50.0)) - 75) <= 1) {
          xCor = (int) (50 * floor((xCor - 75) / 50.0)) + 75;
          yCor += -speed;
          prevDirection = 1;
        }
      } else if (checkPath() == 1) {
        if (abs(xCor - (int) (50 * floor((xCor - 75) / 50.0)) - 75) <= 1) {
          xCor = (int) (50 * floor((xCor - 75) / 50.0)) + 75;
          yCor += speed;
          prevDirection = 0;
        }
      } else if (checkPath() == 2) {
        if (abs(yCor - (int) (50 * floor((yCor - 75) / 50.0)) - 75) <= 1) {
          yCor = (int) (50 * floor((yCor - 75) / 50.0)) + 75;
          xCor -= speed;
          prevDirection = 3;
        }
      } else if (checkPath() == 3) {
        if (abs(yCor - (int) (50 * floor((yCor - 75) / 50.0)) - 75) <= 1) {
          yCor = (int) (50 * floor((yCor - 75) / 50.0)) + 75;
          xCor += speed;
          prevDirection = 2;
        }
      }

      fill(c);
      ellipse(xCor, yCor, 30, 40);

      //if (xCor < 75 || xCor > 725 - speed) {
      //  speed *= -1;
      //  oSpeed = speed;
      //  yCor += 50;
      //}
      //xCor += speed;
      //if enemy got through user's defenses
      if (xCor >= 725 && yCor >= 425) {
        state = DEAD;
        localPlayer.setHealth(localPlayer.getHealth() - 1);
      }
    }
  }

  void pop() {
    if (c == silver) {
      c = gold;
      oSpeed = speed = 12 * speed;
    } else if (c == gold) {
      c = ice;
      oSpeed = speed = 10 * speed;
    } else if (c == ice) {
      c = rose;
      oSpeed = speed = 8 * speed;
    } else if (c == rose) {
      c = moss;
      oSpeed = speed = 6 * speed;
    } else if (c == wood) {
      c = crimson;
    } else state = DEAD;
  }

  int checkPath() {
    //get the coords of pixel to check
    int[][] directions = {{0, -50}, {0, 50}, {-50, 0}, {50, 0}};
    for (int i = 0; i < directions.length; i++) {
      //get the color of pixel
      color nextTile = get((int) (50 * floor((xCor - 75) / 50.0)) + 75 + directions[i][0], (int) (50 * floor((yCor - 75) / 50.0)) + 75 + directions[i][1]);
      //get the path color
      float greenAspect = green(nextTile);

      //check if path color matches shortest path
      if (greenAspect == 100) {
        if (i != prevDirection)
          return i;
      }
    }
    return -1;
  }
}
