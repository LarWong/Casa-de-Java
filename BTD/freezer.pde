class Freezer extends Weapon {

  //inherited vars that are used
  //final static int DEAD = 1;
  //float xCor, yCor;
  //int price;
  //int lastFiredTime = millis();

  Freezer() {
    price = 70;
  }

  Freezer(float mX, float mY) {
    this();
    xCor = mX;
    yCor = mY;
  }

  void atck() {
    shape(freezer, xCor, yCor); //shape of freezer

    for (Enemy enemy : enemies) {
      if (enemy.getState() != DEAD) {

        float distance = pow(this.xCor - enemy.getXCor(), 2) + pow(this.yCor - enemy.getYCor(), 2); //dist btwn centers of freezer & of enemy

        //checks if dist is close enough
        if (enemy.getSlowed() == false && distance <= 5000) {
          enemy.setSpeed(0.5 * enemy.getSpeed()); //reduce speed of enemy
          enemy.setSlowed(true);
        }
        else {
          enemy.setSpeed(enemy.getOSpeed()); //enemy speed returns to normal
          enemy.setSlowed(false);
        }
      }
    }
  }
}
