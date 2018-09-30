class Enemy{
  float enemy_x;
  float enemy_y;
  int enemy_w,enemy_h;
  float enemy_speed;
  int i;
  Enemy(float temp_x,float temp_y,float tempspeed,int tempi){
    enemy_x=temp_x;
    enemy_y=temp_y;
    enemy_w=20;
    enemy_h=60;
    enemy_speed=tempspeed;
    i=tempi;
  }
  
  //load random iamge, get hiter hint from 'https://forum.processing.org/one/topic/load-random-image-please-help-a-noob.html'
  void display(){
    PImage img;
    img=loadImage(i+".png");
    imageMode(CORNER);
    image(img,enemy_x,enemy_y,enemy_w,enemy_h);
  }
  void move(){
    enemy_y+=enemy_speed;
  }
  Boolean bottomTouch(){
    if((enemy_y+enemy_h)>height){
      return true;
    }
    else{return false;}
  }
}