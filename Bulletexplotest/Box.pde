
//creates a box object on the screen
class Box{
  
  Body body;
  float sz;
  boolean alive;
  Box(float x, float y){
    sz = random(10, 50);
    alive = true;
    makeBody(new Vec2(x, y), sz);
    body.setUserData(this);
  }
  
  void killBody(){
    box2d.destroyBody(body);
  }
  //delete?
  boolean done(){
    //find position of particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    //Is it off the bottom of the screen?
    if(pos.y > height+sz*sz || alive == false){
      killBody();
      return true;
    }
    return false;
  }
  
  void display(){
      // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(0);
    stroke(0);
    rect(0, 0,sz, sz);
    popMatrix();
  }
  
  
  void makeBody(Vec2 center, float sz_){
    //Define a polygon (this is for square);
    PolygonShape sd = new PolygonShape();
    float box2dsz = box2d.scalarPixelsToWorld(sz/2);
    sd.setAsBox(box2dsz, box2dsz);
    
    //Define fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    //Parameters that affect physics
    fd.density = 1;
    fd.friction = .3;
    fd.restitution = 0.9;
    
    //Define the body and make it from the shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    
    body = box2d.createBody(bd);
    body.createFixture(fd);
    
    //Give it some initial random velocity
    body.setLinearVelocity(new Vec2(random(-5, 5), random(-5, 5)));
    body.setAngularVelocity(random(-5, 5));
  }
}
    
