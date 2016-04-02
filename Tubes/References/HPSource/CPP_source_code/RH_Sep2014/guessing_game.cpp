// Guessing game, for C++ compilers, web: http://rudih.info
#include <stdlib.h>
#include <iostream>
#include <time.h>
#include <conio.h>

using namespace std;

int magicnumber,count,guess,range;

main() {
   cout << "---Guessing game---" << endl;
   cout << "Enter range (1-32000, e.g. 1000): ";
   cin >> range;
   cout << "Guess a number 1 to " << range << endl;
   srand( (unsigned)time( NULL ) );
   magicnumber=rand()%range+1;
   count=0;
   do {
      cin >> guess;
      count++;
      if (guess<magicnumber) cout << "It is greater" << endl;
      if (guess>magicnumber) cout << "It is less" << endl;
      } while (guess!=magicnumber);
   cout << "You got it in " << count << " guesses" << endl;
   getch();
   return 0;
};
