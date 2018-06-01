abstract class weapon {
  
  protected final static int ALIVE = 0;
  protected final static int DEAD = 1;

  //instance vars
  protected int state;
  protected int HP = 100;
  protected color c;
  protected float xCor, yCOr;
  protected float size;
  protected int atck;
  protected int speed;

  void atck(enemy enemy) {
    enemy.HP = 0;
  }

  void upgrade() {
  }
}
