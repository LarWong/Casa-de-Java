import java.util.*;
import java.io.*;

CreateMap world;
Queue<String> queue;


void setup() {
  size(1200, 500);
  /*
  world = new CreateMap(100, 400, 25);
  Node test = new Node(1,2,null);
  */

}

void draw() {
  String[] lines = loadStrings("map.txt");
  world.creationProcess();
}


void mousePressed() {
  world.mapClick(mouseX,mouseY);
}
/*
  public static void main(String[] args) {
    
    BreathFirstSearchSolver test = new BreathFirstSearchSolver();
    
    System.out.println(test);
    //test.getPath(1, 1);
    test.solve("map.txt");
    System.out.println(test);
    
  }
  */
