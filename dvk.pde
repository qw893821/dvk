import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//drangon.png,1.png,2.png,3.png,4png,5.png,fireball.png resource:www.pixabay.com
//backimage resource:http://www.zcool.com.cn/gfx/ZMzUwOTUy.html
//original enddrgaon.png from:http://kiterrax.deviantart.com/art/Free-sleeping-gem-dragon-lineart-282050322. Modified by myself.
//get imformation about how to loop sound from:https://forum.processing.org/two/discussion/9915/minim-where-to-put-rewind
Dragon dragon=new Dragon(width/2,height);
Enemy[] enemies;
FireBall[] fireballs;
Button buttonEasy,buttonNormal,buttonHard,buttonTime,buttonRestart;
Timer timer;
Score endscore;
float enemy_x,enemy_y;
boolean gamestart=false;
float enemyspeed;//enemy move speed
int enemyaddtime;
int t;//timer
boolean timemode;
boolean readycast=false;
boolean hit=false;
int starttime;
boolean gameend=false;
int survivaltime;
int score=0;
int tempscore;
PImage backimage,enddragon;
String modename;
Minim minim;
AudioPlayer castfireball,enemyburn,bgm;

void setup(){
  size(550,800);
  background(0,200,0);
  buttonEasy= new Button(0,height/2,width/2,height/6,127,"EASY");
  buttonNormal= new Button(0,2*height/3,width/2,height/6,127,"NORMAL");
  buttonHard= new Button(0,5*height/6,width/2,height/6,127,"HARD");
  buttonTime=new Button(width/2,height/2,width/2,height/2,127,"CHALLENGE");
  buttonRestart=new Button(width/2-100,height/2-200,200,100,127,"");
  dragon=new Dragon(width/2,height-40);
  enemies=new Enemy[1];
  fireballs= new FireBall[1];
  fireballs[0]=new FireBall(-100,100);
  endscore=new Score(tempscore,modename);
  timer= new Timer(starttime);
  backimage=loadImage("back.png");
  minim =new Minim(this);
  bgm=minim.loadFile("bgm.wav");
  enemyburn=minim.loadFile("burn.wav");
  castfireball=minim.loadFile("castfireball.wav");
}

void draw(){
  background(backimage);//'https://processing.org/examples/backgroundimage.html' As image() function have performance issue in my original code, I use the background(PImgae) here. It works much better.
  t=millis();
  if(gamestart==false){
    startscreen();
  }
  gameplay();
  endscreen();
  println(enemies.length);
}

void startscreen(){
  buttonEasy.display();
  buttonEasy.over();
  buttonEasy.modeName();
  buttonNormal.display();
  buttonNormal.over();
  buttonNormal.modeName();
  buttonHard.display();
  buttonHard.over();
  buttonHard.modeName();
  buttonTime.display();
  buttonTime.over();
  buttonTime.modeName();
}

void gameplay(){ 
  //mode choose
  if(buttonEasy.modeselect()){
    timer.starttime=millis();
    gamestart=true;
    enemyspeed=1;//temp enemyspeed
    enemyaddtime=4000;
    enemies[0]=new Enemy(random(30,width-30),0,enemyspeed,int(random(1,5)));
    buttonEasy.button_x=-1000;
    buttonNormal.button_x=-1000;
    buttonHard.button_x=-1000;
    buttonTime.button_x=-1000;
    modename="EASY";
    bgm.play();
  }
  else if(buttonNormal.modeselect()){
    timer.starttime=millis();
    gamestart=true;
    enemyspeed=2;
    enemyaddtime=2000;
    enemies[0]=new Enemy(random(30,width-30),0,enemyspeed,int(random(1,5)));
    buttonEasy.button_x=-1000;
    buttonNormal.button_x=-1000;
    buttonHard.button_x=-1000;
    buttonTime.button_x=-1000;
    modename="NORMAL";
    bgm.play();

  }
  else if(buttonHard.modeselect()){
    timer.starttime=millis();
    gamestart=true;
    enemyspeed=2.5;
    enemyaddtime=1100;
    enemies[0]=new Enemy(random(30,width-30),0,enemyspeed,int(random(1,5)));
    buttonEasy.button_x=-1000;
    buttonNormal.button_x=-1000;
    buttonHard.button_x=-1000;
    buttonTime.button_x=-1000;
    modename="HARD";
    bgm.play();

  }
  else if(buttonTime.modeselect()){
    survivaltime=0;
    timer.starttime=millis();
    gamestart=true;
    enemyspeed=0.5;
    enemyaddtime=5000;
    timemode=true;
    enemies[0]=new Enemy(random(30,width-30),0,enemyspeed,int(random(1,5)));
    buttonEasy.button_x=-1000;
    buttonNormal.button_x=-1000;
    buttonHard.button_x=-1000;
    buttonTime.button_x=-1000;
    modename="CHALLENGE";
    bgm.play();
  }
  
  //moving part
  if(gamestart==true){
    if(!bgm.isPlaying()){
       bgm.rewind();
       bgm.play();
    }
    dragon.display();
    dragon.move();
    enemyadd(enemyaddtime,t);
    fireballcast();
    if(timemode){
      if((t%4000<30)&&(enemyspeed<4)){
        enemyspeed+=0.5;
      }
      if((t%4000<30)&&(enemyaddtime>1300)){
        enemyaddtime-=400;
      }
    }
    else if(timer.oneround()){
      tempscore=score;
      gameend=true;
    }
    enemyrelate();
    fireballhittop();
    enemyhit();
  }
}

