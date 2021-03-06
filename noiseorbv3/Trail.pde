

class Trail{
  PVector origin, end;
  float angle, len;
  float decay;

  float res = 5;
  //initiate noise variables
  float nx = 1;
  float ny = len;
  float nz;
  
  int arrlen;
  float[] yval ;
  
  Trail(float x, float y, float a){
    origin = new PVector(x, y);
    angle = a;
    len = random(300, 500);
    decay = random(2);
    nz = a * a * a;
    arrlen = int( len/res);
    yval = new float[arrlen];
    getLine();
  }
  

  
  void getLine(){
    for (float i = 0; i < yval.length; i++){
      yval[int(i)] = map(sin(ny+i/10)*noise(nx+i/10, ny, nz), -1, 1, -i*5, i*5);
    }
    ny+=.01;
  }
  
  void displayLine(){
    getLine();

    
       stroke(0, 10);
       noStroke();
    beginShape();
   
      curveVertex(0, 0);
      for(int i = 0; i < yval.length; i ++){
        
        curveVertex(i * res, yval[i]);
      }
    endShape(CLOSE);
  }
  
  void display(){
    stroke(0);
    fill(0, 5);
    pushMatrix();
      translate(origin.x, origin.y);
      rotate(radians(angle));
      displayLine();
    popMatrix();
  }

}

  
  
  
  
  
  
