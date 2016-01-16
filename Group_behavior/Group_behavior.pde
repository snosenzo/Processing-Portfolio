ArrayList<Vehicle> vehicles;
Path p;
int numv = 300;
void setup(){
  size(600, 600);
  
    p = new Path();
  for(int i = 0; i <= width; i+=2){
    float offset = (PI)/(width/2)*i;
    float y = sin(offset)*150+i;
    p.addPoint(i,  y);
  }
  
  vehicles = new ArrayList<Vehicle>();
  for(int i = 0; i < numv; i++){
    vehicles.add(new Vehicle(random(width), random(height)));
  }
}

void draw(){
  background(255);
  //p.display();
  for(Vehicle v: vehicles){
    v.separate(vehicles);
    //v.follow(p);
    if(mousePressed){
      v.seek(new PVector(mouseX, mouseY));

    }
    if(keyPressed){
      if(key == 'a'){
        v.avoid(new PVector(mouseX, mouseY));
      }
    }
    v.update();
    v.display();

  }
}
