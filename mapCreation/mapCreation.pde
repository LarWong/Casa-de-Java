int boxsize = 25;
int cols, rows;
Square[][] grid;

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
  for (int i=0; i<rows; i++) {
    for (int j=0; j<cols; j++) {
      grid[i][j].appear(i, j);
    }
  }
}


void mousePressed() {
  //print(" " + mouseX + " " + mouseY);
  if (mouseX > (cols-1)*(boxsize) && mouseX < (cols)*(boxsize) && mouseY > (rows-1)*(boxsize) && mouseY < (rows)*(boxsize)) {
    saveMap();
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

void saveMap() {
  PrintWriter map = createWriter("map.txt");
  for (int i=0; i<rows; i++) {
    String text = "";
    for (int j=0; j<cols; j++) {
      int currSquare = grid[j][i].getState();
      //println(currSquare);
        if (currSquare == 0 || currSquare == 4 || currSquare == 5){
          text += "#";
        }
        if (currSquare == 1){
          text += "*";
        }
        if (currSquare == 2){
          text += "&";
        }
        if (currSquare == 3){
          text += "@";
        }
    }
    map.println(text);
  }
  map.flush();
  map.close();
}
