class Fire
{
  PVector current ;
  PVector previous;
  
  float velocity;
  float xDegree; 
  float gravity = 0;
  
  Fire(int xPosTemp, int yPosTemp){
    current = new PVector(xPosTemp, yPosTemp);
    xDegree = random(0,628) * 0.01;
    velocity = random(1,20);
    PVector current = new PVector(0,0);  
  }naw  
  
  Fire(){
    current = new PVector((int)random(50, 750), (int)random(50,500));
    xDegree = random(0,628) * 0.01;
    velocity = random(1,20);
    PVector current = new PVector(0,0); 
  }
  
  void update(){

     previous = current.get();
     PVector next = new PVector(velocity* cos(xDegree), velocity*sin(xDegree)+gravity);
     current.add(next);
     
     gravity += 0.3;
     velocity *=0.98;
     drawLine(current, previous);
     
  }
  
  void drawLine(PVector begin, PVector end) {
    if((6 - gravity/2)>1)
    strokeWeight(6 - gravity/2);
    else
    strokeWeight(1);
    stroke(color((500 - begin.y), (500 - begin.x),255));
    line(begin.x,begin.y,end.x,end.y);
  }
}