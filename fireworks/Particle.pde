class Particle{
  PVector location, velocity, acceleration;
  float lifespan;
  float a1, a2, a3, x1, y1, x2, y2, x3, y3;
  float mass;
  float angVel;
  float angle =0 ;
  float col;
  
  Particle(PVector l, float m, float col){
    location = l.get();
    acceleration = new PVector();
    velocity = PVector.fromAngle(random(TWO_PI));
    velocity.mult(random(3, 4));
    lifespan = 255;
    mass = m;
    //mass = constrain(mass, 1, 6);
    angVel = random(.1, .5);
    
    this.col = col;
    
    a1 = random(PI);
    a2 = random(PI, TWO_PI);
    a3 = random(TWO_PI);
    x1 = 10*mass*cos(a1);
    y1 = 10*mass *sin(a1);
    x2 = 10 * mass * cos(a2);
    y2 = 10 * mass * sin(a2);
    x3 = 10 * mass * cos(a3);
    y3 = 10 * mass * sin(a3); 

  }
  void update(){
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -=5;
    acceleration.mult(0);
    angle+=angVel;
  }
  
  void display(){
    colorMode(HSB);
    stroke(col, 255, 255, lifespan);
    fill(col, 255, 255, lifespan);
    colorMode(RGB);
    pushMatrix();
      translate(location.x, location.y);
      rotate(angle);
      triangle(x1, y1, x2, y2, x3, y3);
    popMatrix();
  }
    
  
  void run(){
    update();
    display();
  }
  
  boolean isDead(){
    if(lifespan < 0.0){
      return true;
    } else{
      return false;
    }
  }
  
  void applyForce(PVector f){
    //f.div(mass);
    acceleration.add(f);
  }
  
}
