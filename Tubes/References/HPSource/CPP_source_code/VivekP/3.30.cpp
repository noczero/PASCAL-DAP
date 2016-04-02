// Dev-C++ compatible

//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com


/*An electricity board charges the following rates to domestic
users to discourage large consumption of energy:
	For the first 100 units - 40p per unit
   For next 200 units		- 50p per unit
   Beyond 300 units			- 60p per unit
All users are charged a minimum of Rs.500.  If the total cost is
more than Rs.250.00 then an additional surcharge of 15% is added.
	Write a program to read the names of users and number of units
consumed and print out the charges with names.*/

#include <iostream.h>
#include <conio.h>
int main()
{
cout<<"\n\n\n\tElectricity Board Charges\n";
cout<<"\n\tTo Discourage Large Consumption of energy\n\n";



char name[20];
cout<<"\n\nEnter USER name :-";
cin>>name;

cout<<"\n\nEnter Number of Units Consumed:-";
float unit;
cin>>unit;

//MANIPULATION
float tc;
if(unit<=100)
	tc=unit*0.40;
else if(unit<=300)
	tc=unit*0.50;
else
	tc=unit*0.60;


float surchase=0;
if(tc>250)
	surchase=tc*0.15;

float total_cost;
total_cost = 500 + surchase + tc;

cout<<"\n\nYOUR BILL AMOUNT IS "<<total_cost;

getch();
}


