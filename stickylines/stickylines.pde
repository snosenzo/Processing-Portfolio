//Sam Nosenzo
//Creates lines around the mouse then deletes them if they are too far away
//try to make it so that the lines move to the next step
//try lerp

import java.util.Iterator;

ArrayList<Lin> ls;


void setup(){
  size(640, 640);
  background(0);
  
  ls = new ArrayList<Lin>();
}

void draw(){
  background(0);
  if( ls.size() < 100){
    for(int i = 0; i < 10; i++){
    ls.add(new Lin());
    }
  }
  
  Iterator<Lin> it = ls.iterator();
  
  while(it.hasNext()){
    Lin l = it.next();
    l.display();
    if(l.tooFar()){
      it.remove();
    }
  }
}

  
  
