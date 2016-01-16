
Trail[] ts = new Trail[72];


void setup(){
  size(640, 640);
  background(255);

 
  for ( int i = 0; i < ts.length; i ++){
    ts[i] = new Trail(width/2, height/2, i * 5);
  }

}

void draw(){
  background(255);
  stroke(0);
  fill(0);
  
  for ( int i = 0; i < ts.length; i ++){
    ts[i].display();
  }
}
  
