int boxsize = 25;
int cols, rows;
Square[][] grid;
boolean creationDone = false;

void setup() {
  size(200, 200);
  cols = (width/boxsize);
  rows = (height/boxsize);
  grid = new Square[rows][cols];
  for (int row = 0; row < rows; row++) {
    for (int col = 0; col < rows; col++) {
      grid[row][col] = new Square(row, col);
    }
  }
}

void draw() {
  background(255);
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


void mousePressed() {
  if (!creationDone) { 
    //print(" " + mouseX + " " + mouseY);
    if (mouseX > (cols-1)*(boxsize) && mouseX < (cols)*(boxsize) && mouseY > (rows-1)*(boxsize) && mouseY < (rows)*(boxsize)) {
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
        if (mouseX > x && mouseX < (x + boxsize) && mouseY > y && mouseY < (y + boxsize)) {
          grid[i][j].changeState();
        }
      }
    }
  }
}

void saveMap() {
  PrintWriter map = createWriter("map.txt");
  for (int i=0; i<rows; i++) {
    String text = "";
    for (int j=0; j<cols; j++) {
      int currSquare = grid[j][i].getState();
      //println(currSquare);
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

    for (String row : lines) {
      for (int ch = 0; ch < row.length(); ch++) {
        x = ch*boxsize;
        char curr = row.charAt(ch);
        if ( curr == '#' ) {
          c = color(0, 0, 0);
        }
        if ( curr == '*' ) {
          c = color(255, 255, 255);
        }
        if ( curr == '&' ) {
          c = color(255, 0, 0);
        }
        if ( curr == '@' ) {
          c = color(0, 0, 255);
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
