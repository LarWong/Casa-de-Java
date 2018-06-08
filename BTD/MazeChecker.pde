/***
 * ALGORITHM for finding exit from starting position:
 *  Algorithm:
 * 1. Begin at the "start position"
 * 2. For each path space, check all four spaces immediately adjacent to the current space.
 * 3. If one of these surrounding spaces is a "*", update the position to that space
 * 4. Otherwise, if there are no * around, backtrack to the last spot with multiple options to move, similar to the knight's tour.
 * 5. Keep moving until the final position is reached, denoted with a "&"
 ***/
class MazeChecker {
  //constant
  final private int MAX_SIZE = 1000; //limit on maze size
  
  //instance vars
  private char[][] maze;
  private boolean solved;


  //initialize constants for map component symbols
  final private char PATH =         '*';
  final private char THE_EXIT =     '&';
  final private char CURRENT =      '@';
  final private char VISITED_PATH = '.';



  //constructor - reads the txt file into a 2D array
  public MazeChecker(String map) {
    try {
      String[] lines = loadStrings(map);
      maze = new char[lines.length][lines[0].length()];

      for (int r = 0; r < lines.length; r++) {
        for (int c = 0; c < lines[0].length(); c++) {
          maze[r][c] = lines[r].charAt(c);
        }
      }

      solved = false; //default state: no solution
    } 
    catch(Exception e) {
      System.out.println( "Error reading file" );
    }
  }//end constructor

  //uses a Depth First Search approach to determine of the maze is solvable
  void solve( int currX, int currY ) {
    //primary base case
    if ( maze[currX][currY] == THE_EXIT ) {
      solved = true;
    }
    //other base cases
    else if ( maze[currX][currY] == PATH) {
      maze[currX][currY] = CURRENT;

      if ( !solved )//down
        solve( currX, currY-1 );
      if ( !solved )//right
        solve( currX+1, currY );
      if ( !solved )//up
        solve( currX, currY+1 );
      if ( !solved )//left
        solve( currX-1, currY );

      maze[currX][currY] = VISITED_PATH;
    }
    return;
  }

  //wrapper method
  public boolean checkMaze() {
    this.solve(1, 1);
    return solved;
  }
}//end of class DepthFirstChecker
