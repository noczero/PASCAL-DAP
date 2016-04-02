/*THE GAME OF LIFE cellular automaton by Kyle Cronin
Rules:
1. Any live cell with fewer than two neighbours dies of loneliness. 
2. Any live cell with more than three neighbours dies of crowding. 
3. Any dead cell with exactly three neighbours comes to life. 
4. Any live cell with two or three neighbours lives, unchanged, to the next generation*/
//=======================================================================
//Global declerations
#include <stdlib.h>
#include <iostream>
#include <cstdlib> 
using std::cin;
using std::cout;
using namespace std;
const int X = 39, Y = 45; //-->Ymax=54 Ymin=19
int x,y,counter,choice;
int loneliness=2,crowding=3,birth=3;
char array [X][Y];
char dead = ' ';
char alive = 1;
char boarder ='=';
void print();
//=======================================================================
//Print introduction
int main()
{start:
system("cls");
cout<<"THE GAME OF LIFE cellular automaton - by Kyle Cronin\n----------------------------------------------------\nRules:\n";
cout<<"1.  Any live cell with fewer than two neighbours dies of loneliness.\n";
cout<<"2.  Any live cell with more than three neighbours dies of crowding.\n"; 
cout<<"3.  Any dead cell with exactly three neighbours comes to life.\n";
cout<<"4.  Any live cell with two or three neighbours lives\n    unchanged, to the next generation.\n\n";
cout<<"Select a pattern\n1.  CUSTOM\n2.  Small Exploder\n3.  Large Exploder\n4.  10 Cell Row\n5.  Spaceship";
cout<<"\n6.  Tumbler\n7.  Glider Gun\n8.  Weird Thing\n9.  Glider\n\n10. Change Rules\n11. Set To Defaults\n12. Exit Program\n\nChoice: ";
cin>>choice;
//=======================================================================
//Initialize Elements
for(y=0;y<Y;y++)
{for(x=1;x<X-1;x++)
array[x][y]=dead;}

//=======================================================================
//Preset patterns
if(choice==12)//Exit Program
{system("cls");
exit(0);}

else if(choice==10)
{system("cls");cout<<"1. Any live cell with fewer than x neighbours dies of loneliness (Default 2): ";
cin>>loneliness;
cout<<"2. Any live cell with more than x neighbours dies of crowding (Default 3): "; 
cin>>crowding;
cout<<"3. Any dead cell with exactly x neighbours comes to life (Default 3): ";
cin>>birth;
goto start;}
else if(choice==11)
{loneliness=2;
crowding=3;
birth=3;
goto start;}
else if(choice >11 || choice <1)
goto start;
print ();
if(choice==9)//Glider
{array[5][5]=alive;
array[6][5]=alive;
array[7][5]=alive;
array[7][4]=alive;
array[6][3]=alive;}
else if(choice==2)//Small Exploder
{array[13][13]=alive;
array[12][13]=alive;
array[14][13]=alive;
array[13][12]=alive;
array[13][15]=alive;
array[12][14]=alive;
array[14][14]=alive;}
else if(choice==3)//Large Exploder
{array[10][12]=alive;
array[10][13]=alive;
array[10][14]=alive;
array[10][15]=alive;
array[10][16]=alive;
array[14][12]=alive;
array[14][13]=alive;
array[14][14]=alive;
array[14][15]=alive;
array[14][16]=alive;
array[12][12]=alive;
array[12][16]=alive;}
else if(choice==4)//10 Cell Row
{array[10][13]=alive;
array[11][13]=alive;
array[12][13]=alive;
array[13][13]=alive;
array[14][13]=alive;
array[15][13]=alive;
array[16][13]=alive;
array[17][13]=alive;
array[18][13]=alive;
array[19][13]=alive;}
else if(choice==5)//Spaceship
{array[2][10]=alive;
array[2][12]=alive;
array[3][9]=alive;
array[4][9]=alive;
array[5][9]=alive;
array[5][12]=alive;
array[6][9]=alive;
array[6][10]=alive;
array[6][11]=alive;}
else if(choice==6)//Tumbler
{array[10][6]=alive;
array[9][7]=alive;
array[10][7]=alive;
array[9][8]=alive;
array[11][8]=alive;
array[11][9]=alive;
array[11][10]=alive;
array[10][10]=alive;
array[10][11]=alive;
array[14][6]=alive;
array[14][7]=alive;
array[15][7]=alive;
array[13][8]=alive;
array[15][8]=alive;
array[13][9]=alive;
array[13][10]=alive;
array[14][10]=alive;
array[14][11]=alive;}
else if(choice==7)//Glider Gun
{array[29][4]=alive;
array[28][4]=alive;
array[28][5]=alive;
array[29][5]=alive;
array[28][12]=alive;
array[27][12]=alive;
array[27][13]=alive;
array[29][13]=alive;
array[28][14]=alive;
array[29][14]=alive;
array[27][20]=alive;
array[26][20]=alive;
array[25][20]=alive;
array[27][21]=alive;
array[26][22]=alive;
array[29][26]=alive;
array[30][26]=alive;
array[29][27]=alive;
array[31][27]=alive;
array[30][28]=alive;
array[31][28]=alive;
array[31][38]=alive;
array[30][38]=alive;
array[31][39]=alive;
array[30][39]=alive;
array[24][39]=alive;
array[23][39]=alive;
array[22][39]=alive;
array[24][40]=alive;
array[23][41]=alive;
array[19][30]=alive;
array[19][29]=alive;
array[19][28]=alive;
array[18][28]=alive;
array[17][29]=alive;}
else if(choice==8)//Weird Thing
{array[10][2]=alive;
array[9][3]=alive;
array[10][3]=alive;
array[9][4]=alive;
array[11][4]=alive;
array[11][5]=alive;
array[11][6]=alive;
array[10][6]=alive;
array[10][7]=alive;
array[11][13]=alive;
array[12][13]=alive;
array[13][13]=alive;
array[14][13]=alive;
array[15][13]=alive;
array[16][13]=alive;
array[17][13]=alive;
array[18][13]=alive;
array[19][13]=alive;}
else if(choice==1)//CUSTOM
{do{
cout<<" Maximise Window\n Enter 99 when finished\n";
cout<<" Enter Element x: ";
cin>>x;
if(x==99)
break;
cout<<" Enter Element y: ";
cin>>y;
if(y==99)
break;
cout<<"\n";
array[x][y]=alive;
print();}
while(x!=99);}
goto initial;
//========================================================================
//Check elements
check:
print();
for(y=0;y<Y;y++)
{for(x=0;x<X;x++){
counter = 0;
if(array[x-1][y-1]==alive || array[x-1][y-1]=='p')
{counter = counter +1;}
if(array[x][y-1]==alive || array[x][y-1]=='p')
{counter = counter +1;}
if(array[x+1][y-1]==alive || array[x+1][y-1]=='p')
{counter = counter +1;}
if(array[x-1][y]==alive || array[x-1][y]=='p')
{counter = counter +1;}
if(array[x+1][y]==alive || array[x+1][y]=='p')
{counter = counter +1;}
if(array[x-1][y+1]==alive || array[x-1][y+1]=='p')
{counter = counter +1;}
if(array[x][y+1]==alive || array[x][y+1]=='p')
{counter = counter +1;}
if(array[x+1][y+1]==alive || array[x+1][y+1]=='p')
{counter = counter +1;}
//Check cell against game rules
//o = was dead now alive
//p = was alive now dead
if(array[x][y]==alive && counter<loneliness)
array[x][y]='p';
if(array[x][y]==alive && counter>crowding)
array[x][y]='p';
if(array[x][y]==dead && counter==birth)
array[x][y]='o';}}
//======================================================================
//Update Elements
for(y=0;y<Y;y++)
{for(x=0;x<X;x++)
{if(array[x][y]=='o')
array[x][y]=alive;
else if(array[x][y]=='p')
array[x][y]=dead;}}
//=======================================================================
//Move to next frame query
initial:
cout<<" Maximise Window\n Press ENTER to move to next cycle\n Enter x to stop ";
x=0;
x=cin.get();
if(x==120 || x==88)
goto start;
goto check;
//=======================================================================
return 0;}
//=======================================================================
//array printing functions --> with or without grid numbers
void print()
{system("cls");
//set boarders before printing
for(y=0;y<Y;y++)
{{array[0][y]=boarder;
array[X-1][y]=boarder;}
for(x=0;x<X;x++)
{array[x][0]=boarder;
array[x][Y-1]=boarder;}}
//print
for(int y=0;y<Y;y++)
{cout<<"\n";
for(int x=0;x<X;x++)
cout<<" "<<array[x][y];
}cout<<"\n\n";}
//=======================================================================

