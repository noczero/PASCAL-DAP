// Using an inline function to calculate
// the volume of a cube
#include <iostream.h>
#include <conio.h>

int main()
{
  cout << "Enter the side length of your cube: ";
  float side;
  float result;
  cin >> side;
  result=side*side*side;
  cout << "Volume of cube with side "
       << side << " is " << result << '\n';
  while (!kbhit());
}
