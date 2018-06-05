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
  private Square[][] maze;
  private int height, width; //height, width of maze
  private boolean solved;


  //initialize constants for map component symbols
  final private int WALL =         0;
  final private int PATH =         1;
  final private int THE_EXIT =     2;
  final private int THE_START =    3;
  final private int VISITED_PATH = 7;



  public DepthFirstChecker(Square[][] mazeInput) {
    // init 2D array to represent maze
    maze = mazeInput;


    /*
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
     */


    //at init time, maze has not been solved:
    solved = false;
  }//end constructor

  void solve( int currX, int currY ) {
    //primary base case
    if ( maze[currX][currY].getState() == THE_EXIT ) {
      solved = true;
    }
    //other base cases
    else if ( maze[currX][currY].getState() == PATH) {
      maze[currX][currY].setState(THE_START);

      if ( !solved )
        solve( currX, currY-1 );
      if ( !solved )
        solve( currX+1, currY );
      if ( !solved )
        solve( currX, currY+1 );
      if ( !solved )
        solve( currX-1, currY );

      maze[currX][currY].setState(VISITED_PATH);
      print(maze[currX][currY].getState());
    }
    return;
  }

  public boolean checkMaze() {
    maze[1][1].setState(PATH);
    this.solve(1, 1);
    maze[1][1].setState(THE_START);
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
