class projectile extends weapon {

  float yVel = 10;


  projectile(float x, float y) {
    setXCor(x);
    setYCor(y);
    setSpeed(10);
    setSize(50);
    setColor(color(200, 0, 0));
    state = ALIVE;
  }

  void move() {
    ellipse(xCor, yCor, size, size);
    if (state == ALIVE){
      yCor -= speed;
    }
    
  }
}
