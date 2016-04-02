/*
 Dungeon, in C++, http://rudih.info
 This game is a text-based RPG which has:
 A random dungeon, hit points, an inventory,
 merchants, enemies, money.
*/

void combat();
void shop();
void makedun();
void drawmap();
void getcoord();
void normal();
#include <iostream>
#include <string>
#include <stdlib.h>
#include <time.h>
#include <conio.h>

using namespace std;

short room[100];
int column, row, y, scratch, cnt, GP, HP, enemyhp;
string user, enemyname;
short armour, knife;

int main()
{
    HP=0;
    cout << "---DUNGEON---" << endl
    << "[E]asy or [H]ard game> ";
    cin >> user;
    if (user=="E" || user=="e") HP = 16;
    if (user=="H" || user=="h") HP = 12;
    if (HP==0) return 0;
    GP=0;
    armour=0;
    knife=0;
    makedun();
    drawmap();
    while(user!="Q" || user!="q"){
           user="";
           getcoord();
           cout << "column="<<column<<" row="<<row<<endl;
           if (room[y]==1||room[y]==8||room[y]==2) normal();
           if (user=="q"||user=="Q") return 0;
           if (user=="m" || user=="M") drawmap();
           if (room[y]==3) {
                    cout<<"You find 2 gold peices on the floor."<<endl;
                    GP=GP+2;
                    room[y]=1;
                    }
           if(room[y]==4||room[y]==5||room[y]==6) combat();
           if (HP<1){
                     cout<<"You have been killed. Game over." <<endl;
                     getch();
                     return 0;
                    } 
           if(room[y]==7) shop();
           if (room[y]==9) {
                    cout<<"You have found the way out! -THE END- enter quits"
                        <<endl;
                    getch();
                    return 0;
                    }    
    } 
}

void makedun()
{
    srand( (unsigned)time( NULL ) );
    scratch=0;
    for (cnt=1;cnt<100;cnt++) {
        scratch=rand()%8;
        room[cnt]=scratch;
    }
    room[100]=room[0];
    scratch=rand()%100;
    room[scratch]=8;
    y=scratch;
    scratch=rand()%100;
    room[scratch]=9;
};

void shop()
{
  cout<<"There is a prisoner here."<<endl;
  cout<<"He asks you if you want to buy something [Y/N]?"<<endl<<"> ";   
  cin>>user;
  if(user=="y"||user=="Y") {
         cout << "Which item:"<< endl
              << "[1]armour - 5GP [2]knife - 10GP [3]potion - 3GP" << endl;
         cin >> scratch;
         if(scratch==1&&GP>4){
                              cout << "You buy the armour."<<endl;
                              GP=GP-5;
                              armour=1;
                              }
         if(scratch==2&&GP>9){
                             cout<<"You buy the knife"<<endl;
                             GP=GP-10;
                             knife=1;
                             }
         if(scratch==3&&GP>2) {
                             cout<<"You buy the potion & drink it (+6HP)."
                                 << endl;
                             GP=GP-3;
                             HP=HP+6;
                             }
  }
  cout<<"The prisoner disappears."<<endl;
  room[y]=1;
}  
                          
void drawmap()
{
     for (cnt=1;cnt<101;cnt++) {
         if (cnt==y){cout<<"* ";} else {cout<<". ";}
         if (cnt%10==0) cout << endl;
         }
}
              
void combat()
{
if(room[y]==4){
              enemyname="snake";
              enemyhp=1;
              }
if(room[y]==5){
              enemyname="guard";
              enemyhp=2;
              }
if(room[y]==6){
              enemyname="skeleton"; 
              enemyhp=6;
              }
cout << "You are attacked by a "<<enemyname<<" with "
<<enemyhp<<" HP."<<endl;
while(enemyhp>0) {
         scratch=rand()%2;
         if(scratch==1){
                cout << "You attack the "<<enemyname<<"."<<endl;
                scratch=rand()%3+1;
                if (knife==1) scratch=scratch+3;
                cout<<"The "<<enemyname<<" loses "<<scratch<<" HP."<<endl;                            
                enemyhp=enemyhp-scratch; }
         else {
              cout<<"The "<<enemyname<<" attacks.";
              scratch=rand()%3+1;
              if(armour==1&&scratch>1) scratch=scratch-2;
              cout<<" You lose "<<scratch<<" HP."<<endl;
              HP=HP-scratch;
              if (HP<1) return;
         }
         if(enemyhp<1) {cout << "You killed the "<<enemyname<<"." <<endl
                        << "The enemy drops 1GP. Press any key..." << endl;
                        getch();     
                        GP=GP+1;
                        room[y]=1;                          
                        }
   }
}

void getcoord()
{
     if (y<10) row=0;
     scratch=0;
     while (scratch<10){
           if (y>=scratch*10) row=scratch;
           scratch++;
           }
     column=(y%10)-1;
     if (column==-1) column=9;
}

void normal()
{
     cout<<"You are in a dungeon room. HP="<<HP<<endl
         <<"[Q]uit - [I]nventory - [M]ap - Move[N],[S],[E],[W]"<<endl
         <<"> ";
     cin >> user;
     if (user=="i" || user=="I") {
                   cout<<"Inventory: GP="<<GP;
                   if (armour==1) cout << " -armour";
                   if (knife==1) cout << " -knife";
                   cout << endl;
                   }
     if (user=="n" || user=="N"){
                   scratch=y-10;
                   if (row==0 || room[scratch]==0) cout<<"North is blocked."<<endl;
                   else y=y-10;
                   }    
     if (user=="s" || user=="S"){
                   scratch=y+10;
                   if (row==9 || room[scratch]==0) cout<<"South is blocked."<<endl;
                   else y=y+10;
                   }  
     if (user=="e" || user=="E"){
                   scratch=y+1;
                   if (column==9 || room[scratch]==0) cout<<"East is blocked."<<endl;
                   else y=y+1;
                   }      
     if (user=="w" || user=="W"){
                   scratch=y-1;
                   if (column==0 || room[scratch]==0) cout<<"West is blocked."<<endl;
                   else y=y-1;
                   }                                   
}
