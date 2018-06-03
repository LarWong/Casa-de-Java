import java.util.ArrayList;

class player {

  //instance vars
  ArrayList<projectile> projectiles;
  //ArrayList<enemy> enemies;
  ArrayList<tower> towers;

  float money;
  int health;
  int level;
  
  //default constructor
  player() {
    money = 50;
    projectiles = new ArrayList<projectile>();
    towers = new ArrayList<tower>();
    health = 100;
  }

  //overloaded constructor with money
  player(float newMoney) {
    this();
    money = newMoney;
  }

  float getMoney() {
    return money;
  }
  
  ArrayList<tower> getTowers(){
    return towers;
  }

  float setMoney(float newMoney) {
    float temp = money;
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

  //for buying projectiles
  void buy(float x, float y) {
    SmallTower  t = new SmallTower(x,y);
    setMoney(getMoney() - t.getCost()); 
    towers.add(t);
  }
  
  void run(){
    for(tower tower: towers){
      tower.run();
    }
  }
  
  void specialPower() {
  }
}
