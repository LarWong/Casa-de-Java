class projectile {

  private final static int ALIVE = 0;
  private final static int DEAD = 1;
  private final static int INJURED = 2;
  private final static int VERYINJURED = 3;

  //instance vars
  private int state = ALIVE;
  private color c = color(255);
  private float xCor, yCor;
  private float xVel, yVel;
  private float size = 10;
  private int atck;

  projectile(float mX, float mY, float newYSpeed, int newAtck) {
    xCor = mX;
    yCor = mY;
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    xVel = 0;
    yVel = -10 * newYSpeed;
    atck = newAtck;
  }

  //constructor used for projectiles that don't only move up and down
  projectile(float mX, float mY, float newXSpeed, float newYSpeed, int newAtck) {
    xCor = mX;
    yCor = mY;
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    xVel = -10 * newXSpeed;
    yVel = -10 * newYSpeed;
    atck = newAtck;
  }


  int getState() {
    return state;
  }

  int getColor() {
    return c;
  }

  float getXCor() {
    return xCor;
  }

  float getYCor() {
    return yCor;
  }

  float getXVel() {
    return xVel;
  }

  float getYVel() {
    return yVel;
  }

  float getSize() {
    return size;
  }

  float getAtck() {
    return atck;
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
      for (enemy enemy : enemies) {
        if (enemy.getState() != DEAD) {

          float distance = pow(this.xCor - enemy.xCor, 2) + pow(this.yCor - enemy.yCor, 2); //dist btwn projectile & center of enemy

          //checks if dist is close enough
          if (distance <= 0.15 * pow(this.size + enemy.size, 2)) {
            this.state = DEAD; //projectile is gone

            if (enemy instanceof bloon) { 
              enemy.pop(); //enemy is dead
            }

            if (enemy instanceof woodenbloon) {
              if (enemy.getState() == INJURED) { 
                enemy.setColor(crimson);
              } 
              else if (enemy.getState() == VERYINJURED) {
                enemy.setState(DEAD);
              } 
              else { //otherwise, the enemy is ALIVE
                enemy.setState(INJURED);
                enemy.setColor(sapphire);
                if(enemy.getXVel() < 0){
                enemy.setXVel(enemy.getXVel() - 1.5);
                }
                else{
                  enemy.setXVel(enemy.getXVel() + 1.5);
                }
              }
            }

            localPlayer.setMoney(localPlayer.getMoney() + 1); //player gets money
          }
        }
      }
    }
  }
}
