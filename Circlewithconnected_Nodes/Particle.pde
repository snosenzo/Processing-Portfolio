class Particle{
  PVector loc, vel, acc;
  float vlim;
  
  Particle(PVector l){
    loc = l.get();
    vel = new PVector(random(-3,3), random(-3, 3));
    acc = new PVector();
    vlim = 4;
  }
  
  void update(){
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
  }
  
  void turnBack(){
    PVector center = new PVector(width/2, height/2);
    float ptangle = PI + vel.heading();
    PVector radvec = PVector.sub(center, loc);
    float cangle = radvec.heading();
    float mg = vel.mag();
    float angleBet = cangle-ptangle;
    cangle+=angleBet;
    vel = PVector.fromAngle(cangle);
    vel.normalize();
    vel.setMag(mg);
  }
  
  void display(){
    strokeWeight(3);
    point(loc.x, loc.y);
  }
}

