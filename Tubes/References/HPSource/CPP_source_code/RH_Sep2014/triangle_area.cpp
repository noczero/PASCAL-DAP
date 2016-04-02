// Triangle area, for C++ compilers, web: http://rudih.info
#include <iostream>
#include <math.h>
#include <conio.h>

using namespace std;

double x, y, angle, radians;
main(){
     cout << "\n---Triangle Area---\nEnter x: ";
     cin >> x;
     cout << "Enter y: ";
     cin >> y;
     cout << "Enter angle: ";
     cin >> angle;
     radians = 3.141593 * (angle / 180);
     cout << "The area is: "
          << x * y * sin(radians) / 2;
     getch();
}

