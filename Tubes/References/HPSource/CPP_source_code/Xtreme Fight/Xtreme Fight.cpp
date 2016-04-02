



//The only thing I can't figure out is WHY the text turns gray when other text scrolls off the screen?!

//I hope you have fun!

#include <stdlib.h> 
#include <stdio.h> 
#include <time.h>   
#include <iostream.h>
#include <string.h>
#include <conio.h>
#include <iomanip.h>
#include <windows.h> //for those pretty colors
int use1 = 0; //for miscellaneous
int use2 = 0;
int use3 = 0;
int use4 = 0;
int use5 = 0;
int easy = 0;
int hard = 0;
char enemyname1[] = "Dragon"; //just for cheking which enemy your are fighting
char enemyname2[] = "Python";
char enemyname3[] = "Boulder";
char enemyname4[] = "Gargoyle";
char enemyname5[] = "Stingray";
char enemyname6[] = "Lighting Bolt";
char enemyname7[] = "Fire Ball";
char enemyname8[] = "Tripod Man";
char enemyname9[] = "Kay-Sar";
char enemyname10[] = "Slayer";

int earned;
int kills = 0;
char yourrank[20];
int ArmorDefense;
int FBdamage;
char FBhit[20];
int FBrandom;
int WTdamage;
char WThit[20];
int WTrandom;
int ETdamage;
char EThit[20];
int ETbolts;
char potionrank[20];
int ETrandom;
int ElectricThunder = 0;
int WaterTsunami = 0;
int FireBlaze = 0;
int FBballs = 0;
int health10 = 0;
int health30 = 0;
int health50 = 0;
int maxhealth = 0;
int maxhealth10 = 0;
int maxhealth30 = 0;
int maxhealth50 = 0;
char armorname[20];
int armorcost;
int BronzeArmor = 0;
int SilverArmor = 0;
int GoldArmor = 0;
int PlatinumArmor = 0;
char potionname[20];
int potioncost;
int crossbow = 0;
int axe = 0;
int bronzesword = 0;
int silversword = 0;
int goldsword = 0;
int platinumsword = 0;
int flamethrower = 0;
int rocketlauncher = 0;

int youaccuracy;
int enemyaccuracy;
int Totalenemyaccuracy;
int enemystrength;
int youstrength;
int enemybattle = 0;
char x; //for input 
char y; //for more input
int enemyattack = 0;
int money = 0;
int enemychoice;
int yourhealth = 100;
int yourmaxhealth = 100;
int enemyhealth;
char yourname[15];
char enemyname[100];

HANDLE stdOut = GetStdHandle(STD_OUTPUT_HANDLE); //has to do with colors

//declaring my functions!

void MainMenu(void);
void Battle(void);
void EnterName(void);
void EnterDifficulty (void);
void BuyWeapon(void);
void Attack(void);
void BuyPotion(void);
void BuyHealthPotion (void);
void BuyWeaponPotion (void);
void BuyArmor (void);
void UseWeaponPotion (void);
void UseHealthPotion (void);
void YourStats (void);
void ET (void);
void WT (void);
void FB (void);
void YouDied (void);
void KilledEnemy (void);
void FBstart (void);
void YouWin (void);
void repeat (void);







void YouDied (void)
{
	if (kills<=5)
	{strcpy(yourrank, "Child"); }
		if ((kills>5) && (kills<=15))
		{strcpy(yourrank, "Squire"); }
		if ((kills>15) && (kills<=30))
		{strcpy(yourrank, "Knight"); }
		if ((kills>30) && (kills<=50))
		{strcpy(yourrank, "Warrior"); }
		if ((kills>50) && (kills<=70))
		{strcpy(yourrank, "Master"); }
		if (kills>70)
		{strcpy(yourrank, "Lord"); }
	system("CLS");
	SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY | BACKGROUND_RED | BACKGROUND_INTENSITY);
cout<<"\n\n\n\n\n\n\n\n\n\t\t\t\tYou Have Died\n\n\n\t\t\t\tYour Rank Was:\n\n\t\t\t\t    "<<yourrank<<"\n\n\n\n\n\n\n\n\n";
cout<<endl;
cout<<"\t\t\t\t\t\t      ";
exit(0);
}

void YouWin (void)
{
	cout<<endl;
	system("CLS");
	cout<<"\t\t\t       CONGRATULATIONS!"<<flush;
	
	SetConsoleTextAttribute(stdOut, FOREGROUND_GREEN | FOREGROUND_INTENSITY);
	cout<<"\n\n\n\n\t\t\t\tYou have won XF"<<flush;
	SetConsoleTextAttribute(stdOut, FOREGROUND_GREEN | FOREGROUND_BLUE| FOREGROUND_RED |FOREGROUND_INTENSITY);
	cout<<"\n________________________________________________________________________________\n";
	cout<<"\n\n\tYou have defeated the mighty Dark Lord and now have proven\n\t\tyourself worthy of being the "<<flush;
		SetConsoleTextAttribute(stdOut, FOREGROUND_GREEN | FOREGROUND_INTENSITY);
	cout<<"BEST XF FIGHTER."<<flush;
		SetConsoleTextAttribute(stdOut, FOREGROUND_GREEN | FOREGROUND_BLUE| FOREGROUND_RED |FOREGROUND_INTENSITY);
	cout<<"\n\n\n________________________________________________________________________________";
	if (easy == 5)
	{cout<<"\nIf you want to REALLY be the best XF fighter, try beating the game on 'hard'.";}
	if (hard == 5)
	{cout<<"\n";}
	cout<<"\n\n\n\n\n\n\n\nThanks for Playing! I hope you had as much fun playing it as I had making it! "<<flush;
	getch();
	repeat();
	
}




void UseHealthPotion (void)

