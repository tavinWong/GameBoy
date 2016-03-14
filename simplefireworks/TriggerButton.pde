class TriggerButton
{
  int xPos;
  int yPos;
  int bSize = 40;
  
  
  color c;
  color overC = 150;
  color offC = 200;
  color chosenC = 0;
  
  boolean mouseOver = false;
  boolean mouseToggle = false;
  
  TriggerButton(int xTemp, int yTemp)
  {
    xPos = xTemp;
    yPos = yTemp;
    
  }
  
  void display()
  {
    noStroke();
    checkMouse();
    fill(c);
    rectMode(CENTER);
    rect(xPos, yPos, bSize, bSize);
  }
  
  void checkMouse(){
    if(dist(mouseX, mouseY, xPos, yPos) < 40)
    {
      mouseOver = true;
    }
    else{
      mouseOver = false;
    }
    if(mouseOver){
      if(mouseToggle){
      c = chosenC;
    }else{
      c = overC;}
    }else{
      if(mouseToggle){
      c = chosenC;
    }else{
      c = offC;}
    }}
  
  void onClick() {
    if(mouseOver){
      if(mouseToggle){
        mouseToggle = false;
      }else{
        mouseToggle = true;
      }
    }
    
  }
}