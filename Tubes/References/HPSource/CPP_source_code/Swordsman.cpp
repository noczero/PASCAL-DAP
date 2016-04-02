/******************************************************************************\
               This game is created by : Joshua Wohle
               after only one week of c++ experience.

               Welcome to Swordsman, the commentated version.
               This is the second version of my newly created
               action game. I fixed some bugs, added comments
               and it has almost 2000 lines of code. Please
               just take the time to rate this game, because
               it has taken me a lot of time creating it as well.

               If you encounter any bugs, or have some sugestions.
               Please contect me at:

               JoshuaWohle1987@hotmail.com

               Hope you have fun!
/******************************************************************************/

#include <iostream.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <conio.h>
#include <iomanip.h>
#include <windows.h>
#include <time.h>


void Menu();                      //declaring my fuctions, variables, integers etc.
void InstructionsManuel();
void YouWinTheGame();
void YouWin();
void YouWinTR();
void YouWinTo();
void YouLose();
void Battle();
void BattleTR();
void TournamentBattle();
void SingleMatch();
void Tournament();
void BuyEquipement();
void ExitChoice();
void Attack();
void AttackTR();
void Potion();
void GiveUp();
void Damage();
void DamageTR();
void DamageEN();
void DamageENTR();
void Weapons();
void Armors();
void Potions();
void Boss1();
void Boss2();
void Boss3();
void Boss4();
void Boss5();
void Boss6();
void Boss7();
char UserName[20];
char EnemyName[20];
int Boss = 0;
int weapon;
int TrainingKills;
int MaxHealth = 100;
int SmallPotion = 2;
int MediumPotion = 1;
int BigPotion = 1;
int MaxPotion = 1;
int SmallMaxHealthPotion = 0;
int MediumMaxHealthPotion = 0;
int BigMaxHealthPotion = 0;
int WoodenStick = 1;
int WoodenSword = 0;
int IronSword = 0;
int SilverSword = 0;
int GoldenSword = 0;
int PlatinumSword = 0;
int Excalibur = 0;
int WoodenArmor = 0;
int IronArmor = 0;
int SilverArmor = 0;
int GoldenArmor = 0;
int PlatinumArmor = 0;
int KristalArmor = 0;
int UserHealth = 100;
int MenuChoice;
int response;
int experience = 0;
int EnemyHealth = 100;
int money = 0;
int DamagePoints;
int gain = 100;
int TR = 0;
int y;
int x;

HANDLE stdOut = GetStdHandle(STD_OUTPUT_HANDLE);    //Has something to do with colors


void Menu()                                          //The main menu function
{
    system("CLS");
    SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_INTENSITY); //Setting color
    cout<<"What do you want to do "<<UserName<<"?\n\n";
    cout<<"(1) Training\n";
    cout<<"(2) Single match\n";
    cout<<"(3) Tournament\n";
    cout<<"(4) Shop\n";
    cout<<"(5) Read the instructions manuel\n";
    cout<<"Or enter (6) to exit the game\n\n";
    cin>>MenuChoice;

    switch (MenuChoice)
    {
     case 1 :   strcpy(EnemyName, "Harold");
                BattleTR();
                break;
     case 2 : SingleMatch();
                break;
     case 3 : Tournament();
                break;
     case 4 : BuyEquipement();
                break;
     case 5 : InstructionsManuel();
              break;
     case 6 : ExitChoice();
                break;
     default : cout<<"Error, bad innput, press any key to continue.";
               getch();
               Menu();
               break;
    }
};

void InstructionsManuel()      //Instructions Manuel
{
 system("CLS");
 SetConsoleTextAttribute(stdOut, FOREGROUND_GREEN | FOREGROUND_GREEN | FOREGROUND_INTENSITY);
 cout<<"Welcome to the Instructions Manuel, here you'lle find\n";
 cout<<"all the basic rules of the game.\n\n";

 cout<<"1. Every 5 victorys in Single Match mode you get a Boss,\n";
 cout<<"wich is much stronger than the other opponnents.\n\n";

 cout<<"2. In Tournament Mode you get to play 7 matches,\n";
 cout<<"for the first two matches you get 100,- each,\n";
 cout<<"for matches 4 to 6 you get 200,- each,\n";
 cout<<"and for the last match you get 500,-!!!.\n\n";

 cout<<"3. You only begin with a few potions, so be carefull with them.\n";
 cout<<"If you want to buy some more Potions, go to the shop.\n\n";

 cout<<"Press any key to return to the Main Menu.\n";
 getch();
 Menu();
};

void ExitChoice()                //Used for checking if you realy want to exit the game
{
 system("CLS");
 cout<<"You really want to exit the game? (1) yes / (2) no\n";
 cin>>response;
 if (response == 1)
 {
  exit(0);
 }
 else if (response == 2)
 {
  system("CLS");
  Menu();
 }
 else
 {
  cout<<"Error, enter 1 or 2\n";
  ExitChoice();
 }
};

void BattleTR()                    //Batlle function in Training mode
{
 system("CLS");
 strcpy(EnemyName, "Harold");
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_INTENSITY);
 cout<<UserName<<"\t\t\t\t\t\t\t\t "<<EnemyName<<endl;
 cout<<"Health "<<UserHealth<<"%\t\t\t\t\t\t\t "<<"Health "<<EnemyHealth<<"%"<<"\n\n";

 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_BLUE | FOREGROUND_INTENSITY);
 cout<<"(1) Attack\n";
 cout<<"(2) Use potion\n";
 cout<<"(3) Give up\n";
 cin>>y;
 cout<<"\n\n";

 switch (y)
 {
  case 1 : AttackTR();
             break;
  case 2 : Potion();
             break;
  case 3 : GiveUp();
             break;
  default  : cout<<"Error, bad input, press any key to continue.\n";
             getch();
             system("CLS");
             BattleTR();
             break;
 }
};

void Battle()                       //Battle function for all the other modes
{
 system("CLS");;
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_INTENSITY);
 cout<<UserName<<"\t\t\t\t\t\t\t\t "<<EnemyName<<endl;
 cout<<"Health "<<UserHealth<<"%\t\t\t\t\t\t\t "<<"Health "<<EnemyHealth<<"%"<<"\n\n";

 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_BLUE | FOREGROUND_INTENSITY);
 cout<<"(1) Attack\n";
 cout<<"(2) Use potion\n";
 cout<<"(3) Give up\n";
 cin>>y;
 cout<<"\n\n";

 switch (y)
 {
  case 1 : Attack();
             break;
  case 2 : Potion();
             break;
  case 3 : GiveUp();
             break;
  default  : cout<<"Error, bad input, press any key to continue.\n";
             getch();
             system("CLS");
             Battle();
             break;
 }
};

