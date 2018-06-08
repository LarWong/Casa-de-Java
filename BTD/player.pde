import java.util.ArrayList;

class Player {

  //instance vars
  private ArrayList<Weapon> weapons;
  private int money;
  private int health;
  private int level;

  //default constructor
  Player() {
    weapons = new ArrayList<Weapon>();
    money = 1000;
    health = 100;
    level = 1;
  }

  // Accessors
  String getWeapons() {
    return weapons.toString();
  }

  int getMoney() {
    return money;
  }
  
  int getHealth() {
    return health;
  }

  int getLevel() {
    return level;
  }
  
  // Mutators
  int setMoney(int newMoney) {
    int temp = money;
    money = newMoney;
    return temp;
  }

  int setHealth(int newHealth) {
    int temp = health;
    health = newHealth;
    return temp;
  }


  int setLevel(int newLevel) {
    int temp = level;
    level = newLevel;
    return temp;
  }

  // creates the user's towers
  void play() {

    //tell each weapon to attack
    for (Weapon weapon : weapons) {
      weapon.atck();
    }
  }

  //user creates towers by buying them
  //determines if user can buy and what he/she buys
  void buy(float mX, float mY, float type) {
    if (type == TOWER) {
      Weapon t = new Tower(mX, mY);
      setMoney(getMoney() - t.getPrice()); 
      weapons.add(t);
    } else if (type == FREEZER) {
      Weapon t = new Freezer(mX, mY);
      setMoney(getMoney() - t.getPrice()); 
      weapons.add(t);
    } else if (type == TACKSHOOTER) {
      Weapon t = new TackShooter(mX, mY);
      setMoney(getMoney() - t.getPrice()); 
      weapons.add(t);
    }
  }

}
