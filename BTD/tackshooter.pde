class tackshooter extends weapon {

  //has these vars inherited from weapon
  //final static int ALIVE = 0;
  //final static int DEAD = 1;
  //int state = ALIVE;
  //int HP;
  //color c;
  //float xCor, yCor;
  //float size;
  //int atck, speed, price;
  //boolean fired;
  //int lastFiredTime = millis();
  //protected ArrayList<projectile> projectiles = new ArrayList<projectile>();

  tackshooter() {
    HP = 100;
    size = 40;
    atck = 10;
    speed = 2;
    price = 100;
  }

  tackshooter(float mX, float mY) {
    this();
    xCor = mX;
    yCor = mY;
  }
  
  
  void atck() {
    ellipse(xCor, yCor, 20, 50);
    for (projectile projectile : projectiles) projectile.move(); //projectiles move

    if (time - lastFiredTime > 1200.0 / speed) { //weapon has certain cooldown
      lastFiredTime = millis();
      projectiles.add(new projectile(xCor, yCor - 10, speed, atck)); //create a new projectile
      projectiles.add(new projectile(xCor - 10, yCor, speed, speed, atck));
      projectiles.add(new projectile(xCor + 10, yCor, speed, speed, atck));
      projectiles.add(new projectile(xCor, yCor + 10, speed, speed, atck));

      //remove projectiles that are dead
      int i = 0;
      while (i < projectiles.size()) { //check which projectiles to remove from ArrayList
        if (projectiles.get(i).getState() == DEAD)
          projectiles.remove(i);
        i++;
      }
    }
  }
}
