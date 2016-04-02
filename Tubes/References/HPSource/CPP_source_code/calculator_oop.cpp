/* There is no reason to use the stuff I did in this calculator.
I wrote the extra 150 lines of code just to piss off people reading this. */

#include <iostream>
#include <cmath>

using namespace std;
typedef unsigned short int USSI;

class Calculator {
public:
    float GetAdd();
    float GetAdd2();
    float GetSub();
    float GetSub2();
    float GetMul();
    float GetMul2();
    float GetDiv();
    float GetDiv2();
    double GetExp();
    void SetAdd (float var1, float var2);
    void SetAdd2 (float var3, float var4);
    void SetSub (float var1, float var2);
    void SetSub2 (float var3, float var4);
    void SetMul (float var1, float var2);
    void SetMul2 (float var3, float var4);
    void SetDiv (float var1, float var2);
    void SetDiv2 (float var3, float var4);
    void SetExp (double var1, double var2);
private:
    float ItsAdd;
    float ItsAdd2;
    float ItsSub;
    float ItsSub2;
    float ItsMul;
    float ItsMul2;
    float ItsDiv;
    float ItsDiv2;
    double ItsExp;
};

float Calculator::GetAdd() {       
    return ItsAdd;
}

float Calculator::GetAdd2() {
    return ItsAdd2;
}

float Calculator::GetSub() {
    return ItsSub;
} 

float Calculator::GetSub2() {
    return ItsSub2;
}  

float Calculator::GetMul() {
    return ItsMul;
}     

float Calculator::GetMul2() {
    return ItsMul2;
}

float Calculator::GetDiv() {
    return ItsDiv;
}    

float Calculator::GetDiv2() {
    return ItsDiv2;
}

double Calculator::GetExp() {
    return ItsExp;
}
    
void Calculator::SetAdd(float var1, float var2) {
    ItsAdd = var1 + var2;
}

void Calculator::SetAdd2(float var3, float var4) {
    ItsAdd2 = var3 + var4;
}

void Calculator::SetSub(float var1, float var2) {
    ItsSub = var1 - var2;
}

void Calculator::SetSub2(float var3, float var4) {
    ItsSub2 = var3 - var4;
}

void Calculator::SetMul(float var1, float var2) {
    ItsMul = var1 * var2;
}   

void Calculator::SetMul2(float var3, float var4) {
    ItsMul2 = var3 * var4;
}

void Calculator::SetDiv(float var1, float var2) {
    ItsDiv = var1/var2;
} 

void Calculator::SetExp(double var1, double var2) {
     ItsExp = pow(var1,var2);
}        
                  
int main() {
USSI looper = 1;
    while (looper==1) {
        cout << "SuperUberDOS-Calculator v0.02\n"
        << "***********************\n"
        << "1. Addition\n"
        << "2. Subtraction\n"
        << "3. Multiplication\n"
        << "4. Division\n"
        << "5. Exponents\n"
        << "9. Quit\n" << endl;
        int Option;
        cin >> Option;
        
        if (Option == 1) {
           Calculator Compute;           
           float var1, var2;
           cout << "First number: ";
           cin >> var1;
           cout << "Second number: ";
           cin >> var2;
           Compute.SetAdd(var1, var2);
           float var3 = Compute.GetAdd();
           cout << var3 << endl;
           cout << "Would you like to add more numbers"
           << " to this? (1 - yes, 2 - no)" << endl;
           USSI third_num;
           cin >> third_num;
           if (third_num == 1) {
                 cout << "You have chosen to use more numbers." 
                 << "Enter '0' at any time to quit. Enter the "
                 << "numbers you wish to use." << endl;
                 while (third_num == 1) {
                      float var4;
                      cin >> var4;
                    if (var4==0) {
                           third_num = 0;
                    }
                    else {
                         Compute.SetAdd2(var3, var4);
                         var3 = Compute.GetAdd2();
                         cout << var3 << endl;
                         cout << "\nNext number: ";
                    }
                }
            }
        }
        else
           if (Option == 2) {
               Calculator Compute;
               float var1, var2;
               cout << "First number: ";
               cin >> var1;
               cout << "Second number: ";
               cin >> var2;
               Compute.SetSub(var1, var2);
               float var3 = Compute.GetSub();
               cout << var3 << endl;
               cout << "Would you like to subtract more numbers"
               << " to this? (1 - yes, 2 - no)" << endl;
               USSI third_num;
               cin >> third_num;
           if (third_num == 1) {
                 cout << "You have chosen to use more numbers." 
                 << "Enter '0' at any time to quit. Enter the "
                 << "numbers you wish to use." << endl;
                 while (third_num == 1) {
                      float var4;
                      cin >> var4;
                    if (var4==0) {
                           third_num = 0;
                    }
                    else {
                         Compute.SetSub2(var3, var4);
                         var3 = Compute.GetSub2();
                         cout << var3 << endl;
                         cout << "\nNext number: ";
                         }
                    }
               }
           }
           else
              if (Option == 3) {
                   Calculator Compute;
                   float var1, var2;
                   cout << "First number: ";
                   cin >> var1;
                   cout << "Second number: ";
                   cin >> var2;
                   Compute.SetMul(var1, var2);
                   float var3 = Compute.GetMul();
                   cout << var3 << endl;
                   cout << "Would you like to multiply more numbers"
                   << " to this? (1 - yes, 2 - no)" << endl;
                   USSI third_num;
                   cin >> third_num;
                   if (third_num == 1) {
                      cout << "You have chosen to use more numbers." 
                      << "Enter '0' at any time to quit. Enter the "
                      << "numbers you wish to use." << endl;
                      while (third_num == 1) {
                         float var4;
                         cin >> var4;
                         if (var4==0) {
                             third_num = 0;
                         }
                         else {
                             Compute.SetMul2(var3, var4);
                             var3 = Compute.GetMul2();
                             cout << var3 << endl;
                             cout << "\nNext number: ";
                    }
                }
            }
        }
              else
                 if (Option == 4) {
                       Calculator Compute;
                       float var1, var2;
                       cout << "First number: ";
                       cin >> var1;
                       cout << "Second number: ";
                       cin >> var2;
                       Compute.SetDiv(var1, var2);
                       float var3 = Compute.GetDiv();
                       cout << var3 << endl;
                 }
                 else
                    if (Option == 5) {
                           Calculator Compute;
                           double var1, var2;
                           cout << "First number: ";
                           cin >> var1;
                           cout << "Second number: ";
                           cin >> var2;
                           Compute.SetExp(var1, var2);
                           double var3 = Compute.GetExp();
                           cout << var3 << endl;
                     }
                     else
                        if (Option == 9) {
                           break;
                           }
                        else
                           cout << "That is not an option! >:(\n" << endl;                     
   }                               
    return 0;
}      
