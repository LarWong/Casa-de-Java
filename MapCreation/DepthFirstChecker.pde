/***
 * ALGORITHM for finding exit from starting position:
 *  Algorithm:
 * - Begin at the "start position"
 * - For each path space, check all four spaces immediately adjacent to the current space.
 *   - If one of these surrounding spaces is a "*", update the position to that space
 *   - Otherwise, if there are no * around, backtrack to the last spot with multiple options to move, similar to the knight's tour.
 * - Keep moving until the final position is reached, denoted with a "&"
 ***/
class DepthFirstChecker {
  final private int MAX_SIZE = 1000; //limit on maze size
  private char[][] maze;
  private int height, width; //height, width of maze
  private boolean solved;


  //initialize constants for map component symbols
  final private char CURRENT =      '@';
  final private char PATH =         '*';
  final private char WALL =         '#';
  final private char THE_EXIT =     '&';
  final private char VISITED_PATH = '.';

  public DepthFirstChecker() {
    // init 2D array to represent maze
    maze = new char[MAX_SIZE][MAX_SIZE];
    height = 0;
    width = 0;

    try {
      String[] lines = loadStrings("map.txt");

      for(int textRow = 0; textRow < lines.length; textRow++){
        
        String line = lines[textRow];;
        width = line.length();

        for ( int i=0; i<line.length(); i++ ) {
          maze[i][textRow] = line.charAt( i );
        }

        height++;
      
      }
    }
    catch(Exception e) {
      System.out.println("does not exist");
    }


    //at init time, maze has not been solved:
    solved = false;
  }//end constructor

  public void solve( int currX, int currY ) {
    //primary base case
    if ( maze[currX][currY] == THE_EXIT ) {
      solved = true;
    }
    //other base cases
    else if ( maze[currX][currY] == PATH ) {
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
    //System.out.println(maze[1][1]);
    this.solve(1, 1);
    return solved;
  }
}//end of class DepthFirstChecker

//DEBUGGING
/*
class MazeChecker{
 public static void main( String[] args ){
 //DEBUGGING
 
 DepthFirstChecker test1 = new DepthFirstChecker("map.txt");
 System.out.println(test1.checkMaze());
 
 }
 */
