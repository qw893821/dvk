class Score{
  int score;
  String modename;
  String common1,common2,challenge;
  Score(int temps,String name){
    score=temps;
    modename=name;
    common1="You played"+" "+modename+" mode";
    common2="You defend"+" "+score+" Knights";
    challenge="You played"+" "+survivaltime+" Seconds";
  }
  void display(){
    if(modename=="CHALLENGE"){
      textSize(32);
      fill(255);
      text(common1,0,440);
      text(common2,0,480);
      text(challenge,0,520);
    }
    else {
      textSize(32);
      fill(255);
      text(common1,0,440);
      text(common2,0,480);
    }
  }
}