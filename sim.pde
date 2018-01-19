int particles = 200;//number of particles created
int randVel = 16;//initialization range for random velocity
int dist = 15;//collision distance
int stroke = 15;//size of particles

float eLoss = 1;//energy retained in collisions between particles (0-1)

Proton[] pro = new Proton[particles];
void setup(){
  for(int i=0;i<pro.length;i++){
    pro[i]= new Proton(random(width),random(height),random(randVel),random(randVel),random(255));
  }
  size(1200, 650);
  frameRate(30);
}

void draw() {
  background(0);
  for(int i=0;i<pro.length;i++){
    pro[i].update();
  }
  
}

class Proton{
  float px;
  float py;
  float vx;
  float vy;
  float col;
  Proton(float posx, float posy, float velx, float vely, float c){
    px = posx; 
    py = posy;
    vx = velx;
    vy = vely;
    col = c;
  } 
    ///////////////////////////////// ACCESS/MODIFY POSITION ///////////////////////////

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
  ///////////////////////////////// ACCESS/MODIFY VELOCITY ///////////////////////////
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
  ///////////////// Update particle position, check for collision, draw //////////////////////
  void update(){
    stroke(col,0,0);
    py += vy; 
    px += vx;
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
    collision(pro);
    point(px,py);

  } 
  
}

// checks euclidian distance between every proton in given array, swaps vx1->vy2, vy1->vx2, etc. and multiplies by a negative scaling factor eLoss (energy lost in collisions, 0.0-1.0)
void collision(Proton[] prot){
  float in;
  for(int i= 0;i<particles;i++){
    for(int j=i+1;j<particles;j++){
      if(sqrt(  (prot[i].getPx()-prot[j].getPx())*(prot[i].getPx()-prot[j].getPx()) + ((prot[i].getPy()-prot[j].getPy())*(prot[i].getPy()-prot[j].getPy())))<dist){
        in=prot[i].getVx();
        prot[i].setVx(-eLoss*prot[j].getVy());
        prot[j].setVy(-eLoss*in);
        
        in=prot[i].getVy();
        prot[i].setVy(-eLoss*prot[j].getVx());
        prot[j].setVx(-eLoss*in);
        
        //change color randomly
        prot[i].setColor(random(255));
        prot[j].setColor(random(255));
      }
    }
  }
}