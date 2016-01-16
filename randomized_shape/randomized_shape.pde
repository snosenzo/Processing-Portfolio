class randomizedshape{
  float theta = 0;
  float jitterx = 500;
  float jittery = 500;
  float init = jitterx;
  float colour;
  float r;
  
  randomizedshape(float x, float y){
  }
  
  void display(float x, float y, float r, int sides,float theta) {
    colour = map(jitterx, 0, init, 60, 0);
    fill(colour,100+random(-5, 5),100+random(-5, 5));
    stroke(0);
    noStroke();
    pushMatrix();
      translate(x,y);
      beginShape();
      if(jitterx>0){
      for(int i = 1; i<=sides; i++){
        vertex(r*cos(radians(360/sides*i))+random(-jitterx,jitterx), r*sin(radians(360/sides*i))+random(-jittery, jittery));
      }
      }
      endShape(CLOSE);
      rotate(radians(theta));
    popMatrix();
  }
  void jitterstep(float jitterstepx, float jitterstepy){
    jitterx = jitterx - jitterstepx;
    jittery = jittery - jitterstepy;

  }
  void rot(float rotstep){
    theta = theta + rotstep;
  } 
}


randomizedshape s;

void setup(){
  background(255);
  colorMode(HSB, 360, 100, 100);
  s = new randomizedshape(width/2, height/2);
  size(800,800);
  frameRate(1000);
}


void draw(){
  s.jitterstep(.1, .1);
  s.rot(1);
  s.display(mouseX, mouseY, 50, 4, 45);
}

