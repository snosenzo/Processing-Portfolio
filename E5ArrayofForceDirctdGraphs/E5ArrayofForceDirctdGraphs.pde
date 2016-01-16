//Sam Nosenzo
//Nature of Code -- Section 5.15
//This program shows the basic setup of a toxiclibs program

import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;


VerletPhysics2D physics;
// Boolean that indicates whether we draw connections or not
boolean showPhysics = true;
boolean showParticles = true;

ArrayList<Cluster> cs;

void setup(){
  colorMode(HSB);
  size(800, 800);
  physics = new VerletPhysics2D();
  cs = new ArrayList<Cluster>();
  
}

void draw(){
  stroke(0);
  physics.update();
  background(255);
  for(Cluster c: cs){
    c.display();
  }

}

void mousePressed(){
   Cluster c = new Cluster((int) random(3, 14), random(100, 200), new Vec2D(mouseX, mouseY));
   cs.add(c);
}

void keyPressed(){
  if(key=='s'){
    saveFrame("fdg"+(int)random(200)+".png");
  }
}
