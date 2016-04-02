// *****************************************
//        cplusplus language tutorial
//                section 2.2
//
//         "Stone, Scissors or Paper"
// Shows:
//   - The use of functions
//   - switch-case and if-else statements
//
// Briefing:
//  In this game, the user and the computer
//  choose each one an option between stone,
//  scissors and paper.
//  Stone wins over scissors, scissors over
//  paper and paper over stone:
//    stone -> scissors -> paper -> stone...
//  The first who wins WINSCORE times is
//  the competition winner.
// *****************************************

#include <iostream.h>
#include <stdlib.h>
#include <time.h>

#define WINSCORE 3

// Function PickRandomOption
// * Returns a random character between 's', 'x', and 'p'
char PickRandomOption (void)
{
   char option;
   srand ( time (NULL) );      // (re)initialize random number generator
   int value = rand()%3;       // Generate random number between 0 and 2

   switch (value) {
      case 0: option='s'; break;
      case 1: option='x'; break;
      case 2: option='p'; break;
   }
   return option;
}

// Function WhoWins
// * check which of the characters passed wins.
// return values:
//   0= tie, 1=the first, 2=the second, -1=error
int WhoWins (char a, char b)
{
   switch (a)
   {
      case 's':
         if (b=='x') return 1;
         else if (b=='p') return 2;
         else return 0;
      case 'x':
         if (b=='p') return 1;
         else if (b=='s') return 2;
         else return 0;
      case 'p':
         if (b=='s') return 1;
         else if (b=='x') return 2;
         else return 0;
      default:
         return -1;
   }
   // NOTE: no break instructions were included in this switch statement
   // because a break instruction at the end of a case would never
   // been executed because there would always be a return statement
   // executed before.
   // For the same reason this peculiar function has no explicit ending
   // return statement.
}

main ()
{
   char you, me;
   int mypoints=0;
   int yourpoints=0;
   int winner;

   do {
      //prompt user.
      cout << "\nEnter s, x or p ";
      cout << "(s=stone, x=scissors, p=paper): ";
      cin >> you;

      //decide computer's option and say it
      me = PickRandomOption();
      cout << "I say: " << me << "\n";

      // check who is the winner
      winner = WhoWins (you,me);

      // show appropiate message:
      if (winner==0) cout << "Tied\n";
      else if (winner==1) { cout << "You win\n"; yourpoints++; }
      else if (winner==2) { cout << "I win\n"; mypoints++; }
      else cout << "Sorry. You entered an Invalid option\n";

      // show current scoreboard.
      cout << "POINTS: You:" << yourpoints;
      cout << " Me:" << mypoints << "\n";

   } while (yourpoints<WINSCORE && mypoints<WINSCORE);

   if (yourpoints>mypoints) cout << "You win the competition!\n";
   else cout << "I win the competition!\n";
   return 0;
}
