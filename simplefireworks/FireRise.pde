class FireRise
{
  int xPos = (int)random(40,760);
  int yPos = (int)random(600,5000);
  color c = color(random(0,255), random(0,255),random(0,255)) ;
  int currentY = yPos;
  int yFinal = (int)random(100, 400);
  
  Boolean reachTop = false;
  
  void fireRise(){
    if(currentY >= yFinal){
      stroke(c);
      strokeWeight(5);
      fill(255);
      //println(currentY);
      ellipse(xPos, currentY, 1, 1 );
      
      currentY -= 6;
    }
    else{
      reachTop = true;
    }
  }
}