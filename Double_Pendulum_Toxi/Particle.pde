class Particle extends VerletParticle2D{
  Particle(Vec2D loc){
    super(loc);
  }
  
  void display(){
    fill(0, 50);
    stroke(0);
    ellipse(x, y, 15, 15);
  }
}

