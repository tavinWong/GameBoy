class returnButton{
  
  int posX = 0;
  int posY = 100;
  int buttonWidth = 100 ;
  int buttonHeight = 50 ;
  color c = #274862;
  color overC = #031635 ;
  color focusC = #274862 ;
  
  boolean mouseOver = false;
  boolean mouseToggle = false;
  boolean buttonToggle = true;
  
  void drawButton(){
    noStroke();
    checkMouse();
    fill(c);
    rect(posX, posY, buttonWidth, buttonHeight);
    fill(255);
    triangle(35, 125,65,118,65,132);
  }
  
  void checkMouse(){
    
    if( mouseX > posX && mouseX < 200 && mouseY > posY && mouseY < 140){
     mouseOver = true;
    }
    else {
     mouseOver = false;
    }
    if(mouseToggle || mouseOver){
     c = overC; 
      }
    else {
      c = #274862;
    }
  }
  
  void onClick(){
    
    if(mouseOver){
      if(mouseToggle){
        mouseToggle = false;
      }
      else {
        mouseToggle = true;
        buttonToggle = false ;
      }
     }
    }
  
    boolean getToggle(){
      return buttonToggle;
    }
   
}