{
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_INTENSITY);
	cout<<"\n\nUse what potion?\n\n"<<flush;
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
	if (health10 == 5)
	{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
	cout<<"(1) - Health10\n"<<flush;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
	if (health30 == 5)
	{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
		cout<<"(2) - Health30\n"<<flush;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
			if (health50 == 5)
	{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
		cout<<"(3) - Health50\n"<<flush;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
			if (maxhealth == 5)
	{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
		cout<<"(4) - MaxHealth\n"<<flush;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
			if (maxhealth10 == 5)
	{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
		cout<<"(5) - MaxHealth10\n"<<flush;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
			if (maxhealth30 == 5)
	{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
		cout<<"(6) - MaxHealth30\n"<<flush;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
			if (maxhealth50 == 5)
	{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
		cout<<"(7) - MaxHealth50\n"<<flush;
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_INTENSITY);

		cin>>x;
	if ((x == '1') && (health10 == 5))
	{
	yourhealth = (yourhealth + 10);
	cout<<"\nYour health has been increased by 10 pts! "<<flush;
	health10 = 0;
	enemybattle = 5;
	getch();
	Battle();
	}

	if ((x == '2') && (health30 == 5))
	{
	yourhealth = (yourhealth + 30);
	cout<<"\nYour health has been increased by 30 pts! "<<flush;
	health30 = 0;
	enemybattle = 5;
	getch();
	Battle();
	}

	if ((x == '3') && (health50 == 5))
	{
	yourhealth = (yourhealth + 50);
	cout<<"\nYour health has been increased by 50 pts! "<<flush;
	health50 = 0;
	enemybattle = 5;
	getch();
	Battle();
	}
				
	if ((x == '4') && (maxhealth == 5))
	{
	yourhealth = yourmaxhealth;
	cout<<"\nYour health has been increased to the maximum! "<<flush;
	maxhealth = 0;
	enemybattle = 5;
	getch();
	Battle();
	}

	if ((x == '5') && (maxhealth10 == 5))
	{
	yourmaxhealth = (yourmaxhealth + 10);
	cout<<"\nYour maximum health has been increased by 10 pts! "<<flush;
	maxhealth10 = 0;
	enemybattle = 5;
	getch();
	Battle();
	}

	if ((x == '6') && (maxhealth30 == 5))
	{
	yourmaxhealth = (yourmaxhealth + 30);
	cout<<"\nYour maximum health has been increased by 30 pts! "<<flush;
	maxhealth30 = 0;
	enemybattle = 5;
	getch();
	Battle();
	}

	if ((x == '7') && (maxhealth50 == 5))
	{
	yourmaxhealth = (yourmaxhealth + 50);
	cout<<"\nYour maximum health has been increased by 50 pts! "<<flush;
	maxhealth50 = 0;
	enemybattle = 5;
	getch();
	Battle();
	}


else if ((health10 < 4) || (health30 <4) || (health50 <4) || (maxhealth <4) || (maxhealth10 <4) || (maxhealth30 <4) || (maxhealth50 <4))
{cout<<"\nYou don't have that potion! "<<flush;
enemybattle = 5;
getch();
Battle();}



}


void UseWeaponPotion (void)
		
		{
			cout<<"\n\nUse what potion?\n\n"<<flush;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
			if (ElectricThunder == 5)
			{SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
			cout<<"(t) - Electric Thunder\n"<<flush;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
			if (WaterTsunami == 5)
			{SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
			cout<<"(w) - Water Tsunami\n"<<flush;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
			if (FireBlaze == 5)
			{SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
			cout<<"(f) - Fire Blaze\n"<<flush;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_INTENSITY);
				cin>>y;
				if ((y == 'w') && (WaterTsunami == 5))
				{WT();}
				if ((y == 'w') && (WaterTsunami < 4))
				{cout<<"\nYou don't have that potion!";
				enemybattle = 5;
				cout<<flush;
				getch();
				Battle();}
				if ((y == 'f') && (FireBlaze == 5))
				{FBstart();}
				if ((y == 'f') && (FireBlaze < 4) && (use1<4))
				{cout<<"\nYou don't have that potion!";
				enemybattle = 5;
				cout<<flush;
				getch();
				Battle();}
				if ((y == 't') && (ElectricThunder < 4))
				{cout<<"\nYou don't have that potion!";
				enemybattle = 5;
				cout<<flush;
				getch();
				Battle();}
				if ((y == 't') && (ElectricThunder == 5))
				{
					cout<<"\nWith what element?";
				cout<<"\n\n(e) - Earth\n(a) - Air\n(f) - Fire\n(w) - Water\n";
				cin>>x;
				if ((x == 'e')|| (x=='a') ||(x =='f') ||(x =='w'))
				
				{
				
				ET();}
				}
				}

				void ET (void)
				{
				
				
		ETrandom = (rand()%100) + 1;
		

if (x == 'e')
{
ETdamage = (rand()%250) + 30;
	if (ETrandom<=65)
			{strcpy(EThit, "struck"); }
			if (ETrandom>65)
			{strcpy(EThit, "missed");
			ETdamage = 0;}
			if (((strcmpi(enemyname, enemyname6)==0)) || ((strcmpi(enemyname, enemyname5)==0)))
{ETdamage = (rand()%11) + 10;}
}
if (x == 'a')
{
ETdamage = (rand()%101) + 100;
	if (ETrandom<=70)
			{strcpy(EThit, "struck"); }
			if (ETrandom>70)
			{strcpy(EThit, "missed");
			ETdamage = 0;}
}
if (x == 'f')
{
	ETrandom = (rand()%100) + 1;
ETdamage = (rand()%131) + 100;
	if (ETrandom<=65)
			{strcpy(EThit, "struck"); }
			if (ETrandom>65)
			{strcpy(EThit, "missed");
			ETdamage = 0;}
}
if (x == 'w')
{
		ETrandom = (rand()%100) + 1;
ETdamage = (rand()%191) + 75;
	if (ETrandom<=70)
			{strcpy(EThit, "struck"); }
	if (ETrandom>70)
			{strcpy(EThit, "missed");
	ETdamage = 0;}
}
if (((strcmpi(enemyname, enemyname6)==0)) || ((strcmpi(enemyname, enemyname5)==0)))
{ETdamage = (rand()%11) + 10;}



			FBrandom = (rand() %100) + 1;
			
					
				if (ETdamage>1)
				{	ETdamage = (rand()%171) + 30;}
				if (x == 'e')
				{cout<<"Electricity is flowing beneath his feet!\n";}
				if (x == 'a')
				{cout<<enemyname<<" is breathing electricy...It's inside him!\n";}
				if (x == 'f')
				{cout<<"You have created Fire bolts!\n";}
				if ((x == 'w') && (use3<4))
				{cout<<"You have created a giant thunderstorm above "<<enemyname<<"!\n";
				use3 = 5;}
					if ((strcmpi(enemyname, enemyname6)==0))
					{cout<<"Lighting Bolt is made of electricity!";}
						if ((strcmpi(enemyname, enemyname5)==0))
						{cout<<"Electricity does not hurt Stingray!";}
				cout<<"The bolt "<<EThit<<" him! ";
				cout<<ETdamage<<" damage was done";
				if (ETbolts>2)
				{enemyattack = 5;}
				enemyhealth = (enemyhealth - ETdamage);
				if (enemyhealth<1)
				{ElectricThunder = 0;
				KilledEnemy();}
			
				cout<<endl;
				getch();
			
				
				ETbolts = ETbolts + 1;
				if (ETbolts>2)
				{ElectricThunder = 0; 
				enemybattle = 5;
				enemyattack = 5;
				Battle();}
					if ((x == 'f') || (x == 'w'))
					{
				if (ETbolts<=2)
				{ET();}
					}
					if ((x == 'e') || (x == 'a'))
					{ElectricThunder = 0; 
				enemybattle = 5;
				enemyattack = 5;
				Battle();}
				
				}
				
				
				
				
				
				
			

////END OF ELECTRIC THUNDER////



void WT (void)
{
	WTrandom = (rand() %100) + 1;

				if ((y == 'w') && (WaterTsunami == 5))
				{
					cout<<"\nWith what element?";
				cout<<"\n\n(e) - Earth\n(a) - Air\n(f) - Fire\n(w) - Water\n";
				cin>>x;
				if ((x == 'e')|| (x=='a') ||(x =='f') ||(x =='w'))
				{
				
if (x == 'e')
{
WTdamage = (rand()%10) + 100;
	if (WTrandom<=100)
			{strcpy(WThit, "crushed"); }
			if (WTrandom>90)
			{strcpy(WThit, "missed");
			WTdamage = 0;}
}
if (x == 'a')
{
WTdamage = (rand()%21) + 130;
	if (WTrandom<=90)
			{strcpy(WThit, "crushed"); }
			if (WTrandom>80)
			{strcpy(WThit, "missed");
			WTdamage = 0;}
}
if (x == 'f')
{
WTdamage = (rand()%21) + 20;
	if (WTrandom<=95)
			{strcpy(WThit, "crushed"); }
			if (WTrandom>80)
			{strcpy(WThit, "missed");
			WTdamage = 0;}
}
if (x == 'w')
{
WTdamage = (rand()%11) + 130;
	if (WTrandom<=100)
			{strcpy(WThit, "crushed"); }
			if (WTrandom>100)
			{strcpy(WThit, "missed");
			WTdamage = 0;}
}



if (x == 'e')
{cout<<"You have created a lake around "<<enemyname<<"!\n";}
if (x == 'w')
{cout<<enemyname<<" can not escape from the giant grasp of the Tsunami!\n";}
if (x == 'f')
{cout<<"The Water Tsunami did not work well with the fire element\n";}
if (x == 'a')
{cout<<"Air becomes water; it will crush "<<enemyname<<"'s bones into dust!\n";}

cout<<"The Tsunami "<<WThit<<" him! ";
				cout<<WTdamage<<" damage was done"<<endl;
				enemyattack = 5;
				enemyhealth = (enemyhealth - WTdamage);
				WaterTsunami = 0;
				getch();
				if (enemyhealth<1)
				{KilledEnemy();}
				enemybattle = 5;
			
				Battle();
				
				
				}
				}
}



///END OF WATER TSUNAMI///


void FBstart (void)
{
	WTrandom = (rand() %100) + 1;

				if ((y == 'f') && (FireBlaze == 5))
				{
					cout<<"\nWith what element?";
				cout<<"\n\n(e) - Earth\n(a) - Air\n(f) - Fire\n(w) - Water\n";
				cin>>x;
				
				if ((x == 'e')|| (x=='a') ||(x =='f') ||(x =='w'))
				{FB();}
				}
}
		void FB (void)
{		
			FBrandom = (rand() %100) + 1;
if (x == 'e')
{
FBdamage = (rand()%101) + 80;

	if (FBrandom<=80)
			{strcpy(FBhit, "burned"); }
			if (FBrandom>80)
			{strcpy(FBhit, "missed");
			FBdamage = 0;}
}

if (x == 'f')
{
FBdamage = (rand()%91) + 120;
	if (FBrandom<=85)
			{strcpy(FBhit, "burned"); }
			if (FBrandom>90)
			{strcpy(FBhit, "missed");
			FBdamage = 0;}
}
if (x == 'w')
{
FBdamage = (rand()%21) + 20;
	if (FBrandom<=90)
			{strcpy(FBhit, "burned"); }
			if (FBrandom>90)
			{strcpy(FBhit, "missed");
			FBdamage = 0;}
}
				
if (x == 'a')
{
	FBrandom = (rand()%100) + 1;
	use1 = 5;
FBdamage = (rand()%30) + 20;
	if (FBrandom<=85)
			{strcpy(FBhit, "burned"); }
			if (FBrandom>85)
			{strcpy(FBhit, "missed");
			FBdamage = 0;}
}

if ((strcmpi(enemyname, enemyname7)==0)) 
{FBdamage = (rand()%11) + 10;}
if (x == 'e')
{cout<<"You have turned the earth's crust into lava!\n";}
if (x == 'w')
{cout<<"The Fire Blaze did not work well with the water element\n";}
if (x == 'f')
{cout<<"You have created a Fire blaze twice the size!\n";}
if ((x == 'a') && (use2<4))
{cout<<"It's raining Fire Balls!\n";
use2 = 5;}
					if ((strcmpi(enemyname, enemyname7)==0))
{cout<<"Fire Ball is amune to Fire!\n";}
					




cout<<"The fire "<<FBhit<<" him! ";
if (FBdamage<=20)
{cout<<"Only ";}
				cout<<FBdamage<<" damage was done"<<endl;
				if (FBballs>4)
				{enemyattack = 5;}
				enemyhealth = (enemyhealth - FBdamage);
				if (use2 <4)
				{FireBlaze = 0;}
				FBballs = FBballs + 1;
				getch();
				if (enemyhealth<1)
				{KilledEnemy();}
			


			
	if ((use2>4) && (FBballs <=4))
	{enemybattle = 5;
	FB();}


				if (FBballs>4)
				{FireBlaze = 0; 
				enemybattle = 5;
				enemyattack = 5;
				Battle();}
				
				if ((x == 'e') || (x == 'w') || (x == 'f'))
				{enemybattle = 5;
				enemyattack = 5;
				Battle();}
				
				
		}
				
				
				
			




void BuyArmor (void)
{
	system("CLS");
cout<<"Welcome to the Armor shop. We sell only the finest armor here, made to protect\nyou from your fellow enemies.\n\n";
cout<<"You have "<<money<<" c\n\n";
cout<<"What would you like to buy?\n";
cout<<"_________________________________\n\n";

cout<<"      Armor:\t\t\t\t Defense:\t\t\tPrice:\n\n";
cout<<"(b) - Bronze Armor\t\t\t5 - 15 pts\t\t\t200 c\n";
cout<<"(s) - Silver Armor\t\t\t15 - 30 pts\t\t\t350 c\n";
cout<<"(g) - Gold Armor\t\t\t30 - 40 pts\t\t\t500 c\n";
cout<<"(p) - Platinum Armor\t\t\t40 - 50 pts\t\t\t650 c\n";
cout<<"(e) - Exit\n";
//This is the easy way of doing things:
cin>>x;
switch (x)
{

case 'b':
{
	strcpy(armorname, "Bronze Armor"); 
	armorcost = 200;
	if (BronzeArmor == 5)
	{cout<<"You already have this armor!"<<flush;
	getch();
	BuyArmor();}
	break;
}
case 's':
{
	strcpy(armorname, "Silver Armor"); 
	armorcost = 350;
if (SilverArmor == 5)
	{cout<<"You already have this armor!"<<flush;
	getch();
	BuyArmor();}
	break;
}
case 'g':
{
	strcpy(armorname, "Gold Armor"); 
	armorcost = 500;
	if (GoldArmor == 5)
	{cout<<"You already have this armor!"<<flush;
	getch();
	BuyArmor();}
	break;
}
case 'p':
{
	strcpy(armorname, "Platinum Armor"); 
	armorcost = 650;
	if (PlatinumArmor == 5)
	{cout<<"You already have this armor!"<<flush;
	getch();
	BuyArmor();}
	break;
}
case 'e':
	{MainMenu();}
}
if (money<armorcost)
{cout<<"\nYou don't have enough coins to buy this armor."
	<<"\nWould you like to buy sotmhing else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyArmor();}
		if (x=='n')
		{MainMenu();}
}
if (money>=armorcost)
{cout<<"\nBuy "<<armorname<<": Are you sure? (y/n) ";
	cin>>x;
	if (x == 'y')
	{	cout<<endl;
	SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY);
	
		cout<<"You have bought the "<<armorname<<" for ";
		
			cout<<armorcost<<" c\n";
		money = (money - armorcost);
		if (armorcost == 200)
		{BronzeArmor = 5;}
			if (armorcost == 350)
		{SilverArmor = 5;}
		if (armorcost == 500)
		{GoldArmor = 5;}
		if (armorcost == 650)
		{PlatinumArmor = 5;}
		
	cout<<"Would you like to buy something else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyArmor();}
		if (x=='n')
		{MainMenu();}

	
}
if (x=='n')
{BuyArmor();}
}}



























				
		void KilledEnemy (void)
		{
if (enemyhealth <1)

{cout<<endl;

cout<<"\nYou have defeated "<<enemyname<<"!";
if ((kills == 10) || (kills == 20) || (kills == 30) || (kills == 40) || (kills == 50) || (kills == 60) || (kills == 70))
{earned = 100;}
else
{
	if (easy == 5)
{earned = 100;}
	if (hard == 5)
	{earned = 50;}
}

cout<<"\nYou have earned "<<earned<<" gold coins!";
kills = (kills + 1);
money = (money + earned);

if (kills == 11) //the bosses last words
{cout<<endl<<endl<<endl<<"Mr.Spike: I can't believe you have defeated me...I...am...dying..!"<<flush;
getch();
cout<<"\n\n"<<yourname<<": Yeah. And tell all your evil friends that you haven't seen the last of me!\nI'm coming back for more."<<flush;
getch();
cout<<"\n\nMr.Spike: NNNOOOOOOOOOOOOO!!!..."<<flush;
getch();
cout<<" *explodes into hundreds of pieces* ";}


if (kills == 21)
{cout<<endl<<endl<<endl<<"Dark Shadow: SCREECH! Thy will not be so lucky again in the future..."<<flush;
getch();
cout<<"\n\n"<<yourname<<": ...Yes I will."<<flush;
getch();
cout<<"\n\nDark Shadow: HHAHAHAHAHAA!! FOOL! The Dark Lord will crush you like an ant!"<<flush;
getch();
cout<<"\n\n"<<yourname<<": We'll see about that. ";}


if (kills == 31)
{cout<<endl<<endl<<endl<<"The Blob: *><95IK@^*%*JM|VDS$$&HJ||%%$@!&*KHHGFTEDark LordGHHFFD&*(*&^%$#@ !!!"<<flush;
getch();
cout<<"\n\n"<<yourname<<": Umm...Ok, Blob."<<flush;
getch();
cout<<"\n\nThe Blob: !!!!!"<<flush;
getch();
cout<<"\n\n"<<yourname<<": I see... ";}

if (kills == 41)
{cout<<endl<<endl<<endl<<"Black Skull: You have great fighting skill, warrior, to defeat me."<<flush;
getch();
cout<<"\n\n"<<yourname<<": Thanks."<<flush;
getch();
cout<<"\n\nBlack Skull: Hehehe...I shall make your enemies stronger! Now let's see\nyou defeat them! HAAHAHAAH!!!";}

if (kills == 51)
{cout<<endl<<endl<<endl<<"Cyclopse: NNOOOOO! How could you defeat me?!"<<flush;
getch();
cout<<"\n\n"<<yourname<<": I get that alot."<<flush;
getch();
cout<<"\n\nCyclopse: You will be no match for the Dark Lord!! BEWARE!!";}



if (kills == 61)
{cout<<endl<<endl<<endl<<"E.V.I.L: I  A.M  E.V.I.L  T.H.E  D.A.R.K  L.O.R.D.S  H.I.G.H.E.S.T\nS.E.R.V.A.N.T."<<flush;
getch();
cout<<"\n\nE.V.I.L: I S.H.A.L.L  S.E.E  Y.O.U.  I.N.   H.E.L.L  !.!.!"<<flush;
getch();
cout<<"\n\n"<<yourname<<": ...*you are temporarily paralyzed by E.V.I.L's last grasp*"; }



if (kills == 71)
{cout<<endl<<endl<<endl<<"Dark Lord: ...You...Have...Defeated..Me!!!"<<flush;
getch();
cout<<"\n\n*Dark Lord starts to shake and turn different colors*"<<flush;
getch();
cout<<"\n\nDark Lord: NNNNOOOOOOOOOOOOOOOOOOOOO !!!!"<<flush;
getch();
cout<<"\n\n*Dark Lord explodes into a million pieces*";}


















enemyattack = 1;
use4 = 0;
cout<<endl;
if ((kills == 10) || (kills == 20) || (kills == 30) || (kills == 40) || (kills == 50) || (kills == 60) || (kills == 70))
{SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_INTENSITY);
	cout<<"\nThe Boss has challenged you. Get ready... "<<flush;
getch();
Battle();
}
getch();
if (kills==71)
{YouWin();}
MainMenu();
}
if (yourhealth<1)
{cout<<"\n\nYou have died in the battle with "<<enemyname<<flush;
getch();
YouDied();
}
		}
	

		



void MainMenu(void)
{

               system("CLS");
			   
enemybattle = 0;
if ((kills == 10) || (kills == 20) || (kills == 30) || (kills == 40) || (kills == 50) || (kills == 60) || (kills == 70))
{enemybattle = 5;}

	cout<<"What whould you like to do?\n\n";

	cout<<"(f) - Fight\n"

		<<"(w) - Buy new weapon\n"
		<<"(a) - Buy new armor\n"
		<<"(p) - Buy new potion\n"
		<<"(s) - Look at your current status\n\n"
		<<"(e) - Exit Game\n\n";

	cin>>x;
	
	switch(x)
	{
	
	case 'f':
	{
                           Battle();   
                break;}
                case 'w':
                {
                         BuyWeapon(); 
                                                 
                }
				case 'p':
					{
						BuyPotion();
					}
				case 'a':
					{	
						BuyArmor();
					}
				case 's':
					{
						YourStats();
					}
				case 'e':
 {
	  cout<<"\nExit Game: Are you sure? (y/n) ";
	  cin>>x;
	 if (x == 'y')
	 {cout<<endl;
	 exit(0);}
	 if (x == 'n')
	 {MainMenu();}

	} 
	}
}




void YourStats (void)
{

	if (kills<=5)
	{strcpy(yourrank, "Child"); }
		if ((kills>5) && (kills<=15))
		{strcpy(yourrank, "Squire"); }
		if ((kills>15) && (kills<=30))
		{strcpy(yourrank, "Knight"); }
		if ((kills>30) && (kills<=50))
		{strcpy(yourrank, "Warrior"); }
		if ((kills>50) && (kills<=70))
		{strcpy(yourrank, "Master"); }
		if (kills>70)
		{strcpy(yourrank, "Lord"); }
	

	system("CLS");
	
cout<<"Name: "<<yourname<<"\n\n";
cout<<"Health: "<<yourhealth<<"%\n\n";
cout<<"Maximum Health: "<<yourmaxhealth<<"%\n\n";
cout<<"Rank: "<<yourrank<<"\n\n";
cout<<"Gold Coins: "<<money<<"\n\n";
cout<<"# of enemies killed: "<<kills<<"\n\n\n";
cout<<"Press any key to continue "<<flush;
getch();
MainMenu();







}




void BuyPotion (void)
{

	system("CLS");
	cout<<"Welcome to the Potions shop. Here you will find two unique types of powerful\npotions that can restore your health or be used as a weapon of magic like no\nother.\n\n";
cout<<"What would you like to buy?\n";
cout<<"_________________________________\n\n";
cout<<"(h) - Health Potion\n";
cout<<"(w) - Weapon Potion\n";
cout<<"(e) - Exit\n";
cin>>x;
if (x == 'h')
{BuyHealthPotion();}
if (x == 'w')
{BuyWeaponPotion();}
if (x == 'e')
{MainMenu();}
}
void BuyHealthPotion (void)
{
	system("CLS");
	cout<<"Ahh, yes...The health potions. A wise chose indeed, "<<potionrank<<".\n\n";

	cout<<"You have "<<money<<" c\n\n";
cout<<"What would you like to buy?\n";
cout<<"_________________________________\n\n";
cout<<"  Potion:\t\t\tDescription:\t\t\t\tPrice:\n\n";
cout<<"(1) - Health10\t\t\tAdds 10 points to your health\t\t   20 c\n";
cout<<"(2) - Health30\t\t\tAdds 30 points to your health\t\t   40 c\n";
cout<<"(3) - Health50\t\t\tAdds 50 points to your health\t\t   50 c\n\n";
cout<<"(4) - MaxHealth\t\t\tRestores your health to\n\t\t\t\tyour current maximum ammount.\t\t  200 c\n\n";
cout<<"(5) - MaxHealth10\t\tAdds 10 points to your maximum health\t  100 c\n";
cout<<"(6) - MaxHealth30\t\tAdds 30 points to your maximum health\t  300 c\n";
cout<<"(7) - MaxHealth50\t\tAdds 50 points to your maximum health\t  500 c\n";
cout<<"(e) - Exit\n\n";
cin>>x;
//the easy way of doing things:
switch (x)
{

case '1':
{
	strcpy(potionname, "Health10"); 
	potioncost = 20;
		if (health10 == 5)
	{cout<<"You already have this potion!"<<flush;
	getch();
	BuyHealthPotion();}
	break;
}
case '2':
{
	strcpy(potionname, "Health30"); 
	potioncost = 40;
		if (health30 == 5)
	{cout<<"You already have this potion!"<<flush;
	getch();
	BuyHealthPotion();}
	break;
}
case '3':
{
	strcpy(potionname, "Health50"); 
	potioncost = 50;
		if (health50 == 5)
	{cout<<"You already have this potion!"<<flush;
	getch();
	BuyHealthPotion();}
	break;
}
case '4':
{
	strcpy(potionname, "MaxHealth"); 
	potioncost = 200;
		if (maxhealth == 5)
	{cout<<"You already have this potion!"<<flush;
	getch();
	BuyHealthPotion();}
	break;
}
case '5':
{
	strcpy(potionname, "MaxHealth10"); 
	potioncost = 100;
		if (maxhealth10 == 5)
	{cout<<"You already have this potion!"<<flush;
	getch();
	BuyHealthPotion();}
	break;
}
case '6':
{
	strcpy(potionname, "MaxHealth30"); 
	potioncost = 300;
		if (maxhealth30 == 5)
	{cout<<"You already have this potion!"<<flush;
	getch();
	BuyHealthPotion();}
	break;
}
case '7':
{
	strcpy(potionname, "MaxHealth50"); 
	potioncost = 500;
		if (maxhealth50 == 5)
	{cout<<"You already have this potion!"<<flush;
	getch();
	BuyHealthPotion();}
	break;
}
case 'e':
	{BuyPotion();}

}
if (money<potioncost)
{cout<<"\nYou don't have enough coins to buy this potion."
	<<"\nWould you like to buy sotmhing else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyHealthPotion();}
		if (x=='n')
		{BuyPotion();}
}
if (money>=potioncost)
{cout<<"Buy "<<potionname<<" potion: Are you sure? (y/n) ";
	cin>>x;
	if (x == 'y')
	{	cout<<endl;
	SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY);

		cout<<"You have bought the "<<potionname<<" potion for ";
		
			cout<<potioncost<<" c\n";
		money = (money - potioncost);
		if (potioncost == 20)
		{health10 = 5;}
			if (potioncost == 40)
		{health30 = 5;}
		if (potioncost == 50)
		{health50 = 5;}
			if (potioncost == 200)
		{maxhealth = 5;}
			if (potioncost == 100)
		{maxhealth10 = 5;}
			if (potioncost == 300)
		{maxhealth30 = 5;}
			if (potioncost == 500)
		{maxhealth50 = 5;}
	cout<<"Would you like to buy something else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyHealthPotion();}
		if (x=='n')
		{BuyPotion();}

	
}
if (x=='n')
{BuyHealthPotion();}
}}
	





void BuyWeaponPotion (void)
{
	if (kills>=30)
		{strcpy(potionrank, "great master"); }
	if (kills<30)
			{strcpy(potionrank, "young jedi"); }
	system("CLS");
	cout<<"The weapon potions...very expensive...but powerful. Use these wisley,\n"<<potionrank<<".\n\n"; 
		cout<<"You have "<<money<<" c\n\n";
cout<<"What would you like to buy?\n";
cout<<"_________________________________\n\n";
cout<<"Potion:\t\t\tDescription:\t\t\t\t\tPrice:\n\n";
cout<<"(t) - Electric Thunder\tCreats a destructive thunder\n\t\t\tstorm above your enemy (30 - 200 pts)\t\t150 c\n\n"; 
cout<<"(w) - Water Tsunami\tCreats a huge wave that drowns\n\t\t\tyour enemy (100 - 150 pts)\t\t\t300 c\n\n"; 
cout<<"(f) - Fire Blaze\tCreates a giant ball of fire which\n\t\t\tmoves around your enemy. Can be twice\n\t\t\tas powerful as the flamethrower (80 - 180 pts)\t350 c\n";
cout<<"(e) - Exit";
cout<<endl;



cin>>x;
switch (x)
{

case 't':
{	
	if (ElectricThunder == 5)
	{cout<<"You already have this potion!"<<flush;
	getch();
	BuyWeaponPotion();}
	strcpy(potionname, "Electric Thunder"); 
	potioncost = 150;
	break;
}
case 'w':
{
	if (WaterTsunami == 5)
	{cout<<"You already have this potion!"<<flush;
	getch();
	BuyWeaponPotion();}
	strcpy(potionname, "Water Tsunami"); 
	potioncost = 300;
	break;
}
case 'f':
{
	if (FireBlaze == 5)
	{cout<<"You already have this potion!"<<flush;
	getch();
	BuyWeaponPotion();}
	strcpy(potionname, "Fire Blaze"); 
	potioncost = 350;
	break;
}
case 'e':
	{BuyPotion();}

}
if (money<potioncost)
{cout<<"\nYou don't have enough coins to buy this potion."
	<<"\nWould you like to buy sotmhing else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeaponPotion();}
		if (x=='n')
		{BuyPotion();}
}
if (money>=potioncost)
{cout<<"Buy "<<potionname<<" potion: Are you sure? (y/n) ";
	cin>>x;
	if (x == 'y')
	{	cout<<endl;
	SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY);

		cout<<"You have bought the "<<potionname<<" potion for ";
		
			cout<<potioncost<<" c\n";
		money = (money - potioncost);
		if (potioncost == 150)
		{ElectricThunder = 5;}
			if (potioncost == 300)
		{WaterTsunami = 5;}
		if (potioncost == 350)
		{FireBlaze = 5;}
		
	cout<<"Would you like to buy something else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeaponPotion();}
		if (x=='n')
		{BuyPotion();}

	
}
if (x=='n')
{BuyWeaponPotion();}
}}























void BuyWeapon(void)
{
	system("CLS");
	cout<<"Welcome to the Weapons of Mass Destruction shop. We sell only the finest weaponsfor really low prices...each one is made by hand with the skill and care of our excellent craftsman.\n\n";
cout<<"You have "<<money<<" c\n\n";
	cout<<"What would like to buy?\n";
	cout<<"_________________________________\n\n";
cout<<"   Weapon:\t\t\tAccuracy:\t Power:\t\t\tPrice:\n\n"//what would I do without random numbers?
<<"(c) - Crossbow\t\t\t   65%\t\t10 - 20 pts\t\t 100 c\n"//(rand() % 11) + 10;
<<"(a) - Axe\t\t\t   75%\t\t20 - 30 pts\t\t 300 c\n"//(rand() % 11) + 20;
<<"(b) - Bronze sword\t\t   90%\t\t10 - 40 pts\t\t 350 c\n"//(rand() % 31) + 10;
<<"(s) - Silver sword\t\t   90%\t\t20 - 40 pts\t\t 450 c\n"//(rand() % 21) + 20;
<<"(g) - Gold sword\t\t   90%\t\t30 - 40 pts\t\t 550 c\n"//(rand() % 11) + 30;
<<"(p) - Platinum sword\t\t   90%\t\t40 - 50 pts\t\t 650 c\n"//(rand() % 11) + 40;
<<"(f) - Flamethrower\t\t   60%\t\t50 - 90 pts\t\t 800 c\n"//(rand() % 41) + 50;
<<"(r) - Rocket launcher\t\t   65%\t\t90 - 100 pts\t\t 1000 c\n";//(rand() % 11) + 90;
cout<<"(e) - Exit";
cout<<endl<<endl;
cin>>x;
//The very long and hard way:
switch(x)
{
case 'c':
{
		if (crossbow == 5)
	{cout<<"You already have this weapon!"<<flush;
	getch();
	BuyWeapon();}
	if (money>=100)
{cout<<"Buy crossbow: Are you sure? (y/n) ";
	cin>>x;
	if (x == 'y')
	{
		cout<<"\nYou have bought the crossbow for 100 c";
		money = (money - 100);
		crossbow = 5;
	cout<<"\nWould you like to buy something else? (y/n)";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
	if (x == 'n')
	{BuyWeapon();}
	}
	if (money<100)
	{
		cout<<"\nYou don't have enough coins to buy this item.";
	cout<<"\nWould you like to buy sotmhing else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
}


case 'a':
{		if (axe == 5)
	{cout<<"You already have this weapon!"<<flush;
	getch();
	BuyWeapon();}
	if (money>=300)
{cout<<"Buy Axe: Are you sure? (y/n) ";
	cin>>x;
	if (x == 'y')
	{
		cout<<"\n\nYou have bought the axe for 300 c";
		money = (money - 300);
		axe = 5;
	cout<<"\nWould you like to buy something else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
	if (x == 'n')
	{BuyWeapon();}
	}
	if (money<300)
	{
		cout<<"\nYou don't have enough coins to buy this item.";
	cout<<"\nWould you like to buy sotmhing else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
}


case 'b':
{
			if (bronzesword== 5)
	{cout<<"You already have this weapon!"<<flush;
	getch();
	BuyWeapon();}
	if (money>=300)
{cout<<"Buy bronze sword: Are you sure? (y/n) ";
	cin>>x;
	if (x == 'y')
	{
		cout<<"\n\nYou have bought the bronze sword for 350 c";
		money = (money - 350);
		bronzesword = 5;
	cout<<"\nWould you like to buy something else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
	if (x == 'n')
	{BuyWeapon();}
	}
	if (money<350)
	{
		cout<<"\nYou don't have enough coins to buy this item.";
	cout<<"\nWould you like to buy sotmhing else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
}



case 's':
{
	if (money>=450)
{cout<<"Buy silver sword: Are you sure? (y/n) ";
	cin>>x;
	if (x == 'y')
	{
		cout<<"\n\nYou have bought the bronze sword for 450 c";
		money = (money - 450);
		silversword = 5;
	cout<<"\nWould you like to buy something else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
	if (x == 'n')
	{BuyWeapon();}
	}
	if (money<450)
	{
		cout<<"\nYou don't have enough coins to buy this item.";
	cout<<"\nWould you like to buy sotmhing else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
}





case 'g':
{
			if (goldsword == 5)
	{cout<<"You already have this weapon!"<<flush;
	getch();
	BuyWeapon();}
	if (money>=550)
{cout<<"\n\nBuy gold sword: Are you sure? (y/n) ";
	cin>>x;
	if (x == 'y')
	{
		cout<<"\n\nYou have bought the gold sword for 550 c";
		money = (money - 550);
	goldsword = 5;
	cout<<"\nWould you like to buy something else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
	if (x == 'n')
	{BuyWeapon();}
	}
	if (money<550)
	{
		cout<<"\nYou don't have enough coins to buy this item.";
	cout<<"\nWould you like to buy sotmhing else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
}




case 'p':
{
			if (platinumsword == 5)
	{cout<<"You already have this weapon!"<<flush;
	getch();
	BuyWeapon();}
	if (money>=650)
{cout<<"\n\nBuy platinum sword: Are you sure? (y/n) ";
	cin>>x;
	if (x == 'y')
	{
		cout<<"\n\nYou have bought the platinum sword for 650 c";
		money = (money - 650);
	platinumsword = 5;
	cout<<"\nWould you like to buy something else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
	if (x == 'n')
	{BuyWeapon();}
	}
	if (money<650)
	{
		cout<<"\nYou don't have enough coins to buy this item.";
	cout<<"\nWould you like to buy sotmhing else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
}



case 'f':
{
			if (flamethrower == 5)
	{cout<<"You already have this weapon!"<<flush;
	getch();
	BuyWeapon();}
	if (money>=800)
{cout<<"\n\nBuy flamthrower: Are you sure? (y/n) ";
	cin>>x;
	if (x == 'y')
	{
		cout<<"\n\nYou have bought the flamethrower for 800 c";
		money = (money - 800);
	flamethrower = 5;
	cout<<"\nWould you like to buy something else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
	if (x == 'n')
	{BuyWeapon();}
	}
	if (money<800)
	{
		cout<<"\nYou don't have enough coins to buy this item.";
	cout<<"\nWould you like to buy sotmhing else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
}



case 'r':
{
			if (rocketlauncher == 5)
	{cout<<"You already have this weapon!"<<flush;
	getch();
	BuyWeapon();}
	if (money>=1000)
{cout<<"\n\nBuy rocket launcher: Are you sure? (y/n) ";
	cin>>x;
	if (x == 'y')
	{
		cout<<"\n\nYou have bought the rocket launcher for 1000 c";
		money = (money - 1000);
	rocketlauncher = 5;
	cout<<"\nWould you like to buy something else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
	if (x == 'n')
	{BuyWeapon();}
	}
	if (money<1000)
	{
		cout<<"\nYou don't have enough coins to buy this item.";
	cout<<"\nWould you like to buy sotmhing else? (y/n) ";
	cin>>x;
		if (x=='y')
		{BuyWeapon();}
		if (x=='n')
		{MainMenu();}
		
	}
}

case 'e':
	{MainMenu();}






}

}

void Battle(void)
{	system("CLS");
	ETbolts = 0;

if (enemybattle < 4)
{
    	enemychoice = (rand() % 100) + 1;
}
youaccuracy = (rand() % 100) + 1; 
Totalenemyaccuracy = (rand() % 100) + 1; 


if ((enemychoice>=1) && (enemychoice<=10))
{strcpy(enemyname, "Dragon"); 
if (enemybattle < 4)
{
enemyhealth = 40;
if ((kills>=10) && (kills<40))
{enemyhealth = 70;}
if (kills>=40)
{enemyhealth = 105;}
}
enemyaccuracy = 80;
enemystrength =  (rand() % 9) + 4;
if ((kills>=10) && (kills<40))
{enemystrength = (rand() % 20) + 5;}
if (kills>=40)
{enemystrength = (rand()%20 ) + 10;}
}



if ((enemychoice>10) && (enemychoice<=20))
{strcpy(enemyname, "Python"); 
if (enemybattle < 4)
{
enemyhealth = 40;
if ((kills>=10) && (kills<40))
{enemyhealth = 70;}
if (kills>=40)
{enemyhealth = 100;}
}
enemyaccuracy = 90;
enemystrength =  (rand() % 10) + 1;
if ((kills>=10) && (kills<40))
{enemystrength = (rand() %20) + 10;}
if (kills>=40)
{enemystrength = (rand()%20 ) + 15;}
}

if ((enemychoice>20) && (enemychoice<=30))
{strcpy(enemyname, "Boulder");
if (enemybattle < 4)
{
enemyhealth = 35;
if ((kills>=10) && (kills<40))
{enemyhealth = 65;}
if (kills>=40)
{enemyhealth = 90;}
}
enemyaccuracy = 60;
enemystrength =  (rand() % 15) + 1;
if ((kills>=10) && (kills<40))
{enemystrength = (rand() %25) + 10;}
if (kills>=40)
{enemystrength = (rand()%25 ) + 15;}
}

if ((enemychoice>30) && (enemychoice<=40))
{strcpy(enemyname, "Gargoyle"); 
if (enemybattle < 4)
{
enemyhealth = 20;
if ((kills>=10) && (kills<40))
{enemyhealth = 50;}
if (kills>=40)
{enemyhealth = 90;}
}
enemyaccuracy = 75;
enemystrength =  (rand() % 8) + 3;
if ((kills>=10) && (kills<40))
{enemystrength = (rand() %18) + 13;}
if (kills>=40)
{enemystrength = (rand()%18 ) + 18;}
}

if ((enemychoice>40) && (enemychoice<=50))
{strcpy(enemyname, "Stingray"); 
if (enemybattle < 4)
{
enemyhealth = 15;
if ((kills>=10) && (kills<40))
{enemyhealth = 45;}
if (kills>=40)
{enemyhealth = 85;}
}
enemyaccuracy = 80;
enemystrength =  (rand() % 12) + 2;
if ((kills>=10) && (kills<40))
{enemystrength = (rand() %22) + 12;}
if (kills>=40)
{enemystrength = (rand()%22 ) + 17;}
}

if ((enemychoice>50) && (enemychoice<=60))
{strcpy(enemyname, "Lighting Bolt");
if (enemybattle < 4)
{
enemyhealth = 30;
if ((kills>=10) && (kills<40))
{enemyhealth = 60;}
if (kills>=40)
{enemyhealth = 80;}
}
enemyaccuracy = 50;
enemystrength =  (rand() % 12) + 2;
if((kills>=10) && (kills<40))
{enemystrength = (rand() %22) + 12;}
if (kills>=40)
{enemystrength = (rand()%22 ) + 17;}
}

if ((enemychoice>60) && (enemychoice<=70))
{strcpy(enemyname, "Fire Ball");
if (enemybattle < 4)
{ 
enemyhealth = 40;
if ((kills>=10) && (kills<40))
{enemyhealth = 70;}
if (kills>=40)
{enemyhealth = 100;}
}
enemyaccuracy = 85;
enemystrength = (rand() % 5) + 1;
if ((kills>=10) && (kills<40))
{enemystrength = (rand() %15) + 10;}
if (kills>=40)
{enemystrength = (rand()%15 ) + 15;}
}

if ((enemychoice>70) && (enemychoice<=80))
{strcpy(enemyname, "Tripod Man");
if (enemybattle < 4)
{
enemyhealth = 30; 
if ((kills>=10) && (kills<40))
{enemyhealth = 70;}
if (kills>=40)
{enemyhealth = 110;}
}
enemyaccuracy = 90;
enemystrength =  (rand() % 4) + 1;
if ((kills>=10) && (kills<40))
{enemystrength = (rand() %14) + 10;}
if (kills>=40)
{enemystrength = (rand()%14 ) + 15;}
}

if ((enemychoice>80) && (enemychoice<=90))
{strcpy(enemyname, "Kay-Sar"); 
if (enemybattle < 4)
{
enemyhealth = 40;
if ((kills>=10) && (kills<40))
{enemyhealth = 70;}
if (kills>=40)
{enemyhealth = 100;}
}
enemyaccuracy = 70;
enemystrength =  (rand() % 7) + 2;
if ((kills>=10) && (kills<40))
{enemystrength = (rand() %17) + 12;}
if (kills>=40)
{enemystrength = (rand()%17 ) + 17;}
}

if ((enemychoice>90) && (enemychoice<=100))
{strcpy(enemyname, "Slayer"); 
if (enemybattle < 4)
{
enemyhealth = 25;
if ((kills>=10) && (kills<40))
{enemyhealth = 70;}
if (kills>=40)
{enemyhealth = 90;}
}
enemyaccuracy = 75;
enemystrength =  (rand() % 6) + 3;
if ((kills>=10) && (kills<40))
{enemystrength = (rand() %16) + 13;}
if (kills>=40)
{enemystrength = (rand()%16 ) + 18;}
}





if (kills == 10)
{
strcpy(enemyname, "Mr. Spike");

if (use4<4)
{enemyhealth = 100;
use4 = 5;} 

enemyaccuracy = 85;
enemystrength =  (rand() % 20) + 10;
}

if (kills == 20)
{
strcpy(enemyname, "Dark Shadow");

if (use4<4)
{enemyhealth = 150;
use4 = 5;} 

enemyaccuracy = 80;
enemystrength =  (rand() % 36) + 5;
}
if (kills == 30)
{
strcpy(enemyname, "The Blob");

if (use4<4)
{enemyhealth = 200;
use4 = 5;} 

enemyaccuracy = 60;
enemystrength =  (rand() % 40) + 1;
}


if (kills == 40)
{
strcpy(enemyname, "Black Skull");

if (use4<4)
{enemyhealth = 350;
use4 = 5;} 

enemyaccuracy = 75;
enemystrength =  (rand() % 40) + 20;
}


if (kills == 50)
{
strcpy(enemyname, "Cyclopse");

if (use4<4)
{enemyhealth = 400;
use4 = 5;} 

enemyaccuracy = 80;
enemystrength =  (rand() % 45) + 25;
}



if (kills == 60)
{
strcpy(enemyname, "E.V.I.L");

if (use4<4)
{enemyhealth = 450;
use4 = 5;} 

enemyaccuracy = 100;
enemystrength =  (rand() % 50) + 35;
}



if (kills == 70)
{
strcpy(enemyname, "Dark Lord");

if (use4<4)
{enemyhealth = 500;
use4 = 5;} 

enemyaccuracy = 100;
enemystrength =  (rand() % 50) + 45;
}





if (BronzeArmor == 5)
{ArmorDefense = (rand()%11) + 5;
enemystrength = (enemystrength - ArmorDefense);
if (enemystrength < 0)
{enemystrength = 0;}
}
if (SilverArmor == 5)
{ArmorDefense = (rand()%16) + 15;
enemystrength = (enemystrength - ArmorDefense);
if (enemystrength < 0)
{enemystrength = 0;}
}
if (GoldArmor == 5)
{ArmorDefense = (rand()%11) + 25;
enemystrength = (enemystrength - ArmorDefense);
if (enemystrength < 0)
{enemystrength = 0;}
}
if (PlatinumArmor == 5)
{ArmorDefense = (rand()%11) + 40;
enemystrength = (enemystrength - ArmorDefense);
if (enemystrength < 0)
{enemystrength = 0;}
}

if ((kills == 70) && (use5<4))
{cout<<"\nDark Lord: We me at last, "<<yourname<<"."<<flush;
getch();
cout<<"\n\n"<<yourname<<": Yes. I've heard so much about you."<<flush;
getch();
cout<<"\n\nDark Lord: You can turn back now. Are you sure you want to challenge me?"<<flush;
getch();
cout<<"\n\n"<<yourname<<": Of course! This is what I've been waiting for..."<<flush;
getch();
cout<<"\n\nDark Lord: Well then prepare to die!"<<flush;
use5 = 5;
getch();
Battle();}



cout<<endl;
system("CLS");



if (enemyhealth<1)
{enemyhealth = 0;}
if (yourhealth<1)
{yourhealth = 0;}

	
	{SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_INTENSITY);
	cout<<yourname<<"\t\t\t\t\t\t\t\t  "<<enemyname<<flush;}




cout<<flush;


cout<<endl;


	if (yourhealth>=80)
		
		{
			cout<<flush;
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);
		cout<<"Health: "<<yourhealth<<"%\t\t\t\t\t\t\t  "<<flush;
		}
		if ((yourhealth<80) && (yourhealth>=50))
		{
			cout<<flush;
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_RED | FOREGROUND_INTENSITY);
		cout<<"Health: "<<yourhealth<<"%\t\t\t\t\t\t\t  "<<flush;
		}
		if (yourhealth<50)
		{{cout<<flush<<flush;
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_RED | FOREGROUND_INTENSITY);
	
		cout<<"Health: "<<yourhealth<<"%\t\t\t\t\t\t\t  "<<flush;

	
		}}














			
if ((enemyhealth>=80))
{{
	cout<<flush;
	cout<<flush;

	SetConsoleTextAttribute(stdOut, FOREGROUND_GREEN | FOREGROUND_INTENSITY);
	
	
	
	cout<<"Health: "<<enemyhealth<<"%"<<flush;
}}
if ((enemyhealth<80) && (enemyhealth>=50))
{
	cout<<flush;
	
SetConsoleTextAttribute(stdOut, FOREGROUND_GREEN | FOREGROUND_RED | FOREGROUND_INTENSITY);
cout<<"Health: "<<enemyhealth<<"%"<<flush;
}
if (enemyhealth<50)
{
	cout<<flush;

	SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_INTENSITY);
cout<<"Health: "<<enemyhealth<<"%"<<flush;
}


	
	







		cout<<endl;
		SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY);
		if (enemyhealth<1)
		{KilledEnemy();}

	if (enemyattack == 5)
{
	if (Totalenemyaccuracy>enemyaccuracy)
{cout<<"\n\n"<<enemyname<<" missed!";
	enemyattack = 1;
		cout<<endl;
		getch();
	Battle();}
if (Totalenemyaccuracy<enemyaccuracy)
{	cout<<"\n\n"<<enemyname<<" attacked you. You lost "<<enemystrength<<" health points.";
yourhealth= (yourhealth - enemystrength);
cout<<endl;
getch();
enemyattack= 1;
Battle();}

}		

if (yourhealth<1)
{cout<<"\n\nYou have died in the battle with "<<enemyname<<flush;
getch();
YouDied();
}

		
		if (enemyattack <5)
{
		cout<<"\n\n(a) - Attack";
		cout<<"\n(h) - Use a health potion";
		cout<<"\n(w) - Use a weapon potion";
		cout<<"\n(r) - Run away\n";
		cin>>x;
		
		switch (x)
		{
		case 'w':
			{UseWeaponPotion();}

		case 'h':
			{UseHealthPotion();}

		case 'a':
			{
			

		
	
		
		
		
		
			cout<<"\n\nAttack with what?"
				<<endl<<endl;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);
			cout<<"(h) - Your hand"
			<<endl;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
				if (crossbow == 5)
				{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
				cout<<"(c) - Crossbow"
				<<endl;
						SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
					if (axe == 5)
					{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
				cout<<"(a) - Axe"
					<<endl;
						SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
				if (bronzesword == 5)
					{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
				cout<<"(b) - Bronze sword"
					<<endl;
						SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
				if (silversword == 5)
					{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
				cout<<"(s) - Silver sword"
					<<endl;
						SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
				if (goldsword == 5)
					{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
				cout<<"(g) - Gold sword"
					<<endl;
						SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
				if (platinumsword == 5)
					{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
				cout<<"(p) - Platinum sword"
					<<endl;
						SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
				if (flamethrower == 5)
					{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
				cout<<"(f) - Flamethrower"
					<<endl;
						SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_RED);
				if (rocketlauncher == 5)
					{	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), FOREGROUND_GREEN | FOREGROUND_INTENSITY);}
				cout<<"(r) - Rocket launcher"
					<<endl;
				 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY);
			cin>>y;
			if ((y == 'h') && (youaccuracy>=75))

			{cout<<"You missed";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemybattle = 5;
			Battle();}

			if ((y == 'h') && (youaccuracy<75))

			{youstrength = (rand() % 15) + 1;
			cout<<"You smacked him! "<<enemyname<<" lost "<<youstrength<<" health points.";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemyhealth = (enemyhealth - youstrength);
			enemybattle = 5;
			Battle();}

			if ((y == 'c') && (youaccuracy<=65) && (crossbow == 5))

			{youstrength = (rand() % 11) + 10;
			cout<<"You hit him! "<<enemyname<<" lost "<<youstrength<<" health points.";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemyhealth = (enemyhealth - youstrength);
			enemybattle = 5;
			Battle();}

			if ((y == 'c') && (youaccuracy>65) && (crossbow == 5))

			{cout<<"You missed";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemybattle = 5;
			Battle ();}


if ((y == 'a') && (youaccuracy<=75) && (axe == 5))

			{youstrength = (rand() % 11) + 20;
			cout<<"You slashed him! "<<enemyname<<" lost "<<youstrength<<" health points.";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemyhealth = (enemyhealth - youstrength);
			enemybattle = 5;
			Battle();}

			if ((y == 'a') && (youaccuracy>75) && (axe == 5))

			{cout<<"You missed";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemybattle = 5;
			Battle();}

			if ((y == 'b') && (youaccuracy<=90) && (bronzesword == 5))

			{youstrength = (rand() % 31) + 10;
			cout<<"You struck him! "<<enemyname<<" lost "<<youstrength<<" health points.";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemyhealth = (enemyhealth - youstrength);
			enemybattle = 5;
			Battle();}

			if ((y == 'b') && (youaccuracy>90) && (bronzesword == 5))

			{cout<<"You missed";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemybattle = 5;
			Battle();}

					if ((y == 's') && (youaccuracy<=90) && (silversword == 5))

			{youstrength = (rand() % 21) + 20;
			cout<<"You struck him! "<<enemyname<<" lost "<<youstrength<<" health points.";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemyhealth = (enemyhealth - youstrength);
			enemybattle = 5;
			Battle();}

			if ((y == 's') && (youaccuracy>90) && (silversword == 5))

			{cout<<"You missed";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemybattle = 5;
			Battle();}

						if ((y == 'g') && (youaccuracy<=90) && (goldsword == 5))

			{youstrength = (rand() % 11) + 30;
			cout<<"You struck him! "<<enemyname<<" lost "<<youstrength<<" health points.";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemyhealth = (enemyhealth - youstrength);
			enemybattle = 5;
			Battle();}

			if ((y == 'g') && (youaccuracy>90) && (goldsword == 5))

			{cout<<"You missed";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemybattle = 5;
			Battle();}

							if ((y == 'p') && (youaccuracy<=90) && (platinumsword == 5))

			{youstrength = (rand() % 11) + 40;
			cout<<"You struck him! "<<enemyname<<" lost "<<youstrength<<" health points.";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemyhealth = (enemyhealth - youstrength);
			enemybattle = 5;
			Battle();}

			if ((y == 'p') && (youaccuracy>90) && (platinumsword == 5))

			{cout<<"You missed";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemybattle = 5;
			Battle();}

								if ((y == 'f') && (youaccuracy<=60) && (flamethrower == 5))

			{youstrength = (rand() % 41) + 50;
			cout<<"You burned him! "<<enemyname<<" lost "<<youstrength<<" health points.";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemyhealth = (enemyhealth - youstrength);
			enemybattle = 5;
			Battle();}

			if ((y == 'f') && (youaccuracy>60) && (flamethrower == 5))

			{cout<<"You missed";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemybattle = 5;
			Battle();}

								if ((y == 'r') && (youaccuracy<=65) && (rocketlauncher == 5))

			{youstrength = (rand() % 11) + 90;
			cout<<"You exploded him! "<<enemyname<<" lost "<<youstrength<<" health points.";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemyhealth = (enemyhealth - youstrength);
			enemybattle = 5;
			Battle();}

			if ((y == 'r') && (youaccuracy>65) && (rocketlauncher == 5))

			{cout<<"You missed";
			cout<<endl;
			getch();
			enemyattack = 5;
			enemybattle = 5;
			Battle();}

			else if ((crossbow <4) || (axe<4) || (bronzesword<4) || (silversword<4) || (goldsword<4) || (platinumsword<4) || (flamethrower<4) || (rocketlauncher<4))
{cout<<"\nYou do not have that weapon!";
cout<<endl;
enemybattle = 5;
getch();
Battle();}




		



	case 'r':
		{MainMenu();}
	default:
		{cout<<"\nPlease choose a correct option";
		cout<<endl;
		enemybattle = 5;
		getch ();
		Battle();}

	
}
	}	
	
}}


	
void EnterName(void)
{

     system("CLS");

	cout<<"Enter your name: ";
	cin>>yourname;
	EnterDifficulty();
}
void EnterDifficulty (void)
{
	cout<<"\n\nEnter the difficulty:";
	cout<<"\n\n(1) - Easy\n\n(2) - Hard\n\n";
		cin>>x;
	if (x == '1')
	{easy = 5;
	MainMenu();}
if (x == '2')
	{hard = 5;
	MainMenu();}
else
	{cout<<"\nPlease choose a correct option"<<flush;
	getch();
	EnterDifficulty();
	}
	
	MainMenu();

}
void repeat (void)
{
	cout<<endl;
	system("CLS");
     SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
 
           cout<<"\t\t\t\t| "<<flush;
		   SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY);
		   cout<<"X"<<flush;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
			   cout<<"treme "<<flush;
SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY);
			   cout<<"F"<<flush;
				   SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
				cout<<"ight |";
		   cout<<"\n\t\t\t\t________________";
		   cout<<"\n\t\t\t\t        |";
		   cout<<"\n\_______________________________________/ \\______________________________________";
		   
  
           cout<<endl<<endl<<endl;
			   
		  

          SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY);
		  
		  cout<<"(s) - Start game"
		  
           <<endl<<endl
           <<"(e) - Exit"
           <<endl<<endl;
          cin>>x;

           if (x == 's')
		   {
			   ETdamage = (rand()%171) + 30;
                 MainMenu();
           }

if (x == 'e')
{cout<<endl;
exit(0);}
}
int main()
{
	if (kills<=5)
	{strcpy(yourrank, "Child"); }
		if ((kills>5) && (kills<=15))
		{strcpy(yourrank, "Squire"); }
		if ((kills>15) && (kills<=30))
		{strcpy(yourrank, "Knight"); }
		if ((kills>30) && (kills<=50))
		{strcpy(yourrank, "Warrior"); }
		if ((kills>50) && (kills<=70))
		{strcpy(yourrank, "Master"); }
		if (kills>70)
		{strcpy(yourrank, "Lord"); }

	SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_BLUE | FOREGROUND_INTENSITY | BACKGROUND_RED | BACKGROUND_GREEN | BACKGROUND_INTENSITY);
cout<<"So you have to kill off evil aliens who are taking over the world yada yada yada...\n\n";

cout<<"Actually, it all started when you woke up this morning...You turned on your\ncomputer, downloaded this strange game that had a crappy name, and now here you are playing it. You have entered another world, a world where you 'simply striveto survive while battling bad guys and collecting coins' ..say that five times\nfast. NOW.\n\n";

cout<<"You don't realize yet, but I am actually taking over your mind...You relize thisgame has colored backgrounds and you think that is tight. You think this intro  is kick-ass and you wan't to play more. No, you wan't to play so badly your\nveins are popping out of your skin and you can't stop this uncontrollable\nfeeling you have of wanting to stop reading this and start playing. So go young jedi and defeat the evil badguys to win your victory!\n\n";

cout<<"You have entered the world of...\n\n"<<flush;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY| BACKGROUND_RED | BACKGROUND_GREEN | BACKGROUND_INTENSITY);
cout<<"****Xtreme Fight****\n";
cout<<endl;
SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_BLUE | FOREGROUND_INTENSITY |BACKGROUND_RED | BACKGROUND_GREEN | BACKGROUND_INTENSITY);
cout<<"Press anything to play!";
cout<<"\n\nNote: Best viewed in full screen\n\n                                                                               "<<flush;

getch();
cout<<endl;
system("CLS");
     SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
 
           cout<<"\t\t\t\t| "<<flush;
		   SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY);
		   cout<<"X"<<flush;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
			   cout<<"treme "<<flush;
SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY);
			   cout<<"F"<<flush;
				   SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
				cout<<"ight |";
		   cout<<"\n\t\t\t\t________________";
		   cout<<"\n\t\t\t\t        |\t\t\t\t   v0.8";
		   cout<<"\n\_______________________________________/ \\______________________________________";
		   
			
  
           cout<<endl<<endl<<endl;
			   
		  
		   

          SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE | FOREGROUND_INTENSITY);
		  
		  cout<<"(s) - Start game"
		  
           <<endl<<endl
           <<"(e) - Exit"
           <<endl<<endl;
          cin>>x;

           if (x == 's')
		   {srand ( time(NULL) ); //has its goods and bads
			   ETdamage = (rand()%171) + 30;
                 EnterName ();
           }

if (x == 'e')
{cout<<endl;}
           return 0;
} 


//THE END!

//I hope you liked it!

//sorry for the lack of comments and organization!


