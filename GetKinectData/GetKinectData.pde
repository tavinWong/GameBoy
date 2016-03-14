import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Table table;
Kinect kinect;
float[] depthLookUp = new float[2048];
TableRow dataRow[] = new TableRow[20000];
int count;
void setup() {
  size(400, 600);
  kinect = new Kinect(this);
  kinect.initDepth();
  count = 0;
  table = new Table();
  
  table.addColumn("x");
  table.addColumn("y");
  table.addColumn("z");
  
  for (int i = 0; i < depthLookUp.length; i++) {
    depthLookUp[i] = rawDepthToMeters(i);
  }
}

void draw(){
  //noLoop();
  background(0);
  int[] depth = kinect.getRawDepth();
  int skip = 4;
  
  for (int x = 0; x < kinect.width; x += skip) {
    for (int y = 0; y < kinect.height; y += skip) {
      int offset = x + y*kinect.width;
      int rawDepth = depth[offset];
      PVector v = depthToWorld(x, y, rawDepth);
      noStroke();
      fill(200);
      ellipse((int)(1000*v.x+200),(int)(100*v.z), 5, 5);
      /**
      dataRow[count] = table.addRow();
      dataRow[count].setFloat("x", v.x);
      dataRow[count].setFloat("y", v.y);
      dataRow[count].setFloat("z", v.z);
      count++;**/
      
    }
  }
}
 
    
    
    
    
float rawDepthToMeters(int depthValue) {
  if (depthValue < 2047) {
    return (float)(1.0 / ((double)(depthValue) * -0.0030711016 + 3.3309495161));
  }
  return 0.0f;
}

PVector depthToWorld(int x, int y, int depthValue) {

  final double fx_d = 1.0 / 5.9421434211923247e+02;
  final double fy_d = 1.0 / 5.9104053696870778e+02;
  final double cx_d = 3.3930780975300314e+02;
  final double cy_d = 2.4273913761751615e+02;

  PVector result = new PVector();
  double depth =  depthLookUp[depthValue];//rawDepthToMeters(depthValue);
  result.x = (float)((x - cx_d) * depth * fx_d);
  result.y = (float)((y - cy_d) * depth * fy_d);
  result.z = (float)(depth);
  return result;
}