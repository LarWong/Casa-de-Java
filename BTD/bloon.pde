class bloon extends enemy {
  //inherited instance vars
  //final static int ALIVE = 0;
  //final static int DEAD = 1;
  //int state = ALIVE;
  //int HP = 100;
  //color c;
  //float xCor, yCor;
  //float xVel, yVel;
  //float size;

  //default constructor
  bloon() {
    c = color(crimson); //UPDATE
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    xCor = yCor = 50;
    xVel = 2;
    yVel = 0;
    size = 50;
  }

  bloon(float mX, float mY) {
    this();
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    xCor = mX;
    yCor = mY;
  }
}