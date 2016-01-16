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
  n = new Node(width/2, height/2, 50);
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
  
  
  
