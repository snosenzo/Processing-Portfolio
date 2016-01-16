class Path{
  
  ArrayList<PVector> points;
  
  float radius; //width of path
  
  Path(){
    radius = 20;
    points = new ArrayList<PVector>();
  }
  
  //function to add points to the path
  void addPoint(float x, float y){
    PVector point = new PVector(x, y);
    points.add(point);
  }
  
  void display(){
    //display Path
    stroke(0);
    noFill();
    
    beginShape();
    for(PVector v: points){
      vertex(v.x, v.y);
    }
    endShape();
  }
}
    
