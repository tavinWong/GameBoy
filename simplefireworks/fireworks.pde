PImage bg;

int buttonCount = 4;
TriggerButton button1;
TriggerButton button2;


int randomCount = 50;
Fire[] fires0 = new Fire[randomCount+1];

int riseCount = 100;
FireRise[] fireRises = new FireRise[riseCount + 1];

int fireCount1 = 200;
Fire[][] fires = new Fire[riseCount + 1][fireCount1 + 1];


void setup()
{
 
 size(800,600);
 
 colorMode(RGB, 600);
 frameRate(30);
 button1 = new TriggerButton(20,580);
 button2 = new TriggerButton(780,580);
 
 for(int x = buttonCount; x>0; x--){
   
 }
 
   for (int i = 0; i < riseCount ; i++)
   {
     fireRises[i] = new FireRise();
   }
   for (int j = 0 ; j < riseCount ;j ++)
  {  
    for (int k = 0; k < fireCount1 ; k++ ){
    
      fires[j][k] = new Fire(fireRises[j].xPos, fireRises[j].yFinal);
      }
  }
    for (int x = randomCount; x >= 0; x--) {
    fires0[x] = new Fire();
  }
  bg = loadImage("bg.png");
  background(bg); 
}

void draw()
{
  

    background(bg); 

  
  pushMatrix();
  
  //draw buttons
  
  button1.display();
  //button2.display();
  
  //translate(width/2, height/2);
  
  if(button1.mouseToggle == true)
  {
    
    //button1.mouseToggle = false;
   for (int i = 0; i < riseCount ; i++)
   {
     fireRises[i].fireRise();
     if (fireRises[i].reachTop == true)
         for (int k = 0; k < fireCount1 ; k++ ){
    
      fires[i][k].update();
    }
   }   
  }
    
  popMatrix();
}
/**
void emitFire()
{
  pushMatrix();
   for (int j = 0 ; j < riseCount ;j ++)
  {  
    for (int k = 0; k < fireCount1 ; k++ ){
    
      fires[j][k].update();
    }
  }
  popMatrix();
}
**/

void mouseClicked(){
    button1.onClick();
    button2.onClick();
}