// A subclass of Weapon
class TackShooter extends Weapon {

  //default constructor
  TackShooter() {
    speed = 1;
    price = 100;
  }

  //overloaded constructor
  TackShooter(float mX, float mY) {
    this();
    xCor = mX;
    yCor = mY;
  }


  // how this subclass attacks
  void atck() {

    shape(tackshooter, xCor, yCor); //shape of tack shooter
    for (Projectile projectile : projectiles) projectile.move(); //projectiles move

    if (time - lastFiredTime > 4000.0 / speed) { //weapon has certain cooldown
      lastFiredTime = millis();
      //create new projectiles in 6 different directions
      projectiles.add(new Projectile(xCor, yCor, speed));
      projectiles.add(new Projectile(xCor, yCor, -speed, speed));
      projectiles.add(new Projectile(xCor, yCor, -speed, -speed));
      projectiles.add(new Projectile(xCor, yCor, speed, -speed));
      projectiles.add(new Projectile(xCor, yCor, speed, speed));
      projectiles.add(new Projectile(xCor, yCor, -speed));

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
