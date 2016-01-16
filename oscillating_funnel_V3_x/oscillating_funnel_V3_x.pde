class Particles {
  PVector loc, vel;
  float amp;
  float theta;
  Particles (float x, float y) {
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
  }

  void display() {
    //stroke(255, 150);
    //fill(255, 50);
    ellipse(loc.x, loc.y, 4, 4);
  }
}
int steps = 160;
Particles[] p1 = new Particles[steps];
Particles[] p2 = new Particles[steps];

void setup() {
  size(1600, 640);
  background(0);
  stroke(255);
  for (int i = 0; i < p1.length; i++) {
    p1[i] = new Particles(i*(width/steps), height/2-100);
  }
  for (int i = 0; i < p2.length; i++) {
    p2[i] = new Particles(i*(width/steps), height/2+100);
  }
}
float theta1 = 0;
float theta2 = PI;
float lindist = 75;
float ampconst1 = .012;
float ampconst2 = .012;
void draw() {
  background(0);

  for (float i = 0; i < p1.length; i++) {
    float col1 = map(sin(theta1+i/4), -1, 1, 0, 255);
    stroke(col1);
    p1[(int) i].loc.y = map(sin(theta1+i/4), -1, 1, height/2-(i*i*ampconst1+1), height/2 +(i*i*ampconst1+1));
    p1[(int) i].display();
  }

  for (float i = 0; i < p2.length; i++) {
    float col2 = map(sin(theta2+i/3.3), -1, 1, 0, 255);
    stroke(col2);
    p2[(int) i].loc.y = map(sin(theta2+i/7), -1, 1, height/2-(i*i*ampconst2+1), height/2 +(i*i*ampconst2+1));
    p2[(int) i].display();

  }
  
  for (float i = 0; i < p2.length; i++) {
    float col2 = map(sin(theta2+i/3.3+PI/2), -1, 1, 0, 255);
    stroke(col2);
    for (int j = 0; j< p2.length; j++) {
      float d1 = dist(p2[(int) i].loc.x, p2[(int) i].loc.y, p2[j].loc.x, p2[j].loc.y);
      if (d1 < lindist) {
        line( p2[(int)i].loc.x, p2[(int)i].loc.y, p2[j].loc.x, p2[j].loc.y);
      }
    }
  }
  for (float i = 0; i < p1.length; i++) {
    float col1 = map(sin(theta1+i/4+PI/2), -1, 1, 0, 255);
    stroke(col1);
      for (int j = 0; j< p1.length; j++) {
      float d1 = dist(p1[(int) i].loc.x, p1[(int) i].loc.y, p1[j].loc.x, p1[j].loc.y);
      float d2 = dist(p1[(int) i].loc.x, p1[(int) i].loc.y, p2[j].loc.x, p2[j].loc.y);
      if (d1 < lindist) {
        line( p1[(int)i].loc.x, p1[(int)i].loc.y, p1[j].loc.x, p1[j].loc.y);
      }
      if (d2 < lindist) {
        line( p1[(int)i].loc.x, p1[(int)i].loc.y, p2[j].loc.x, p2[j].loc.y);
      }
    }
  }
  
  

  if ( keyPressed) {
    if (key == 's') {
      saveFrame("oscill"+random(3000)+".png");
    }
  }


  theta1+=.05;
  theta2+=.05;
}

