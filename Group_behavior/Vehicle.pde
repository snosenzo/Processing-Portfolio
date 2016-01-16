class Vehicle{
  PVector location, velocity, acceleration;
  float maxspeed, maxforce;
  float r;

  Vehicle(float x, float y){
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-2, 2),random(-2, 2));
    location = new PVector(x, y);
    r = 3.0;
    
    maxspeed = 3;
    maxforce = .3;
  }
  
  void update(){
    //checkwalls();
    //checkbound();
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display(){
    float theta = velocity.heading() + PI/2;
    fill(0);
    //stroke(255);
    noStroke();
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
  
  void checkwalls(){
    if(location.x > width-50){
      PVector desired = new PVector(-maxspeed, velocity.y);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    } else if(location.x < 50){
      PVector desired = new PVector(maxspeed, velocity.y);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
    if(location.y > height-50){
      PVector desired = new PVector(velocity.x, -maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    } else if(location.y < 50){
      PVector desired = new PVector(velocity.x, maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }
  
  void checkbound(){
    if(location.x < 0){
      location.x = width;
    } else if(location.x > width){
      location.x = 0;
    }
    
    if(location.y < 0){
      location.y = height;
    }else if(location.y > height){
      location.y = 0;
    }
  }
  
  void seek(PVector target){
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(maxspeed); //scale vector to maxspeed;
    
    PVector steer = PVector.sub(desired, velocity); //Reynolds formula for steering force
    steer.limit(maxforce);
    
    applyForce(steer); //apply the force asa the object acceleration
    
  }
  
  void avoid(PVector target){
    PVector desired = PVector.sub(target, location);
    desired.normalize();
    desired.mult(-1 * maxspeed); //scale vector to maxspeed;
    
    PVector steer = PVector.sub(desired, velocity); //Reynolds formula for steering force
    steer.limit(maxforce);
    
    applyForce(steer); //apply the force asa the object acceleration
  
  }
      
  
  void applyForce(PVector force){
    acceleration.add(force);
  }
  
  //Chapter 6.11
  
  void separate(ArrayList<Vehicle> vehicles){
    PVector sum = new PVector();
    int count = 0;
    
    float desiredseparation = 50;
    for(Vehicle other: vehicles){
      float d = PVector.dist(location, other.location);
      
      if((d >desiredseparation*1.2) && (d < desiredseparation*1.5)){
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        sum.sub(diff);
        stroke(0);
        line(location.x, location.y, other.location.x, other.location.y);
        count++;
      }
      
      else if((d > 0) && (d < desiredseparation)){
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        //diff.mult(1.2);
        sum.add(diff);
        count++;   
      }
      else if((d > desiredseparation) && (d < desiredseparation*1.2)){
        /*PVector stab = velocity.get();
        stab.mult(-.2);
        sum.add(stab);
        count++;
        */        
      }
      
    }
    if(count > 0 ){
      sum.div(count);
      sum.setMag(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      
      applyForce(steer);
    }
  }

  
  
  
  
  /*
  void follow(FlowField flow){
    PVector desired = flow.lookup(location);
    desired.mult(maxspeed);
    
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
  */
  
  
  
  
  
  
  
  
  //Chapter 6.9
  void follow(Path p){
    PVector target = null;
    //Predict the vehicles future location;
    PVector predict = velocity.get();
    predict.normalize();
    predict.mult(25);
    PVector predictLoc = PVector.add(location, predict);
    float worldRecord = 1000000;
    //Find the normal point along the path.
    for(int i = 0; i < p.points.size()-1; i++){
      PVector a = p.points.get(i);
      PVector b = p.points.get(i+1);
      PVector normalPoint = getNormalPoint(predictLoc, a, b);
      if (normalPoint.x < a.x || normalPoint.x > b.x){
        normalPoint = b.get();
      }
      float distance = PVector.dist(predictLoc, normalPoint);
      
      if(distance < worldRecord){
        worldRecord = distance;
        target = normalPoint.get();
      }
    }
    //Move a little further along the path and set a target
    /*
    PVector dir = PVector.sub(b, a);
    dir.normalize();
    dir.mult(10);
    PVector target = PVector.add(targetp, dir);
    */
    //IF off the path, steer to stay on
    float distance = PVector.dist(target, predictLoc);
    if(distance > p.radius){
      seek(target);
    }
  }
  
  PVector getNormalPoint(PVector p, PVector a, PVector b){
    PVector ap = PVector.sub(p, a); //Vector from a to p
    PVector ab = PVector.sub(b, a); //Vector from a to b
    
    //Using the dot product for scalar projection
    ab.normalize();
    ab.mult(ap.dot(ab));
    
    PVector normalPoint = PVector.add(a, ab);
    
    return normalPoint;
  }
    

}
  
  
  
    
