class Creature{

   private PImage img;
   Creature(){
     //how to load image
     img = loadImage("Tower.png");
   }
   void appear(){
     // image(PImage, xCor, yCor, width, height)
     image(img, 100, 100, 100, 100);
   }



}
