abstract class enemy {

  //final vars
  protected final static int ALIVE = 0;
  protected final static int DEAD = 1;

  //instance vars
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

  void move() {
  }

  void collide() {
  }

  void pop() {
    state = DEAD;
  }
}
