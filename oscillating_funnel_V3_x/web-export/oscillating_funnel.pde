class Particles{
  PVector loc, vel;
  float amp;
  float theta;
  Particles (float x, float y){
   loc = new PVector(x, y);
   vel = new PVector(0, 0);
  }
  
  void display(){
    stroke(255, 150);
    fill(255, 50);
    ellipse(loc.x, loc.y, 4, 4);
  }
}
    
Particles[] p1 = new Particles[64];
Particles[] p2 = new Particles[64];

void setup(){
  size(640, 640);
  background(0);
  stroke(255);
  for (int i = 0; i < p1.length; i++){
    p1[i] = new Particles(width/2-100, i*10);
  }
  for (int i = 0; i < p2.length; i++){
    p2[i] = new Particles(width/2+100, i*10);
  }
}
float theta1 = 0;
float theta2 = PI;
float lindist = 70;
void draw(){
  background(0);
  
  for(float i = 0; i < p1.length; i++){
    p1[(int) i].loc.x = map(sin(theta1+i/5), -1, 1, width/2-1/(i*.1+1)*width/2, width/2 +1/(i*.1+1)*width/2);
    p1[(int) i].display();
    for(int j = 0; j< p1.length; j++){
      float d1 = dist(p1[(int) i].loc.x, p1[(int) i].loc.y, p1[j].loc.x, p1[j].loc.y);
      float d2 = dist(p1[(int) i].loc.x, p1[(int) i].loc.y, p2[j].loc.x, p2[j].loc.y);
      if(d1 < lindist){
        line( p1[(int)i].loc.x, p1[(int)i].loc.y, p1[j].loc.x, p1[j].loc.y);
      }
      if(d2 < lindist){
        line( p1[(int)i].loc.x, p1[(int)i].loc.y, p2[j].loc.x, p2[j].loc.y);
      }
    }
  }
  for(float i = 0; i < p2.length; i++){
    p2[(int) i].loc.x = map(sin(theta2+i/4), -1, 1, width/2-1/(i*.1+1)*width/2, width/2 +1/(i*.1+1)*width/2);
    p2[(int) i].display();
      for(int j = 0; j< p2.length; j++){
        float d1 = dist(p2[(int) i].loc.x, p2[(int) i].loc.y, p2[j].loc.x, p2[j].loc.y);
          if(d1 < lindist){
            line( p2[(int)i].loc.x, p2[(int)i].loc.y, p2[j].loc.x, p2[j].loc.y);
          }
      }
  }
  
  theta1+=.01;
  theta2+=.01;
}
  

