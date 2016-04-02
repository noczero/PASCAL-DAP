// Mystery calculator, for C++ compilers, http://rudih.info

// In this game the computer determines a secret number.
// The idea came from a card trick.

void card1();
void card2();
void card3();
void card4();
void card5();
void card6();
#include <iostream>
#include <conio.h>

using namespace std;

int answer, usercard;
char card;

main(){
  cout << "---THE MYSTERY CALCULATOR---" << endl
  << "Choose a card 1 to 6: ";
  cin >> usercard;
  if (usercard < 1 || usercard > 6){
     cout << "Invalid input." << endl;
     return 0;
     };
  cout << endl
  << "Choose any number from this card and remember it:"
  << endl;
  if (usercard == 1) card1();
  if (usercard == 2) card2();
  if (usercard == 3) card3();
  if (usercard == 4) card4();
  if (usercard == 5) card5();
  if (usercard == 6) card6();
  cout << "Press any key to continue..." << endl;
  getch();
  answer = 0;
  card1();
  cout << "Does you number appear on this card (Y/N)? ";
  cin >> card;
  if (card == 'Y' || card == 'y'){
     answer = answer + 1;
     };
  card2();
  cout << "Does you number appear on this card (Y/N)? ";
  cin >> card;
  if (card == 'Y' || card == 'y'){
     answer = answer + 2;
     };
  card3();
  cout << "Does you number appear on this card (Y/N)? ";
  cin >> card;
  if (card == 'Y' || card == 'y'){
     answer = answer + 4;
     };
  card4();
  cout << "Does you number appear on this card (Y/N)? ";
  cin >> card;
  if (card == 'Y' || card == 'y'){
     answer = answer + 8;
     };
  card5();
  cout << "Does you number appear on this card (Y/N)? ";
  cin >> card;
  if (card == 'Y' || card == 'y'){
     answer = answer + 16;
     };
    card6();
  cout << "Does you number appear on this card (Y/N)? ";
  cin >> card;
  if (card == 'Y' || card == 'y'){
     answer = answer + 32;
     };
  cout << endl << "Your number is: " << answer
       << ". Press any key to exit. ";
  getch();
  return 0;
}


void card1(){
 cout << endl
      << "1  3  5  7  9  11 13 15" << endl
      << "17 19 21 23 25 27 29 31" << endl
      << "33 35 37 39 41 43 45 47" << endl
      << "49 51 53 55 57 59 61 63" << endl
 << endl;
};

void card2(){
 cout << endl
      << "2  3  6  7  10 11 14 15" << endl
      << "18 19 22 23 26 27 30 31" << endl
      << "34 35 38 39 42 43 46 47" << endl
      << "50 51 54 55 58 59 62 63" << endl
 << endl;
};

void card3(){
 cout << endl
      << "4  5  6  7  12 13 14 15" << endl
      << "20 21 22 23 28 29 30 31" << endl
      << "36 37 38 39 44 45 46 47" << endl
      << "52 53 54 55 60 61 62 63" << endl
 << endl;
};

void card4(){
 cout << endl
      << "8  9  10 11 12 13 14 15" << endl
      << "24 25 26 27 28 29 30 31" << endl
      << "40 41 42 43 44 45 46 47" << endl
      << "56 57 58 59 60 61 62 63" << endl
 << endl;
};

void card5(){
 cout << endl
      << "16 17 18 19 20 21 22 23" << endl
      << "24 25 26 27 28 29 30 31" << endl
      << "48 49 50 51 52 53 54 55" << endl
      << "56 57 58 59 60 61 62 63" << endl
 << endl;
};

void card6(){
 cout << endl
      << "32 33 34 35 36 37 38 39" << endl
      << "40 41 42 43 44 45 46 47" << endl
      << "48 49 50 51 52 53 54 55" << endl
      << "56 57 58 59 60 61 62 63" << endl
 << endl;
};


