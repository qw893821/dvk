class Dragon{
  float dragon_x,dragon_y;
  int dragon_w,dragon_h;
  Dragon(float tempx,float tempy){
    dragon_x=tempx;
    dragon_y=tempy;
    dragon_w=80;
    dragon_h=40;
  }
  void display(){
    PImage dragon;
    dragon=loadImage("dragon.png");
    imageMode(CENTER);
    image(dragon,dragon_x+(dragon_w)/2,dragon_y+dragon_h/2);
  }
  void move(){
    if((keyPressed==true)&&(key==CODED)&&(dragon_x>0)&&(keyCode==LEFT)){
        dragon_x-=3;
    }
    else if((keyCode==RIGHT)&&(keyPressed==true)&&(dragon_x+dragon_w<width)){
        dragon_x+=3;
      }
    }
}