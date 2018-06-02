abstract class weapon {

  protected final static int ALIVE = 0;
  protected final static int DEAD = 1;

  //instance vars
  protected int state;
  protected int HP = 100;
  protected color c;
  protected float xCor, yCor;
  protected float size;
  protected int atck;
  protected int speed;
  protected int price;

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

  color getColor() {
    return c;
  }

  color setColor(color newC) {
    int temp = c;
    c = newC;
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

  float getSize() {
    return size;
  }

  float setSize(float newSize) {
    float temp = size;
    size = newSize;
    return temp;
  }

  int getAtck() {
    return atck;
  }

  int setAtck(int newAtck) {
    int temp = atck;
    atck = newAtck;
    return temp;
  }

  int getSpeed() {
    return speed;
  }

  int setSpeed(int newSpeed) {
    int temp = speed;
    speed = newSpeed;
    return temp;
  }

  int getPrice() {
    return price;
  }

  int setPrice(int newPrice) {
    int temp = price;
    price = newPrice;
    return temp;
  }

  void atck(enemy enemy) {
    enemy.setHP(enemy.getHP() - atck);
  }

  void upgrade() {
  }
}