void SingleMatch()                          //Single match mode
{
 system("CLS");
 srand((unsigned)time(NULL));               //random number
 x = rand() % 15;
 if (x == 0)
 {
 strcpy(EnemyName, "Claude");               //declaring random names
 }
 else if (x == 1)
 {
 strcpy(EnemyName, "Luca");
 }
 else if(x == 2)
 {
 strcpy(EnemyName, "Ludovic");
 }
 else if(x == 3)
 {
 strcpy(EnemyName, "Tristan");
 }
 else if(x == 4)
 {
 strcpy(EnemyName, "Joshua");
 }
 else if(x == 5)
 {
 strcpy(EnemyName, "Christiaan");
 }
 else if(x == 6)
 {
 strcpy(EnemyName, "Florian");
 }
 else if(x == 7)
 {
 strcpy(EnemyName, "Duke");
 }
 else if(x == 8)
 {
 strcpy(EnemyName, "Maria");
 }
 else if(x == 9)
 {
 strcpy(EnemyName, "Andreas");
 }
 else if(x == 10)
 {
 strcpy(EnemyName, "Jona");
 }
 else if(x == 11)
 {
 strcpy(EnemyName, "Piccard");
 }
 else if(x == 12)
 {
 strcpy(EnemyName, "Stefan");
 }
 else if(x == 13)
 {
 strcpy(EnemyName, "Jeremie");
 }
 else if(x == 14)
 {
 strcpy(EnemyName, "Nathalie");
 }
 else if(x == 15)
 {
 strcpy(EnemyName, "Paul");
 }
 Battle();
};

void Tournament()                         //tournament mode
{
 system("CLS");
 TR = TR + 1;
 srand((unsigned)time(NULL));            //random number
 x = rand() % 15;
 if (x == 0)
 {
 strcpy(EnemyName, "Claude");            //declaring random names
 }
 else if (x == 1)
 {
 strcpy(EnemyName, "Luca");
 }
 else if(x == 2)
 {
 strcpy(EnemyName, "Ludovic");
 }
 else if(x == 3)
 {
 strcpy(EnemyName, "Tristan");
 }
 else if(x == 4)
 {
 strcpy(EnemyName, "Joshua");
 }
 else if(x == 5)
 {
 strcpy(EnemyName, "Christiaan");
 }
 else if(x == 6)
 {
 strcpy(EnemyName, "Florian");
 }
 else if(x == 7)
 {
 strcpy(EnemyName, "Duke");
 }
 else if(x == 8)
 {
 strcpy(EnemyName, "Maria");
 }
 else if(x == 9)
 {
 strcpy(EnemyName, "Andreas");
 }
 else if(x == 10)
 {
 strcpy(EnemyName, "Jona");
 }
 else if(x == 11)
 {
 strcpy(EnemyName, "Piccard");
 }
 else if(x == 12)
 {
 strcpy(EnemyName, "Stefan");
 }
 else if(x == 13)
 {
 strcpy(EnemyName, "Jeremie");
 }
 else if(x == 14)
 {
 strcpy(EnemyName, "Nathalie");
 }
 else if(x == 15)
 {
 strcpy(EnemyName, "Paul");
 }
 Battle();
};

void BuyEquipement()                 //Shop mode
{
 system("CLS");
 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"Welcome to The Shop, here you'lle find everything you need.\n";
 cout<<"We are the best, cheapest and only shop in the neighborhood,\n";
 cout<<"so buy as much as you can!\n\n";

 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"What do you want to buy?\n\n";

 cout<<"1. Weapons\n";
 cout<<"2. Armor\n";
 cout<<"3. Potions\n";
 cout<<"4. Return to main menu\n";
 cin>>x;

 switch (x)
 {
  case 1 : Weapons();
           break;
  case 2 : Armors();
           break;
  case 3 : Potions();
           break;
  case 4 : Menu();
           break;
  default : cout<<"Error, please enter correct number.\n";
            BuyEquipement();
            break;
 }

};

void GiveUp()                           //battle function 3, give up and return to main menu
{
 system("CLS");
 experience = experience - 1;
 Menu();
};

void Weapons()                         //My weapon shop
{
 system("CLS");
 cout<<"Wich Weapon(s) do you want to buy?\n\n";
 cout<<"Your money = "<<money<<"\n\n";
 cout<<"NAME\t\t\tDAMAGE\t\t\tCOST\n";
 cout<<"1. Wooden Sword\t\t10-20\t\t\t250\n";
 cout<<"2. Iron Sword\t\t20-30\t\t\t350\n";
 cout<<"3. Silver Sword\t\t30-40\t\t\t500\n";
 cout<<"4. Golden Sword\t\t40-50\t\t\t750\n";
 cout<<"5. Platinum Sword\t50-60\t\t\t1000\n";
 cout<<"6. Excalibur\t\t70-100\t\t\t1500\n";
 cout<<"7. Return to buy menu\n";
 cout<<"8. Return to main menu\n\n";
 cout<<"What do you want to do?\n";
 cin>>x;

 switch (x)
 {
  case 1 : if (money >= 250)
           {
            cout<<"Fine Choice\n";
            money = money - 250;
            WoodenSword = 1;
            cout<<"Press any key to continue.\n";
            getch();
            Weapons();
           }
           else
           {
            cout<<"You don't have enough money\n";
            cout<<"Press any key to continue.\n";
            getch();
            Weapons();
           };
           break;
  case 2 : if (money >= 350)
           {
            cout<<"Fine Choice\n";
            money = money - 350;
            IronSword = 1;
            cout<<"Press any key to continue.\n";
            getch();
            Weapons();
           }
           else
           {
            cout<<"You don't have enough money\n";
            cout<<"Press any key to continue.\n";
            getch();
            Weapons();
           };
           break;
  case 3 : if (money >= 500)
           {
            cout<<"Fine Choice\n";
            money = money - 500;
            SilverSword = 1;
            cout<<"Press any key to continue.\n";
            getch();
            Weapons();
           }
           else
           {
            cout<<"You don't have enough money\n";
            cout<<"Press any key to continue.\n";
            getch();
            Weapons();
           };
           break;
  case 4 : if (money >= 750)
           {
            cout<<"Fine Choice\n";
            money = money - 750;
            GoldenSword = 1;
            cout<<"Press any key to continue.\n";
            getch();
            Weapons();
           }
           else
           {
            cout<<"You don't have enough money\n";
            cout<<"Press any key to continue.\n";
            getch();
            Weapons();
           };
           break;
  case 5 : if (money >= 1000)
           {
            cout<<"Fine Choice\n";
            money = money - 1000;
            PlatinumSword = 1;
            cout<<"Press any key to continue.\n";
            getch();
            Weapons();
           }
           else
           {
            cout<<"You don't have enough money\n";
            cout<<"Press any key to continue.\n";
            getch();
            Weapons();
           };
           break;
  case 6 : if (money >= 1500)
           {
            cout<<"Fine Choice\n";
            money = money - 1500;
            Excalibur = 1;
            cout<<"Press any key to continue.\n";
            getch();
            Weapons();
           }
           else
           {
            cout<<"You don't have enough money\n";
            cout<<"Press any key to continue.\n";
            getch();
            Weapons();
           };
           break;
  case 7 : BuyEquipement();
           break;
  case 8 : Menu();
           break;
  default : cout<<"Error, enter a number from 1 to 6, press any key to continue.\n";
            getch();
            Weapons();
            break;
 }
};

