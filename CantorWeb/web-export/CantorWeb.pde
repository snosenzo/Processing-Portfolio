//Sam Nosenzo
//8/19/15
//Nature of Code 8.3 Cantor Set Recursive Function


void setup(){
  strokeCap(SQUARE);
  size(600, 600);
  background(255);
  cantor(width/2, height/2 , 150, 0, theta1);
  //saveFrame("cantor-V"+int(random(200000))+".png");
}
float theta1 = 0;
float mot = 0;
void draw(){
  background(255);
  mot = map(sin(theta1),-1, 1, 20, 80);
  cantor(width/2, height/2, 250, 0, mot);
  theta1+=.01;
}
  
float angle = 0;
void cantor(float x, float y, float len, float angle, float theta){
  
  //noSmooth();
  strokeWeight(1);
  if(len >= 1.5){
    pushMatrix();
    translate(x, y);
    rotate(radians(angle));
    line(-len/2, 0, len/2, 0);
    popMatrix();
    cantor(x+len*.5*cos(radians(angle)), y+len*.5*sin(radians(angle)), len*.7, angle+theta, theta);
    cantor(x-len*.5*cos(radians(angle)), y-len*.5*sin(radians(angle)), len*.7, angle-theta, theta);
  }
}
  

