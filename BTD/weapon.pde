import java.util.ArrayList;
//Superclass for this game's weapons
abstract class Weapon {

  //final vars
  protected final static int ALIVE = 0;
  protected final static int DEAD = 1;

  //instance vars
  protected float xCor, yCor;
  protected int speed, price;
  protected int lastFiredTime = millis();
  protected ArrayList<Projectile> projectiles = new ArrayList<Projectile>();

  // Accessors
  int getPrice() {
    return price;
  }

  String getProjectiles() {
    return projectiles.toString();
  }

  //default way of attacking enemies
  void atck() {

    for (Projectile projectile : projectiles) projectile.move(); //projectiles move

    if (time - lastFiredTime > 4000.0 / speed) { //weapon has certain cooldown
      lastFiredTime = millis();
      projectiles.add(new Projectile(xCor, yCor - 10, speed)); //create a new projectile
      projectiles.add(new Projectile(xCor, yCor - 10, -speed));

      //remove projectiles that are dead
      int i = 0;
      while (i < projectiles.size()) { //check which projectiles to remove from ArrayList
        if (projectiles.get(i).getState() == DEAD)
          projectiles.remove(i);
        i++;
      }
    }
    int i = 0;
    while (i < enemies.size()) { //remove enemies that are dead
      if (enemies.get(i).getState() == DEAD)
        enemies.remove(i);
      i++;
    }
  }

}
