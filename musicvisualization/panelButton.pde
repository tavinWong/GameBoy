class panelButton
{
  int xPos;
  int yPos;
  int bSize = 40;
  int bType;
  
  color c;
  color overC = 150;
  color offC = 0;
  color chosenC = 150;
  
  boolean mouseOver = false;
  boolean mouseToggle = false;
  
  panelButton(int xTemp, int yTemp, int type)
  {
    xPos = xTemp;
    yPos = yTemp;
    bType = type;
  }
  
  void display()
  {
    stroke(50);
    checkMouse();
    fill(c);
    rectMode(CENTER);
    rect(xPos, yPos, bSize, bSize);
  }
  
  void checkMouse(){
    if(dist(mouseX, mouseY, xPos, yPos) < bSize)
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
      c = overC;
    }
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