void Armors()                           //My armor shop
{
 system("CLS");
 cout<<"Wich Armor(s) do you want to buy?\n\n";
 cout<<"Your money = "<<money<<"\n\n";
 cout<<"NAME\t\t\tDAMAGE RES.\t\t\tCOST\n";
 cout<<"1. Woode Armor\t\t0-5\t\t\t250\n";
 cout<<"2. Iron Armor\t\t5-10\t\t\t350\n";
 cout<<"3. Silver Armor\t\t10-15\t\t\t500\n";
 cout<<"4. Golden Armor\t\t15-20\t\t\t750\n";
 cout<<"5. Platinum Armor\t20-25\t\t\t1000\n";
 cout<<"6. Kristal Armor\t25-35\t\t\t1500\n";
 cout<<"7. Return to buy menu\n";
 cout<<"8. Return to main menu\n\n";
 cout<<"What do you want to do?\n";
 cin>>x;

 switch (x )
 {
  case 1 : if (money >= 250)
           {
            cout<<"Fine Choice.\n";
            money = money - 250;
            WoodenArmor = 1;
            cout<<"Press any key to continue.\n";
            getch();
            Armors();
           }
          else
              {
               cout<<"You don't have enough money!!!\n";
               cout<<"Press any key to continue.\n";
               getch();
               Armors();
              };
          break;
  case 2 : if (money >= 350)
           {
            cout<<"Fine Choice.\n";
            money = money - 350;
            IronArmor = 1;
            cout<<"Press any key to continue.\n";
            getch();
            Armors();
           }
          else
              {
               cout<<"You don't have enough money!!!\n";
               cout<<"Press any key to continue.\n";
               getch();
               Armors();
              };
          break;
  case 3 : if (money >= 500)
           {
            cout<<"Fine Choice.\n";
            money = money - 500;
            SilverArmor = 1;
            cout<<"Press any key to continue.\n";
            getch();
            Armors();
           }
          else
              {
               cout<<"You don't have enough money!!!\n";
               cout<<"Press any key to continue.\n";
               getch();
               Armors();
              };
          break;
  case 4 : if (money >= 750)
           {
            cout<<"Fine Choice.\n";
            money = money - 750;
            GoldenArmor = 1;
            cout<<"Press any key to continue.\n";
            getch();
            Armors();
           }
          else
              {
               cout<<"You don't have enough money!!!\n";
               cout<<"Press any key to continue.\n";
               getch();
               Armors();
              };
          break;
  case 5 : if (money >= 1000)
           {
            cout<<"Fine Choice.\n";
            money = money - 1000;
            PlatinumArmor = 1;
            cout<<"Press any key to continue.\n";
            getch();
            Armors();
           }
          else
              {
               cout<<"You don't have enough money!!!\n";
               cout<<"Press any key to continue.\n";
               getch();
               Armors();
              };
          break;
  case 6 : if (money >= 1500)
           {
            cout<<"Fine Choice.\n";
            money = money - 1500;
            KristalArmor = 1;
            cout<<"Press any key to continue.\n";
            getch();
            Armors();
           }
          else
              {
               cout<<"You don't have enough money!!!\n";
               cout<<"Press any key to continue.\n";
               getch();
               Armors();
              };
          break;
  case 7 : BuyEquipement();
          break;
  case 8 : Menu();
           break;
  default : cout<<"Error, enter a number from 1 to 6, press any key to continue.\n";
            getch();
            Weapons();
            break;
 }
};

void Potions()                          //and my potions shop
{
 system("CLS");
 cout<<"Wich Potion(s) do you want to buy?\n\n";
 cout<<"Your money = "<<money<<"\n\n";
 cout<<"NAME\t\t\tEFFECT\t\t\tCOST\n";
 cout<<"1. Small Potion\t\t+25HP\t\t\t50\n";
 cout<<"2. Medium Potion\t+50HP\t\t\t75\n";
 cout<<"3. Big Potion\t\t+100HP\t\t\t125\n";
 cout<<"4. Max Helath Potion\tMax Health\t\t150\n\n";
 cout<<"5. Small Max Potion\tMax Health +25\t\t200\n";
 cout<<"6. Medium Max Potion\tMax Health +50\t\t300\n";
 cout<<"7. Big Max Potion\tMax Health +100\t\t500\n";
 cout<<"8. Return to buy menu\n";
 cout<<"9. Return to main menu\n\n";
 cout<<"What do you want to do?\n";
 cin>>x;

 switch (x)
 {
  case 1 : if (money >= 50)
           {
           cout<<"Fine Choice\n";
           SmallPotion = SmallPotion + 1;
           money = money - 50;
           cout<<"Press any key to continue.\n";
           getch();
           Potions();
           }
           else
           {
            cout<<"You don't have enough money yet!!!";
            cout<<"Press any key to continue.\n";
            getch();
            Potions();
           }
           break;
  case 2 : if (money >= 75)
           {
           cout<<"Fine Choice\n";
           MediumPotion = MediumPotion + 1;
           money = money - 75;
           cout<<"Press any key to continue.\n";
           getch();
           Potions();
           }
           else
           {
            cout<<"You don't have enough money yet!!!";
            cout<<"Press any key to continue.\n";
            getch();
            Potions();
           }
           break;
  case 3 : if (money >= 125)
           {
           cout<<"Fine Choice\n";
           BigPotion = BigPotion + 1;
           money = money - 125;
           cout<<"Press any key to continue.\n";
           getch();
           Potions();
           }
           else
           {
            cout<<"You don't have enough money yet!!!";
            cout<<"Press any key to continue.\n";
            getch();
            Potions();
           }
           break;
  case 4 : if (money >= 150)
           {
           cout<<"Fine Choice\n";
           MaxPotion = MaxPotion + 1;
           money = money - 150;
           cout<<"Press any key to continue.\n";
           getch();
           Potions();
           }
           else
           {
            cout<<"You don't have enough money yet!!!";
            cout<<"Press any key to continue.\n";
            getch();
            Potions();
           }
           break;
  case 5 : if (money >= 200)
           {
           cout<<"Fine Choice\n";
           SmallMaxHealthPotion = SmallMaxHealthPotion + 1;
           money = money - 200;
           cout<<"Press any key to continue.\n";
           getch();
           Potions();
           }
           else
           {
            cout<<"You don't have enough money yet!!!";
            cout<<"Press any key to continue.\n";
            getch();
            Potions();
           }
           break;
  case 6 : if (money >= 300)
           {
           cout<<"Fine Choice\n";
           MediumMaxHealthPotion = MediumMaxHealthPotion + 1;
           money = money - 300;
           cout<<"Press any key to continue.\n";
           getch();
           Potions();
           }
           else
           {
            cout<<"You don't have enough money yet!!!";
            cout<<"Press any key to continue.\n";
            getch();
            Potions();
           }
           break;
  case 7 : if (money >= 500)
           {
           cout<<"Fine Choice\n";
           BigMaxHealthPotion = BigMaxHealthPotion + 1;
           money = money - 500;
           cout<<"Press any key to continue.\n";
           getch();
           Potions();
           }
           else
           {
            cout<<"You don't have enough money yet!!!";
            cout<<"Press any key to continue.\n";
            getch();
            Potions();
           }
           break;
  case 8 : BuyEquipement();
           break;
  case 9 : Menu();
           break;
  default : cout<<"Error, number from 1 to 7, press any key to continue.";
            getch();
            Potions();
  }
};

