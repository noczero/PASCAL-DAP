/*
/-------------------------------------------------------------------------\
|                                                                         | 
|                         We proudly present...                           |
|                                                                         |
|                                                                         |
|                         AAAAAAA                                         |
|                        A:::::::A                                        |
|                       A::::A::::A                                       |
|                      A::::A A::::A                                      |
|                     A::::AAAAA::::A   L T E Z Z A                       |
|                    A:::::::::::::::A                                    |
|                   A:::::::AAA:::::::A          ... the RPG              |
|                  A:::::::A   A:::::::A                                  |
|                 AAAAAAAAAA   AAAAAAAAAA                                 |
|                                                                         |
|                                                                         |
|                            Altezza v0.9                                 |
|                                                                         |
|                                                                         |
|                  +==============================+                       |
|                  |  http://cypher.hypermart.net |                       |
|                  |     cypherg@earthlink.net    |                       |
|                  |     http://slayersfan.com    |						  |
|                  |     tenchi1@animeinn.net     |						  |
|                  +==============================+                       |
|                                                                         |
|                                                                         |
|                                                                         |
|                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~                      |
|                                                                         |
|                                                                         |
|                            da Credits...                                |
|                                                                         |
| Main Programmer..........................Dan "SilverDragonThar" Landree |
| Additional Programming...................Bryan "cg" de la Fuente        |
| Additional Programming...................Josh Bolick                    |
|                                                                         |
|                             ~~~~~~~~~~                                  |
|                                                                         |
| Logo Created by..........................Josh Bolick                    |
|                                                                         |
|                             ~~~~~~~~~~                                  |
|                                                                         |
| Story by.................................Josh Bolick &                  |
|                                          Bryan de la Fuente             |
|                                                                         |
|                             ~~~~~~~~~~                                  |
|                                                                         |
| Characters by............................Dan Landree                    |
|                                                                         |
|                                                                         |
|                                                                         |
|                                                                         |
| Coded in C++ using Codewarrior versions 4.0 and 6.0                     |
|                                                                         |
|                                                                         |
\-------------------------------------------------------------------------/
*/

#include <iostream>
#include <stdio.h>
#include <time.h>
#include <math.h>
#include <string.h>
#include <iomanip.h>
#include <conio.h>

using namespace std;

void elfene();
void raistlin();
void endscene();
void triwarr();
void battlegrounds();
int bosspet();
int battle();
int randomnumbergen();
void clrscr();
void heal();
void rival1();
void rival2();
void rival3();
void rival4();
int cause();
void map1();
void map2();
void map3();
void weaponsstore();
int bossbeast();
int yourp=10, cheat=0, yourw=10, life=5, dog1=10, beast1=10,  gold=0, rival=10, spw=0, add=0, elf=10;
int WhoFirst, hp=100, mhp=100, enemyHP, enemyAP, armor=10, enemyWH, weapon=25, howmanymore=10;
int level, run, thp, tdamage, ddamage, runaway=0, goldgain, runpossible;
char playern[35], yourcause[12], enemy[15], weaponname[11];
bool input_valid = false;
char gender, dir1, surhid, dir2, map2sub, yourc, dir3, healyesno, buy, bchoice, morebattle, whatone;