void endscreen(){
  if(gameend==true){
    background(0);
    endscore=new Score(tempscore,modename);
    endscore.display();
    buttonRestart.display();
    buttonRestart.fill_c=0;
    enddragon=loadImage("enddragon.png");
    imageMode(CENTER);
    image(enddragon,buttonRestart.button_x+100,buttonRestart.button_y+50);
    bgm.pause();
    for(int i=enemies.length;i>1;i--){
      enemies=(Enemy[])shorten(enemies);
    }
    for(int i=fireballs.length;i>0;i--){
      fireballs=(FireBall[])shorten(fireballs);
    }
    gamestart=false;
    if(buttonRestart.modeselect()){
      gameend=false;
      timemode=false;
      buttonEasy.button_x=0;
      buttonNormal.button_x=0;
      buttonHard.button_x=0;
      buttonTime.button_x=width/2;
      score=0;
    }
  }
}

//function used to add enemies
void enemyadd(int eat,int tempt){
  Enemy e =new Enemy(random(30,width-30),0,enemyspeed,int(random(1,5)));
  if((tempt>eat)&&((tempt%eat)<21)){
    enemies=(Enemy[])append(enemies,e);
  }
}

//code related to enemy
void enemyrelate(){
  for(int i=0;i<enemies.length;i++){
      enemies[i].display();
      enemies[i].move();
      if(enemies[i].bottomTouch()){
        tempscore=score;
        if(timemode==true){
          timemode=false;
          gameend=true;
          bgm.pause();
          survivaltime=(millis()-timer.starttime)/1000;
        }
        if(i==enemies.length-1){
          enemies=(Enemy[])shorten(enemies);
        }
        else{
          for(int c=i;c<enemies.length-1;c++){
            enemies[c]=enemies[c+1];
          }
          enemies=(Enemy[])shorten(enemies);
        }
      }
  } 
}

void fireballcast(){
  if(gameend!=true){
    if(keyPressed==true){
      readycast=true;
    }
    FireBall fb=new FireBall(dragon.dragon_x+(dragon.dragon_w)/2,height-40);
    if((readycast)&&(key==32)&&(fireballs.length<5)&&(keyPressed!=true)){
      fireballs=(FireBall[])append(fireballs,fb);
      readycast=false;
      castfireball.play();
      castfireball.rewind();
    }
    for(int i=0;i<fireballs.length;i++){
      fireballs[i].display();
      fireballs[i].move();
    }
  }
}

void fireballhittop(){
  for(int i=0; i<fireballs.length;i++){
    if(fireballs[i].toptouch()){
      if(i==fireballs.length-1){
        fireballs=(FireBall[])shorten(fireballs);
      }
      else{
        for(int c=i;c<fireballs.length-1;c++){
          fireballs[c]=fireballs[c+1];
        }
        fireballs=(FireBall[])shorten(fireballs);
      }
    }
  }
}

//hitenemy
void enemyhit(){
  for(int ei=0;ei<enemies.length;ei++){
    for(int fi=0;fi<fireballs.length;fi++){
      if(ei<enemies.length){
        if(fireballs[fi].hit(enemies[ei])){
          
          enemyburn.play();
          enemyburn.rewind();
          score++;
          if(ei==enemies.length-1){
            enemies=(Enemy[])shorten(enemies);
          }
          else {
            for(int ec=ei;ec<enemies.length-1;ec++){
            enemies[ec]=enemies[ec+1];
            }
            enemies=(Enemy[])shorten(enemies);
          }
          if(fi==fireballs.length-1){
            fireballs=(FireBall[])shorten(fireballs);
          }
          else {
            for(int fc=fi;fc<fireballs.length;fc++){
              if(fc+1<fireballs.length){
                fireballs[fc]=fireballs[fc+1];
              }
            }
            fireballs=(FireBall[])shorten(fireballs);
          }
        }
      }
    }
  }
}