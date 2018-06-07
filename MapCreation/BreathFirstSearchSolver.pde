import java.util.*;
import java.io.*;

public class BreathFirstSearchSolver {

  final private int MAX_SIZE = 1000; //limit on maze size
  private char[][] maze;
  private int heightM, widthM; //height, width of maze
  private Queue<Node> queue;
  public Node shortestPath;


  //initialize constants for map component symbols
  final private char WALL =         '#';
  final private char PATH =         '*';
  final private char THE_EXIT =     '&';
  final private char VISITED =      '.';



  public BreathFirstSearchSolver(String mazeInput) {
    // init 2D array to represent maze
    //maze = mazeInput;
    queue = new LinkedList<Node>();

    try {


      String[] lines = loadStrings("map.txt");
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

  public void getPath(int colStart, int rowStart) {

    Node start = new Node(colStart, rowStart, null);
    queue.add( start );

    while ( !queue.isEmpty() ) {

      Node current = queue.remove();
      int currX = current.getX();
      int currY = current.getY();

      if (maze[currX][currY] == THE_EXIT) {
        shortestPath = current;
        return;
      }
      maze[currX][currY] = VISITED;
      if (maze[currX+1][currY] == PATH || maze[currX+1][currY] == THE_EXIT) {
        Node nextNode = new Node(currY, currX+1, current);
        queue.add(nextNode);
      }

      if (maze[currX-1][currY] == PATH || maze[currX-1][currY] == THE_EXIT) {
        maze[currX][currY] = VISITED;
        Node nextNode = new Node(currY, currX-1, current);
        queue.add(nextNode);
      }

      if (maze[currX][currY+1] == PATH || maze[currX][currY+1] == THE_EXIT) {
        maze[currX][currY] = VISITED;
        Node nextNode = new Node(currY+1, currX, current);
        queue.add(nextNode);
      }

      if (maze[currX][currY-1] == PATH || maze[currX][currY-1] == THE_EXIT) {
        maze[currX][currY] = VISITED;
        Node nextNode = new Node(currY-1, currX, current);
        queue.add(nextNode);
      }
    }
    return;
  }

  public String toString() {
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

  public void solve(String mapName) {
    //find path
    this.getPath(1, 1);
    //reset grid
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
    //System.out.println(this);

    //write into a txt
    try {
      File oldMap = new File("map.txt");
      oldMap.delete();
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