int main () {// 1 START
		 while(hp>0) {// 2 START
	
		weaponname[0]='D';
		weaponname[1]='e';
		weaponname[2]='a';
		weaponname[3]='t';
		weaponname[4]='h';
		weaponname[5]='c';
		weaponname[6]='y';
		weaponname[7]='t';
		weaponname[8]='h';
		weaponname[9]='e';
		weaponname[10]=NULL;    
		
	
		cout << endl;
		cout << endl << endl;
		cout << "                             AAAAAAA" << endl;
		cout << "                            A:::::::A" << endl;
		cout << "                           A::::A::::A" << endl;
		cout << "                          A::::A A::::A" << endl;
		cout << "                         A::::AAAAA::::A     L T E Z Z A" << endl;
		cout << "                        A:::::::::::::::A" << endl;
		cout << "                       A:::::::AAA:::::::A" << endl;
		cout << "                      A:::::::A   A:::::::A" << endl;
		cout << "                     AAAAAAAAAA   AAAAAAAAAA" << endl << endl << endl << endl << endl << endl;
		cout << "                     A World of Wonder and Adventure..." << endl << endl << endl << endl << endl;
		cout << "                        [ Press enter to continue ]";
		cin.get();
			
		cout << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl;
		cout << "... Once upon a time there was a cold and dark land known as Altezza, this" << endl;
		cout << "place was full of magic and wonder.  The Gods of this place watched over the" << endl;
		cout << "inhabitants and would sometimes interfere with the beings that live in this" << endl;
		cout << "place." << endl << endl;
		cout << "    But now there has been an upset in the balance of the powers and the Gods" << endl;
		cout << "are now causing much ruckus.  With the Gods upset the normal order is now lost" << endl;
		cout << "and a strewed form of anarchy has taken over..." << endl << endl << endl;
		cout << "                  .....Welcome to Altezza." << endl << endl;
		cout << "                        [ Press enter to continue ]";
  
		cin.get();

		clrscr();
		
		yourc=cause();
		if(yourc=='1') {// 3 START
	
			yourcause[0]='m';
			yourcause[1]='a';
			yourcause[2]='g';
			yourcause[3]='e';
			yourcause[4]=NULL;
								
		}// 3 END

		 if(yourc=='2') {// 4 START
			
			yourcause[0]='t';
			yourcause[1]='h';
			yourcause[2]='e';
			yourcause[3]='i';
			yourcause[4]='f';
			yourcause[5]=NULL;
		}// 4 END


		if(yourc=='3') {// 5 START
		
			yourcause[0]='w';
			yourcause[1]='a';
			yourcause[2]='r';
			yourcause[3]='r';
			yourcause[4]='i';
			yourcause[5]='o';
			yourcause[6]='r';
			yourcause[7]=NULL;
			
		}// 5 END



		if(yourc=='4') { // 6 START

			yourcause[0]='n';
			yourcause[1]='e';
			yourcause[2]='c';
			yourcause[3]='r';
			yourcause[4]='o';
			yourcause[5]='m';
			yourcause[6]='a';
			yourcause[7]='n';
			yourcause[8]='c';
			yourcause[9]='e';
			yourcause[10]='r';
			yourcause[11]=NULL;
			
		}// 6 END


		
		clrscr();
		input_valid=false;
		while (input_valid!=true) {// 7 START
		cout << "What is the gender of your character?" << endl;
		cout << "[1] Male" << endl;
		cout << "[2] Female" << endl;
		cin >> gender;
		if ((gender=='1') || (gender=='2'))
			input_valid = true;
		}// 7 END
		
		
		
		
		cout << endl << endl << endl;
		cout << "Enter your character's name: ";
		cin >> playern;

		clrscr();

		if(strcmp(playern, "slayers")==0) {// 8 START

			cout << "You Activated the Cheat! Who told you?" << endl << endl;
			cheat=1;
			cout << "You wake up to a pounding at your door..." << endl;
			cout << "There are many voices speaking of war outside..." << endl;
			cout << "Open up! And meet your doom!!! The " << yourcause << " class is going down!" << endl;
			cout << "This a direct order from the faction of death! FACE YOUR ENEMY!!" << endl << endl;
			cout << endl << endl;
			weapon << weapon + 200;
			mhp = mhp +100;
			hp = hp + 100;

			cin.get();
		}// 8 END

		else {// 9 START

			clrscr();
			cout << "You wake up to a pounding at your door..." << endl;
			cout << "There are many voices speaking of war outside..." << endl;
			cout << "Open up! And meet your doom!!! The " << yourcause << " class is going down!" << endl;
			cout << "This a direct order from the faction of death! FACE YOUR ENEMY!!" << endl << endl;
			cout << endl << endl;
			
			cin.get();

		}// 9 END


		input_valid=false;
		while ((input_valid!=true))	{//10 START
		cout << "The human warrior seems raging mad.\nWhat shall you do?" << endl;
		cout << "[1] Surrender" << endl;
		cout << "[2] Hide" << endl;
		cin >> surhid;
		if ((surhid=='1') || (surhid=='2'))
			input_valid = true;
		}// 10 END		

		if(surhid=='1') {// 11 START
		
			clrscr();
			cout << "The warrior took your surrender, and took you outside." << endl;
			cout << "He took his Sword and decapitated you in the courtyard. You are dead" << endl << endl;
			cout << "[Press Enter To Rest In Peace]" << endl << endl;

			cin.get();

			hp=0;
		}// 11 END

		else {// 12 START
			clrscr();
			cout << "You fall to the side of your bed and listen waiting..." << endl;
			cout << "Suddenly, you hear a scream of pain. Then, the sounds of swords clashing. You" << endl;
			cout << "ask a peasant what happened and figure out that a lord of fire killed him. The" << endl;
			cout << "lord left after slaying someone from the faction of death. You decide that you" << endl;
			cout << "made a wise decision, considering that you could be dead!" << endl;
			cout << "Good Job " << playern << "!" << endl;
			cout << "After all that is over, you go over and get dressed in your uniform. It's" << endl;
			cout << "going to be another day in fear of the other factions" << endl << endl;
			cout << "You walk into the courtyard..." << endl;
			cout << "The smell of the air tells you that you are still alive. The land of Altezza" << endl;
			cout << "is very dry and arid. The local city known as 'Stone Hill' is a complete" << endl;
			cout << "wasteland. The wasteland extends in all directions. Far North is Rigor," << endl;
			cout << "standing in heavy fog. To the West is Stonn Forest; to the east, a barren" << endl;
			cout << "desert; south is your house. " << endl <<endl;
			cout << "You decide to leave in fear of another faction coming to kill you." << endl << endl;
			cout << "Where do you want to go?" << endl;
		input_valid=false;
		while (input_valid!=true)	
		{//13 START
			cout << "[1] North to Rigor" << endl;
			cout << "[2] West to Stonn Forest" << endl;
			cout << "[3] East to Desert" << endl;
			cout << "[4] BattleGrounds" << endl;
			cin >> dir1;
			if  ((dir1 == '1') || (dir1 == '2') || (dir1 == '3') || (dir1 == '4'))
				input_valid=true;
		}// 13 END
			if(dir1=='1') {// 14 START
				clrscr();
				map1();
			}// 14 END

			if(dir1=='2') {// 15 START
				clrscr();
				map2();
			}// 15 END

			if(dir1=='3') {// 16 START
				clrscr();
				map3();
			}// 16 END
			if(dir1=='4') {// 17 START
				clrscr();
				battlegrounds();
			}// 17 END

			
		}// 12 END
}// 2 END

  return 0;
}// 1 END OF MAIN!!

