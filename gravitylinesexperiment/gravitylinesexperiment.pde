//Sam Nosenzo
//7/9/15
//strip of lines down the top velocity initially to the right
//attractor at the center

class Part{
  PVector loc;
  PVector vel;
  PVector acc;
  
  Part(float x, float y){
    loc = new PVector(x, y);
    vel = new PVector(10, 0);
    acc = new PVector(0, 0);
  }
  
  void display(){
    stroke(255, 100);
    fill(255, 20);
    ellipse(loc.x, loc.y, 3, 3);
    
  }
  
  void update(){
    //vel.setMag(6);
    vel.limit(25);
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
  }
  
  void attract(Part p){
    PVector force = PVector.sub(p.loc, loc);
    float d = dist(p.loc.x, p.loc.y, loc.x, loc.y);
    float mag = 10 / (d * d);
    mag = constrain(mag, 0, 2);
    force.normalize();
    force.mult(mag);
    applyForce(force);
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
  
  void checkEdges(){
    if(loc.x < 0){
      loc.x = 0;
      vel.x = vel.x * -1;
    } else if( loc.x > width){
      loc.x = width;
      vel.x = vel.x * -1;
    }
    
    if(loc.y < 0){
      loc.y = 0;
      vel.y = vel.y * -1;
    } else if(loc.y > height){
      loc.y = height;
      vel.y = vel.y * -1;
    }
  }
  
}


Part[] p = new Part[50];

void setup(){
  size(640, 640);
  background(0);
  for( int i = 0; i < p.length; i++){
    p[i] = new Part(width/2, i*(200/p.length));
  }
}

void draw(){
  background(0);
  for(int i = 0; i < p.length; i++){
    for(int j = 0; j < p.length;j++){
      if(i!=j){
        float d = dist(p[i].loc.x, p[i].loc.y, p[j].loc.x, p[j].loc.y);
        if( d < 70){
          stroke(255, 60);
          line(p[i].loc.x, p[i].loc.y, p[j].loc.x, p[j].loc.y);
        }
      //p[i].attract(p[j]);
      
      }
      PVector center = new PVector(width/2, height/2);
      PVector grav = PVector.sub(center, p[i].loc);
      float mag = 100 / dist(p[i].loc.x, p[i].loc.y, width/2, height/2);
      grav.normalize();
      mag = constrain(mag, 0, .03);
      grav.mult(mag);
      p[i].applyForce(grav);
      PVector centrip = PVector.mult(grav, -1);
      
      
      //centrip.mult(2);
      //p[i].applyForce(centrip);
    }
    p[i].update();
    p[i].display();
    //p[i].checkEdges();
    }
}

void keyPressed(){
  if(key=='s'){
    saveFrame("orbitlines"+(int) random(1000)+".png");
  }
}
