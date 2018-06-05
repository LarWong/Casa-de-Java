CreateMap world;

void setup() {
  size(1200, 500);
  world = new CreateMap(500, 1000, 25);
}

void draw() {
  world.creationProcess();
}


void mousePressed() {
  world.mapClick(mouseX,mouseY);
}
