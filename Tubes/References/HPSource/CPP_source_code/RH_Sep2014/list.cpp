// List, for C++ compilers, web: http://rudih.info
#include <iostream>
#include <fstream>
#include <conio.h>

using namespace std;

char filen[100], ch;

main() {
  cout << "Enter file to list: ";
  cin >> filen;
  ifstream in(filen);
  if (!in) {
     cout << "Error";
     getch();
     return 1;
     }
  while (in.get(ch)) cout << ch;
  in.close();
  cout << "Press any key to exit...";
  getch();
  return 0;
}
