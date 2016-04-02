//Hex2decimal.
// for Borland C++, Visual C++.


#include <fstream.h>
#include <iostream.h>
#include <conio.h>

void main() {
  int TempNum;
  //Read it in as hex.
  cin >> hex >> TempNum;
  //Print it as decimal.
  cout << TempNum;
  while (!kbhit());
}
