// Arithmetic Questioner, R. Horne, web: http://rudih.info
// public domain, for C++ compilers, rev 3
#include <stdlib.h>
#include <iostream>
#include <time.h>

using namespace std;

int numb1, numb2, numb3, numb4, operat, division;
int user, result, maxadd, maxmul, numoperan; // variables

int main() {
   cout << "Arithmetic Questioner - enter a negative number to quit"
   << endl << endl; // Show name and usage note
   cout << "Set max number of operands per question (2-4): ";
   cin >> numoperan;
   if (numoperan <= 1) return 0; // potential exit
   if (numoperan == 2) {maxadd = 16350; maxmul = 180;}; // ~ squareroot of int
   if (numoperan == 3) {maxadd = 10850; maxmul = 31;};
   if (numoperan == 4) {maxadd = 8150; maxmul = 13;};
   cout << "Set max number to add or subtract (1-" << maxadd << "): ";
   cin >> maxadd;
   if (maxadd <= 0) return 0;
   cout << "Set max number to multiply or divide (1-" << maxmul <<"): ";
   cin >> maxmul;
   srand( (unsigned)time( NULL ) ); // start randomizer function
   user = 1; // initialize user
   while (user >= 0) { // beginning of loop
         cout << endl;
         operat = rand() % 4; // get operator
         if (operat < 2) { // less than 2 is add or subtract
             numb1 = rand() % maxadd; // get operands and modulo divide
             numb2 = rand() % maxadd;
             numb3 = rand() % maxadd;
             numb4 = rand() % maxadd;
             if (operat == 0) {
                        cout << numb1 << " + " << numb2;
                        if (numoperan > 2) cout << " + " << numb3;
                        if (numoperan > 3) cout << " + " << numb4;
                        cout << " = ";
             };
             if (operat == 1) {
                        numb1 = numb1 * 2;
                        while (numb2 + numb3 + numb4 > numb1) {
                              numb2 = rand() % maxadd; // avoid neg answer
                              numb3 = rand() % maxadd;
                              numb4 = rand() % maxadd;
                              };
                        while (numb3 + numb4 > numb2) {
                              numb3 = rand() % maxadd;
                              numb4 = rand() % maxadd;
                              };
                        while (numb4 > numb3) {
                              numb4 = rand() % maxadd;
                              };
                        cout << numb1 << " - " << numb2;
                        if (numoperan > 2) cout << " - " << numb3;
                        if (numoperan > 3) cout << " - " << numb4;
                        cout << " = ";
             };
         };
         if (operat == 2) { // 2 is multiply
            numb1 = rand() % maxmul;
            numb2 = rand() % maxmul;
            numb3 = rand() % maxmul;
            numb4 = rand() % maxmul;
            cout << numb1 << " * " << numb2; // similar code to addition
            if (numoperan > 2) cout << " * " << numb3;
            if (numoperan > 3) cout << " * " << numb4;
            cout << " = ";
         };
         if (operat == 3) { // 3 is divide
            numb1 = rand() % maxmul;
            numb1++;
            numb2 = rand() % maxmul;
            numb2++;
            numb3 = rand() % maxmul;
            numb3++;
            numb4 = rand() % maxmul;
            numb4++;
            if (numoperan == 2) division = numb1 * numb2; // reverse of answer
            if (numoperan == 3) division = numb1 * numb2 * numb3;
            if (numoperan == 4) division = numb1 * numb2 * numb3 * numb4;
            cout << division << " / " << numb2;
            if (numoperan > 2) cout << " / " << numb3;
            if (numoperan > 3) cout << " / " << numb4;
            cout << " = ";
         };
         cin >> user;  // get user input
         if (operat == 0) {
            if (numoperan == 2) result = numb1 + numb2;
            if (numoperan == 3) result = numb1 + numb2 + numb3;
            if (numoperan == 4) result = numb1 + numb2 + numb3 + numb4;
   	        if (user == result) cout << "Correct";
            else cout << "Incorrect, it's " << result; // provide feedback
         };
         if (operat == 1) {
            if (numoperan == 2) result = numb1 - numb2;
            if (numoperan == 3) result = numb1 - numb2 - numb3;
            if (numoperan == 4) result = numb1 - numb2 - numb3 - numb4;
   	        if (user == result) cout << "Correct";
            else cout << "Incorrect, it's " << result;
         };
	     if (operat == 2) {
            if (numoperan == 2) result = numb1 * numb2;
            if (numoperan == 3) result = numb1 * numb2 * numb3;
            if (numoperan == 4) result = numb1 * numb2 * numb3 * numb4;
   	        if (user == result) cout << "Correct";
            else cout << "Incorrect, it's " << result;
       	 };
	     if (operat == 3) {
            if (numoperan == 2) result = division / numb2;
            if (numoperan == 3) result = division / numb2 / numb3;
            if (numoperan == 4) result = division / numb2 / numb3 / numb4;
   	        if (user == result) cout << "Correct";
            else cout << "Incorrect, it's " << result;
	     };
   };
   return 0;
} // end of program
