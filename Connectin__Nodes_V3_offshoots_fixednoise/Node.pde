//node class
//I guess all it really does is store a pvector and display an ellipse at its location
class Node{
  PVector loc;
  float size;
  boolean centralNode = false;
  Node(float x, float y, float sz){
    loc = new PVector(x, y);
    size = sz;
  }
  
  void display(){
    stroke(255);
    noFill();
    strokeWeight(size);
    point(loc.x, loc.y);
  }
}
    
    
