//Sam Nosenzo
//Creates lines around the mouse then deletes them if they are too far away

import java.util.Iterator;

ArrayList<Lin> ls;


void setup(){
  size(640, 640);
  background(0);
  
  ls = new ArrayList<Lin>();
}

void draw(){
  //background(0);
  fill(0, 20);
  rect(0, 0, width, height);
  if( ls.size() < 50){
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

void mousePressed(){
  background(0);
}

  
  
