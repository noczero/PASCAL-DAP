// Justin C. Miller
// University of Wisconsin Oshkosh
// Made for: http://www.geocities.com/neonprimetime.geo/index.html
// Date: 2001
// Borland Builder 4.0
// Beginner's Excercise
// Description: Calculate the approximate
//				number of days you have
//				been alive (ignore leap year)
//				Multiply your age in years
//				by 365 and add in the number
//				of days from your birthday
//				to today's date

#include <iostream.h>

// global variable holds the number of days in each month
// [1] = January, [2] = February ..... [12] = December
int months[13] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31} ;

int main()
{
	int tyear, tday, tmonth ;
	cout << "What is today's date?" << endl ;
	cout << "Please enter the year..." ;
	cin >> tyear ;
	cout << "Please enter the month..." ;
	cin >> tmonth ;
	cout << "Please enter the day..." ;
	cin >> tday ;

	int byear, bday, bmonth ;
	cout << "What is your birthday?" << endl ;
	cout << "Please enter the year..." ;
	cin >> byear ;
	cout << "Please enter the month..." ;
	cin >> bmonth ;
	cout << "Please enter the day..." ;
	cin >> bday ;

	int days = 0 ;
	
	// converted the months/days into just days
	// so for example : feb 2 would be the 33rd day
	//					 (31 + 2)
	//					march 3 would be the 62nd day
	//					(31 + 28 + 3)
	int newtoday = 0 ;
	for(int j = 1 ; j < tmonth ; j++)
		newtoday = newtoday + months[j] ;
	newtoday = newtoday + tday ;

	int newbday = 0 ;
	for(int i = 1 ; i < bmonth ; i++)
		newbday = newbday + months[i] ;
	newbday = newbday + bday ;

	// the following is TRICKY CODE
	// calculating the number of days alive
	if(newtoday >= newbday)
	{
		while(tyear > byear)
		{	
			days = days + 365 ;
			byear++ ;
		}
		days = days + ( newtoday - newbday) ;
	}
	else
	{
		while(tyear > (byear + 1))
		{
			days = days + 365 ;
			byear++ ;
		}
		days = days + (365 - newbday + newtoday) ;
	}

	cout << "You've been alive approximately " << days << " days." << endl ;

	return 0 ;
}


