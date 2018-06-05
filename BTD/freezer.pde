class freezer extends weapon {

  //has these vars inherited from weapon
  //final static int ALIVE = 0;
  //final static int DEAD = 1;
  //int state = ALIVE;
  //int HP;
  //color c;
  //float xCor, yCor;
  //float size;
  //int atck, speed, price;
  //boolean fired;
  //int lastFiredTime = millis();
  //ArrayList<projectile> projectiles;

  freezer() {
    HP = 100;
    size = 40;
    atck = 10;
    speed = 1;
    price = 70;
  }

  freezer(float mX, float mY) {
    this();
    xCor = mX;
    yCor = mY;
  }

  void atck() {
    shape(freezer, xCor, yCor); //shape of tower

    if (time - lastFiredTime > 1200.0 / speed) { //weapon has certain cooldown
      for (enemy enemy : enemies) {
        if (enemy.getState() != DEAD) {

          float distance = pow(this.xCor - enemy.xCor, 2) + pow(this.yCor - enemy.yCor, 2) + 20; //dist btwn projectile & center of enemy



          //checks if dist is close enough
          if (distance <= pow(this.size + enemy.size, 2)) {
            //enemy.setHP(enemy.getHP() - atck);
            //////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////NOT ALWAYS
            if (enemy.getXVel() > 1) {
              enemy.setXVel(enemy.getXVel() - 0.5); //enemy slows down when traveling right
            } else if (enemy.getXVel() < -1) { //enemy slows down when traveling left
              enemy.setXVel(enemy.getXVel() + 0.5);
            }
          } else { //speed returns to normal
            enemy.setXVel(enemy.getOrigXVel());
          }
        }
      }
    }
  }
}
