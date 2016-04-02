// Running average, for C++ compilers, web: http://rudih.info
#include <iostream>

using namespace std;

int count;
double usernumber, answer, total;

main(){
  cout << "---Running average---" << endl;
  do {
    cout << "Enter number or -1 to stop: ";
    cin >> usernumber;
    count++;
    total = total + usernumber;
    answer = total / count;
    cout << answer << endl;
  } while (usernumber >= 0);
  return 0;
};
