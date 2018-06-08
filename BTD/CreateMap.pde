// main class for creating the map
class CreateMap {

  //instance vars
  private int boxsize, cols, rows;
  private Square[][] grid;
  boolean creationDone; //is the map completed?

  //constructor
  CreateMap(int worldsizeY, int worldsizeX, int squaresize) {
    boxsize = squaresize;
    boolean creationDone = false; //default: map is incomplete

    rows = (worldsizeY/boxsize);
    cols = (worldsizeX/boxsize);
    grid = new Square[rows][cols];

    //create square for the user to click
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        grid[row][col] = new Square(row, col, rows, cols, squaresize);
      }
    }
  }//end constructor

  //make the squares to appear, determines if map is done or not
  boolean creationProcess() {
    if (!creationDone) { 
      for (int i=0; i<rows; i++) {
        for (int j=0; j<cols; j++) {
          grid[i][j].appear(i, j);
        }
      }
    } else {
      printMap(); // colors the background
      return creationDone;
    }
    return creationDone;
  }

  // writes the map that the user created into a txt
  void saveMap() {
    PrintWriter map = createWriter("map.txt");
    for (int i=0; i<rows; i++) {
      String text = "";
      for (int j=0; j<cols; j++) {
        int currSquare = grid[i][j].getState();
        //symbols correspond to the colors of the grid
        /***************
         * - path
         & - the exit
         # - walls
         ***************/
        if (currSquare == 1 || currSquare == 3) {
          text += "*";
        } else if (currSquare == 2) {
          text += "&";
        } else {
          text += "#";
        }
      }
      map.println(text);
    }
    map.flush();
    map.close();
  }

  // reads the txt file and colors the background with appropriate colors
  /******************************************
   black - walls and the surrounding border
   white - path
   green - shortest path
   ******************************************/
  void printMap() {
    try {
      String[] lines = loadStrings("map.txt");
      int x, y = 0;
      color c = color(100, 100, 100);// default color

      for (int textRow = 0; textRow < rows; textRow++) {
        for (int ch = 0; ch < lines[textRow].length(); ch++) {
          x = ch*boxsize;
          char curr = lines[textRow].charAt(ch);
          switch(curr) {
          case '#': //wall
            c = color(0, 0, 0);
            break;
          case '*': //path
            c = color(255, 255, 255);
            break;
          case '&': //exit
            c = color(255, 0, 0);
            break;
          case '@': //start
            c = color(0, 0, 255);
            break;
          case '!': //shortest path
            c = color(0, 100, 0);
            break;
          }
          //printing each pixel one at a time, color depends on what area it is in the grid
          for (int xPixel = x; xPixel < x + boxsize; xPixel++) {
            for (int yPixel = y; yPixel < y + boxsize; yPixel++) {
              set(xPixel, yPixel, c);
            }
          }
          x++;
        }
        y += boxsize;
      }
    }
    catch(Exception e) {
      System.out.println("does not exist");
    }
  }

  // facilitates a mouse click during map creation
  void mapClick(int xM, int yM) {
    if (!creationDone) { // only available if map is not completes

      if (xM > 0 && xM < (boxsize) && yM > 0 && yM < (boxsize)) {
        clearThis(); //clear button
      }

      // submit button
      if (xM > (cols-1)*(boxsize) && xM < (cols)*(boxsize) && yM > (rows-1)*(boxsize) && yM < (rows)*(boxsize)) {
        saveMap();
        MazeChecker check = new MazeChecker("map.txt");
        boolean working = check.checkMaze(); // DFS to determine if the maze is complete (path from beginning to end)
        if (working) {
          creationDone = true;
          PathFinder path = new PathFinder("map.txt");
          path.solve(); //BFS to determine the shortest path possible
          println("good MAP"); //complements the user for making a good map
        } else {
          println("Invaild MAP!!!!"); //does the oppoisite
          creationDone = false;
        }
      }

      //uses mouse coords to determine which box the coords belong to
      for (int i=0; i<rows-1; i++) {
        for (int j=0; j<cols-1; j++) {
          int x = j*boxsize;
          int y = i*boxsize;
          if (xM > x && xM < (x + boxsize) && yM > y && yM < (y + boxsize)) {
            grid[i][j].changeState();
          }
        }
      }
    }
  }

  //represent the grid, everything is white
  void clearThis() {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        if (grid[row][col].getState() == 1)
          grid[row][col].changeState();
        ;
      }
    }
  }
}
