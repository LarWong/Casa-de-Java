import java.util.*;
import java.io.*;

/***
 * ALGORITHM for finding shortest path from starting position:
 *  Algorithm:
 * 1. Begin at the "start position" (its coords are put into class Node)
 * 2. Queue it
 * 3. Dequeue and check if it is the exit
 * 4. If it is, return that node. Otherwise, queue all possible path spaces adjacent to it as nodes
 * 5. Repeat step 3-4 until the exit is found or there are not more nodes to queue
 * This essentially turns the maze into a tree and checks each level of that tree. Each queuing process creates a level
 ***/

class PathFinder {
  //constant
  final private int MAX_SIZE = 1000; //limit on maze size
  
  //instance vars
  private char[][] maze;
  private int heightM, widthM; //height, width of maze
  private Queue<Node> queue;
  public Node shortestPath;


  //initialize constants for map component symbols
  final private char WALL =         '#';
  final private char PATH =         '*';
  final private char THE_EXIT =     '&';
  final private char VISITED =      '.';


  //constructor
  public PathFinder(String mazeInput) {
    // init a queue
    queue = new LinkedList<Node>();

    //read the txt into a 2D array
    try {
      String[] lines = loadStrings(mazeInput);
      heightM = lines.length;
      widthM = lines[0].length();
      maze = new char[heightM][widthM];


      for (int textRow = 0; textRow < heightM; textRow++) {
        for (int ch = 0; ch < widthM; ch++) {
          maze[textRow][ch] = lines[textRow].charAt(ch);
        }
      }
    } 
    catch( Exception e ) {
      System.out.println( "Error file" );
    }
  }//end constructor

  //BFS approach to finding the shortest path
  void getPath(int colStart, int rowStart) {

    Node start = new Node(colStart, rowStart, null); //starting position
    queue.add( start );

    //keep the process going until there are no more nodes to queue
    while ( !queue.isEmpty() ) {
      
      //dequeue
      Node current = queue.remove();
      int currX = current.getX();
      int currY = current.getY();

      //check if it is the exit
      if (maze[currX][currY] == THE_EXIT) {
        shortestPath = current;
        return;
      }
      maze[currX][currY] = VISITED;
      
      //queue the node to the right if possible
      if (maze[currX+1][currY] == PATH || maze[currX+1][currY] == THE_EXIT) {
        Node nextNode = new Node(currY, currX+1, current);
        queue.add(nextNode);
      }
      //queue the node to the left if possible
      if (maze[currX-1][currY] == PATH || maze[currX-1][currY] == THE_EXIT) {
        maze[currX][currY] = VISITED;
        Node nextNode = new Node(currY, currX-1, current);
        queue.add(nextNode);
      }
      //queue the node above current if possible
      if (maze[currX][currY+1] == PATH || maze[currX][currY+1] == THE_EXIT) {
        maze[currX][currY] = VISITED;
        Node nextNode = new Node(currY+1, currX, current);
        queue.add(nextNode);
      }
      //queue the node below current if possible
      if (maze[currX][currY-1] == PATH || maze[currX][currY-1] == THE_EXIT) {
        maze[currX][currY] = VISITED;
        Node nextNode = new Node(currY-1, currX, current);
        queue.add(nextNode);
      }
    }
    return;
  }

  //prints out the 2D maze
  String toString() {
    String s = "";
    for (int i = 0; i < heightM; i++) {
      for (int j = 0; j < widthM; j++) {
        s += maze[i][j];
        s += " ";
      }
      s+= "\n";
    }
    return s;
  }
  
  //wrapper method for the main algorithm
  //solves and saves it into a txt
  void solve() {
    //find path
    this.getPath(1, 1);
    //reset grid so solution can be placed into it
    try {
      String[] lines = loadStrings("map.txt");
      maze = new char[heightM][widthM];
      for (int textRow = 0; textRow < heightM; textRow++) {
        for (int ch = 0; ch < widthM; ch++) {
          maze[textRow][ch] = lines[textRow].charAt(ch);
        }
      }
    }
    catch( Exception e ) {
      System.out.println( "Error reading" );
    }

    //modify grid with correct path
    maze[1][1] = '!';
    while (shortestPath.getParent() != null) {
      maze[shortestPath.getX()][shortestPath.getY()] = '!';
      shortestPath = shortestPath.getParent();
    }

    //write into a txt
    try {
      File oldMap = new File("map.txt");
      oldMap.delete(); //delete old map
      PrintWriter map = createWriter("map.txt");
      for (int row = 0; row < heightM; row++) {
        String text = "";
        for (int col = 0; col < widthM; col++) {
          text += maze[row][col];
        }
        map.println(text);
      }
      map.flush();
      map.close();
    } 
    catch(Exception e) {
      System.out.println("cannot save");
    }
  }
}
