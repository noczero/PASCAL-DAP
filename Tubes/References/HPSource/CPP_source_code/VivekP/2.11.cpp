// Dev-C++ compatible
//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com

/* Write a C++ program that will ask for a temperature in Fahrenheit
and display it in Celsius. */
// FORMULA      C = F-32 / 1.8 //
//----------------------------//

#include<conio.h>
#include<iostream.h>
int main()
{
float f,c;
cout<<"Enter Fahrenheit degree to find temperature in celsius: ";
cin>>f;
c = (f-32)/1.8;
cout<<"\n\n\tCELSIUS DEGREE = "<<c;
getch();
}

