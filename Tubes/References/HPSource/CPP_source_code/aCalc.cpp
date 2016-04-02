// for MinGW C++, http://rudih.info

#include <iostream>

using namespace std;

int main() {
   double num, den, result;
   char op;
   do {
      cout << "Calculator - Enter number: ";
      cin >> num;
      cout << "Enter operator +,-,*,/: ";
      cin >> op;
      cout << "Enter second number: ";
      cin >> den;
      if (op=='+') result=num+den;
      if (op=='-') result=num-den;
      if (op=='*') result=num*den;
      if (op=='/') result=num/den;
      cout << result << endl;
   }
   while (op!='e');
}
