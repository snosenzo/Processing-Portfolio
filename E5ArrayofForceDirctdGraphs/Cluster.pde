class Cluster {
 
  // A cluster is a grouping of nodes
  ArrayList nodes;
  float col = random(255);
  float diameter;

  // We initialize a Cluster with a number of nodes, a diameter, and centerpoint
  Cluster(int n, float d, Vec2D center) {

    // Initialize the ArrayList
    nodes = new ArrayList();

    // Set the diameter
    diameter = d;

    // Create the nodes
    for (int i = 0; i < n; i++) {
      // We can't put them right on top of each other
      nodes.add(new Node(center.add(Vec2D.randomVector())));
    }

    // Connect all the nodes with a Spring
    for (int i = 1; i < nodes.size(); i++) {
      VerletParticle2D pi = (VerletParticle2D) nodes.get(i);
      for (int j = 0; j < i; j++) {
        VerletParticle2D pj = (VerletParticle2D) nodes.get(j);
        // A Spring needs two particles, a resting length, and a strength
        physics.addSpring(new VerletSpring2D(pi,pj,diameter,.01));
      }
    }
  }


  
  void display(){
    stroke(col, 255, 255, 130);
    fill(col, 255, 255, 30);
    for(int i = 0; i < nodes.size(); i++){
      Node n = (Node) nodes.get(i);
      n.display();
    }
    
    for(int i = 0; i < nodes.size(); i++){
      VerletParticle2D ni = (VerletParticle2D) nodes.get(i);
      for(int j = i+1; j < nodes.size(); j++){
        VerletParticle2D nj = (VerletParticle2D) nodes.get(j);
        line(ni.x, ni.y, nj.x, nj.y);
      }
    }
  }
}
    
  

