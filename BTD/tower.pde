abstract class tower {
  protected float cost;
  protected float damage;
  protected float xCor;
  protected float yCor;
  protected PImage img = loadImage("Tower.png");

  ArrayList<projectile> projectiles = new ArrayList<projectile>();

  float getCost() {
    return cost;
  }

  float getDamage() {
    return damage;
  }

  float setXCor(float x) {
    float temp = xCor;
    xCor = x; 
    return temp;
  }

  float setYCor(float y) {
    float temp = yCor;
    yCor = y; 
    return temp;
  }
  
  abstract void run();
}