void map3() {// 1 START

	while (hp>0) {// 2 START
	cout << "You have come to a barren desert. It has no name other than the dry death." << endl;
	cout << "It has no mercy..." << endl;
	cout << "You try to breathe the scratchy air. But your mouth can't handle the dryness"  << endl;
	cout << "and starts to crack, Your face is wet with with perspiration. This is the" << endl;
	cout << "hottest place you have ever been." << endl << endl;
	cout << "Press Enter To Continue..." << endl << endl;

	cin.get();
	cin.get();

	clrscr();
	cout << "Uh oh! A beast just bit at your ankle and is attacking you!!!" << endl;
	bosspet();
	battle();
	if (hp>0)
	{
	clrscr();
	cout << "Ahead is lord of fire from before." << endl;
	cout << "He looks like he about to die but you see he has full health. That was his dog.." << endl << endl << endl;
	cout << "He doesn't seem to see you, but he's raging mad." << endl;
	cout << "He can senses that someone killed his beast, his partner." << endl << endl;
	bossbeast();
	battle();
	if (hp>0)
	{
		clrscr();

		cout << "You spot something unnatural glimmering in the sand" << endl;
		cout << "You go over to see what it is. It's a bag of gold." << endl;
		cout << "You got 50 coins!" << endl << endl;

         gold=50;
		

		input_valid=false;
		while (input_valid!=true) {// 3 START
		cout << "Where do you want to go now?" << endl;
		cout << "[1] North" << endl;
		cout << "[2] West" << endl;
		cout << "[3] BattleGrounds" << endl;
		cin >> dir2;
		if ((dir2=='1') || (dir2=='2') || (dir2=='3'))
			input_valid=true;
		}// 3 END
		if(dir2=='1') {// 4 START
			clrscr();
			map1();
		}// 4 END

		if (dir2=='2') {// 5 START
			clrscr();
			map2();
		}// 5 END
		if (dir2=='3') {// 6 START
			clrscr();
			battlegrounds();
		}// 6 END

}
}
}// 2 END
}// 1 END OF MAP 1



