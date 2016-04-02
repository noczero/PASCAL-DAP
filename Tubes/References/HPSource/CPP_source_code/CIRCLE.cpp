// for Borland C++, Visual C++, Dev-C++.
// This program computes the circumference and
//   area of a cirle given its radius.

#include <iostream.h>
#include <conio.h>

int main()
{
  float radius;
  float circum;
  float area;
  cout << "enter radius: ";
  cin >> radius;
  circum=radius*3.1416;
  area=radius*radius*3.1416;
  cout << "circumference: " << circum << "\n";
  cout << "area: " << area << "\n";
  while (!kbhit());
}

