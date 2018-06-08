class Tower extends Weapon {

  //inherited vars that are used
  //final static int DEAD = 1;
  //float xCor, yCor;
  //int speed, price;
  //int lastFiredTime = millis();
  //ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

  Tower() {
    speed = 3;
    price = 30;
  }

  Tower(float mX, float mY) {
    this();
    xCor = mX;
    yCor = mY;
  }

  void atck() {
    shape(tower, xCor, yCor); //shape of tower
    super.atck();
  }
}