void map2() {// 1 START
	while (hp>0){// 2 START

	cout << "Welcome to the Stonn Forest!" << endl;
	cout << "You feel as if there is many eyes watching you..." << endl;
	cout << "All around is redwood trees, and complete silence surrounds you. Nothing is" << endl;
	cout << "visible, but you do sense that someone, or something, is watching you..." << endl << endl;
	cout << "Please select an option below." << endl << endl;
	input_valid=false;
	while (input_valid!=true) {// 3 START
	cout << "[1] Healing Specialist" << endl;
	cout << "[2] Weapon Dealer" << endl;
	cout << "[3] BattleGrounds" << endl;
	cin >> map2sub;
	if ((map2sub=='1') || (map2sub=='2') || (map2sub=='3'))
		input_valid=true;
		}// 3 END
// add choices
	if(map2sub=='1')
		heal();
	if(map2sub=='2')
		weaponsstore();
	if(map2sub=='3')
		battlegrounds();
					
	clrscr();
	cout << "You hear you name being screamed from behind you" << endl;
	cout << "you look around as you see your ";

	if(yourc=='1') 
		cout << "mage arch rival. He has an evil aura around him" << endl;
	
	if(yourc=='2') 
		cout << "thief arch rival, You see him walking, swiftly.." << endl;
	
	if(yourc=='3') 
		cout << "warrior arch rival, sword brandished and ready." << endl;
	
	if(yourc=='4') 
			cout << "evil necromancer arch rival, with a spellbook at the ready." << endl;
	
	cout << "He runs after you and pins you on the ground." << endl;
	cout << "'Die " << playern << "!'\nHe screams in your face waving his weapon at you." << endl << endl;
	cout << "Press Enter To Continiue..." << endl << endl;

	cin.get();
	
	if(yourc=='1')
		{// 4 START
			rival1();
			battle();
		}// 4 END
	if(yourc=='2')
		{// 5 START
			rival2();
			battle();
		}// 5 END
	if(yourc=='3')
		{// 6 START
			rival3();
			battle();
		}// 6 END
	if(yourc=='4')
		{// 7 START
			rival4();
			battle();
		}// 7 END
	
	
	
	
	
	if (hp>0)
	{
		cout << "As you are walking on the main trail." << endl;
		cout << "As you walk, you see something moving in the distance." << endl;
		cout << "You see it coming towards you. You make out your class' dress..." << endl;
		cout << "It is your childhood mage friend and fellow warrior." << endl << endl;
		cout << "Press Enter To Continue..." << endl;
		
		cin.get();
		cin.get();

		clrscr();
		cout << "'Hello " << playern << ". " << endl;
		cout << "You and Camaway talk a while, still fearing other attacks. He says Rigor is where all the" << endl;
		cout << "small battles stop, and the big battles begin..." << endl << endl << endl;
		cout << "Press Enter To Continue..." << endl << endl;

		cin.get();


		clrscr();
		input_valid=false;
		while (input_valid!=true) {// 8 START
		cout << "Where do you want to go?" << endl;
		cout << "[1] Go with Camaway to Rigor" << endl;
		cout << "[2] Go East to the barren dessert." << endl;
		cout << "[3] BattleGrounds" << endl;
		cin >> dir3;
		if ((dir3=='1') || (dir3=='2') || (dir3=='3'))
			input_valid=true;
		}// 8 END
		if(dir3=='2') {// 9 START
			clrscr();
			map3();
		}// 9 END

		if(dir3=='1') 
		{// 10 START
			clrscr();
			cout << "You walk North to Rigor with Camaway, talking about your childhood." << endl;
			cout << "Suddenly, Camaway drops to his knees in mid-sentence." << endl;
			cout << "An arrow has been shot in his back. You run away in fear that you too will die." << endl;
			cout << "You seemed to escape the attacker, but you just lost a your best friend." << endl;
			cout << "You must seek revenge at Rigor..." << endl << endl;
			cout << "Press Enter To Continue..." << endl << endl;

			cin.get();

			clrscr();

			map1();
		}// 10 END
		if(dir3=='3')
		{// 11 START
			battlegrounds();
		}// 11 END
}
}// 2 END
}// 1 END OF MAP 2!!!