void AttackTR()                                //option Attack in Training mode
{
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"Wich weapon do you want to use?\n";
 cout<<"1. Wooden  Stick\n";
 cout<<"2. Wooden Sword\n";
 cout<<"3. Iron Sword\n";
 cout<<"4. Silver Sword\n";
 cout<<"5. Golden Sword\n";
 cout<<"6. PLatinum Sword\n";
 cout<<"7. Excalibur\n";
 cin>>y;

switch (y)
 {
  case 1 : weapon = 1;
           break;
  case 2 : if (WoodenSword == 1)                       //checking if you have  the sword
              {
               weapon = 2;
              }
           else
            {
             cout<<"You don't have this weapon yet!!!\n\n";
             cout<<"Press any key to continue.\n";
             getch();
             system("CLS");
             BattleTR();
            };
          break;
  case 3 : if (IronSword == 1)
              {
               weapon = 3;
              }
           else
            {
             cout<<"You don't have this weapon yet!!!\n\n";
             cout<<"Press any key to continue.\n";
             getch();
             system("CLS");
             BattleTR();
            };
          break;
  case 4 : if (SilverSword == 1)
              {
               weapon = 4;
              }
           else
            {
             cout<<"You don't have this weapon yet!!!\n\n";
             cout<<"Press any key to continue.\n";
             getch();
             system("CLS");
             BattleTR();
            };
          break;
  case 5 : if (GoldenSword == 1)
              {
               weapon = 5;
              }
           else
            {
             cout<<"You don't have this weapon yet!!!\n\n";
             cout<<"Press any key to continue.\n";
             getch();
             system("CLS");
             BattleTR();
            };
          break;
  case 6 : if (PlatinumSword == 1)
              {
               weapon = 6;
              }
           else
            {
             cout<<"You don't have this weapon yet!!!\n\n";
             cout<<"Press any key to continue.\n";
             getch();
             system("CLS");
             BattleTR();
            };
          break;
  case 7 : if (Excalibur == 1)
              {
               weapon = 7;
              }
           else
            {
             cout<<"You don't have this weapon yet!!!\n\n";
             cout<<"Press any key to continue.\n";
             getch();
             system("CLS");
             BattleTR();
            };
          break;
 default : cout<<"Bad input, press enter and try again.";
            getch();
            AttackTR();
            break;
 }
 srand ((unsigned)time(NULL));
 x = rand() % 10;
 if (x == 3)
 {
  cout<<"You missed! press any key to continue\n";
  getch();
  DamageENTR();
 }
 DamageTR();
};

void Attack()                      //Option attck in all the other modes
{
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"Wich weapon do you want to use?\n";
 cout<<"1. Wooden  Stick\n";
 cout<<"2. Wooden Sword\n";
 cout<<"3. Iron Sword\n";
 cout<<"4. Silver Sword\n";
 cout<<"5. Golden Sword\n";
 cout<<"6. PLatinum Sword\n";
 cout<<"7. Excalibur\n";
 cin>>y;

switch (y)
 {
  case 1 : weapon = 1;
           break;
  case 2 : if (WoodenSword == 1)
              {
               weapon = 2;
              }
           else
            {
             cout<<"You don't have this weapon yet!!!\n\n";
             cout<<"Press any key to continue.\n";
             getch();
             system("CLS");
             Battle();
            };
          break;
  case 3 : if (IronSword == 1)
              {
               weapon = 3;
              }
           else
            {
             cout<<"You don't have this weapon yet!!!\n\n";
             cout<<"Press any key to continue.\n";
             getch();
             system("CLS");
             Battle();
            };
          break;
  case 4 : if (SilverSword == 1)
              {
               weapon = 4;
              }
           else
            {
             cout<<"You don't have this weapon yet!!!\n\n";
             cout<<"Press any key to continue.\n";
             getch();
             system("CLS");
             Battle();
            };
          break;
  case 5 : if (GoldenSword == 1)
              {
               weapon = 5;
              }
           else
            {
             cout<<"You don't have this weapon yet!!!\n\n";
             cout<<"Press any key to continue.\n";
             getch();
             system("CLS");
             Battle();
            };
          break;
  case 6 : if (PlatinumSword == 1)
              {
               weapon = 6;
              }
           else
            {
             cout<<"You don't have this weapon yet!!!\n\n";
             cout<<"Press any key to continue.\n";
             getch();
             system("CLS");
             Battle();
            };
          break;
  case 7 : if (Excalibur == 1)
              {
               weapon = 7;
              }
           else
            {
             cout<<"You don't have this weapon yet!!!\n\n";
             cout<<"Press any key to continue.\n";
             getch();
             system("CLS");
             Battle();
            };
          break;
  default : cout<<"Bad input, press enter and try again.";
            getch();
            Attack();
            break;
 }
 srand ((unsigned)time(NULL));             //random number
 x = rand() % 10;
 if (x == 3)
 {
  cout<<"You missed! press any key to continue.\n";
  getch();
  DamageEN();
 }
 Damage();
};

