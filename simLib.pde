float getEuclidianDistance(float x1, float x2, float y1, float y2){ //exactly what it sounds like
  return sqrt(  ((x1-x2)*(x1-x2)) + ((y1-y2)*(y1-y2)) );
}
class Proton{
  float px;
  float py;
  float vx;
  float vy;
  float col;
  Proton(float posx, float posy, float velx, float vely, float c){ //Protons have 2-dimensional position and velocity, as well as a color value
    px = posx; 
    py = posy;
    vx = velx;
    vy = vely;
    col = c;
  } 
  float getPx(){
    return this.px;
  }
  float getPy(){
    return this.py;
  }
  void setPx(float x){
    this.px = x;
  }
  void setPy(float y){
    this.py = y;
  }
  float getVx(){
    return this.vx;
  }
  float getVy(){
    return this.vy;
  }
  void setVx(float x){
    this.vx = x;
  }
  void setVy(float y){
    this.vy = y;
  }
  void setColor(float c){
    this.col = c;
  }
  
  void update(){ //draw next point
    stroke(col,0,0); //color becomes random shade of red
    py += vy; //update x,y position
    px += vx;
    //////////////////////////////// collision check on bounding box
    if (py > height) { 
      py = height;
      vy = -0.9*vy;
    } 
    if (py < 0) { 
      py = 0;
      vy = -0.9*vy;
    } 
    if (px > width) { 
      px = width;
      vx = -0.9*vx;
    } 
    if (px < 0) { 
      px = 0;
      vx = -0.9*vx;
    }
    strokeWeight(stroke);
    if (vx<2 && vx>-2) {
      vx=random(randVel);
    }
    if (vy<2 && vy>-2) {
      vy=random(randVel);
    }
    collision();///////////////collision check between particles
    point(px,py); //draw this point

  } 
  
}