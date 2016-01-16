//Sam Nosenzo
//Nature of Code -- Section 5.15
//This program shows the basic setup of a toxiclibs program

import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;

float len  = 200;
float strength = 0.01;

VerletSpring2D spring1;
VerletSpring2D spring2;
Particle p1, p2, p3;

void setup(){
  size(800, 800);
  background(255);
  stroke(0, 50);
  //Initialization of all of the objects
  p1 = new Particle(new Vec2D(width/2, 20));
  p2 = new Particle(new Vec2D(500, 20));
  p3 = new Particle(new Vec2D(600, 20));
  spring1 = new VerletSpring2D(p1, p2, len, strength);
  spring2 = new VerletSpring2D(p2, p3, len, strength);
  physics = new VerletPhysics2D();
  //World Setup and additions
  physics.setWorldBounds(new Rect(0, 0, width, height));
  physics.addBehavior(new GravityBehavior(new Vec2D(0, 0.1)));
  physics.addParticle(p1);
  physics.addParticle(p2);
  physics.addParticle(p3);
  physics.addSpring(spring1);
  physics.addSpring(spring2);
}

void draw(){
  //display particle and move world along
  //background(255);
  physics.update();
  p1.x = mouseX;
  p1.y = mouseY;
  /*
  p1.display();
  p2.display();
  p3.display();
  */
  line(p1.x, p1.y, p2.x, p2.y);
  line(p2.x, p2.y, p3.x, p3.y);
}

void mousePressed(){
  background(255);
}


void keyPressed(){
  if(key=='s'){
    saveFrame("dblpend"+(int) random(1000)+".png");
  }
}
