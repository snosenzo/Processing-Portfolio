

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
    len = random(150, 300);
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

    noFill();
    beginShape();
      stroke(0);
      curveVertex(0, 0);
      for(int i = 0; i < yval.length; i ++){
        stroke(0, i * res);
        curveVertex(i * res, yval[i]);
      }
    endShape();
  }
  
  void display(){
    stroke(0);
    fill(0);
    pushMatrix();
      translate(origin.x, origin.y);
      rotate(radians(angle));
      displayLine();
    popMatrix();
  }

}

  
  
  
  
  
  
