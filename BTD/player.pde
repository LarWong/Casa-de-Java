import java.util.ArrayList;

class player {

  //instance vars
  ArrayList<weapon> weapons;
  int money;
  int health;
  int level;

  //default constructor
  player() {
    money = 50;
    weapons = new ArrayList<weapon>();
    health = 100;
  }

  //overloaded constructor with money
  player(int newMoney) {
    this();
    money = newMoney;
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

  //for buying weapons
  void buy() {
  }

  void specialPower() {
  }
}