void Potion()                         //Option :  Use Potion
{
 cout<<"Wich potion do you want to use?\n";
 cout<<"1. Small Potion ("<<SmallPotion<<")\n";
 cout<<"2. Medium Potion ("<<MediumPotion<<")\n";
 cout<<"3. Big Potion ("<<BigPotion<<")\n";
 cout<<"4. Max Health Potion ("<<MaxPotion<<")\n";
 cout<<"5. Small Max Health Potion ("<<SmallMaxHealthPotion<<")\n";
 cout<<"6. Medium Max Health Potion("<<MediumMaxHealthPotion<<")\n";
 cout<<"7. Big Max Health Potion ("<<BigMaxHealthPotion<<")\n";
 cin>>x;
 switch(x)
 {
  case 1 : if (SmallPotion >= 1)
           {
            UserHealth = UserHealth + 25;
                       if (UserHealth > MaxHealth)
                       {
                        UserHealth = MaxHealth;
                       }
            SmallPotion = SmallPotion - 1;
            cout<<"Your health increased by 25%, press any key to continue.";
            getch();
            Battle();
            }
           else
           {
            cout<<"You don't have this potion yet, press any key to continue.";
            getch();
            Battle();
           }
           break;
  case 2 : if (MediumPotion >= 1)
           {
            UserHealth = UserHealth + 50;
                        if (UserHealth > MaxHealth)
                        {
                         UserHealth = MaxHealth;
                        }
            MediumPotion = MediumPotion - 1;
            cout<<"Your health increased by 50%, press any key to continue.";
            getch();
            Battle();
           }
           else
           {
            cout<<"You don't have this potion yet, press any key to continue.";
            getch();
            Battle();
           }
           break;
  case 3 : if (BigPotion >= 1)
           {
            UserHealth = UserHealth + 100;
                       if (UserHealth > MaxHealth)
                        {
                         UserHealth = MaxHealth;
                        }
            BigPotion = BigPotion - 1;
            cout<<"Your health increased by 100%, press any key to continue.";
            getch();
            Battle();
           }
           else
           {
            cout<<"You don't have this potion yet, press any key to continue.";
            getch();
            Battle();
           };
           break;
  case 4 : if (MaxPotion >= 1)
           {
            UserHealth = MaxHealth;
            MaxPotion = MaxPotion - 1;
            cout<<"Your Health is restored, press any key to continue.";
            getch();
            Battle();
           }
           else
           {
            cout<<"You don't have this potion yet, press any key to continue.";
            getch();
            Battle();
           };
           break;
  case 5 : if (SmallMaxHealthPotion >= 1)
           {
            MaxHealth = MaxHealth + 25;
            SmallMaxHealthPotion = SmallMaxHealthPotion - 1;
            cout<<"You maximal health increased by 25%, press any key to continue.";
            getch();
            Battle();
           }
           else
           {
            cout<<"You don't have this potion yet, press any key to continue.";
            getch();
            Battle();
           };
           break;
  case 6 : if (MediumMaxHealthPotion >= 1)
           {
            MaxHealth = MaxHealth + 50;
            MediumMaxHealthPotion = MediumMaxHealthPotion - 1;
            cout<<"You maximal health increased by 50%, press any key to continue.";
            getch();
            Battle();
           }
           else
           {
            cout<<"You don't have this potion yet, press any key to continue.";
            getch();
            Battle();
           };
           break;
  case 7 : if (BigMaxHealthPotion >= 1)
           {
            MaxHealth = MaxHealth + 100;
            BigMaxHealthPotion = BigMaxHealthPotion - 1;
            cout<<"You maximal health increased by 100%, press any key to continue.";
            getch();
            Battle();
           }
           else
           {
            cout<<"You don't have this potion yet, press any key to continue.";
            getch();
            Battle();
           };
           break;
  default : cout<<"Please try again, press any key to continue.\n";
            getch();
            Potion();
            break;
 };
};


void DamageTR()                        //Damage in Training mode
{
 if (weapon == 1)
    {
     srand ((unsigned)time(NULL));
     x = rand() % 10;
     EnemyHealth = EnemyHealth - x;
     DamagePoints = x;
    }
 else if (weapon == 2)
      {
       srand ((unsigned)time(NULL));
       x = rand() % 10;
       EnemyHealth = EnemyHealth - 10;
       EnemyHealth = EnemyHealth - x;
       DamagePoints = 10;
       DamagePoints = DamagePoints + x;
      }
 else if (weapon == 3)
      {
       srand ((unsigned)time(NULL));
       x = rand() % 10;
       EnemyHealth = EnemyHealth - 20;
       EnemyHealth = EnemyHealth - x;
       DamagePoints = 20;
       DamagePoints = DamagePoints + x;
      }
 else if (weapon == 4)
      {
       srand ((unsigned)time(NULL));
       x = rand() % 10;
       EnemyHealth = EnemyHealth - 30;
       EnemyHealth = EnemyHealth - x;
       DamagePoints = 30;
       DamagePoints = DamagePoints + x;
      }
 else if (weapon == 5)
      {
       srand ((unsigned)time(NULL));
       x = rand() % 10;
       EnemyHealth = EnemyHealth - 40;
       EnemyHealth = EnemyHealth - x;
       DamagePoints = 40;
       DamagePoints = DamagePoints + x;
      }
 else if (weapon == 6)
      {
       srand ((unsigned)time(NULL));
       x = rand() % 10;
       EnemyHealth = EnemyHealth - 50;
       EnemyHealth = EnemyHealth - x;
       DamagePoints = 50;
       DamagePoints = DamagePoints + x;
      }
 else if (weapon == 7)
      {
       srand ((unsigned)time(NULL));
       x = rand() % 30;
       EnemyHealth = EnemyHealth - 70;
       EnemyHealth = EnemyHealth - x;
       DamagePoints = 70;
       DamagePoints = DamagePoints + x;
      }
  if (EnemyHealth > 0)
  {
  cout<<"You dealt "<<DamagePoints<<" damage to "<<EnemyName<<"."<<endl;;
  cout<<"Press any key to continue.\n";
  getch();
  DamageENTR();
  }
  else
  {
   YouWinTR();                 //if UserHealth < 0 ....
  }
};

