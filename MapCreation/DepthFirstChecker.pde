/***
 * ALGORITHM for finding exit from starting position:
 *  Algorithm:
 * - Begin at the "start position"
 * - For each path space, check all four spaces immediately adjacent to the current space.
 * - If one of these surrounding spaces is a "*", update the position to that space
 * - Otherwise, if there are no * around, backtrack to the last spot with multiple options to move, similar to the knight's tour.
 * - Keep moving until the final position is reached, denoted with a "&"
 ***/
class DepthFirstChecker {
  final private int MAX_SIZE = 1000; //limit on maze size
  private char[][] maze;
  private boolean solved;


  //initialize constants for map component symbols
  final private int WALL =         '#';
  final private int PATH =         '*';
  final private int THE_EXIT =     '&';
  final private int CURRENT =      '@';
  final private int VISITED_PATH = '.';



  public DepthFirstChecker(String map) {
    try {
      String[] lines = loadStrings(map);
      maze = new char[lines.length][lines[0].length()];

      for (int r = 0; r < lines.length; r++) {
        for (int c = 0; c < lines[0].length(); c++) {
          maze[r][c] = lines[r].charAt(c);
        }
      }

      solved = false;
    } 
    catch(Exception e) {
      System.out.println( "Error reading file" );
    }
  }//end constructor

  void solve( int currX, int currY ) {
    //primary base case
    if ( maze[currX][currY] == THE_EXIT ) {
      solved = true;
    }
    //other base cases
    else if ( maze[currX][currY] == PATH) {
      maze[currX][currY] = CURRENT;

      if ( !solved )
        solve( currX, currY-1 );
      if ( !solved )
        solve( currX+1, currY );
      if ( !solved )
        solve( currX, currY+1 );
      if ( !solved )
        solve( currX-1, currY );

      maze[currX][currY] = VISITED_PATH;
    }
    return;
  }

  public boolean checkMaze() {
    this.solve(1, 1);
    return solved;
  }
}//end of class DepthFirstChecker
