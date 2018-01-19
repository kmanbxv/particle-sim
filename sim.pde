int particles = 200;//number of particles created
int randVel = 16;//initialization range for random velocity
int dist = 15;//collision distance
int stroke = 15;//size of particles

float eLoss = 1;//energy retained in collisions between particles (0-1)

Proton[] pro = new Proton[particles];
void setup(){
  for(int i=0;i<pro.length;i++){
    pro[i]= new Proton(random(width),random(height),random(randVel),random(randVel),random(255)); //make a bunch of randomly placed, oriented, and colored Proton objects
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



void collision(){ //collisions betweeen particles (detection, messing with resultant velocities)
  float in;
  for(int i= 0;i<particles;i++){
    for(int j=i+1;j<particles;j++){
      if(getEuclidianDistance(pro[i].getPx(),pro[j].getPx(),pro[i].getPy(),pro[j].getPy())<dist){
        in=pro[i].getVx();
        pro[i].setVx(-eLoss*pro[j].getVy());
        pro[j].setVy(-eLoss*in);
        
        in=pro[i].getVy();
        pro[i].setVy(-eLoss*pro[j].getVx());
        pro[j].setVx(-eLoss*in);
        
        //change color randomly
        pro[i].setColor(random(255));
        pro[j].setColor(random(255));
      }
    }
  }
}