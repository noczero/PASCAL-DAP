//by Zach Hunt
//In this program the computer trys to guess a
//number that you think of between 1 and 100
#include <iostream.h>
#include <conio.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

main()
{
begin:	
   srand( (unsigned)time( NULL ) );   //random number generation
    int play ;
    int guesses=0;    //number of times it took the cxomputer to guess your number
	int correct;   //input if the computer's guess is higher lower or correct
	int answer=1;  //while this equals 1 the while loop will keep on going
	int low=0;     //what the lowest number the computer can guess is
	int max;   //what the max is for the computer to guess
	int guess;  //what the computer guesses and 50 is the first guess
	int level;
	int number;

redo:
cout<<"Select a level"<<'\n';
cout<<"(1)1-10"<<'\n';
cout<<"(2)1-100"<<'\n';
cout<<"(3)1-1,000"<<'\n';
cout<<"(4)1-10,000"<<'\n';
cin>>level;
if (level==1) 
{number=10;
 guess=5;
 max=11;
}
if (level==2)
{number=100;
 guess=50;
 max=101;
}
if (level==3) 
{number=1000;
 guess=500;
 max=1001;
}
if (level==4) 
{number=10000;
 guess=5000;
 max=10001;
}

if (level>4 || level<1) goto redo;
cout<<"Think of a number between 1 and "<<number<<endl;
getch();
do
{
guesses++;
cout<<"Is it "<<guess<<'\n';
cout<<"(1)Higher"<<'\n';
cout<<"(2)Lower"<<'\n';
cout<<"(3)Correct"<<'\n';
cin>>correct;    //input if the computer's guess is higher or lower than your number

switch(correct)
{
case 1:   //higher
low=guess;
while(guess<=low || guess>=max)
{
guess=rand() % max;
}
break;
case 2:   //lower

max=guess;
while(guess<=low || guess>=max)
{
guess=rand() % max;
}
break;
case 3:   //correct
answer=2; //if computer's guess is correct it will quit the program
break;
}
}
while(answer==1);
if (guesses==1) cout<<"It took the computer "<<guesses<<" guess"<<endl;
if (guesses>1) cout<<"It took the computer "<<guesses<<" guesses"<<endl;
getch();
cout<<"Do you want to play again"<<'\n';
cout<<"(1)Yes"<<'\n';
cout<<"(2)No"<<'\n';
cin>>play;
if (play==1) goto begin;
return 0;
}