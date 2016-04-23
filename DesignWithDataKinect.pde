import processing.serial.*;

import oscP5.*;
import netP5.*;

import SimpleOpenNI.*; 

OscP5 oscP5;
NetAddress myRemoteLocation;
SimpleOpenNI  context; 

Serial myPort;

PImage img;

String textString1;
String textString2;
String textString3;

float xpos = 0;
int leftd = 750;
int dataSent[];
int dataSentMax[];
int dataSentMin[];

int muiltP[];
int muiltD[];
float pixelB[];

int time = 1000;

boolean startTrack;
void setup(){
  frameRate(10);
  size(800, 600); 
  background(255);
  startTrack = false;
  context = new SimpleOpenNI(this);
 
  context.enableDepth(); 
  context.enableUser(); 
  context.setMirror(true); 

  //img=createImage(640,480,RGB);
  //img.loadPixels();
  
  //load image
  img = loadImage("painting.jpg");
  img.loadPixels();
  loadPixels();
  
  muiltP = new int[5];
  muiltD = new int[5];
  dataSent = new int[3];
  dataSentMax = new int[3];
  dataSentMin = new int[3];

  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
  //oscP5 = new OscP5(this,11000);
  //myRemoteLocation = new NetAddress("172.20.88.2",10000);


  pixelB = new float[480000];
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      int loc1 = x + y*img.width;
      pixelB[loc1] = 0;
    }
  }

}
 
void draw(){

  //background(255);
  image(img, 0, 0);
  context.update();
  
           /** depth image and people color
            PImage depthImage=context.depthImage();
            depthImage.loadPixels();
           
            //get user pixels - array of the same size as depthImage.pixels, that gives information about the users in the depth image:
            // if upix[i]=0, there is no user at that pixel position
            // if upix[i] > 0, upix[i] indicates which userid is at that position
            int[] upix=context.userMap();
           
            //colorize users
            
            for(int i=0; i < upix.length; i++){
              if(upix[i] > 0){
                //there is a user on that position
                //NOTE: if you need to distinguish between users, check the value of the upix[i]
                img.pixels[i]=color(0,0,255);
              }else{
                //add depth data to the image
               img.pixels[i]=depthImage.pixels[i];
              }
            }
            img.updatePixels();
            image(img,0,0);
            **/
  
  int[] users=context.getUsers();
   if(users.length == 0){
     
     startTrack = false;
   }
  ellipseMode(CENTER);
   dataSent[2] = 2000; //default depth value for tracking
  //iterate through users
  for(int i=0; i < users.length; i++){
    startTrack = true;
    int uid=users[i];
    
    //draw center of mass of the user (simple mean across position of all user pixels that corresponds to the given user)
    PVector realCoM=new PVector();
    
    //get the CoM in realworld (3D) coordinates
    context.getCoM(uid,realCoM);
    PVector projCoM=new PVector();
    
    //convert realworld coordinates to projective (those that we can use to draw to our canvas)
    context.convertRealWorldToProjective(realCoM, projCoM);
    fill(255,0,0);
    ellipse(projCoM.x,projCoM.y,10,10);
    
    //track the closest user for transmitting the data.
    if(projCoM.z < dataSent[2]){
     dataSent[0] = (int)projCoM.x;
     //dataSent[1] = (int)projCoM.y;
     dataSent[2] = (int)projCoM.z; 
    }
    
    //text("User: " + i, (leftd + i*200) , 50);
    
    muiltP[i] = (int)(projCoM.x * 800 / 640);
    muiltD[i] = (int)(projCoM.z/500); 
    //check if user has a skeleton
    if(context.isTrackingSkeleton(uid)){
      //draw head
      PVector realHead=new PVector();
      
      //get realworld coordinates of the given joint of the user (in this case Head -> SimpleOpenNI.SKEL_HEAD)
          context.getJointPositionSkeleton(uid,SimpleOpenNI.SKEL_HEAD,realHead);
      PVector projHead=new PVector();
      context.convertRealWorldToProjective(realHead, projHead);
      fill(0,255,0);
      ellipse(projHead.x,projHead.y,10,10);
      
     if(projCoM.z > dataSent[2]){
       dataSent[1] = (int)projHead.y;
      }
                    /** draw left hand
                    PVector realLHand=new PVector();
                    context.getJointPositionSkeleton(uid,SimpleOpenNI.SKEL_LEFT_HAND,realLHand);
                    PVector projLHand=new PVector();
                    context.convertRealWorldToProjective(realLHand, projLHand);
                    fill(255,255,0);
                    ellipse(projLHand.x,projLHand.y,10,10);
                    **/
 
    }
  }

  int temp = 0;
  if(time < millis()){
 
   myPort.write("a" + dataSent[0] + "," + temp + ","+ temp +"\n");
   time += 10000; 
   for(int k = 0 ; k<3; k++){
     
     dataSentMax[k] = (dataSentMax[k] > dataSent[k])? dataSentMax[k]:dataSent[k];
     dataSentMin[k] = (dataSentMin[k] < dataSent[k])? dataSentMin[k]:dataSent[k];
     
   }
   
   println("*******datasent*******");
   println(dataSent);
   //println(dataSentMin);
   //println("-------max,min-------");
   
  }
 

  fadeImage();

 
}
 



