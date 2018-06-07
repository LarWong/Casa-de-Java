//class version of MapCreation for the main driver
class CreateMap {

  private int boxsize, cols, rows;
  private Square[][] grid;
  boolean creationDone;

  CreateMap(int worldsizeY, int worldsizeX, int squaresize) {
    boxsize = squaresize;
    boolean creationDone = false;

    rows = (worldsizeY/boxsize);
    cols = (worldsizeX/boxsize);
    grid = new Square[rows][cols];

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        grid[row][col] = new Square(row, col, rows, cols, squaresize);
      }
    }
  }

  boolean creationProcess() {
    if (!creationDone) { 
      for (int i=0; i<rows; i++) {
        for (int j=0; j<cols; j++) {
          grid[i][j].appear(i, j);
        }
      }
    } else {
      printMap();
      return creationDone;
    }
    return creationDone;
  }

  void saveMap() {
    PrintWriter map = createWriter("map.txt");
    for (int i=0; i<rows; i++) {
      String text = "";
      for (int j=0; j<cols; j++) {
        int currSquare = grid[i][j].getState();
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


  void printMap() {
    try {
      String[] lines = loadStrings("map.txt");
      int x, y = 0;
      color c = color(100, 100, 100);

      for (int textRow = 0; textRow < rows; textRow++) {
        for (int ch = 0; ch < lines[textRow].length(); ch++) {
          x = ch*boxsize;
          char curr = lines[textRow].charAt(ch);
          switch(curr) {
          case '#': 
            c = color(0, 0, 0);
            break;
          case '*': 
            c = color(255, 255, 255);
            break;
          case '&': 
            c = color(255, 0, 0);
            break;
          case '@': 
            c = color(0, 0, 255);
            break;
          case '!': 
            c = color(0, 100, 0);
            break;
          }
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


  void mapClick(int xM, int yM) {
    if (!creationDone) {

      if (xM > 0 && xM < (boxsize) && yM > 0 && yM < (boxsize)) {
        clearThis();
      }

      if (xM > (cols-1)*(boxsize) && xM < (cols)*(boxsize) && yM > (rows-1)*(boxsize) && yM < (rows)*(boxsize)) {
        saveMap();
        MazeChecker check = new MazeChecker("map.txt");
        boolean working = check.checkMaze();
        if (working) {
          creationDone = true;
          PathFinder path = new PathFinder("map.txt");
          //print(path);
          path.solve("map.txt");
          println("good MAP");
        } else {
          println("Invaild MAP");
          creationDone = false;
        }
      }

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
