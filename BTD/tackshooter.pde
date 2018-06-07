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
    shape(tackshooter, xCor, yCor); //shape of tack shooter
    for (projectile projectile : projectiles) projectile.move(); //projectiles move

    if (time - lastFiredTime > 12000.0 / speed) { //weapon has certain cooldown
      lastFiredTime = millis();
      projectiles.add(new projectile(xCor, yCor, speed, atck)); //create a new projectile
      projectiles.add(new projectile(xCor, yCor, -1 * speed, speed, atck));
      projectiles.add(new projectile(xCor, yCor, -1 * speed, -1 * speed, atck));
      projectiles.add(new projectile(xCor, yCor, speed, -1 * speed, atck));
      projectiles.add(new projectile(xCor, yCor, speed, speed, atck));
      projectiles.add(new projectile(xCor, yCor, -1 * speed, atck));

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
