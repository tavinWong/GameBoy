import ddf.minim.analysis.*;
import ddf.minim.*;

//audio variables
Minim minim,minim1;
AudioPlayer player;
FFT fft;
FFT fft0;
AudioInput in;
float[] angle;
float[][]y = new float[50000][1050];
float[][]x = new float[50000][1050];
float[] x1,x2;
int zCount;

//Panel buttons

panelButton bUp,bDown,bOpen,bPause;

//camera variables
PVector camP = new PVector(1000, 0, 0); // camera position
PVector camF_abs = new PVector();     // camera focus (absolute position)
PVector camF_rel = new PVector();     // camera focus (relative vector)
float camDir, camElev;                // last camera bearing/elevation angles
float mx, my;                         // last mouse X/Y
float MouseX, MouseY;                 // replicate inbuilt mouse variables
float scaleY;                         // scale mouseY inputs to vertical movement
float scaleX;                         // scale mouseX inputs to horizontal movement
int direction = 0;                    // code for controling movement
float moveSpeed = 10;                 // overall controls responsiveness
float sumTemp = 0;
int checkTime = 0;

PGraphics pg;
PImage bg;
PImage pause, down, up, open;

MouseEvent event;

void setup()
{
  size(1980, 1080, P3D);
  minim = new Minim(this);
  minim1 = new Minim(this);
  in = minim1.getLineIn(Minim.STEREO, 2048, 192000.0);
  player = minim.loadFile("viva.mp3");
  fft = new FFT(player.bufferSize(), player.sampleRate());
  fft0 = new FFT(in.bufferSize(), in.sampleRate());
  x1 = new float[fft0.specSize()];
  x2 = new float[fft0.specSize()];
  angle = new float[fft0.specSize()];
  zCount = 0;

  // initialise camera variables
  scaleY = PI/height;
  scaleX = PI/width;
  camDir = 2.8;
  camElev = 2.96;
  MouseX = 1364;
  MouseY = 278;

  camF_rel = setVector(camDir, camElev);
  camP.x = 1281;
  camP.y = -690;
  camP.z = 836;
  camF_abs.x = 1281;
  camF_abs.y = -690;
  camF_abs.z = 836;
  frameRate(240);
  
  //initialize interacting interface
  pg = createGraphics(220,200);
  
  //initi panel button
  bUp = new panelButton(260,120,1);
  bDown = new panelButton(260,200,2);
  bOpen = new panelButton(160,120,3);
  bPause = new panelButton(160,200,4);
}
 
void draw()
{
  background(0);
  
  //draw coordinates just for testing
  stroke(255,0,0); //z red
  //line(0,0,0,0,0,1000);
  stroke(0,255,0);//y green
  //line(0,0,0,0,1000,0);
  stroke(0,0,255);//x blue
  //line(0,0,0,1000,0,0);
  
  
  //initialize interacting interface
  hint(DISABLE_DEPTH_TEST);
  camera();
  noLights();
  // 2D code
  pg.beginDraw();
  //bg = loadImage("bg.png");
  pg.background(50); 
  
  open = loadImage ("open.png");
  pg.image(open,40,20);
  up = loadImage ("up.png");
  pg.image(up,124,20);
  down = loadImage ("down.png");
  pg.image(down,124,114);
  pause = loadImage ("pause.png");
  pg.image(pause,40,114);
  
  bUp.display();
  bDown.display();
  bOpen.display();
  bPause.display();
    if(bPause.mouseToggle){
    println("Pause 1");
    bPause.mouseToggle = false;
    if(player.isPlaying())
    {
      player.pause();
    }
    else
    {
      player.loop();
    }
  }
    else if(bOpen.mouseToggle){
    //selectInput("Select a file to process:", "fileSelected");
    direction = 0;
    bOpen.mouseToggle = false;
  }
  else if(bUp.mouseToggle){
    //bUp.mouseToggle = false;
    direction = 5;
  }
    else if(bDown.mouseToggle){
    //bDown.mouseToggle = false;
    direction = 6;
  }
  else if(!bUp.mouseToggle ||!bDown.mouseToggle ){
    if(direction !=1 && direction != 3)
    direction = 0;
  }

  else if(bPause.mouseToggle){
    bPause.mouseToggle = false;
    if(player.isPlaying())
    {
      player.pause();
    }
    else
    {
      player.loop();
    }
  }
  
  pg.endDraw();
  image(pg,100,300);
  
  hint(ENABLE_DEPTH_TEST);

  
   
   
  setCamera();
  
  //println("x: "+mx+" y: "+my);
  //println("camDir: "+camDir+" camElev: "+camElev);
  camera(camP.x, camP.y, camP.z, camF_abs.x, camF_abs.y, camF_abs.z, 0, 0, -1);
  //println("x: "+camF_abs.x +" y: "+camF_abs.y+" z: "+camF_abs.z);
  if(mousePressed)
  {
    if(checkTime < 2)
    {
      mx = constrain(mouseX, 0, width);
      my = constrain(mouseY, 0, height);
      checkTime ++;
    }
    else
    {
      MouseX = constrain(mouseX, 0, width);
      MouseY = constrain(mouseY, 0, height);
      turnCamera();
    }
  }
  else
  {
    checkTime = 0;
  }
  //player.play();
  fft.forward(player.mix);
  audioVisual();
  fft0.forward(in.mix);
  audioVisual3();

}
 

void stop()
{
  player.close();
  minim.stop();
 
  super.stop();
}