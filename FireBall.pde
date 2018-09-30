  class FireBall{
  float fireball_x,fireball_y;
  int fireball_r;
  FireBall(float tempx,float tempy){
    fireball_x=tempx;
    fireball_y=tempy;
    fireball_r=12;
  }
  void display(){
    PImage fireball;
    fireball=loadImage("fireball.png");
    imageMode(CENTER);
    image(fireball,fireball_x,fireball_y,24,24);
  }
  void move(){
    fireball_y-=5;
  }
  Boolean toptouch(){
    if(fireball_y<0){
      return true;
    }
    else {return false;}
  }
  //learn from simpleponggame.
  boolean hit(Enemy e){
    float ex=e.enemy_x;
    float ey=e.enemy_y;
    float ew=e.enemy_w;
    float eh=e.enemy_h;
    if((fireball_x-fireball_r>ex+ew)
      ||(fireball_x+fireball_r<ex)
      ||(fireball_y+fireball_r<ey)
      ||(fireball_y-fireball_r>ey+eh)){
        return false;
      }
      else{return true;}
  }
}