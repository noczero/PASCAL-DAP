// Justin C. Miller
// University of Wisconsin Oshkosh
// Made for: http://www.geocities.com/neonprimetime.geo/index.html
// Date: 2001
// Borland Builder 4.0// to change from farhenheit to celsius
#include <iostream.h>
int main()
{
	double celsius ;
	double fahrenheit ;
	cout << "Please enter a Fahrenheit temp and I'll change it to Celsius!" << endl;
	cin >> fahrenheit;
	celsius = (fahrenheit - 32.0) * (5.0/9.0);
	cout << fahrenheit << " degrees Fahrenheit = " << celsius << " degrees Celsius" << endl;
	return 0;
}