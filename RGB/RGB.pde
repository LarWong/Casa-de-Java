void setup(){
  background(100,0,0);
  rect(10,10,10,10);
  frameRate(5);
}

void draw(){
  int i = 0;
  print(hex(get(i,i)) + " ");
  print(red(get(i,i))  + " ");
  print(blue(get(i,i))  + " ");
  print(green(get(i,i))  + " ");
  print("\n");
  background(-10223616);
  i+=10;

}