void map1() {// 1 START
	while (hp>0){// 2 START
	cout << "Welcome to Rigor!" << endl;
	cout << "This is where the small battles stop and the big battles begin..." << endl;
	cout << "The dense fog strangles the mountain with danger." << endl << endl;
	cout << "Press Enter To Continue..." << endl << endl;

	cin.get();

	weaponsstore();

	cout << "You walk up the mountain feeling light and carefree." << endl << endl;
	cout << "Press Enter To Continue..." << endl << endl;

	cin.get();

	clrscr();
	cout << "Rocks and dirt cover your boots, as you hear screaming up ahead." << endl;
	cout << "You take out your " << weaponname << endl;
	cout << "You see some dry blood and remember that this is a dangerous" << endl;
	cout << "mountain, and that you must always be on guard." << endl << endl;
	cout << "Press Enter To Continue..." << endl << endl;

	cin.get();

	clrscr();

	cout << "A high shriek bellows in your ears, as you fall on your knees." << endl;
	cout << "An elf is attacking you. His Sting Blade Sword is waving" << endl;
	cout << "inches above your head, he tries to thrust it into your skull." << endl << endl;
	cout << "Press Enter To Continue..." << endl << endl;

	cin.get();

	clrscr();
	elfene();
	battle();
	
if (hp>0)
	{
		cout << "\n\nPress Enter To Continue..." << endl << endl;

		cin.get();

		clrscr();
		cout << "You continue trotting up the mountain. You are almost at the top of of it." << endl;
		cout << "You are attacked by a three-headed beast!!" << endl;

		triwarr();
		battle();
if (hp>0)
{
		cout << "Press Enter To Continue..." << endl << endl;

		cin.get();

		clrscr();
		cout << "You are now on top of Rigor, looking out on Altezza." << endl;
		cout << "You find a mage and he administers your wounds and you are now back to full" << endl;
		cout << "heatlh. After you are full healed you continue to walk up the path. The" << endl;
		cout << "wind blows peacefully throughout the air. You look arround and see a horrific" << endl;
		cout << "sight. The masters of the classes are on the mountain with you. Three of them" << endl;
		cout << "are chained up, one is steaming mad. You see many bodies of warriors of all" << endl;
		cout << "types lay around your feet." << endl;
		cout << "Caramon is on the far left. Floating in the air with a look of defeat on his" << endl;
		cout << "face. He is surrounded by chains, as well as the other two. On the right, next" << endl;
		cout << "to Caramon, is Fumahi. Next to Fumahi is Cotari, she is hopeless as she sits" << endl;
		cout << "on the ground in chains. Raistlin, the theif master, is laughing at his deeds." << endl;
		cout << "The final battle awaits..." << endl;
		cout << "Now is the battle with Raistlin... You have to win to release all the masters" << endl;
		cout << "and win Altezza" << endl << endl;
		cout << "Press Enter To Continue..." << endl << endl;
		cin.get();
		clrscr();
		raistlin();
		battle();
		if (hp>0)
		{
		endscene();
		}
}
}		
}	// 2 END
} // 1 END OF MAP 3

void clrscr() {// 1 START

	cout << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl;
	cout << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl << endl;
}// 1 END OF CLRSCR!!!

