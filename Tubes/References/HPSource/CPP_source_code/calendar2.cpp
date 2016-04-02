//////////////////////////////////////////////////////////////////////////////////////////////
// console gregorian calender app. 
// (c) stoned coder 2001
// uses zeller's algorithm for finding the day for the date
//////////////////////////////////////////////////////////////////////////////////////////////
// details of algorithm are :-
//
// [x] = floor (x)
//
// f=k+[((13*m)-1)/5]+d+[d/4]+[c/4]-(2*c)
//
// where k=day of the month
//       m=month number march=1 jan=11 feb=12 etc.
//       d=last two digits of year.... if m=1 or m=2 d=d-1 (jan,feb treated as previous year)
//       c=first two digits of year i.e. number of centuries.
//
// once we have f we divide by 7 and take remainder.If negative add 7. remainder = day of the week
// 0=sunday 1=monday 6=saturday etc.
//////////////////////////////////////////////////////////////////////////////////////////////
// includes
#include <iostream>
#include <iomanip>
#include <cmath>
#include <windows.h>
#include <cstdlib>
// using statements
using namespace std;
// function prototypes
void clrscr();
void gotoxy(int,int);
// classes
class calender
{
public:
	calender(int d=1,int m=1,int y=2001); //defaults to 1/1/2001 (uk format dd/mm/yy)
	virtual ~calender() {} // do nothing destructor virtual in case of use of inheritance
	void printcalender();
	
private:
	bool isleapyear(); // returns true if year is leap
	int checkday(int); // checks legality of date
	int whatdayisfirstofmonth(); // returns 0 to 6 sunday to saturday
	int howmanydays(); // returns number of days in month
	int day;
	int month;
	int year;
};
//////////////////////////////////////////////////////////////////////////////////////////////
// constructor
//
// checks validity of date and sets members
//
//////////////////////////////////////////////////////////////////////////////////////////////
calender::calender(int d,int m,int y)
{
	
	if (y<1582) // church accepted gregorian calender in 1582
	{
		cout<<endl<<"The year "<<y<<" is before the gregorian calender was accepted by the church."
			<<"Setting to 2001."<<endl;
		year=2001; // invalid year so set to 2001
	}
	else
	{
		year=y; // y is valid so use it to set year
	}
	if ((m>=1) && (m<=12)) // check month between 1 and 12
	{
		month=m; // if it is set month
	}
	
	else
	{
		cout<<endl<<"The month "<<m<<" is invalid. Setting to month 1"<<endl;
		month=1;
	}
	day=checkday(d); // validate the day
}
//////////////////////////////////////////////////////////////////////////////////////////////
//
// isleapyear()
//
// checks whether year is a leap year in the gregorian calender
// a year is leap if it is divisable by four but not if divisible by 100
// unless it is divisible by 400
//
// returns true if leap and false if not
//
//////////////////////////////////////////////////////////////////////////////////////////////
bool calender::isleapyear()
{
	if ((year%400==0) || ((year %4==0) && (year%100 !=0)))
	{
		return true; // its a leap year
	}
	
	else
	{
		return false; // its not a leap year
	}
}
//////////////////////////////////////////////////////////////////////////////////////////////
//
// checkday(int)
//
// checks day is legal for month
//
// in:- day to be tested
//
// returns day if legal and 1 if not legal
//
//////////////////////////////////////////////////////////////////////////////////////////////
int calender::checkday(int testday)
{
	
	if ((testday>0) && (testday<= howmanydays()))
	{
		return testday; // day is valid for month
	}
	cout<<endl<<"Invalid day entered "<<testday<<"/"<<month<<"/"<<year
		<<". Setting to the first of the month."<<endl;
	return 1; // hopefully wont get here but if invalid day entered day is set to 1
}
//////////////////////////////////////////////////////////////////////////////////////////////
//
// int howmanydays()
//
// returns number of days in month
//
//////////////////////////////////////////////////////////////////////////////////////////////
int calender::howmanydays()
{
	if((month==2)&& isleapyear())
	{
		return 29; // feb has 29 days in a leap year
	}
	static const int daysinmonth[12]={31,28,31,30,31,30,31,31,30,31,30,31};
	return daysinmonth[month-1];
}
//////////////////////////////////////////////////////////////////////////////////////////////
//
// int whatdayisfirstofmonth()
//
// uses zeller's algorithm to find out what day the first of the month falls on falls on.
//
// returns 0 to 6 corresponding to sunday to saturday.
//
//////////////////////////////////////////////////////////////////////////////////////////////
int calender::whatdayisfirstofmonth()
{
	int c=year/100; // # of centuries
	int d=year%100; // # of years through century
	int m=(month+10)%12; // # of month march is 1,feb is 12
	int k=1; // set the day part to 1 so we get back the day for first of month
	if ((month==1)||(month==2))// treat jan and feb as if they were in previous year
	{
		if (d==0) // if d is 0 then to go back a year d becomes 99 and c become c-1
		{
			d=99;
			c-=1;
		}
		else
		{
		d-=1; // jan and feb are treated as previous year
		}
	}
	 float g=(k + (floor(((13*m)-1)/5)) + d + (floor(d/4)) + (floor(c/4)) - (2*c));
	 int f=static_cast<int>(g)%7; // cast result of algorithm to int to take modulus
	 if (f<0) // if negative add 7
	 {
		 f+=7;
	 }
	 return f; // returns 0 to 6 corresponding to sunday to saturday
}
//////////////////////////////////////////////////////////////////////////////////////////////
//
// void printcalender()
//
// prints the calender for the entered date
//
//////////////////////////////////////////////////////////////////////////////////////////////
void calender::printcalender()
{
	clrscr();
	cout<<"Date entered was :- "<<day<<"/"<<month<<"/"<<year<<endl;
	cout<<endl<<setw(8)<<"SUNDAY"<<setw(8)<<"MONDAY"<<setw(9)<<"TUESDAY"<<setw(11)<<"WEDNESDAY"<<setw(10)
		<<"THURSDAY"<<setw(8)<<"FRIDAY"<<setw(10)<<"SATURDAY"<<endl;
	int startday=whatdayisfirstofmonth();
	int endday=howmanydays();
	for (int i=0;i<startday;i++)
	{
		if (i==0) 
		{
			gotoxy(4,4);
			cout<<"-";
		}
		if (i==1)
		{
			gotoxy(12,4);
			cout<<"-";
		}
		if (i==2)
		{
			gotoxy(21,4);
			cout<<"-";
		}
		if (i==3)
		{
			gotoxy(31,4);
			cout<<"-";
		}
		if (i==4)
		{
			gotoxy(42,4);
			cout<<"-";
		}
		if (i==5)
		{
			gotoxy(50,4);
			cout<<"-";
		}
	} // end of for loop
	
	
	int rows=4;
	int count=1;
	for(int j=startday;j<(startday+endday);j++)
		{
		if(j%7==0)
		{ 
			rows+=2;
			gotoxy(4,rows);
		}
		if(j%7==1) gotoxy(12,rows);
		if(j%7==2) gotoxy(21,rows);
		if(j%7==3) gotoxy(31,rows);
		if(j%7==4) gotoxy(42,rows);
		if(j%7==5) gotoxy(50,rows);
		if(j%7==6) gotoxy(60,rows);
		if(count==day) // set text to bright red if count is the day entered
		{
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_INTENSITY|FOREGROUND_RED);
		}
		else
		{
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_INTENSITY|FOREGROUND_RED|FOREGROUND_BLUE|FOREGROUND_GREEN);
		}
		cout<<count;
		count ++;
	} // end of for loop
	cout<<endl<<endl<<endl;
}
//////////////////////////////////////////////////////////////////////////////////////////////
//
// void clrscr()
//
// clears the console window
//
// Thanks go to sunlight @ cprogramming.com
//
//////////////////////////////////////////////////////////////////////////////////////////////
void clrscr()
{
   COORD coordScreen = { 0, 0 };
   DWORD cCharsWritten;
   CONSOLE_SCREEN_BUFFER_INFO csbi;
   DWORD dwConSize;
   HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
   GetConsoleScreenBufferInfo(hConsole, &csbi);
   dwConSize = csbi.dwSize.X * csbi.dwSize.Y;
   FillConsoleOutputCharacter(hConsole, TEXT(' '), dwConSize, coordScreen, &cCharsWritten);
   GetConsoleScreenBufferInfo(hConsole, &csbi);
   FillConsoleOutputAttribute(hConsole, csbi.wAttributes, dwConSize, coordScreen, &cCharsWritten);
   SetConsoleCursorPosition(hConsole, coordScreen);
}
//////////////////////////////////////////////////////////////////////////////////////////////
//
// void gotoxy(int x,int y)
// 
// moves cursor to x,y in windows console
//
//////////////////////////////////////////////////////////////////////////////////////////////
void gotoxy(int x, int y) 
{ 
    COORD point; 
    point.X = x; point.Y = y; 
    SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),point); 
}
//////////////////////////////////////////////////////////////////////////////////////////////
//
// int main()
//
// entry point for program
//
// returns 0 back to the OS
//
//////////////////////////////////////////////////////////////////////////////////////////////
int main()
{
	
	while (1)
	{
	clrscr();
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_INTENSITY|FOREGROUND_RED|FOREGROUND_BLUE|FOREGROUND_GREEN);
	cout<<"Welcome to the gregorian calender calculator. v.1.00"<<endl<<endl
		<<"Use UK format.... day/month/full year. Use the '/' char to delimit your entry..."
		<<endl<<endl;
	cout<<"Please enter the date you would like to see the calender for :- ";
	char input_day[4];
	char input_month[4];
	char input_year[6];
	cin.getline(input_day,3,'/'); // get the input as strings
	cin.getline(input_month,3,'/');
	cin.getline(input_year,5,'\n');
	cout<<endl;
	int d=atoi(input_day); // convert input to integer
	int m=atoi(input_month);
	int y=atoi(input_year);
	calender date(d,m,y); // instantiate the calender object
	system("PAUSE"); // wait for a keypress
	date.printcalender(); // print the calender
	cout<<"Another calender (Y/N) ? ";
	char input[5];
	cin.getline(input,4);
	if ((input[0]=='N') || (input[0]=='n'))
	{
		break; // drop out of while loop
	}
	} // end of while loop
	
	return 0;
}
