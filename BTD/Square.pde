// class for each square in the grid during creation process
class Square {

  //============final vars=================
  final static int WALL = 0;
  final static int PATH = 1;
  final static int END = 2;
  final static int START = 3;
  final static int BORDER = 4;
  final static int CONFIRM = 5;
  final static int CLEAR = 6;
  //=======================================

  //instance vars 
  private int state;
  private int rows;
  private int cols;
  private int boxsize;
  private color c;

  //constructor
  Square(int row, int col, int rows, int cols, int actualBoxsize) {

    this.rows = rows;
    this.cols = cols;
    this.boxsize = actualBoxsize;

    this.setState(WALL);// default option
    // determine what the square will do/will be
    if (row == 0 || col == 0 || row == rows - 1 || col == cols - 1) { 
      this.setState(BORDER);
    }
    if ( ( row == 0 && col == 0) ) {
      this.setState(CLEAR);
    } 
    if ( (row == 1 && col == 1) ) {
      this.setState(START);
    }
    if ( (row == rows - 2 && col == cols - 2) ) {
      this.setState(END);
    }
    if ( ( row == rows-1 && col == cols-1) ) {
      this.setState(CONFIRM);
    } 

    this.changeColor();
  }

  // for the user to create their own path
  // user only allowed to change the walls/paths
  void changeState() {
    if (state == WALL || state == PATH) {
      this.state++;
      this.state %= 2;
      this.changeColor();
    }
  }

  //determines how the square will be represented on the grid
  void changeColor() {
    if (this.state == WALL) c = color(255, 255, 255); //white
    if (this.state == PATH) c = color(255, 0, 0); //red
    if (this.state == END) c = color(0, 255, 0); //green
    if (this.state == START) c = color(0, 0, 255); //blue
    if (this.state == BORDER) c = color(100, 100, 100); //grey
    if (this.state == CONFIRM) c = color(0, 130, 130); //cyan
    if (this.state == CLEAR) c = color(130, 130, 0); //yellowish-brown
  }

  //creates a visual (the grid)
  void appear(int row, int col) {
    this.changeColor();
    fill(this.c);
    rect(col*boxsize, row*boxsize, boxsize, boxsize);
  }

  // Accessor
  int getState() {
    return this.state;
  }
  
  // Mutator
  void setState(int changeState) {
    switch(changeState) {
    case 0: 
      this.state = WALL;
      break;
    case 1: 
      this.state = PATH;
      break;
    case 2: 
      this.state = END;
      break;
    case 3: 
      this.state = START;
      break;
    case 4: 
      this.state = BORDER;
      break;
    case 5: 
      this.state = CONFIRM;
      break;
    case 6: 
      this.state = CLEAR;
      break;
    }
  }
}
