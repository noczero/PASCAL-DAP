// Arithmetic Questioner, for C++ compilers, web: http://rudih.info
#include <stdlib.h>
#include <iostream>
#include <time.h>

using namespace std;

int num, den, operat, division, user, result, upperadd, uppermul;

int main() {
   cout << "Arithmetic Questioner - enter a negative number to quit"
   << endl << endl; // Show name and usage note
   cout << "Set greatest number to add or subtract (1-15990): ";
   cin >> upperadd;
   if (upperadd <= 0) return 0; // potential exit
   cout << "Set greatest number to multiply or divide (1-178): ";
   cin >> uppermul;
   if (uppermul <= 0) return 0;
   if (uppermul > 178 || upperadd > 15990) cout << "Number too large error"
   << endl; // display error message when appropriate
   srand( (unsigned)time( NULL ) ); // start randomizer function
   user=1; // initialize user
   while (user >= 0) { // beginning of loop
         cout << endl;
         num = rand() % 32000; // get random integers
         den = rand() % 32000;
         operat = rand() % 4; //get operator
         if (operat < 2) { // less than 2 is add or subtract
             num = num % upperadd; den = den % upperadd; // modulo divisions
             if (den >= num) {  //avoid negative responses
                 operat = 0; // set operat
                 cout << num << " + " << den << " = ";
             }
             else {
                 operat = 1;
                 cout << num << " - " << den << " = ";
             };
         };
         if (operat == 2) { // 2 is multiply
              num = num % uppermul; den = den % uppermul;
	          den++; num++;
              cout << num << " * " << den << " = ";
         };
         if (operat == 3) { // 3 is divide
            num = num % uppermul; den = den % uppermul;
	        den++; num++; // avoid division by 0
            division = num * den; // get division to reverse
            cout << division << " / " << den << " = ";
         };
         cin >> user;  // get user input
         if (operat == 0) {
            result = num + den; // calculate result
   	        if (user == result) cout << "Correct";
            else cout << "Incorrect, it's " << result; // provide feedback
         };
         if (operat == 1) {
		    result = num - den;
		    if (user == result) cout << "Correct";
		    else cout << "Incorrect, it's " << result;
	     };
	     if (operat == 2) {
	     	result = num * den;
	      	if (user == result) cout << "Correct";
	       	else cout << "Incorrect, it's " << result;
       	 };
	     if (operat == 3) {
	     	result = division / den;
	     	if (user == result) cout << "Correct";
	      	else cout << "Incorrect, it's " << result;
	     };
   };
return 0;
} // end of program
