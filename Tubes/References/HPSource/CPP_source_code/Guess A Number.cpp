// This software was created by _William_
// (c) 2006
//
//---------------------------------------------




#include <stdlib.h>
#include <iostream>
#include <time.h>


using namespace std;

void Start ();
void GetResults ();

int i, j, life, maxrand;
char c;


void
Start ()
{
      i = 0;
      j = 0;
      life = 0;
      maxrand = 0;

      cout << "Select a difficulty mode:\n";  // user should select a level
      cout << "Level 1: Sissy (0-5)\n";
      cout << "Level 2: Easy (1-10)\n";
      cout << "Level 3: Medium (1-35)\n";
      cout << "Level 4: Hard (1-100)\n";
      cout << "Level 5: Masters (1-350)\n";
      cout << "Level 6: Impossible (1-500)\n\n";
      cout << "or type 'q' to quit the game.\n";
      c = 30;

      cin  >> c;
      cout << "\n\n";                     // read the user's input

      switch (c)
      {
             /* the random number will be between 1 and maxrand */
             case '1' : maxrand = 5;  life = 3;    // number of lifes of the player
             break;
             case '2' : maxrand = 10; life = 4;
             break;
             case '3' : maxrand = 35; life = 5;
             break;
             case '4' : maxrand = 100; life = 7;
             break;
             case '5' : maxrand = 350; life = 10;
             break;
             case '6' : maxrand = 500; life = 11;
             break;
             default : exit(0);
             break;
          }


          srand( (unsigned)time( NULL ) ); // initiate rand() function
          j = rand() % maxrand;  // j= get a random value between 1 and maxrand

          GetResults();

}


void
GetResults ()
{
           if (life <= 0)
           // then player loses
           {
                   cout << "You lose!! Why don't you play again?\n\n";
                   Start();
           }

           cout << "Type a number: \n";
           cin  >> i;         // read user's number

           if ((i>maxrand) || (i<0)) // if the user's number isn't correct restart
           {
        cout << "This number isn't between 1 and " << maxrand;
        GetResults();
     }

     if (i == j)
     {
        cout << "You found the secret number! Good Job!!!\n\n"; // the user found the secret number
        Start();
     }

     else if (i>j)
     {
        cout << "Too BIG!\n";
        life = life - 1;    // -1 to the user's "life"
        cout << "Number of life left: \n" << life << "\n\n";
        GetResults();
     }

     else if (i<j)
     {
        cout << "Too SMALL!\n";
        life = life - 1;
        cout << "Number of life left: \n" << life << "\n\n";
        GetResults();
     }
}


int
main ()
{
     cout << "                            *** Guess a number ***\n";
     cout << "The goal of this game is to guess a number. You will have different levels\n";
     cout << "that have a bigger range of numbers.\n";
     cout << "The computer, will then tell you if the number you typed in is \n";
     cout << "too big or too small compared to the secret number that you need to find.\n";
     cout << "Have Fun!!\n\n";
     Start();
     system("PAUSE");
     return 0;
}

