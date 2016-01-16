//Sam Nosenzo
//Particles in a circle
//Connected with lines
//Fix ricochet 
//9/10/15

ArrayList<Particle> ps;
int numpts = 80;
int r = 175;
void setup() {
  size(800, 800);
  background(255);
  ps = new ArrayList<Particle>();
  for (int i = 0; i < numpts; i++) {
    float x = (r-100)*cos(random(TWO_PI))+width/2;
    float y = (r-100)*sin(random(TWO_PI))+height/2;
    Particle p = new Particle(new PVector(x, y));
    ps.add(p);
  }
}
float prad = 60;
int connectlim = 10;
void draw() {
  background(255);
  noFill();
  stroke(180);
  strokeWeight(1);
  ellipse(width/2, height/2, r*2, r*2);
  colorMode(HSB);
  for (int i = 0; i < ps.size (); i++) {
    int connects = 0;
    Particle p = ps.get(i);
    float d = dist(p.loc.x, p.loc.y, width/2, height/2);
    if (d > r) {
      p.turnBack();
    }
    p.update();
    p.display();

    for (int j = i+1; j < ps.size (); j++) {
      Particle p2 = ps.get(j);
      float d1 = dist(p.loc.x, p.loc.y, p2.loc.x, p2.loc.y);
      if (connects < 10) {
        if (d1 < prad) {
          for (int k = j+1; k < ps.size (); k++) {
            Particle p3 = ps.get(k);
            float d2 = dist(p2.loc.x, p2.loc.y, p3.loc.x, p3.loc.y);
            if ( d2 < prad) {
              float hue = map(d, 0, r, 0, 60);
              strokeWeight(1);
              stroke(hue, 255, 255);
              fill(hue, 255, 255, 80);
              beginShape();
              vertex(p.loc.x, p.loc.y);
              vertex(p2.loc.x, p2.loc.y);
              vertex(p3.loc.x, p3.loc.y);
              endShape(CLOSE);
              connects++;
            }
          }
        }
      }
    }
  }
}


void keyPressed(){
  if(key=='s'){
    saveFrame("netnodes"+(int) random(200)+".png");
  }
}

