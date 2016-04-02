#include <iostream>
#include <math.h>
using namespace std;

void area_of_circle(double r) {
     double a;
     a = r * r * 3.1415926;
     cout << "The area is " << a << "\n";
     }

void area_of_triangle(double b, double h) {
     double a;
     a = b * h / 2;
     cout << "The area is " << a << "\n";
     }

void area_of_cube(double s) {
     double a;
     a = s * s * s;
     cout << "The area is " << a << "\n";
     }
     
void average(int n) {
     double sum = 0;
     for (int i = 1; i <= n; ++i) {
         cout << "Enter number " << i << " of " << n << ": ";
         double num;
         cin >> num;
         sum = sum + num;
         }
     cout << "The average is: " << sum / n << ".\n";
     }

void sum(int n) {
     double sum = 0;
     for (int i = 1; i <= n; ++i) {
         cout << "Enter number " << i << " of " << n << ": ";
         double num;
         cin >> num;
         sum = sum + num;
         }
     cout << "The sum is: " << sum << ".\n";
     }
     
void subtract() {
     cout << "Enter the first number to subtract: ";
     double one;
     cin >> one;
     cout << "Enter the second number: ";
     double two;
     cin >> two;
     double sum = one - two;
     cout << "The difference is " << sum << "\n";
     }
     
void multiply() {
     cout << "Enter the first number to multiply: ";
     double one;
     cin >> one;
     cout << "Enter the second number: ";
     double two;
     cin >> two;
     double sum = one * two;
     cout << "The product is " << sum << "\n";
     }

void divide() {
     cout << "Enter the first number to divide: ";
     double one;
     cin >> one;
     cout << "Enter the second number: ";
     double two;
     cin >> two;
     double sum = one / two;
     cout << "The quotient is " << sum << "\n";
     }

void square(double sqr) {
     double sum = sqr * sqr;
     cout << "The square of " << sqr << " is: " << sum << "\n";
     }
     
void ptheorem(int choice) {
     switch (choice) {
     case 1: 
                  cout << "Enter the first number: ";
                  {
                  double one;
                  cin >> one;
                  cout << "Enter the second number: ";
                  double two;
                  cin >> two;
                  double sum = sqrt (one * one + two * two);
                  cout << "The hypotenuse is " << sum << " units long\n";
                  }
                  break;
     case 2:
          cout << "Enter the value of the hypotenuse: ";
          {
          double hyp;
          cin >> hyp;
          cout << "Enter the value of the leg: ";
          double leg;
          cin >> leg;
          double sum = sqrt (hyp * hyp - leg * leg);
          cout << "The leg is " << sum << " units long\n";
          }
          break;
     }
     }

void factorial (int n) {
     int sum = 1;
     for (int m = 1; m <= n; ++m)
     {
         sum = sum * m;
     }
     cout << "The factorial is: " << sum << ".\n";
}

void display_menu() {
     cout << "Choose which area you would like to calculate:\n";
    cout << "1. Area of a circle\n";
    cout << "2. Area of a triangle\n";
    cout << "3. Area of a cube\n";
    cout << "4. Average of numbers\n";
    cout << "5. Sum of numbers\n";
    cout << "6. Subtract 2 numbers\n";
    cout << "7. Multiply 2 numbers\n";
    cout << "8. Divide 2 numbers\n";
    cout << "9. The square of a number\n";
    cout << "10. The square root of a number\n";
    cout << "11. The pythagorean theorem\n";
    cout << "12. The factorial of a number\n";
    cout << "Pick a number: ";
    int choice;
    cin >> choice;
        
    switch (choice) {
           case 1:
                cout << "Enter the radius of the circle: ";
                double num;
                cin >> num;
                area_of_circle(num);
                break;
           case 2:
                cout << "Enter the base of the triangle: ";
                double base;
                cin >> base;
                cout << "Enter the height of the triangle: ";
                double height;
                cin >> height;
                area_of_triangle(base, height);
                break;
           case 3:
                cout << "Enter a side length of the cube: ";
                double side;
                cin >> side;
                area_of_cube(side);
                break;
           case 4:
                cout << "How many numbers do you want to calculate the average of?: ";
                int avg;
                cin >> avg;
                average(avg);
                break;
           case 5:
                cout << "How many numbers do you want to calculate the sum of?: ";
                int sm;
                cin >> sm;
                sum(sm);
                break;
           case 6:
                subtract();
                break;
           case 7:
                multiply();
                break;
           case 8:
                divide();
                break;
           case 9:
                cout << "Enter the number you would like to square: ";
                {
                double sqr;
                cin >> sqr;
                square(sqr);
                }
                break;
           case 10:
                cout << "Enter the number you want to find the Square Root of: ";
                {
                double sr;
                cin >> sr;
                double total = sqrt (sr);
                cout << "The square root is " << total << "\n";
                }
                break;
           case 11:
                cout << "Do you have the values of: \n";
                cout << "1. Both of the legs\n";
                cout << "2. A leg and the hypotenuse\n";
                {
                int sel;
                cin >> sel;
                ptheorem(sel);
                }
                break;
           case 12:
                cout << "Enter the number you want to find the factorial of: ";
                int fact;
                cin >> fact;
                factorial(fact);
                break;
    }
    
    if (choice > 12) {
       cout << "You can't do that, you must choose a number from 1 to 11: ";
       cin >> choice;
       } 
    else {}
    
    string answer;
    cout << "Would you like to make another calculation? (Y|N): ";
    cin >> answer;
    if (answer == "y") {
              display_menu();
              }
    else {}
}
int main () {
    display_menu();
                   }