void Damage()                    //damage in all the other modes
{
 if (weapon == 1)
    {
     srand ((unsigned)time(NULL));
     x = rand() % 10;
     EnemyHealth = EnemyHealth - x;
     DamagePoints = x;
    }
 else if (weapon == 2)
      {
       srand ((unsigned)time(NULL));
       x = rand() % 10;
       EnemyHealth = EnemyHealth - 10;
       EnemyHealth = EnemyHealth - x;
       DamagePoints = 10;
       DamagePoints = DamagePoints + x;
      }
 else if (weapon == 3)
      {
       srand ((unsigned)time(NULL));
       x = rand() % 10;
       EnemyHealth = EnemyHealth - 20;
       EnemyHealth = EnemyHealth - x;
       DamagePoints = 20;
       DamagePoints = DamagePoints + x;
      }
 else if (weapon == 4)
      {
       srand ((unsigned)time(NULL));
       x = rand() % 10;
       EnemyHealth = EnemyHealth - 30;
       EnemyHealth = EnemyHealth - x;
       DamagePoints = 30;
       DamagePoints = DamagePoints + x;
      }
 else if (weapon == 5)
      {
       srand ((unsigned)time(NULL));
       x = rand() % 10;
       EnemyHealth = EnemyHealth - 40;
       EnemyHealth = EnemyHealth - x;
       DamagePoints = 40;
       DamagePoints = DamagePoints + x;
      }
 else if (weapon == 6)
      {
       srand ((unsigned)time(NULL));
       x = rand() % 10;
       EnemyHealth = EnemyHealth - 50;
       EnemyHealth = EnemyHealth - x;
       DamagePoints = 50;
       DamagePoints = DamagePoints + x;
      }
 else if (weapon == 7)
      {
       srand ((unsigned)time(NULL));
       x = rand() % 30;
       EnemyHealth = EnemyHealth - 70;
       EnemyHealth = EnemyHealth - x;
       DamagePoints = 70;
       DamagePoints = DamagePoints + x;
      }
  if (EnemyHealth > 0)
  {
  cout<<"You dealt "<<DamagePoints<<" damage to "<<EnemyName<<"."<<endl;
  cout<<"Press any key to continue.\n";
  getch();
  DamageEN();
  }
  else
  {
   if (TR == 1)
   {
   YouWinTo();
   }
   else
   {
   YouWin();
   }
  }
};

void DamageEN()                     //damage dealt by the enemy
{
 srand ((unsigned)time(NULL));
 x = rand() % 10;
 if (x == 7)
 {                                                //Can't always have a hit
  cout<<"He missed!\n";
  cout<<"Press any key to continue.\n";
  getch();
  Battle();
 }
 if (experience <= 5)
 {
  srand ((unsigned)time(NULL));
  x = rand() % 10;
  UserHealth = UserHealth - x;
  DamagePoints = x;
 }
 else if (experience <= 10)
 {
  srand ((unsigned)time(NULL));
  x = rand() % 15;
  UserHealth = UserHealth - x;
  DamagePoints = x;
 }
 else if (experience <= 15)
 {
  srand ((unsigned)time(NULL));
  x = rand() % 10;
  UserHealth = UserHealth - 10;
  UserHealth = UserHealth - x;
  DamagePoints = 10;
  DamagePoints = DamagePoints + x;
 }
 else if (experience <= 25)
 {
  srand ((unsigned)time(NULL));
  x = rand() % 15;
  UserHealth = UserHealth - 15;
  UserHealth = UserHealth - x;
  DamagePoints = 15;
  DamagePoints = DamagePoints + x;
 }
 else
 {
   srand ((unsigned)time(NULL));
  x = rand() % 15;
  UserHealth = UserHealth - 25;
  UserHealth = UserHealth - x;
  DamagePoints = 25;
  DamagePoints = DamagePoints + x;
 }
 if (WoodenArmor == 1)
    {
     srand ((unsigned)time(NULL));
     x = rand() % 5;
     DamagePoints = DamagePoints - x;
     UserHealth = UserHealth + x;
     if (DamagePoints < 0)
     {
     x = 0 - DamagePoints;
     UserHealth = UserHealth - x;
     DamagePoints = 0;
     }
    }
 else if (IronArmor == 1)
    {
     srand ((unsigned)time(NULL));
     x = rand() % 5;
     DamagePoints = DamagePoints - 5;
     DamagePoints = DamagePoints - x;
     UserHealth = UserHealth + 5;
     UserHealth = UserHealth + x;
     if (DamagePoints < 0)
     {
     x = 0 - DamagePoints;
     UserHealth = UserHealth - x;
     DamagePoints = 0;
     }
    }
 else if (SilverArmor == 1)
    {
     srand ((unsigned)time(NULL));
     x = rand() % 5;
     DamagePoints = DamagePoints - 10;
     DamagePoints = DamagePoints - x;
     UserHealth = UserHealth + 10;
     UserHealth = UserHealth + x;
     if (DamagePoints < 0)
     {
     x = 0 - DamagePoints;
     UserHealth = UserHealth - x;
     DamagePoints = 0;
     }
    }
 else if (GoldenArmor == 1)
    {
     srand ((unsigned)time(NULL));
     x = rand() % 5;
     DamagePoints = DamagePoints - 15;
     DamagePoints = DamagePoints - x;
     UserHealth = UserHealth + 15;
     UserHealth = UserHealth + x;
     if (DamagePoints < 0)
     {
     x = 0 - DamagePoints;
     UserHealth = UserHealth - x;
     DamagePoints = 0;
     }
    }
 else if (PlatinumArmor == 1)
    {
     srand ((unsigned)time(NULL));
     x = rand() % 5;
     DamagePoints = DamagePoints - 20;
     DamagePoints = DamagePoints - x;
     UserHealth = UserHealth + 20;
     UserHealth = UserHealth + x;
     if (DamagePoints < 0)
     {
     x = 0 - DamagePoints;
     UserHealth = UserHealth - x;
     DamagePoints = 0;
     }
    }
 else if (KristalArmor == 1)
    {
     srand ((unsigned)time(NULL));
     x = rand() % 10;
     DamagePoints = DamagePoints - 25;
     DamagePoints = DamagePoints - x;
     UserHealth = UserHealth + 25;
     UserHealth = UserHealth + x;
     if (DamagePoints < 0)
     {
     x = 0 - DamagePoints;
     UserHealth = UserHealth - x;
     DamagePoints = 0;
     }
    }
 if (UserHealth <= 0)
    {
    cout<<"You Lose!!!\n";
    getch();
    YouLose();
    }
 else
     {
     cout<<EnemyName<<" dealt "<<DamagePoints<<" damage to you.\n";
     cout<<"Press any key to continue.\n";
     getch();
     Battle();
     }
};

