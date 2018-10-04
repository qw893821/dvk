# dvk
This is a shooting game about a dragon fright with knight. It will have two modes. I would create a class called Button to achieve it. This class would have several methods like display and internalClickCheck.
The display method is used to show the button and it is a void type. In this method, it would contain a rollover check to change the color.
The internalClickCheck method is used to check the mouse position and determine which mode play selected. It would have the code like this:
		Boolean internalClickCheck() {
If ((mouseClicked==true) &&(mouseX>topleftx ) &&(mouseX<bottomrightx)&&(mouseY>topleftY)&&(mouseY<bottomrighty))
{
	Return true;
}
Else {return false;}
}
I would two objects of this class to show the mode select button. This part will show on the start screen.

Enemy class.
This class is about enemy in this game. I would use images of knight in the final version because in lots fiction, knight would defeat the dragon to become a hero. This class would have methods like display and move. Once they reach the bottom of the screen, player would be punished.
I would create an Enemy array to storage these enemy objects.
Dragon class
This class is used to create the dragon which player would control in this game. It will contain method like display and move. Players could only move left or right in this game. Players must try their best to fight with those knights by casting fire balls.
At the first version, I would use a rectangle to represent the dragon and use an image at the final version.
FireBall
This is the most important part of this game because player would use this object to defeat enemies. Players could cast fire ball by pressing the ‘space’ key. However, players could just cast five fire balls at the same time which means there should be five or less fire balls on the screen at the same time.
The code of fire ball number check would like this
		firebalNuCheck (){
			if ((fireballs.length<5)&&(key==32)){
				FireBall fb=new FireBall (dragonx, dragony);
				fireballs=(FireBall [])append(fireballs, fb);
}
}
Another important code about fire ball is about the interaction of the enemies. Once the fire ball intersecting with enemy, both of them would disappear. 
	fireballInsectionCheck(){
		for(int i=0;i<fireballs.length;i++){
		for(int r=0;r<enemies.length;r++){
if((fireballs[i].fireballx> enemies[r].topx)&&( fireballs[i].fireballx< enemies[r].bottomx)){
		if((fireballs[i].firebally+r> enemies[r].topy)||( fireballs[i].firebally-r< enemies[r].bottomx)){
		for(int c=i;c<fireballs.length;c++){
			fireballs[i]=fireballs[i+1];
}
fireballs=(FireBall[])shorten(fireballs);
for(int b=r;b<fireballs.length;b++){
	enemies[b]=enemies[b+1];
}
enemies=(Enemies[])shorten(enemies);
					return true;
				}
}
Else if(fireballs[i].firebally> enemies[r].topy)&&( fireballs[i].firebally< enemies[r].bottomy){
	If((fireballs[i].fireballx+r> enemies[r].topx)||( fireballs[i].fireballx-r< enemies[r].bottomy)){
		
		Return true;
	}
}
Else {return false;}
}
}
}
When they intersect with each, I want just shorten the array to save memory. This is a method I learned from my undergraduate study.
Score
The score will not exhibit until game overs. In the time based, the score adds based on the time player played and the enemies number player had destroyed.
In the challenge mode, there will be no time limitation in this game. However, it would still contain a hidden timer which help calculate the score.
End screen
This screen would appear when game is over. There will be a score show at the middle of the screen and exhibit the image of the knights I used in this game. 
Furthermore, an image would locate at the bottom of the screen, if player click the image, this game will restart.
