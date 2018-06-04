class SmallTower extends tower {

  SmallTower(float x, float y) {
    cost = 10;
    damage = 10;
    xCor = x;
    yCor = y;
  }

//determines movement of projectiles
  void run() {
    ellipse(xCor,yCor,50,50);
    projectiles.add(new WeakProjectile(xCor,yCor + 10)); 
    for (projectile projectile : projectiles) {
      projectile.move();
    }
  }
  
  
}