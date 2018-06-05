class tower extends weapon {

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

  tower() {
    HP = 100;
    size = 40;
    atck = 10;
    speed = 1;
    price = 30;
  }

  tower(float mX, float mY) {
    this();
    xCor = mX;
    yCor = mY;
  }

  void atck() {
    shape(tower, xCor, yCor); //shape of tower
    super.atck();
  }
}