void DamageENTR()           //damage dealt by the enemy in Training mode
{
 srand ((unsigned)time(NULL));
 x = rand() % 10;
 if (x == 7)
 {
  cout<<"He missed!\n";
  cout<<"Press any key to continue.\n";
  getch();
  Battle();
 }
 if (experience <= 5)
 {
  srand ((unsigned)time(NULL));
  x = rand() % 10;
  UserHealth = UserHealth - x;
 }
 else if (experience <= 10)
 {
  srand ((unsigned)time(NULL));
  x = rand() % 15;
  UserHealth = UserHealth - x;
 }
 else if (experience <= 15)
 {
  srand ((unsigned)time(NULL));
  x = rand() % 10;
  UserHealth = UserHealth - 10;
  UserHealth = UserHealth -x;
 }
 else if (experience <= 25)
 {
  srand ((unsigned)time(NULL));
  x = rand() % 15;
  UserHealth = UserHealth - 15;
  UserHealth = UserHealth -x;
 }
 else
 {
   srand ((unsigned)time(NULL));
  x = rand() % 15;
  UserHealth = UserHealth - 25;
  UserHealth = UserHealth -x;
 }
 cout<<EnemyName<<" Dealt "<<DamagePoints<<" damage to you.\n";
 cout<<"Press any key to continue.\n";
 getch();
 BattleTR();
};

void YouWinTR()                      //You win in Training mode, this is where it is different from
{                                    //the single match mode
 UserHealth = MaxHealth;
 EnemyHealth = 100;
 TrainingKills = TrainingKills + 1;
 cout<<"You won!!!\n";
 if (TrainingKills == 5)
    {
     cout<<"You've got 5 Training Kills, and won a Small Potion!!!";
     SmallPotion = SmallPotion + 1;
    }
 else if (TrainingKills == 10)
      {
       cout<<"You've got 10 Training Kills, and you won a Medium Potion!!!";
       MediumPotion = MediumPotion + 1;
      }
 else if (TrainingKills == 15)
      {
       cout<<"You've got 15 Training Kills, and you won a Big Potion!!!";
       BigPotion = BigPotion + 1;
      }
 else if (TrainingKills == 20)
      {
       cout<<"You've got 20 Training Kills, and you won a Max Potion!!!";
       MaxPotion = MaxPotion + 1;
      }
 cout<<"Press any key to continue.\n";
 getch();
 system("CLS");
 Menu();
};

void YouWin()                      //You win in all the other modes
{
 EnemyHealth = 100;
 experience = experience + 1;
 money = money + 100;
 cout<<"You won!!!\n";
 if (Boss == 1)                       //Declaring Bosses
 {
  system("CLS");
  cout<<"This can't be happening, you beat me...\n";
  cout<<"Van Hooi will teach you a lessen, one day!!!\n\n";
  cout<<"You won a Small Potion\n";
  SmallPotion = SmallPotion + 1;
  cout<<"Press any key to continue\n";
  Boss = 0;
  getch();
  Menu();
 }
 else if (Boss == 2)
 {
  system("CLS");
  cout<<"This can't be happening, you beat me...\n";
  cout<<"Van Hooi will teach you a lessen, one day!!!\n\n";
  cout<<"You won a Medium Potion\n";
  MediumPotion = MediumPotion + 1;
  cout<<"Press any key to continue\n";
  Boss = 0;
  getch();
  Menu();
 }
 else if (Boss == 3)
 {
  system("CLS");
  cout<<"This can't be happening, you beat me...\n";
  cout<<"Van Hooi will teach you a lessen, one day!!!\n\n";
  cout<<"You won a Big Potion\n";
  BigPotion = BigPotion + 1;
  cout<<"Press any key to continue\n";
  Boss = 0;
  getch();
  Menu();
 }
 else if (Boss == 4)
 {
  system("CLS");
  cout<<"This can't be happening, you beat me...\n";
  cout<<"Van Hooi will teach you a lessen, one day!!!\n\n";
  cout<<"You won a Max Potion\n";
  MaxPotion = MaxPotion + 1;
  cout<<"Press any key to continue\n";
  Boss = 0;
  getch();
  Menu();
 }
 else if (Boss == 5)
 {
  system("CLS");
  cout<<"This can't be happening, you beat me...\n";
  cout<<"Van Hooi will teach you a lessen, one day!!!\n\n";
  cout<<"You won a Small Max Health Potion\n";
  SmallMaxHealthPotion = SmallMaxHealthPotion + 1;
  cout<<"Press any key to continue\n";
  Boss = 0;
  getch();
  Menu();
 }
 else if (Boss == 6)
 {
  system("CLS");
  cout<<"This can't be happening, you beat me...\n";
  cout<<"Van Hooi will teach you a lessen, one day!!!\n\n";
  cout<<"You won a Medium Max Health Potion\n";
  MediumMaxHealthPotion = MediumMaxHealthPotion + 1;
  cout<<"Press any key to continue\n";
  Boss = 0;
  getch();
  Menu();
 }
 else if (Boss == 7)
 {
  YouWinTheGame();
 }

 if (experience == 5)
 {
  system("CLS");
  Boss1();
 }
 else if (experience == 10)
 {
  system("CLS");
  Boss2();
 }
 else if (experience == 15)
 {
  system("CLS");
  Boss3();
 }
 else if (experience == 20)
 {
  system("CLS");
  Boss4();
 }
 else if (experience == 25)
 {
  system("CLS");
  Boss5();
 }
 else if (experience == 30)
 {
  system("CLS");
  Boss6();
 }
 else if (experience == 40)
 {
  system("CLS");
  Boss7();
 }
 cout<<"Press any key to continue.\n";
 getch();
 system("CLS");
 Menu();
};

void YouWinTo()                   //You win while in Tournament
{
     cout<<"Get ready for your second opponent.";
     getch();
     EnemyHealth = 100;
     if (TR <= 3)
     {
      money = money + gain;
      cout<<"You gained "<<gain<<" for "<<TR<<" match(es)"<<endl;
      cout<<"Press any key to continue.\n";
      getch();
      gain = gain + 100;
      Battle();
     }
     else if (TR <= 5)
     {
     money = money + gain;
     cout<<"You gained "<<gain<<" for " <<TR<<" matches"<<endl;
     cout<<"Press any key to continue.\n";
     getch();
     gain = gain + 200;
     Battle();
     }
     else if (TR == 7)
     {
       money = money + 500;
       gain = gain + 500;
       cout<<"You've won the tournament!!!\n";
       cout<<"You gained "<<gain<<" for this tournament";
       gain = 0;
       TR = 0;
       Menu();
     }
};

void YouLose()                   //Game Over
{
 system("CLS");
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"//__________________GAME OVER__________________\\"<<endl<<endl;
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_INTENSITY);
 cout<<"This game was created by : Joshua Wohle\n\n";
 cout<<"My first game in c++!!!\n\n";
 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_INTENSITY);
 cout<<"If you have some tips or some information, please mail me at:\n\n";
 cout<<"JoshuaWohle1987@hotmail.com\n\n";
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"I hope you had fun playing the game.";
 getch();
 exit(0);
};

