//subclass of Enemy
class Bloon extends Enemy {

  //default constructor
  Bloon() {
    xCor = yCor = 75;
  }

  //overloaded constructor
  Bloon(float mX, float mY, color newColor) {
    xCor = mX;
    yCor = mY;
    c = newColor;
    if (c == silver) {
      //oSpeed = speed = 10;
    } else if (c == gold) {
      //oSpeed = speed = 9;
    } else if (c == ice) {
      //oSpeed = speed = 8;
    } else if (c == rose) {
      //oSpeed = speed = 7;
    } else if (c == wood) {
      //oSpeed = speed = 4;
    } else if (c == moss) {
      //oSpeed = speed = 6;
    } else if (c == sapphire) {
      //oSpeed = speed = 5;
    } else if (c == crimson) {
      //oSpeed = speed = 4;
    }
  }
}
