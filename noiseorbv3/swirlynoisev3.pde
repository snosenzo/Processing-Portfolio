
Trail[] ts = new Trail[100];


void setup(){
  size(640, 640);
  background(255);

 
  for ( int i = 0; i < ts.length; i ++){
    ts[i] = new Trail(width/2, height/2, i * 3.6);
  }

}

void draw(){
  //background(255);
  noStroke();
  fill(255, 5);
  rect(0, 0, width, height);
  stroke(0,10);
  fill(0);
  
  for ( int i = 0; i < ts.length; i ++){
    //ts[i].origin.x = mouseX;
    //ts[i].origin.y = mouseY;
    ts[i].display();
  }
}

void mousePressed(){
  background(255);
}
  
