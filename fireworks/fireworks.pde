//Sam Nosenzo
//8/20/15
//Fireworks?

ArrayList<Rocket> rkts;
ArrayList<Particle> ps;
PVector gravity;
void setup() {
  size(700, 700);
  background(0);
  stroke(255);
  fill(255);

  gravity = new PVector(0, .15);

  rkts = new ArrayList<Rocket>();
  ps = new ArrayList<Particle>();
}

void draw() {
  //background(0);
  noStroke();
  fill(0, 40);
  rect(0, 0, width, height);
  for (int i = rkts.size ()-1; i >=0; i--) {
    Rocket r = rkts.get(i);
    r.applyForce(gravity);
    r.thrust();
    r.update();
    if (r.fuse >= 0) {
      r.display();
    } else if ( r.fuse <= -5) {
      float col = random(255);
      for (int j = 0; j < 50; j++) {
        
        ps.add(new Particle(new PVector(r.loc.x, r.loc.y), random(.2, .6), col));
      }
      rkts.remove(i);
    }
  }
  for (int i = ps.size ()-1; i >=0; i--) {
    Particle p = ps.get(i);
    p.applyForce(gravity);
    p.update();
    p.display();
    if (p.isDead()) {
      ps.remove(i);
    }
  }


  if (mousePressed) {
    Rocket r = new Rocket(mouseX, -PI/2, .6, 40);
    rkts.add(r);
  }
}


/*
void mousePressed(){
 Rocket r = new Rocket(mouseX, -PI/2, .6, 40);
 rkts.add(r);
 }
 */
