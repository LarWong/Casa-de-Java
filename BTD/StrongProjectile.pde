class StrongProjectile extends projectile {



  StrongProjectile(float x, float y) {
    xCor = x;
    yCor = y;
    speed = 5;
    size = 8;
    c = color(400, 0, 0);
    state = ALIVE;
  }



  
}