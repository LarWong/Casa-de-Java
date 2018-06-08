// for PathFinder, holds information regarding a tile in the maze
class Node { 
  int xCor;
  int yCor;
  Node parentNode;

  public Node(int y, int x, Node parent) {
    this.xCor = x;
    this.yCor = y;
    this.parentNode = parent;
  }

  // Acessors
  public Node getParent() {
    return this.parentNode;
  }

  public int getX() {
    return this.xCor;
  }

  public int getY() {
    return this.yCor;
  }

  // for debugging purposes
  public String toString() {
    return "col = " + this.xCor + " row = " + this.yCor;
  }
}
