class Rocket{
  
  PVector loc, vel, acc;
  int fuel, initfuel;
  float initacc;
  float angle;
  int fuse = int(random(75, 100));
  Rocket( float x, float theta, float ia, int fl){
    loc = new PVector(x, height-random(50));
    vel = new PVector();
    acc = new PVector();
    angle = theta;
    initacc = ia;
    initfuel = fl;
    fuel = fl;
  }
  
  void update(){
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
    fuse--;

  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
  
  void thrust(){
    float mag = 0;
    float theta = PI/2;
    if( fuel < .1*initfuel){
      mag = map(fuel, 0, initfuel, 0, initacc);
      theta = vel.heading()+ random(-PI/15, PI/15);
    } 
    else if(fuel == initfuel){
      mag = initacc*1.5;
      theta = angle;
      fuel-=5;
    }
    else if(fuel <=0){
      mag = 0;
      theta = vel.heading();
    }
    else {
      mag = initacc;
      theta = vel.heading()+random(-PI/15, PI/15);
    }
  
    PVector thrust = PVector.fromAngle(theta);
    thrust.setMag(mag);
    if(fuel > 0){
      applyForce(thrust);
    }
    fuel-=1;
  }
  
  void display(){
    fuse--;
    if(fuel >0) fill(255, 0, 0);
    else fill(255);
    if(fuse < 0) fill(0, 255, 0);
    if(vel.y > 0) stroke(0, 0, 255);
    else stroke(255);
    
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(vel.heading());
    beginShape();
      vertex(8,  0);
      vertex(0,  3);
      vertex(0, -3);
    endShape(CLOSE);
   popMatrix();
  }
} 
    
    
  
