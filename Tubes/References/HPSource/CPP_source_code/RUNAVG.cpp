// Compute a running average of numbers
// entered by the user.
// for MinGW C++.

#include <iostream>

using namespace std;

int r_avg(int i);

main()
{
  int num;

  do {
    cout << "enter numbers (-1 to quit): ";
    cin >> num;
    cout << "running average is: " <<
    r_avg(num) << "\n";
  } while(num>-1);
}

int r_avg(int i)
{
  static int sum=0, count=0;
  sum = sum + i;
  count++;
  return sum / count;
}