int cause() {// 1 START

	clrscr();
		input_valid=false;
		while (input_valid!=true) {// 2 START
		cout << "What character class are you going to be?\n";
		cout << "[1] Mage\n";
		cout << "   Primarily Magic User- Uses staffs.\n";
		cout << "[2] Theif\n";
		cout << "   Stealth - Can only use daggers\n";
		cout << "[3] Warrior\n";
		cout << "   Heavy Armor - Heavy weapons; No magic or special abilities\n";
		cout << "[4] Necromancer\n";
		cout << "   Magic User - Uses magic that has reference to the dead/undead\n";
		cin >> yourc;
		if ((yourc=='1') || (yourc=='2') || (yourc=='3') || (yourc=='4'))
			input_valid=true;
		}// 2 END
	return yourc;
}// 1 END
int battle() {// 1 START
	while ((enemyHP > 0) && (hp>0)){// 2 START
	cout << "You are in combat with a: " << enemy << endl;
	cout << "Enemy HP:\t\t\t" << enemyHP << "\tYour HP:\t\t" << hp << "/" << mhp << endl;
	cout << "Enemy Armor Points:\t\t" << enemyAP << "\tYour Armor Points:\t" << armor << endl;
	cout << "Ememy Weapon Damage Max:\t" << enemyWH << "\tYour Weapon Damage Max:\t" << weapon << endl << endl;
	input_valid=false;
	while (input_valid!=true) {// 3 START
	cout << "What Do you wish to do?\n";
	cout << "[1] Attack" << endl;
	cout << "[2] Run" << endl;
	cout << "[3] View Stats" << endl;
	cin >> bchoice;
	if ((bchoice=='1') || (bchoice=='2') || (bchoice=='3'))
		input_valid=true;
		
	}// 3 END
		if (bchoice == '1'){// 4 START
				WhoFirst = randomnumbergen();
					if (WhoFirst > 15)
						{// 5 START
							if (hp>0)
							{ // beta START
							ddamage = (weapon-(enemyAP*.25));
							enemyHP =  enemyHP - ddamage;
							cout << "\nYou hit for " << ddamage << " points damage" << endl << endl;
								if (enemyHP < 1)
									{// 6 START
										cout << "You have killed the enemy" << endl;
										cout << "You gain: " << goldgain << " gold pieces";
										gold = gold + goldgain; 
										hp=hp+5;
										mhp=mhp+5;
									}// 6 END
							}// beta end
							if (enemyHP > 0)
							{// 7 START
								tdamage = (enemyWH-(armor*.25));
								hp = hp - tdamage;
								cout << "\nEnemy hits for " << tdamage << " points damage" << endl << endl;
								if (hp < 1)
									{// 8 START
										cout << "You LOST!!\tNow you are lying on the ground of Altezza" << endl;
										hp=0;
									}// 8 END
							}// 7 END
							
						}// 5 END
					if (WhoFirst < 15)
						{// 9 START
							if (enemyHP > 0)
							{// 10 START
								tdamage = (enemyWH-(armor*.25));
								hp = hp - tdamage;
								cout << "\nEnemy hits for " << tdamage << " points damage" << endl << endl;
								if (hp < 1)
									{// 11 START
										cout << "You LOST!!\tNow you are lying on the ground of Altezza" << endl;
										hp=0;
									}// 11 END
							}// 10 END
							if (hp>0)
							{// beta START	
								
							ddamage = (weapon-(enemyAP*.25));
							enemyHP =  enemyHP - ddamage;
							cout << "You hit for " << ddamage << " points damage" << endl << endl;
								if ((enemyHP < 1)&&(hp > 0))
									{// 12 START
										cout << "You have killed the enemy" << endl;
										cout << "You gain: " << goldgain << " gold pieces";
										gold = gold + goldgain;  
										hp = hp+5;
										mhp = mhp+5;
									}// 12 END
								else
									{}
							}// beta END
						} // 9 END
		}// 4 END
		if (bchoice == '2')
			{// 13 START
				run = randomnumbergen();
				if ((run> 10)&&(runpossible==1))
					{// 14 START
						cout << "\nYou have sucessfully run from your enemy" << endl;
						thp = hp;
						hp = -2;
					}// 14 END
				else
					{// 15 START
						cout << "\nYou failed to succesfully run away" << endl;
					}// 16 START
			}// 13 END
		if (bchoice == '3')
			{// 17 START
				cout << "\n" << playern << "'s Statistics" << endl;
				cout << "Armor :" << armor << endl;
				cout << "Weapon Name: " << weaponname << endl;
				cout << "Weapon Damage :" << weapon << endl;
				cout << "HP :" << hp << "/" << mhp << endl; 
				cout << "Gold:" << gold << endl << endl;
			}// 17 END
				
		}// 2 END
		if (hp==-2)
			hp = thp;
return 0;
}// 1 END OF BATTLE!!!
void heal()
{// 1 START
		cout << "Hello this is Thimas of the healing arts" << endl;
		cout << "To have us restore full health the price is 50 gold pieces" << endl;
		input_valid=true;
		while (input_valid!=true) {// 2 START
		cout << "Do you want us to use our powers and heal you?" << endl;
		cout << "[1] yes \n[2] no/leave" << endl;
		cin >> healyesno;
		if ((healyesno=='1') || (healyesno=='2') || (healyesno=='3'))
			input_valid=true;
		}// 2 END
			if((healyesno=='1')&&(gold>50))
			{// 3 START
				hp = mhp;
				cout << "Your HP is now full: " << hp << "/" << mhp << endl;
			}// 3 END
			if((healyesno=='1')&&(gold<50))
			{// 4 START
				cout << "I don't have time to heal the poor...." << endl;
			}// 4 END
			if (healyesno=='3')
			{}// 5 START AND END
}// 1 END OF HEAL!!!
void weaponsstore()
{// 1 START
		cout << "Max's Weapons gallery" << endl;
		cout << "[1] DeathWand -- Max Damage: 200 -- Price: 400" << endl;
		cout << "[2] Remover   -- Max Damage: 100 -- Price: 200" << endl;
		cout << "[3] Basher    -- Max Damage: 75  -- Price: 100" << endl;
		input_valid=false;
		while (input_valid!=true) {// 2 START
		cout << "Would you like to buy one of my wares?\n\n[1] yes \n[2] No\n"<< endl << endl;
		cin >> buy;
		if ((buy=='1') || (buy=='2'))
			input_valid=true;
		}// 2 END
		if(buy=='1')
		{// 3 START
			input_valid=false;
			while (input_valid!=true) {// 4 START
			cout << "Which one would you like to purchase? "<< endl;
			cin >> whatone;
			if ((whatone=='1') || (whatone=='2') || (whatone=='3'))
				input_valid=true;
				}// 4 END
			
			if(whatone=='1')
			{// 5 START
				if(gold<400)
					cout << "You dont have enough money to buy this weapon.\nYou need " << 400-gold <<" more gold to buy it" << endl;
				else {// 6 START
				cout << "You buy the best one the DeathWand" << endl;
				weapon=200;
				weaponname[0]='D';
				weaponname[1]='e';
				weaponname[2]='a';
				weaponname[3]='t';
				weaponname[4]='h';
				weaponname[5]='W';
				weaponname[6]='a';
				weaponname[7]='n';
				weaponname[8]='d';
				weaponname[9]=NULL;
				}// 6 END
			}// 5 END
			if(whatone=='2')
			{// 7 START
				if(gold<200)
					cout << "You dont have enough money to buy this weapon.\nYou need " << 200-gold <<" more gold to buy it" << endl;
				else {// 8 START
				
				cout << "You buy the Remover" << endl;
				weapon=100;
				weaponname[0]='R';
				weaponname[1]='e';
				weaponname[2]='m';
				weaponname[3]='o';
				weaponname[4]='v';
				weaponname[5]='e';
				weaponname[6]='r';
				weaponname[7]=NULL;
				}// 8 END
			}// 7 END
			if(whatone=='3')
			{// 9 START
				if(gold<100)
					cout << "You dont have enough money to buy this weapon.\nYou need " << 100-gold <<" more gold to buy it" << endl;	
				else {// 10 START
				cout << "You buy the Basher" << endl;
				weapon=75;
				weaponname[0]='B';
				weaponname[0]='a';
				weaponname[0]='s';
				weaponname[0]='h';
				weaponname[0]='e';
				weaponname[0]='r';
				weaponname[0]=NULL;
				}// 10 END
			}// 9 END
			cout << "\n" << playern << "'s Statistics" << endl;
			cout << "Armor :" << armor << endl;
			cout << "Weapon Name: " << weaponname << endl;
			cout << "Weapon Damage :" << weapon << endl;
			cout << "HP :" << hp << "/" << mhp << endl;
			cout << "Gold:" << gold << endl << endl;
		}// 3 END
		
		if(buy=='2')
		{}// 11 START AND END
}// 1 END
 int randomnumbergen()
{
	srand (time(0) /*000000*/);
	int yo = rand();
	int cool = yo * .0008;
	return (cool);
}
int bosspet()
{
	enemy[0]='W';
	enemy[1]='o';
	enemy[2]='l';
	enemy[3]='f';
	enemy[4]='s';
	enemy[5]='b';
	enemy[6]='a';
	enemy[7]='n';
	enemy[8]='e';
	enemyHP=50;
	enemyAP=5;
	enemyWH=10;
	goldgain=40;
	runpossible=1;
return 0;
}
int bossbeast()
{
	enemy[0]='D';
	enemy[1]='o';
	enemy[2]='i';
	enemy[3]='d';
	enemy[4]='a';
	enemy[5]='s';
	enemy[6]='h';
	enemy[7]='i';
	enemy[8]='m';
	enemy[9]='a';
	enemy[10]='s';
	enemy[11]='t';
	enemy[12]='e';
	enemy[13]=NULL;
	enemyHP=150;
	enemyAP=25;
	enemyWH=15;
	goldgain=90;
	runpossible=0;
	return 0;

}
void rival1()
{
	enemy[0]='D';
	enemy[1]='e';
	enemy[2]='m';
	enemy[3]='o';
	enemy[4]='n';
	enemy[5]='g';
	enemy[6]='o';
	enemy[7]='d';
	enemy[8]=NULL;
	enemyHP=100;
	enemyAP=0;
	enemyWH=40;
	goldgain=142;
	runpossible=0;

}
void rival2()
{
	enemy[0]='R';
	enemy[1]='a';
	enemy[2]='t';
	enemy[3]='m';
	enemy[4]='a';
	enemy[5]='n';
	enemy[6]=NULL;
	enemyHP=100;
	enemyAP=20;
	enemyWH=40;
	goldgain=200;
	runpossible=0;

}
void rival3()
{
	enemy[0]='B';
	enemy[1]='a';
	enemy[2]='t';
	enemy[3]='t';
	enemy[4]='l';
	enemy[5]='e';
	enemy[6]='o';
	enemy[7]='n';
	enemy[8]=NULL;
	enemyHP=200;
	enemyAP=0;
	enemyWH=40;
	goldgain=300;
	runpossible=0;

}
void rival4()
{
	enemy[0]='D';
	enemy[1]='e';
	enemy[2]='a';
	enemy[3]='d';
	enemy[4]='r';
	enemy[5]='e';
	enemy[6]='n';
	enemy[7]='o';
	enemy[8]=NULL;
	enemyHP=100;
	enemyAP=0;
	enemyWH=40;
	goldgain=142;
	runpossible=0;

}
void elfene()
{
	enemy[0]='T';
	enemy[1]='o';
	enemy[2]='r';
	enemy[3]='m';
	enemy[4]='e';
	enemy[5]='s';
	enemy[6]='i';
	enemy[7]='s';
	enemy[8]=NULL;
	enemyHP=149;
	enemyAP=24;
	enemyWH=40;
	goldgain=300;
	runpossible=1;

}
void triwarr()
{
	enemy[0]='T';
	enemy[1]='r';
	enemy[2]='i';
	enemy[3]='w';
	enemy[4]='a';
	enemy[5]='r';
	enemy[6]='r';
	enemy[7]='i';
	enemy[8]='o';
	enemy[9]='r';
	enemy[10]=NULL;
	enemyHP=333;
	enemyAP=33;
	enemyWH=33;
	goldgain=333;
	runpossible=1;

}
void raistlin()
{
	enemy[0]='R';
	enemy[1]='a';
	enemy[2]='i';
	enemy[3]='s';
	enemy[4]='t';
	enemy[5]='l';
	enemy[6]='i';
	enemy[7]='n';
	enemy[8]=NULL;
	enemyHP=500;
	enemyAP=4;
	enemyWH=75;
	goldgain=4000000;
	runpossible=0;

}
void battlegrounds(){// 1 START
while (hp>0) {// 2 START
morebattle='1';
while(((morebattle=='1')&&(hp>0))||((morebattle=='3')&&(hp>0))) {// 3 START
	enemy[0]='A';
	enemy[1]='n';
	enemy[2]='t';
	enemy[3]=NULL;
	enemyHP=(randomnumbergen()+30);
	enemyAP=randomnumbergen();
	goldgain=(randomnumbergen()+30);
	enemyWH=(randomnumbergen()+12);
	battle();
		input_valid=false;
	while (input_valid!=true) {// 4 START
	cout << "\n\n\n\nDo you want to battle some more?" << endl;
	cout << "[1] Yes" << endl;
	cout << "[2] No" << endl;
	cout << "[3] HEAL! (Price: 50 gp)" << endl;
	cin >> morebattle;
	if ((morebattle=='1') || (morebattle=='2') || (morebattle=='3'))
		input_valid=true;
	}// 4 END
	
	 
	if (morebattle==3)
		{// 5 START
		if (gold<50)
			cout << "You do not have enough money!!" << endl;
		else
			mhp = hp;
		
		}// 5 END
	}
	if (hp>0)
	{
		input_valid=false;
			while (input_valid!=true) {// 6 START
			cout << "[1] North to Rigor" << endl;
			cout << "[2] West to Stonn Forest" << endl;
			cout << "[3] East to Desert" << endl;
			cin >> dir1;
			if ((dir1=='1') || (dir1=='2') || (dir1=='3'))
				input_valid=true;
			}// 6 END
			if(dir1=='1') {// 7 START
				clrscr();
				map1();
			}// 7 END

			if(dir1=='2') {// 8 START
				clrscr();
				map2();
			}// 8 END

			if(dir1=='3') {// 9 START
				clrscr();
				map3();
			}// 9 END
	
	}			
	
	if (hp < 1)
		{
		cout << "You thought that you could do something while you are dead hah hah hah..." << endl;
		cout << " [Press Enter To Rest In Peace]";
		}		
	}// 3 END
	}
// 2 end
// 1 end
void endscene()
{
	cout << "    With your final blow death is dealt to Raistlin and the heavens pierce" << endl;
	cout << "the dark clouds with a strong beam of light.  This is the first time that" << endl;
	cout << "Altezza has seen sunlight in a long time and you have a strange feeling" << endl;
	cout << "that the evil has been lifted from this land.  As you look over Raistlin's" << endl;
	cout << "lifeless corpse you see his eyelids twitch Paying no mind you turn and" << endl;
	cout << "leave this land and return to the place where this all began.  Raistlin" << endl;
	cout << "is dead and Altezza will be allowed to flourish once again among the" << endl;
	cout << "greatest realms ever to exist." << endl;
}


// the end... FINALLY.