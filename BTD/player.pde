import java.util.ArrayList;

class player {

  //instance vars
  ArrayList<weapon> weapons;
  int money;

  //default constructor
  player() {
    money = 0;
    weapons = new ArrayList<weapon>();
  }

  //overloaded constructor with name, money
  player(int newMoney) {
    this();
    money = newMoney;
  }

  void buy() {
  }

  void specialPower() {
  }
}
