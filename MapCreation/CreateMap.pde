//class version of MapCreation for the main driver
class CreateMap {

  private int boxsize, cols, rows;
  Square[][] grid;
  boolean creationDone;

  CreateMap(int worldsize, int squaresize) {
    int boxsize = squaresize;
    boolean creationDone = false;
    cols = (worldsize/boxsize);
    rows = (worldsize/boxsize);
    grid = new Square[rows][cols];
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < rows; col++) {
        grid[row][col] = new Square(row, col);
      }
    }
  }

  void creationProcess() {
    if (!creationDone) { 
      for (int i=0; i<rows; i++) {
        for (int j=0; j<cols; j++) {
          grid[i][j].appear(i, j);
        }
      }
    } else {
      printMap();
    }
  }

  void saveMap() {
    PrintWriter map = createWriter("map.txt");
    for (int i=0; i<rows; i++) {
      String text = "";
      for (int j=0; j<cols; j++) {
        int currSquare = grid[j][i].getState();
        if (currSquare == 0 || currSquare == 4 || currSquare == 5) {
          text += "#";
        }
        if (currSquare == 1 || currSquare == 3) {
          text += "*";
        }
        if (currSquare == 2) {
          text += "&";
        }
      }
      map.println(text);
    }
    map.flush();
    map.close();
    creationDone = true;
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
          switch( curr ) {
          case '#': 
            c = color(0, 0, 0);
          case '*': 
            c = color(255, 255, 255);
          case '&': 
            c = color(255, 0, 0);
          }
          
          if (textRow == 1 && ch == 1){
            c = color(0,0,255);
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
      //print(" " + mouseX + " " + mouseY);
      if (xM > (cols-1)*(boxsize) && xM < (cols)*(boxsize) && yM > (rows-1)*(boxsize) && yM < (rows)*(boxsize)) {
        saveMap();
        DepthFirstChecker check = new DepthFirstChecker();
        if (check.checkMaze()) {
          println("good MAP");
          creationDone = true;
        } else {
          println("Invaild MAP");
          creationDone = false;
        }
      }
      for (int i=0; i<rows-1; i++) {
        for (int j=0; j<cols-1; j++) {
          int x = i*boxsize;
          int y = j*boxsize;
          if (xM > x && xM < (x + boxsize) && yM > y && yM < (y + boxsize)) {
            grid[i][j].changeState();
          }
        }
      }
    }
  }
}