void YouWinTheGame()                 //when you finished the game
{
 system("CLS");
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"//__________________YOU WON__________________\\"<<endl<<endl;
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_INTENSITY);
 cout<<"This game was created by : Joshua Wohle\n\n";
 cout<<"My first game in c++!!!\n\n";
 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_INTENSITY);
 cout<<"If you have some tips or some information, please mail me at:\n\n";
 cout<<"JoshuaWohle1987@hotmail.com\n\n";
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"I hope you had fun playing the game.";
 getch();
 exit(0);
};

void Boss1()                           //Bosses
{
 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_INTENSITY);
 getch();
 cout<<"Press any key to continue.\n";
 system("CLS");
 cout<<"You've made it to a village called Green Town.\n";
 cout<<"You go to the nearest cafe to drink and eat something,\n";
 cout<<"you are so hungry that you ask for the first menu you see.\n";
 cout<<"Quickly you go to the toilets(you didn't have a leak for about three days),\n";
 cout<<"and the moment you enter them, you see a man slapping a girl.\n";
 cout<<"As you are a gentleman, you can't let him continue.\n";
 cout<<"He takes his sword, and you take yours...\n\n";
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"Press any key to continue.\n";
 getch();
 strcpy(EnemyName, "DUDE");
 EnemyHealth = 125;
 Boss = 1;
 Battle();
};

void Boss2()
{
 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_INTENSITY);
 getch();
 cout<<"Press any key to continue.\n";
 cout<<"After two days of walking in the desert, you arrive at an hotel.\n";
 cout<<"You ask for a room, but you don't have any money.\n";
 cout<<"The owner of the hotel tells you that if you want a room,\n";
 cout<<"You can make the money for it by fighting his strongest man.\n";
 cout<<"As this is your last chance, you don't say no, but the man\n";
 cout<<"is much stronger than you would think he is!!!\n\n";
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"Press any key to continue.\n";
 getch();
 strcpy(EnemyName, "BULDOZER");
 EnemyHealth = 150;
 Boss = 2;
 Battle();
};

void Boss3()
{
 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_INTENSITY);
 getch();
 cout<<"You crossed the desert, and ran into an old man.\n";
 cout<<"He asks you for a piece of bread, but you don't have any,\n";
 cout<<"The old man is angry, and begins to sniffle in your stuff.\n";
 cout<<"The moment he sees your sword he grabbes it, but he is to slow,\n";
 cout<<"You take your wsord first, and challange him for a battle...\n\n";
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"Press any key to continue.\n";
 getch();
 strcpy(EnemyName, "POOR OLD MAN");
 EnemyHealth = 175;
 Boss = 3;
 Battle();
};

void Boss4()
{
 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_INTENSITY);
 getch();
 cout<<"You hear a voice in your head, it tells you to look around.\n";
 cout<<"You look around and you see a man with a sword in is hand,\n";
 cout<<"must be a servant of Van Hooi...\n\n";
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"Press any key to continue.\n";
 getch();
 strcpy(EnemyName, "SERVANT");
 EnemyHealth = 200;
 Boss = 4;
 Battle();

};

void Boss5()
{
 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_INTENSITY);
 getch();
 cout<<"You get attacked from behind, but are able to free yourself.\n";
 cout<<"Would you be able to defeat this enemy???\n\n";
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"Press any key to continue.\n";
 getch();
 strcpy(EnemyName, "WARIOR");
 EnemyHealth = 200;
 Boss = 5;
 Battle();
};

void Boss6()
{
 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_INTENSITY);
 getch();
 cout<<"You arrived at Van Hooi's castle. The first thing you see\n";
 cout<<"when you enter is a big welcome poster, with your photo on it.\n";
 cout<<"You know that something is going to happen, but what?\n";
 cout<<"After a few moments of silence, you hear foot steps behind you.\n\n";
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"Press any key to continue.\n";
 getch();
 strcpy(EnemyName, "CASTLE GUARD");
 EnemyHealth = 225;
 Boss = 6;
 Battle();
};

void Boss7()
{
 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_RED | FOREGROUND_INTENSITY);
 getch();
 cout<<"You finally arrive in front of Van Hooi, will you be able to beat him?\n";
 cout<<"Van Hooi : come on little rat, show me what you've got.\n";
 cout<<UserName<<" : when I'm finished with you, you would wish\n";
 cout<<"you where never born!!!\n\n";
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
 cout<<"Press any key to continue.\n";
 getch();
 strcpy(EnemyName, "Van Hooi");
 EnemyHealth = 250;
 Boss = 7;
 Battle();
};

int main()        //main structure, first the story and then calling Menu() fuction
{
 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_INTENSITY);
    cout<<"Welcome to";
 SetConsoleTextAttribute(stdOut, FOREGROUND_RED | FOREGROUND_RED | FOREGROUND_INTENSITY);
    cout<<" Swordsman 1.0 ";
 SetConsoleTextAttribute(stdOut, FOREGROUND_BLUE | FOREGROUND_GREEN | FOREGROUND_INTENSITY);
    cout<<"The goal of the game is to defeat\n";
    cout<<"your enemys before they defeat you. On the way, you have\n";
    cout<<"to make some choices and fight some real tough guys.\n";
    cout<<"This is an action game, so I hope you have fun.\n\n";

    cout<<"Enter your name:\n";
    cin>>UserName;
    system("CLS");


    cout<<"It all began on a peacefull Sunday morning, you and your\n";
    cout<<"dad where having breakfast together when suddenly a man with\n";
    cout<<"a sword came out of nowhere. Your dad was a man of courage,\n";
    cout<<"so he took his sword as well and told you to run away as fast\n";
    cout<<"as possible. You didnt want to leave him behind, but you had to,\n";
    cout<<"you where only 10 years old...\n\n";

    cout<<"After two hours of running, you ran into a man that knew you somehow.\n";
    cout<<"He asked you what happened, you told him the whole story and then you\n";
    cout<<"realised that the man that you where talking to was the old trainer\n";
    cout<<"in fencing of your father, his name was Harold. He did try to stop the\n";
    cout<<"man that was fighting with your father, but it was already too late.\n";
    cout<<"He was dead...\n\n";

    cout<<"Harold told you after that the man that killed your father was called\n";
    cout<<"Rick van Hooi. He told you also that he would train you till you would\n";
    cout<<"be able to beat the man who killed your father...\n\n";

    cout<<"Press any key to continue.\n";
    getch();
    system("CLS");

    cout<<"Ten years later, you have become a skilled fencer, but you have much to learn.\n";
    cout<<"Harold: "<<UserName<<" I have learned you all I could, now you have to go and\n";
    cout<<"practice in the open world, challange as many people as you can, because Rick\n";
    cout<<"van Hooi is not an easy opponnent.\n\n";

    cout<<"Press any key to continue.\n";
    getch();
    system("CLS");

    Menu();
      system("PAUSE");
      return 0;
}
