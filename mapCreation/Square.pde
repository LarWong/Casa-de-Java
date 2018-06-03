/*
 Casa De Java - Kevin Wang, Larry Wong, Alvin Ye
 APCS2 pd8
 Lab4 - All That Bouncin’
 2018-05-24
 */

class Square {

  //============final vars=========================
  final static int WALL = 0;
  final static int PATH = 1;
  final static int END = 2;
  final static int START = 3;
  final static int BORDER = 4;
  final static int CONFIRM = 5;
  //===============================================

  //vars (ball info & movement)
  int state;
  color c;

  //constructor with state var
  Square(int row, int col) {
    
    this.state = WALL;// default option
    if (row == 0 || col == 0 || row == rows - 1 || col == cols - 1) { 
      this.state = BORDER;
    }
    if ( (row == 1 && col == 1) ){
      this.state = START;
    }
    if ( (row == rows - 2 && col == cols - 2) ){
      this.state = END;
    }
    if ( ( row == rows-1 && col == cols-1) ){
      this.state = CONFIRM;
    } 
    
    this.changeColor();
  }

  void changeState() {
    if (state == WALL || state == PATH) {
      this.state++;
      this.state %= 2;
      this.changeColor();
    }
  }

  void changeColor() {
    if (this.state == WALL) c = color(255, 255, 255); //white
    if (this.state == PATH) c = color(255, 0, 0); //red
    if (this.state == END) c = color(0, 255, 0); //green
    if (this.state == START) c = color(0, 0, 255); //blue
    if (this.state == BORDER) c = color(100, 100, 100); //grey
    if (this.state == CONFIRM) c = color(0, 130, 130); //cyan
  }

  void appear(int row, int col) {
    fill(this.c);
    rect(row*boxsize, col*boxsize, boxsize, boxsize);
  }
  
  int getState(){
    return state;
  }
}
