// Justin C. Miller
// University of Wisconsin Oshkosh
// Made for: http://www.geocities.com/neonprimetime.geo/index.html
// Date: 2001
// Borland Builder 4.0
// this program takes a date entered with numbers
// by the user and prints it out
// in a decent format using words

#include <iostream.h>
#include <stdlib.h>
#include <conio.h>

void Error(int, char*) ;
void PrintDate(int, int, int) ;

char * months[13] = { "", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"} ;

int main()
{
	int  month, day, year ;
	char dummy ;
	while(true){
		cout << "(Please enter -1 to exit)" << endl ;
		cout << "(Please enter a date in mm/dd/yyyy format)" << endl ;
		cin >> month ;
		if(month == -1) break ;
		cin >> dummy >> day >> dummy >> year ;
		
		PrintDate(month, day, year) ;
		getch() ;
		system("cls") ;
	}

	return 0 ;
}

void Error(int t, char * s)
{
	cout << "Fatal Error: " << t << s << endl ;
	exit(1) ;
}
void PrintDate(int month, int day, int year)
{
	if(month > 12 || month < 0)
		Error(month, " is an invalid month") ;

	if(day > 31 || day < 0)
		Error(day, " is an invalid day") ;

	if(year < 0)
		Error(year, " is an invalid year") ;

	cout << months[month] << " " << day << ", " << year << endl ;
}