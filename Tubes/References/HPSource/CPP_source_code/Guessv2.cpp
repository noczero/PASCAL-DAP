// *****************************************
//        cplusplus language tutorial
//                section 2.1
//
//            "Guess the number"
// Shows:
//   - do-while
//   - if-else
//
// Briefing:
//  The computer generates a random number
//  between 1 and MAX_RANGE. The user must
//  guess the number. Each time the user
//  makes an attempt the computer tells if
//  the number is greater or less than.
// *****************************************

#include <iostream.h>
#include <stdlib.h>
#include <time.h>
#include <conio.h>

// Define the greatest possible value:
#define MAX_RANGE 10000

main ()
{
  int counter=0;
  long value,input;

  srand ( time (NULL) );         // Initialize random generator
  value = rand()%MAX_RANGE+1;    // Get random between 1 and MAX_RANGE

  cout << "\nInsert a value between 1 and " << MAX_RANGE << " : ";

  do {

    cin >> input;                // Get user input
    counter++;                   // increase attempts counter

    if (value>input)             // is value grater than the input?
      cout << "Value is greater than " << input << ". Try again : ";

    else if (value<input)        // if not, is it less?
      cout << "Value is less than " << input << ". Try again : ";

    else {                       // else it is the correct number!
      cout << "That's right! Value was " << input;
      cout << "\nYou have needed " << counter <<" attempts.";
      }

  } while (value!=input);
  while (!kbhit());
  return 0;
}