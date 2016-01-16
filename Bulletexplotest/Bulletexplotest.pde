//Sam Nosenzo
// 7/4/2015
//Want to creat e physics simulation of whic a bullet is shot into blocks that explode when they collide with the bullet

import java.util.Iterator;
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;


Box2DProcessing box2d;

ArrayList<Proj> ps;
ArrayList<Box> bxs;
ArrayList<Bit> bts;

void setup(){
  
  frameRate(60);
  background(255);
  size(650, 350);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();
  //custom gravity;
  box2d.setGravity(0, -10);
  ps = new ArrayList<Proj>();
  bxs = new ArrayList<Box>();
  bts = new ArrayList<Bit>();
  
  
}

void draw(){
  background(255);
  box2d.step();
  
  for(int i = ps.size()-1; i >= 0; i--){
    Proj p = ps.get(i);
    p.display();
    //Particles that leave the screen we delete
    //need to be deleted from the list and the world
    if(p.done()){
      ps.remove(i);
    }
  }
  
  for(int i = bxs.size()-1; i >= 0; i--){
    Box bx = bxs.get(i);
    bx.display();
    if(bx.done() || bx.alive == false){
      Vec2 pos = box2d.getBodyPixelCoord(bx.body);
      float size = bx.sz;
      bxs.remove(i);
      
      for (int j = 0; j < 2*size; j++){
        bts.add(new Bit(pos.x+random(-size, size), pos.y+random(-size, size)));
    }
    }
  }
  
  for(int i = bts.size()-1; i >= 0; i--){
    Bit bt = bts.get(i);
    bt.display();
    if(bt.done()){
      bts.remove(i);
    }
  }
  
  if(mousePressed){
     //ps.add(new Proj(mouseY));
    //bxs.add(new Box(mouseX, mouseY));
  }
  
  
}





void mousePressed(){
  ps.add(new Proj(mouseY));
  bxs.add(new Box(mouseX, mouseY));

}

void keyPressed(){
  if(key=='s'){
    saveFrame("bulletexplo"+random(3000)+".png");
  }
}
  
  
