import java.util.*;
import java.io.*;

public class BreathFirstSearchSolver{

  final private int MAX_SIZE = 1000; //limit on maze size
  private char[][] maze;
  private int height, width; //height, width of maze
  public static Queue<Node> queue;


  //initialize constants for map component symbols
  final private char WALL =         '#';
  final private char PATH =         '*';
  final private char THE_EXIT =     '&';
  final private char VISITED =      '.';



  public BreathFirstSearchSolver(String mapName) {
    // init 2D array to represent maze
    maze = new char[MAX_SIZE][MAX_SIZE];
    queue = new LinkedList<Node>();

    try {
      Scanner reader = new Scanner( new File(mapName) );


      int row = 0;

      while( reader.hasNext() ) {

        String line = reader.nextLine();
        System.out.println(line);

        if ( width < line.length() ){
          width = line.length();
        }

        for( int i=0; i<line.length(); i++ ){
          maze[i][row] = line.charAt( i );
        }

        height++;
        row++;
      }

    } catch( Exception e ) {
      System.out.println( "Error reading file" );
    }

  }//end constructor

  public Node getPathBFS(int xStart, int yStart) {

    Node start = new Node(xStart,yStart, null);
    queue.add( start );

    while( !queue.isEmpty() ) {

      Node current = queue.remove();
      int currX = current.getX();
      int currY = current.getY();

      if (maze[currY][currX] == THE_EXIT) {
        return current;
      }
      maze[currY][currX] = VISITED;
      if(maze[currY+1][currX] == PATH || maze[currY+1][currX] == THE_EXIT) {
        Node nextNode = new Node(currY+1, currX, current);
        queue.add(nextNode);
      }

      if(maze[currY-1][currX] == PATH || maze[currY-1][currX] == THE_EXIT) {
        maze[currY][currX] = VISITED;
        Node nextNode = new Node(currY-1, currX, current);
        queue.add(nextNode);
      }

      if(maze[currY][currX+1] == PATH || maze[currY][currX+1] == THE_EXIT) {
        maze[currY][currX] = VISITED;
        Node nextNode = new Node(currY, currX+1, current);
        queue.add(nextNode);
      }

      if(maze[currY][currX-1] == PATH || maze[currY][currX-1] == THE_EXIT) {
        maze[currY][currX] = VISITED;
        Node nextNode = new Node(currY, currX-1, current);
        queue.add(nextNode);
      }
    }
    return null;
  }

  public String toString(){
    String s = "";
    for(int i = 0; i < height; i++){
      for(int j = 0; j < width; j++){
        s += maze[j][i];
        s += " ";
      }
      s += "\n";
    }
    return s;
  }

  public static void main(String[] args) {
    BreathFirstSearchSolver test = new BreathFirstSearchSolver("map.txt");
    System.out.println(test);
    Node p = test.getPathBFS(1,1);
    System.out.println(test);

    while(p.getParent() != null) {
      System.out.println(p);
      p = p.getParent();
    }

  }

}
