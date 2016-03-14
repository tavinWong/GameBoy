class Hist{
  
  int year;
  int number;
  
  int xSize = 25 ;
  int ySize = 50 ;
  
  int Xpos = 1250;
  boolean mouseToggle = false;
  boolean mouseOver = false;
 
  int timelinetemp;
  int order ;
  int yLevel = 0;
  int highest ;
  int count ;
  int k;
  
  Hist(int year0, int number0, boolean Toggle0, int timeline0, int count0){
    
    year = year0;
    number = number0;
    mouseToggle = Toggle0;
    timelinetemp = timeline0;
    
    count = count0;
  }
  
  void diplayHist(){

    
    highest = number/10;
    order = year - 2004;
    
    int basePos = Xpos + dx * timelinetemp;
    int d = 5;
    
    //title
    fill(255);
    textSize(40);
    textAlign(CENTER);
    text("Number of Startups Every Year", 1500 +timelinetemp * dx, 135);
    
    textSize(12);
    text("2004     2005     2006     2007     2008     2009     2010     2011     2012     2013", 15+1500 +timelinetemp * dx, 650);
    text("500",1200 +timelinetemp * dx , 550);
    text("1000",1200 +timelinetemp * dx , 500);
    text("1500",1200 +timelinetemp * dx , 450);
    text("2000",1200 +timelinetemp * dx , 400);
    text("2500",1200 +timelinetemp * dx , 350);
    
    
    //draw coordinates
    stroke(#274862);
    strokeWeight(2);
    fill(#274862);
    
    line(basePos, 600 , basePos +20 * xSize + 40 , 600);
    triangle(basePos +20 * xSize + 40, 600 - d ,basePos +20 * xSize + 40, 600 +d ,basePos +20 * xSize + 40 +20, 600);
    
    line(basePos, 600 , basePos, 600 - 6 * ySize);
    triangle(basePos+d,600 - 6 * ySize, basePos-d, 600 - 6 * ySize, basePos, 600 - 6 * ySize -20 );
    
    //check toggle
    if(dx == -36 && count <= 300){
      
      if(count < highest){
        strokeWeight(1);
          for(k = 0; k < count ; k ++){
            stroke(#d96831);
            line(basePos + xSize + xSize * order * 2, 600 - k ,basePos + xSize * (order+1) * 2, 600 - k);
            
          }
        }
        else {
          fill(#e6b33d);
          rect(basePos + xSize + xSize * order * 2, 600, xSize, -highest);
          fill(255);
          text(number, basePos + xSize * (order+1) * 2 - 5 ,300);
        }
      count ++ ;
    }
    else if (dx == -36){
      fill(#e6b33d);
      rect(basePos + xSize + xSize * order * 2, 600, xSize, -highest);
      fill(255);
      text(number, basePos + xSize * (order+1) * 2 - 5 ,300);
    }
    
  }
  
}