import java.util.ArrayList;

class player {

  //instance vars
  private ArrayList<weapon> weapons;
  private int money;
  private int health;
  private int level;

  //default constructor
  player() {
    weapons = new ArrayList<weapon>();
    money = 50;
    health = 100;
    level = 1;
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    weapons.add(new tower(500, 300));
  }

  String getWeapons() {
    return weapons.toString();
  }

  int getMoney() {
    return money;
  }

  int setMoney(int newMoney) {
    int temp = money;
    money = newMoney;
    return temp;
  }

  int getHealth() {
    return health;
  }

  int setHealth(int newHealth) {
    int temp = health;
    health = newHealth;
    return temp;
  }

  int getLevel() {
    return level;
  }

  int setLevel(int newLevel) {
    int temp = level;
    level = newLevel;
    return temp;
  }

  void play() {

    //tell each weapon to attack
    for (weapon weapon : weapons) {
      weapon.atck();
    }
  }

  void buy(float x, float y) {
    weapon  t = new tower(x, y);
    setMoney(getMoney() - t.getPrice()); 
    weapons.add(t);
  }

  void specialPower() {
  }
}
