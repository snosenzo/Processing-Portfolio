void setup(){
  size(1920,1080);
  background(255);
  stroke(0);
  fill(0);
  smooth();
}
int csize = 30;
void circleGrid(){
  for (int gridx=40; gridx<width-20;gridx=gridx+csize){
    for (int gridy = 40; gridy<height-20; gridy = gridy+csize){
      float radius = int(random(5,25));
      ellipse(gridx,gridy,radius,radius);
    }
  }
}
void randcircles(){
  for (int i = 1; i<300;i++){
    float radius = random(50);
    ellipse(random(40,width-20), random(40,height-20), radius, radius);
  }
}

void draw(){
  //background(255);
  if (keyPressed){
    if(key == 'g'){

      background(255);
       circleGrid();     
    }
    if(key == 's'){
      saveFrame("circle-###.png");
    }
    if(key == 'r'){
      background(255);
      stroke(255);
      randcircles();
      noStroke();
    }
  }
}
