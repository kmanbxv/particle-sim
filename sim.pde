int particles = 200;//number of particles created
int randVel = 16;//initialization range for random velocity
int dist = 15;//collision distance
int stroke = 15;//size of particles
int elStroke = 4;

float eLoss = 1;//energy retained in collisions between particles (0-1)

Particle[] par = new Particle[particles];
void setup(){
  for(int i=0;i<par.length/3;i++){
    par[i]= new Particle(random(width), random(height), random(randVel), random(randVel), 1); //make a bunch of randomly placed and oriented Particle objects
  }
  for(int i=par.length/3;i<par.length*2/3;i++){
    par[i]= new Particle(random(width), random(height), random(randVel), random(randVel), 0); //make a bunch of randomly placed and oriented Neutron objects
  }
  for(int i=par.length*2/3;i<par.length;i++){
    par[i]= new Particle(random(width), random(height), random(randVel*2), random(randVel*2), -1); //make a bunch of randomly placed and oriented Electron objects
  }
  size(1200, 650);
  frameRate(30);
}

void draw() {
  background(0);
  for(int i=0;i<par.length;i++){
    par[i].update();
  }
}



void collision(){ //collisions betweeen particles (detection, messing with resultant velocities)
  float in;
    for(int i=0;i<particles;i++){
    for(int j=i+1;j<particles;j++){
      if(getEuclidianDistance(par[i].getPx(),par[j].getPx(),par[i].getPy(),par[j].getPy())<dist && par[i].getCharge()==par[j].getCharge()){
        in=par[i].getVx();
        par[i].setVx(-eLoss*par[j].getVy());
        par[j].setVy(-eLoss*in);
        
        in=par[i].getVy();
        par[i].setVy(-eLoss*par[j].getVx());
        par[j].setVx(-eLoss*in);
        
        //change color randomly
        //par[i].setColor(random(255));
        //par[j].setColor(random(255));
      }
    }
  }
}