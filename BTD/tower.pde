// A subclass of Weapon
class Tower extends Weapon {

  //default constructor
  Tower() {
    speed = 3;
    price = 30;
  }
  
  //overloaded constructor
  Tower(float mX, float mY) {
    this();
    xCor = mX;
    yCor = mY;
  }
  
  //how this subclass attacks
  void atck() {
    shape(tower, xCor, yCor); //shape of tower
    super.atck();
  }
}
