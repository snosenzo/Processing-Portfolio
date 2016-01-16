import java.util.Iterator;
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


class Proj{
  float y;
  float x1, y1, x2, y2, x3, y3;
  float mass;
  Body body;
  
  Proj(float y_){
    y = y_;
    mass = 1;
    x1 = 10*mass*cos(0);
    y1 = 10*mass *sin(0);
    x2 = 10 * mass * cos(PI-PI/8);
    y2 = 10 * mass * sin(PI-PI/8);
    x3 = 10 * mass * cos(PI+PI/8);
    y3 = 10 * mass * sin(PI+PI/8); 
    
    makeBody(new Vec2(0, y));
    body.setUserData(this);

  }
  
  void killBody(){
    box2d.destroyBody(body);
  }
  
  boolean done(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    if(pos.y> height || pos.x > width){
      killBody();
      return true;
    }
    return false;
  }
  
  
  boolean contains(float x, float y){
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }
 
  
  
  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    //get rotation
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
      vertex(v.x, v.y);
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
    
    FixtureDef fd = new FixtureDef();
    fd.shape = sd;
    //Parameters that affect physics
    fd.density = 1000;
    fd.friction = .3;
    fd.restitution = .9;
    
    
    
    //Define the body and make it fromt he shape
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    bd.setBullet(true);
    
    
    body = box2d.createBody(bd);
    body.createFixture(fd);
    
    //give random velocity
    body.setLinearVelocity(new Vec2(random(1000, 10000), 0));
    body.setAngularVelocity(0);
    
    
  }
  
  
}
    
    
    
