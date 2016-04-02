// *****************************************
//        cplusplus language tutorial
//                section 3.2
//
//            "The Secret Word"
// Shows:
//   - strings
//   - arrays of strings
//   - cstring functions: strcpy and strlen
//
// Briefing:
//  The user has to discover all the letters
//  in a secret keyword.
//  Each letter said that is in the keyword
//  is shown in its rightful location.
//  He/She has the opportunity to fail up
//  to FAILS_ALLOWED times.
// *****************************************

#include <iostream.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#define N_KEYS 12
#define KEY_MAX_WIDTH 20
#define FAILS_ALLOWED 7

// Possible keywords. You may inser new ones if you increase N_KEYS.
char possiblekeys [N_KEYS][KEY_MAX_WIDTH] = {
	"mushroom", "pineapple", "neighborhood", "citizen",
	"programming", "darkness", "fundamental", "encyclopedia",
	"businessman", "restaurant", "observatory", "civilization"
};

// This will store the key
char key [KEY_MAX_WIDTH];

// This will store the string shown on screen with letters already discovered.
char outstring [KEY_MAX_WIDTH];

int CheckLetter (char letter);

main ()
{
  char input;
  int valid;
  int fails = FAILS_ALLOWED;
  unsigned int discovered = 0;
  unsigned int n;

  // Select a key.
  srand ( time (NULL) );            // Initialize random number generator
  int value = rand()%N_KEYS;        // Get random between 0 and NKEYS-1
  strcpy (key,possiblekeys[value]); // Copy key

  // Set outstring to '-' characters plus terminating null-character
  for (n=0; n<strlen(key); n++) outstring[n]='-';
  outstring[n]='\0';

  do {
	// Prompt user
    cout << "\nDiscover the secret key: " << outstring << "\n";
    cout << "Enter a letter (You may fail " << fails << " times): ";
    cin >> input; cin.ignore (100,'\n');

	// check if letter is valid
    valid = CheckLetter (input);

	// it it is valid, increase dicovered letters counter.
	// if not, decrease allowed fails
	if (valid!=0) discovered+=valid;
	else fails--;

  } while (discovered < strlen(key) && fails>0);
  // The loop ends if key is discovered or fails are exhausted.

  // Display CORRECT! only if key was discovered.
  if (discoverd == strlen(key)) cout << "CORRECT! ";

  cout "Key was '" << key <<"'.\n";
  return 0;
}

// Function that checks if letter is in key.
// returns the number of times the letter was found in key
int CheckLetter (char letter)
{
	unsigned int n;
	int found=0;
	for (n=0; n<strlen(key); n++)
		if (key[n]==letter && outstring[n]=='-')
		{
			found++;
			outstring[n]=key[n];
		}
	return found;
}
