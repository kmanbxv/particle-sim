float wallX;
float wallGapY;
float wallWidth;



int particles = 200;//number of particles created
int randVel = 10;//initialization range for random velocity
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
  wallX = width/2;
  wallGapY = 100;
  wallWidth = 50;
  frameRate(30);
}

void draw() {
  background(0);
  rect(wallX, wallGapY, wallWidth, height-wallGapY);
  for(int i=0;i<par.length;i++){
    par[i].update();
  }
}



void collision(){ //collisions betweeen particles (detection, messing with resultant velocities)
  float in;
  float fudge = 0.5;
    for(int i=0;i<particles;i++){
      //wall collision left side//////////////////////////////////////////////////////// WALL STUFF /////////////////////////////////////
      
        if(par[i].getPy()<wallGapY+6 && par[i].getPx()> wallX+2 && par[i].getPx() < wallX+wallWidth - 2 && par[i].getPy() > wallGapY ){ // gap top collisions
          par[i].setPy(-par[i].getPy());
          par[i].setPx(wallGapY);
          
          
          par[i].setPx(par[i].getPx()+fudge*par[i].getVx()); //fudge factor to add an extra step separating after collisions (stops accidental clumping)
          par[i].setPy(par[i].getPy()+fudge*par[i].getVy());
        }
        if(par[i].getPx()< wallX+(wallWidth/2) && par[i].getPy() > wallGapY && par[i].getPx() >= wallX){ //if its left of the wall, below the hole, and dist or closer to the left of the wall
              par[i].setVx(-0.99*par[i].getVx());//reverse it horizontally
              
              par[i].setPx(wallX-2);
              
              //par[i].setPx(par[i].getPx()+fudge*par[i].getVx()); //fudge factor to add an extra step separating after collisions (stops accidental clumping)
              par[i].setPy(par[i].getPy()+fudge*par[i].getVy());
        }
        if(par[i].getPx()> wallX+(wallWidth/2) && par[i].getPy() > wallGapY && par[i].getPx() <= wallX + wallWidth){ //if its left of the wall, below the hole, and dist or closer to the left of the wall
              par[i].setVx(-1*par[i].getVx());//reverse it horizontally
              
              par[i].setPx(wallX+51);
              
              par[i].setPx(par[i].getPx()+fudge*par[i].getVx()); //fudge factor to add an extra step separating after collisions (stops accidental clumping)
              par[i].setPy(par[i].getPy()+fudge*par[i].getVy());
        }
        
    for(int j=i+1;j<particles;j++){
      if(getEuclidianDistance(par[i].getPx(),par[j].getPx(),par[i].getPy(),par[j].getPy())<dist && par[i].getCharge()==par[j].getCharge()){
        in=par[i].getVx(); //three step swap (*2, so 6 steps) for velocities of two colliding particles
        par[i].setVx(-eLoss*par[j].getVy());
        par[j].setVy(-eLoss*in);
        
        in=par[i].getVy();
        par[i].setVy(-eLoss*par[j].getVx());
        par[j].setVx(-eLoss*in);
        
        par[i].setPx(par[i].getPx()+fudge*par[i].getVx()); //fudge factor to add an extra step separating after collisions (stops accidental clumping)
        par[i].setPy(par[i].getPy()+fudge*par[i].getVy());
        
        par[j].setPx(par[j].getPx()+fudge*par[j].getVx());
        par[j].setPy(par[j].getPy()+fudge*par[j].getVy());
        
        
        
        //change color randomly
        //par[i].setColor(random(255));
        //par[j].setColor(random(255));
      }
    }
  }
}