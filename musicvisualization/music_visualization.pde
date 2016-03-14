//the visualization of music from inner file.
void audioVisual() {
  if(zCount == 50000)
  {
   zCount = 0; 
  }
  sumTemp = 0;
  noStroke();
  pushMatrix();
  //translate(width/4,3*height/5);
  for (int i = 0; i < fft.specSize() ; i++) {
    y[zCount][i] = fft.getBand(i);
    x[zCount][i] = fft.getFreq(i)/100;
    sumTemp += fft.getBand(i);
  }
  int sum = (int)sumTemp/400;
  float sumFinal = sum * 0.1;
  //println("sumFinal: "+sumFinal);
  //println(zCount);
  for (int j = 0; j <= zCount; j++ ){
     
    for (int i = 0; i < fft.specSize() ; i++) {
      //stroke(0,200,map(y[i],0,4,0,255));
      //stroke(255-5*(zCount-j), x[j][i]*100, 0);
      
      if((zCount - j)<= 100){
        if(zCount - j<1) stroke(#FAF600);
        if(zCount - j>=1)
        stroke(255-5*(zCount-j), x[j][i]*100, 0);
        line(-10*(zCount-j),i*(1+sumFinal),1,-10*(zCount-j),i*(1+sumFinal),x[j][i]*200);
      }
    }
  }
  zCount ++;
  popMatrix();  
}

//the visualization of audience data
void audioVisual3(){
  pushMatrix();
  //translate(-500,500, 500);
  for (int i = 0; i < fft.specSize() ; i++) {
    pushMatrix();
    angle[i] = angle[i] + fft0.getFreq(i);
    rotateZ(cos(angle[i]/2));
    rotateX(sin(angle[i]/2));
    rotateY(sin(angle[i]/2));
    translate((int)random(-1000,1000),(int)random(-1000,1000),(int)random(-1000,1000));
    fill(200, 255-fft0.getFreq(i)*20,255);
    box(3*fft0.getBand(i));
    popMatrix();
  }
  popMatrix();
}