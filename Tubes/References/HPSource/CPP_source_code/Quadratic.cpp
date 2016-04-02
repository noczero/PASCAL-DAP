#include <cstdlib>
#include <iostream>
#include<math.h>
#include <conio.h>
using namespace std;

int main(int argc, char *argv[])
{
    float a,b,c,root1,root2,delta;
    cout<<"Enter three numbers a,b,& c of "<<"ax^2+ bx+ c:";
    cin>>a>>b>>c;
    if(!a)
    cout<<"Value of a should not be zero"<<"Aborting!!!!!!"<<"\n";
    else
    {
        delta=b*b-4*a*c;
        if (delta>0)
        {
         root1=(-b+sqrt(delta))/(2*a);
         root2=(-b-sqrt(delta))/(2*a);
         cout<<"Roots are real and unequal"<<"\n";
         cout<<"Root1"<<root1<<"\n";
         cout<<"Root2"<<root2<<"\n";
        }
         else 
         cout<<"Roots are complex and imaginary"<<"\n";
    }
   getch();
   return 0;      
    
}
