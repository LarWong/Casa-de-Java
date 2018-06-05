class LargeTower extends tower {

  LargeTower(float x, float y) {
    cost = 50;
    damage = 10;
    xCor = x;
    yCor = y;
  }

  //determines ball movement
  void run() {
    ellipse(xCor,yCor,50,50);
    projectiles.add(new StrongProjectile(xCor,yCor + 10)); 
    for (projectile projectile : projectiles) {
      projectile.move();
    }
  }
  
  
}