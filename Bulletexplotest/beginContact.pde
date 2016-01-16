
//Collision event functions

void beginContact(Contact cp){
  //Get both fixtures
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  //get both Bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
  //Get our object that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();
  
  //If object 1 is a Projectile then Object 2 must be a box
  //note that we are ignoring particle on particle collisions
  if(o1.getClass() == Proj.class && o2.getClass() != Bit.class && o2.getClass() != Proj.class){
    Box b = (Box) o2;
    b.alive = false;
    

  
    
  }
  //If object 2 is a Projectile, then object 1 is a box
  else if(o2.getClass() == Proj.class && o1.getClass() != Bit.class && o1.getClass() != Proj.class){
    Box b = (Box) o1;

    b.alive = false;
    
   
    //Put particle shatter class here
    
   // println("This should be working for some reason");
    
  }
}

void endContact(Contact cp){
}


