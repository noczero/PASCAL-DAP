// GCalc, for C++ compilers, web: http://rudih.info
#include <iostream>
#include <math.h>
#include <string.h>

using namespace std;

double num1, num2, radians;
char op[80];

main(){
     top:
     cout << "\nCalulator - Enter number: ";
     cin >> num1;
     cout << "Enter operator (+,-,*,/,sqr,cos,sin,tan): ";
     cin >> op;
     if(!strcmp(op,"sqr")){
         cout << sqrt(num1);
         goto top; };
     if(!strcmp(op,"cos")){
         radians = 3.141593 * (num1 / 180);
         cout << cos(radians);
         goto top; };
     if(!strcmp(op,"sin")){
         radians = 3.141593 * (num1 / 180);
         cout << sin(radians);
         goto top; };
     if(!strcmp(op,"tan")){
         radians = 3.141593 * (num1 / 180);
         cout << tan(radians);
         goto top; };
     cout << "Enter second number: ";
     cin >> num2;
     if (!strcmp(op,"+"))cout << (num1+num2);
     if (!strcmp(op,"-"))cout << (num1-num2);
     if (!strcmp(op,"*"))cout << (num1*num2);
     if (!strcmp(op,"/"))cout << (num1/num2);
     goto top;
}

