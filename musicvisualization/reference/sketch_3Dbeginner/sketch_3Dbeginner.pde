float x,y,z;
float d = 0.1;

void setup() {
  size(1200, 1200, P3D);
  background(100);
  rectMode(CORNER);
  fill(51);
  noStroke();
  frameRate(450);
}

void draw() {
  translate(620,770,0);
  rotateZ(d);
  fill(d);
  rect(200, 200, 100, 100);
  if(d <= 200 ) d = d + 0.1;
  if(d > 200)  d -= 0.1; 
  //clear();
  
}