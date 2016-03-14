void setCamera() {
  camF_rel = setVector(camDir, camElev);
  if (direction >= 1 & direction <= 4) moveCamera(moveSpeed);
  if (direction >= 5 & direction <= 6) elevCamera(moveSpeed);
 
    camF_abs = camF_rel.get();
  camF_abs.add(camP);
}
PVector setVector(float dir, float elev){
  //generic function to calculate the PVector based on radial coordinates
  PVector v = new PVector(cos(dir), sin(dir), 0);
  float fz = -sin(elev);
  float fy = sqrt(1-pow(fz, 2));
  v.mult(fy);
  v.z = fz;
  return(v);
}
 
 
void moveCamera (float speed) {
  PVector moveto = new PVector();

  if (direction%2 == 0) {
    float dir = 0;
    if (direction == 2) dir = camDir + PI;  // move right
    else                dir = camDir - PI;  // move left
    PVector v = setVector(dir, 0);
    v.mult(speed);
    camP.add(v);
  }
 
  else {
    moveto = camF_rel.get();
    if (direction == 1) moveto.mult(-1); // forward
  }
 
  moveto.normalize();
  moveto.mult(speed);
  camP.sub(moveto);
}
 

void turnCamera(){
    float x = mx - MouseX;
    float x_scaled = x * scaleX;
    float y = my - MouseY;
    float y_scaled = y * scaleY;
    camDir += x_scaled;
    camElev -= y_scaled;
    mx = MouseX;
    my = MouseY;
}
void turnCameraS(){
    float x = mx - MouseX;
    float x_scaled = x * scaleX;
    float y = my - MouseY;
    float y_scaled = y * scaleY;
    camDir += x_scaled;
    camElev += y_scaled;
    mx = MouseX;
    my = MouseY;
}

 
 
void elevCamera (float speed) {
  if (direction == 5) {  // lower camera
    camP.z -= speed;               
    camF_abs.z -= speed;
  }
  else {                 // raise camera
    camP.z += speed;               
    camF_abs.z += speed;
  }
}
 