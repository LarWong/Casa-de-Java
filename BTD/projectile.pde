class projectile extends weapon {

  float yVel = 10;


  projectile(float x, float y) {
    xCor = x;
    yCor = y;
    speed = 10;
    size = 4;
    c = color(200, 0, 0);
    state = ALIVE;
  }

  void move() {
    fill(c);
    ellipse(xCor, yCor, size, size);
    if (state == ALIVE){
      yCor -= speed;
    }
    if(yCor > height || yCor < 0){
     state = DEAD; 
     size = 0;
    }
    
  }
}
