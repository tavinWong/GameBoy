int num = 2;
int circleSize = 90;
PImage img;

void setup() {
 size(1600,1000); 
 img = loadImage("moon-wide.jpg");
}

void draw() {
  noLoop();
  for(int i = 0; i < num; i++){
     drawCircle(int(random(width)), int(random(height))); 
  }
}

void drawCircle(int xPos, int yPos){
  noFill();
  strokeWeight(1);
  
  for (int i = circleSize; i > 0; i--){
    stroke(200,20,20,180 - circleSize);
    ellipse(xPos, yPos, i, i);
  }

}