import java.io.*;

Table table1;
Table table2;

//Table 1 variables
String[] destinations;
float[] destValue;
int count = 0;
Pie[] pies ;
float stageSum = 0;

//Table 2 variables
int[] years;
int[] numbers;
int count1 = 0;
Hist[] hists ;
int count0 = 0;

//timeline variables
int timeline = 0;
int dx = -10;

boolean Toggle = false;
boolean Over = false;
returnButton rb = new returnButton();

void setup(){
 size(1050,800);
 smooth();
 frameRate(40);
 table1 = loadTable("schoolleaverdestinations.csv", "header");
 table2 = loadTable("businessstartups.csv", "header");
 destinations = new String[15]; 
 destValue = new float[15];
 years = new int[15];
 numbers = new int[15];
 
 //noLoop();
}

void draw(){
  
 background(#172c3c);

 count = 0;
 count1 = 0;
 for (TableRow row : table1.rows ()){
   
   destinations[count] = row.getString("Number of leavers");
   String tempString = row.getString("percentage").replace("%","");
   destValue[count] = Float.parseFloat(tempString); 
   count ++;
   
 }
 
 pies = new Pie[count+1];
 
 for (int i = 0; i <= count ;i ++){
   
   pies[i] = new Pie(destinations[i], destValue[i], stageSum, Toggle, timeline);
   stageSum += destValue[i];  
   pies[i].displayPie();
 }
 

 
 for (TableRow row1 : table2.rows()){
   years[count1] = row1.getInt("Year");
   numbers[count1] = row1.getInt("Number");
   count1 ++;
 }
 
 hists = new Hist[count1+1];
 
 for (int j = 0;j <=count1 ; j++){
  
   hists[j] = new Hist(years[j], numbers[j], Toggle, timeline, count0);
   hists[j].diplayHist();
 }
 
 if(Toggle){
   if(count0 > 10)
   rb.drawButton();
   if(!rb.getToggle()){
     Toggle = rb.getToggle();
     rb.buttonToggle = true ;
     count0 = 0;
   }

 }
 
 
 //-------------check Toggle------------------------
 if(Toggle) {
   
   if (timeline < 26 ){
     timeline ++;
     dx -- ;
   }
   else if( timeline == 26 && dx < 0){
     count0 ++;
   }
 }
 else{
  
   if(timeline > 0){
     timeline -- ;
     dx ++;
   }
   
   /** old method
  timeline = 0 ;
  dx = -10 ;
  **/
 }
 
 //-------------------draw Button----------------------
 
 
 stageSum = 0;
 fill(200);
 
}

void mouseClicked(){
  rb.onClick();
  for(int i =0; i < pies.length ; i++){
    pies[i].onClick(); 
    Toggle = pies[i].mouseToggle;
  }
}