//Sam Nosenzo
//7/27/15
//Gonna try to set of a network of nodes that are organically attached to one another
//added some offshoots to make them look more root-like

//main node from which the roots spread from
Node n;

//List of nodes that are added by clicking somewhere on the screen
ArrayList<Node> nodes;
//list of roots protruding from the main node
ArrayList<Root> roots;

void setup(){
  size(800, 800);
  background(0);
  
  //initializing main node and lists
  nodes = new ArrayList<Node>();
  n = new Node(width/2, height-50, 50);
  roots = new ArrayList<Root>();
  
  
}
 
 
void draw(){
  
  n.display();
  //use of a for loop to display the nodes and roots and allow them to function properly
  // the loop is only based off of the number of nodes because the roots and the nodes are added at the same time
  for(int i = 0; i < nodes.size(); i++){
   Node ns = nodes.get(i);
   Root r = roots.get(i);
   //display the nodes as circles, I chose not to display default-ly
   //ns.display();
   if(dist(r.loc.x, r.loc.y, r.targ.x, r.targ.y) > 20){
      if(random(1) > .95){
        //if the distance is greater than a certain amount the root has the chance to create offshoots
        //5% of the time
        r.createOffshoot();
      }
   }
   //operate and display roots
   r.update();
   r.display();
 }
}

void mousePressed(){
  //add node and root each time the mouse is pressed
  Node ns = new Node(mouseX, mouseY, random(10, 25));
  nodes.add(ns);
  
  //The angle makes sure the root is coming out of the side of the main node that is facing the new node
  float angle = PVector.sub(ns.loc, n.loc).heading();
  Root r = new Root(n.loc.x+.5*n.size*cos(angle), n.loc.y+.5*n.size*sin(angle), random(10, 15), ns.loc);
  roots.add(r); 
}
  
  
  
//node class
//I guess all it really does is store a pvector and display an ellipse at its location
class Node{
  PVector loc;
  float size;
  boolean centralNode = false;
  Node(float x, float y, float sz){
    loc = new PVector(x, y);
    size = sz;
  }
  
  void display(){
    stroke(255);
    noFill();
    strokeWeight(size);
    point(loc.x, loc.y);
  }
}
    
    
//slightly based off of the vehicle class in the Nature of code
//tooking the seek function and added a noise function and a few modifications
//and the update function too i guess

//essentially what it does is it creates an object that starts at a location and noisely
//steers itself to its target location
//The display function makes the size of the root based on it's distance from the point


class Root{
  
  //initialization of variable
  PVector loc, vel, acc;
  //stores the path. was going to do something with this
  //could just run a while loop and have it appear at once
  //but I like watching it grow
  ArrayList<PVector> path;
  //This list allows the roots to have smaller offshoots of the same object essentially
  ArrayList<Root> offshoots;
  PVector targ;
  //start of the noise function
  float nx = random(200000); 
  //current size and initial size are stored
  float size, initSize;
  float maxspeed = 3;
  float maxforce = 2;
  float id;
  float noisestart;
  
  
  Root(float x, float y, float sz, PVector tgt){
    loc = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    size = sz;
    targ = tgt.get();
    initSize = sz;
    path = new ArrayList<PVector>();
    offshoots = new ArrayList<Root>();
    //randomizes the noise function a bit more
    noisestart = random(0, TWO_PI);
    //initial distance from point
    id = dist(loc.x, loc.y, targ.x, targ.y);
  }
  
  void update(){
    //always seeks the target if the distance from it is less than 10
    if(dist(loc.x, loc.y, targ.x, targ.y) > 10){

      seek(targ);
    }
    //physics stuff
    vel.add(acc);
    vel.limit(maxspeed);
    loc.add(vel);
    path.add(loc);
    acc.mult(0);
  }
  
  void display(){
    //display offshoots (if any)
    for(Root r: offshoots){
      //only display if they are more than 5 pixels away
     if(dist(r.loc.x, r.loc.y, r.targ.x, r.targ.y) > 5 ){
      r.update();
      r.display();
     }
    }
    //display main root  
    strokeWeight(size);
    stroke(255);
    point(loc.x, loc.y);
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
    
  
  void seek(PVector target){
    PVector desired = PVector.sub(target, loc);
    //store current distance
    float d = desired.mag();
    //map size of the root to the distance
    size = map(d, 0, id, 0, initSize);
    desired.normalize();

    desired.mult(maxspeed); //scale vector to maxspeed;
    //get current direction of target
    float angle = target.heading();
    //add noise to the angle
    angle+=map(noise(nx), 0, 1, -noisestart, TWO_PI-noisestart);
    PVector steer = PVector.sub(desired, vel); //Reynolds formula for steering force
    //create force vector from the noise angle and give it a little strength
    PVector offset = PVector.fromAngle(angle);
    offset.mult(3);
    //add the noise vector to the original steering vector
    steer.add(offset);
    steer.limit(maxforce);
    
    
    applyForce(steer); //apply the force as the object acceleration
    nx+=.5;
  }
  
  void createOffshoot(){
     //adds an offshoot to the root
    Root r = new Root(loc.x, loc.y, size*.5, new PVector(loc.x+random(-50, 50), loc.y+random(-50, 50)));
    offshoots.add(r);
  }
}

