class Button{
  int button_x,button_y;
  int button_w,button_h;
  int fill_c;
  int c=255;
  String modename;
  PImage knight1,knight2,knight3,knight4,knight5;
  Button(int tempx,int tempy,int tempw,int temph,int tempc,String name){
    button_x=tempx;
    button_y=tempy;
    button_w=tempw;
    button_h=temph;
    fill_c=tempc;
    modename=name;
    knight1=loadImage("1.png");
    knight2=loadImage("2.png");
    knight3=loadImage("3.png");
    knight4=loadImage("4.png");
    knight5=loadImage("5.png");
  }
  void display(){
    strokeWeight(3);
    fill(fill_c);
    rectMode(CORNER);
    rect(button_x,button_y,button_w,button_h);
    imageMode(CORNER);
    if(modename=="EASY"){
      image(knight1,button_x+5,button_y+5);
    }
    else if(modename=="NORMAL"){
      image(knight1,button_x+5,button_y+5);
      image(knight2,button_x+30,button_y+5);
    }
    else if(modename=="HARD"){
      image(knight1,button_x+5,button_y+5);
      image(knight2,button_x+30,button_y+5);
      image(knight3,button_x+55,button_y+5);
    }
    else if(modename=="CHALLENGE"){
      image(knight1,button_x+5,button_y+5);
      image(knight2,button_x+30,button_y+5);
      image(knight3,button_x+55,button_y+5);
      image(knight4,button_x+80,button_y+5);
      image(knight5,button_x+105,button_y+5);
    }
  }
  void over(){
    if((mouseX<button_x+button_w)&&(mouseX>button_x)&&(mouseY<button_y+button_h)&&(mouseY>button_y)){
      fill_c=c;
      if(c>127){
        c-=2;
      }
    }
    else {
      c=255;
      fill_c=127;
    }
  }
  Boolean modeselect(){
    if((mousePressed==true)&&(mouseX<button_x+button_w)&&(mouseX>button_x)&&(mouseY<button_y+button_h)&&(mouseY>button_y)){
      return true;
    }
    else {return false;}
  }
  void modeName(){
    if(button_x==0){
      textSize(32);
      fill(255);
      text(modename,button_x+70,button_y+80);
    }
    else if(button_x==width/2){
      textSize(32);
      fill(255);
      text(modename,button_x+70,button_y+200);
    }
  }
}