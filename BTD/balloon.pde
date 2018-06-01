class balloon extends enemy {
  //instance vars

  //default constructor
  balloon() {
    state = ALIVE;
    c = color(150, 0, 0);
    xCor = yCor = 50;
    xVel = 0.5;
    yVel = 0;
    size = 50;
  }
  
  balloon(float mX, float mY) {
    this();
    xCor = mX;
    yCor = mY;
  }
}