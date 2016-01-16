


void setup(){
  size(800, 800);
  background(0);
  stroke(255);
  noFill();
  smooth();
}
float spacing = 7;
float res = 1;
float nx = 0, ny = 0, nz = 0;
float maxd = 200;
void draw(){
  //background(0);
  fill(0, 10);
  rect(0, 0, width, height);
  
  for(int i = 0;i < height; i+=spacing){
    if(dist(0, mouseY, 0, i) < 10 || mousePressed ){
    beginShape();
    for(int j = 0; j < width; j+=res){
      
      float d = dist(mouseX, mouseY, j , i);
      if( d > maxd) d = maxd;
      
      float amp = map(d, 0, maxd, 50, 0);
      float x = j;
      float y = i + map(noise(nx+j*res/100, ny+i*res/100, nz), 0, 1, -amp, amp);
      vertex(x, y);
    }
    endShape();
    }
    }
    ny-=.01;
    nz+=.01;
}
