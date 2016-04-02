// Leap year, for C++ compilers, web: http://rudih.info
void regularcalc();
void centurycalc();
#include <iostream>

using namespace std;

int year, modyear;

main(){
 loop1:
 cout << "Enter a year. 0 exits." << endl;
 cin >> year;
 modyear=year%100;
 if (modyear == 0){
     centurycalc();
   }
   else {
     regularcalc();
   };
   if (year!=0) goto loop1;
};

void regularcalc(){
 modyear=year%4;
 if (modyear == 0) {
    cout << "That year is a leap year." << endl;
    }
    else {
      cout << "That year is not a leap year." << endl;
    };
};

void centurycalc(){
 modyear=year%400;
 if (modyear == 0) {
    cout << "That year is a leap year." << endl;
    }
    else {
      cout << "Not even close to a leap year." << endl;
    };
};

