class Timer{
  int roundtime;
  int starttime;
  Timer(int temps){
    roundtime=60*1000;
    starttime=temps;
  }
  Boolean oneround(){
    if(roundtime<millis()-starttime){
      return true;
    }
    else{return false;}
  }
}