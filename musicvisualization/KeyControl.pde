void keyPressed() {

  if (keyCode == 39 | key == 'd') direction = 2;  // move right

  else if (keyCode == 37 | key == 'a') direction = 4;  // move left

}
 
void mouseWheel(MouseEvent event) {
  if(event.getCount()<(-2)) direction = 1;      //move forward
  else if(event.getCount()>2)  direction = 3;    //move backward
  println(event.getCount());
}

// stop dragging the screen
void keyReleased() {
  direction = 0;
}

//control of panel buttons
void mouseClicked(){
    bUp.onClick();
    bDown.onClick();
    bOpen.onClick();
    bPause.onClick();
    
}