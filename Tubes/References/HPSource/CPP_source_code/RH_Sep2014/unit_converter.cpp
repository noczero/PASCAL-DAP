// Unit converter, for C++ compilers, web: http://rudih.info
#include <iostream>
#include <conio.h>

using namespace std;

double result, num;
int conv;

main(){
 do {
   cout << "---Unit converter---" << endl;
   cout << "Enter conversion type, or <0> to quit:" << endl;
   cout << "<1>inch-centimetre <2>centimetre-inch ";
   cout << "<3>foot-metre <4>metre-foot" << endl;
   cout << "<5>mile-kilometre <6>kilometre-mile" << endl;
   cout << "<7>pound-kilogram <8>kilogram-pound ";
   cout << "<9>ounce-gram <10>gram-ounce" << endl;
   cout << "<11>acre-metre square <12>metre square-acre" << endl;
   cout << "<13>pint-litre <14>litre-pint" << endl;
   cout << "<15>fahrenheit-celsius <16>celsius-fahrenheit" << endl;
   cin >> conv;
   if (conv<=0 || conv > 16) return 0;
   cout << "Enter unit measure: ";
   cin >> num;
   if (conv == 1) result = num * 2.54;           //to cent
   if (conv == 2) result = num * .393;           //to inch
   if (conv == 3) result = num * .348;           //to met
   if (conv == 4) result = num * 3.28;           //to foot
   if (conv == 5) result = num * 1.6093;         //to mile
   if (conv == 6) result = num * .625;           //to km
   if (conv == 7) result = num * .4536;          //to pound
   if (conv == 8) result = num * 2.2075;         //to kgram
   if (conv == 9) result = num * 28.3495;        //to oz
   if (conv == 10) result = num / 28.3495;       //to gram
   if (conv == 11) result = num * 4046.8;        //to acre
   if (conv == 12) result = num / 4046.8;        //to m2
   if (conv == 13) result = num * .568;          //to litre
   if (conv == 14) result = num / .568;          //to pint
   if (conv == 15) result = (num - 32) * 5 / 9;  //to cel
   if (conv == 16) result = (num * 9 / 5) + 32;  //to fah
   cout << "Result = " << result;
   cout << endl << "Press any key to continue...";
   cout << endl << endl;
   getch();
 }while (conv!=0);
}
