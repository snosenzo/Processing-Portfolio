class Lin{
  PVector end;
  float maxd = 100;
  Lin(){
    end = new PVector();
    end.x = random(mouseX-maxd, mouseX+maxd);
    end.y = random(mouseY-maxd, mouseY+maxd);
    
  }
  
  void display(){
    stroke(255, 50);
    line(mouseX, mouseY, end.x, end.y);
  }
  
  boolean tooFar(){
    float d = dist(mouseX, mouseY, end.x, end.y);
    boolean u = false;
    if(d <= maxd+50){
      u = false; 
   
    }
    else if(d > maxd+50){
      u = true;

    }
   return(u);
  }
}
