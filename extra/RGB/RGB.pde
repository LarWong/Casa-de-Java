void setup(){
  background(100,125,0);
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
  //background();
  i+=10;

}