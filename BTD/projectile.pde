class Projectile {

  private final static int ALIVE = 0;
  private final static int DEAD = 1;

  //instance vars
  private int state = ALIVE;
  private color c = color(255);
  private float xCor, yCor;
  private float xVel, yVel;
  private float size = 10;

  //overloaded constructor
  Projectile(float mX, float mY, float newYVel) {
    xCor = mX;
    yCor = mY;
    yVel = 25 * newYVel;
  }

  //overloaded constructor for projectiles that don't vertically
  Projectile(float mX, float mY, float newXVel, float newYVel) {
    this(mX, mY, newYVel);
    xVel = 25 * newXVel;
  }


  int getState() {
    return state;
  }

  void move() {

    collide(); //check for collision with enemy
    if (state != DEAD) {
      fill(c);
      triangle(xCor - size / 2.0, yCor, xCor + size / 2.0, yCor, xCor + size / 4.0, yCor - size);
      xCor += xVel;
      yCor += yVel;
    }
  }

  void collide() {

    if (state != DEAD) { //only projectiles that have not hit an enemy
      for (Enemy enemy : enemies) {
        if (enemy.getState() != DEAD) {

          float distance = pow(this.xCor - enemy.xCor, 2) + pow(this.yCor - enemy.yCor, 2); //dist btwn projectile & center of enemy

          //checks if dist is close enough
          if (distance <= 0.15 * pow(this.size + 50, 2)) {
            this.state = DEAD; //projectile is gone 
            enemy.pop(); //behavior of enemy upon hit
            localPlayer.setMoney(localPlayer.getMoney() + 2); //player gets money
          }
        }
      }
    }
  }
}
