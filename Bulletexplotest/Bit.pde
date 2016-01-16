class Bit{
  PVector location;
  float x1, y1, x2, y2, x3, y3;
  float mass;
  float angle =0 ;

  
  Body body;
  
  Bit(float x, float y){    

    mass = random(.1, .2);
    //mass = constrain(mass, 1, 6);
    float a1, a2, a3;
    /* Random Angles
    a1 = random(TWO_PI/3);
    a3 = random(TWO_PI/3+.01, 2*TWO_PI/3-.01);
    a2 = random(2*TWO_PI/3, 3*TWO_PI/3);
    */
    a1 = 0;
    a3 = TWO_PI/3;
    a2 = -TWO_PI/3;
    
    /*
    a1 = 0;
    a2 = random(.01, PI-.1);
    a3 = random(PI+.1, TWO_PI-.1);
    */
    x1 = 10*mass*cos(a1);
    y1 = 10*mass *sin(a1);
    x2 = 10 * mass * cos(a2);
    y2 = 10 * mass * sin(a2);
    x3 = 10 * mass * cos(a3);
    y3 = 10 * mass * sin(a3); 
  
      
    println("a1 = " + a1);
    println("a2 = " + a2);
    println("a3 = " + a3);
  
    makeBody(new Vec2(x, y));
    body.setUserData(this);

  }
  
  void killBody(){
    box2d.destroyBody(body);
  }
  //particle ready for deletion?
  boolean done(){
    //screen position of particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    //is it off the bottom of the screen?
    if(pos.y > height){
      killBody();
      return true;
    }
    return false;
  }
  

  
  
  

    
  void display(){

    Vec2 pos  = box2d.getBodyPixelCoord(body);
    //get its rotation
    float a = body.getAngle();
    
    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
    
    
    rectMode(CENTER);
    stroke(0);
    fill(0);
    pushMatrix();
      translate(pos.x, pos.y);
      rotate(-a);
      beginShape();
        for(int i = 0; i < ps.getVertexCount(); i++){
          Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
          vertex(v.x,v.y);
        }
      endShape(CLOSE);
    popMatrix();
  }
  
  void makeBody(Vec2 center){
    PolygonShape sd = new PolygonShape();
    
    Vec2[] vert = new Vec2[3];
    vert[0] = box2d.vectorPixelsToWorld(new Vec2(x1, y1));
    vert[1] = box2d.vectorPixelsToWorld(new Vec2(x2, y2));
    vert[2] = box2d.vectorPixelsToWorld(new Vec2(x3, y3));
    
    sd.set(vert, vert.length);
    
    //Define the body and make it fromt he shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    bd.setBullet(true);
    body = box2d.createBody(bd);
    body.createFixture(sd, 1.0);
    
    //give random velocity
    body.setLinearVelocity(new Vec2(random(50, 100), random(-20, 20)));
    body.setAngularVelocity(random(-5, 5));
    
    
  }
}   
