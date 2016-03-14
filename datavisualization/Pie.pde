class Pie{
  
  String destination;
  float percentage;
  float stage;

  color c =#274862;
  color overC = color(60+random(10), 89, 79);
  color hC = color(157, 120, 93);
  color aC = color(178 , 190, 126);
  color vC = color(114, 111, 128);
  color tC = color(56, 13, 49);
  color fC = color(89, 61, 67);
  
  boolean mouseToggle = false;
  boolean mouseOver = false;

  int Xpos = width/2;
  
  int timelinetemp ;
  
  Pie(String dest, float percentage0, float stage0, boolean Toggle0, int timeline0){
    
    destination = dest;
    percentage = percentage0;
    stage = stage0;
    mouseToggle = Toggle0;
    
    timelinetemp = timeline0;
  }
  
  void displayPie(){
    
    //title
    fill(255);
    textSize(40);
    textAlign(CENTER);
    text("University Leavers Destinations", 550 +timelinetemp * dx, 100);
    
       
    //note
    textSize(15);
    textAlign(LEFT);
    fill(c);
    rect(100 + timelinetemp * dx, 600 , 20 ,-10 );
    text("Unemployed or Unknown", 150 + timelinetemp * dx, 600);
    fill(hC);
    rect(100 + timelinetemp * dx, 620 , 20 ,-10 );
    text("Higher Education", 150 + timelinetemp * dx, 620);
    fill(fC);
    rect(100 + timelinetemp * dx, 640 , 20 ,-10 );
    text("Further Education", 150 + timelinetemp * dx, 640);
    fill(tC);
    rect(100 + timelinetemp * dx, 660 , 20 ,-10 );
    text("Training", 150 + timelinetemp * dx, 660);
    fill(overC);
    rect(100 + timelinetemp * dx, 680 , 20 ,-10 );
    text("Employment", 150 + timelinetemp * dx, 680);
    fill(vC);
    rect(100 + timelinetemp * dx, 700 , 20 ,-10 );
    text("Voluntary Work", 150 + timelinetemp * dx, 700);
    fill(aC);
    rect(100 + timelinetemp * dx, 720 , 20 ,-10 );
    text("Activity Agreement", 150 + timelinetemp * dx, 720);
    
    stroke(#172c3c);
    strokeWeight(5);
    
    checkMouse();
    
    //color check
    if(destination != null) {
      checkMouse();
      Character c3 = destination.charAt(0);
      if(c3.equals('U') ){
        fill(c);
      }
      else if (c3.equals('H')){
        fill(hC);
        println("1");
      }
      else if (c3.equals('F')){
        fill(fC);
      }
      else if (c3.equals('T')){
        fill(tC);
      }
      else if (c3.equals('E')){
        fill(overC);
      }
      else if (c3.equals('V')){
        fill(vC);
      }
      else if (c3.equals('A')){
        fill(aC);
      }
      
    }
    //check Toggle
    if(Toggle == true){
      Xpos = Xpos +timelinetemp * dx ;

      arc(Xpos,height/2,500,500, stage/50 * PI - PI/2 , (stage + percentage)/50 * PI - PI/2 - PI/100 );
    }
    else
    {
      Xpos = Xpos +timelinetemp * dx ;
      arc(Xpos,height/2,500,500, stage/50 * PI - PI/2 , (stage + percentage)/50 * PI - PI/2 - PI/100 );
    }
  }
  
  
  void checkMouse(){
    
    if(dist(mouseX,mouseY,width/2,height/2) < 250 && mouseX - mouseY < 100 && mouseY +0.54 * mouseX <688){
      mouseOver = true ;
      fill(255);
      textSize(18);
      text("Check the amount of startups ",30 +timelinetemp * dx , 280);
    }
    else{
      mouseOver = false ;
    }
    if(mouseToggle || mouseOver){
      overC = #d96831; 
    }
   
  }
  
  void onClick(){
    
    if(mouseOver){
      if(mouseToggle){
        mouseToggle = false;
      }
      else {
      mouseToggle = true;
      }
    } 
  }
  
  int timeLine(){
    return timelinetemp;
  }
}