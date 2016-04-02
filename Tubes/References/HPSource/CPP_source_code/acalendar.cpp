


////////////////////////////////////////////////////////////////
//
//	Author: "CruZZAder"
//	Novermber 28, 2001
// You can use this code for learning purposes.
//
///////////////////////////////////////////////////////////////

/*  YOU MUST INDLUDE THE ABOVE BY COPYRIGHT LAW IF YOU CHANGE THIS CODE IN ANY
WAY!*/

#include <stdio.h>
// Will set values for statements.
int isleapyear(int x);
void printWeekHeader();
void printMonthHeader();
void printdays(int m);
int daystart;								//global
int year;                           //global
int main()
{
	printf("What year is it?:");//Asks the user to input info.
	scanf("%d",&year);//Receives input.
   printf("\n\nSunday  =0\n");
   printf("Monday  =1\n");
   printf("Tuesday =2\n");
   printf("Wednsday=3\n");
   printf("Thursday=4\n");
   printf("Friday  =5\n");
   printf("Saturday=6");
   printf("\n\nWhat is the first day of January?:");
   scanf("%d",&daystart);
   getchar();
	printMonthHeader();//Recalls the value for printMonthHeader.
   getchar();
}

void printWeekHeader()//Assigns value to the statement printWeekHeader.
{
	printf("Su Mo Tu We Th Fr Sa\n");//Print out letters.
}

int isleapyear (int x)//Function evaluates if leap year or not.
{


   if (year==0)//Evaluates if the number given is equal to zero it will return
	{					//a value of zero. Else the program will continue.
   	return 0;
   }
   else
   {
		if (year%100!=0 && year%4==0)//Determines that if a year is divisible by
      {                            	//400 it will return a value of 1.
     	  	return 1;
      }
		else if (year%400==0)// If false it will return a value of 1.
      {
   		return 1;
      }
      else//A value of zero is returned if we get this far.
   	{
   		return 0;
    	}

	}
}

void printdays(int m)//Assigns value to the statement printdays.
{
	int count=0, looplimit,i;//Declares and initializes variables.
   int x;
   int s[12]={31,28,31,30,31,30,31,31,30,31,30,31};

   if (m==1)//Sets a condition. If true it executes.
   {
   	x=isleapyear(year);
		looplimit=s[m]+x;//Assings s[m]=x to looplimit.
   }

   else//If the if statement is false this will be executed.
   {
		looplimit=s[m];//Assings s[m] to looplimit.
   }

	for (i=0;i<daystart;i++)//Sets a condition. Compares daystart and i.
   {
   	printf("   ");
      count++;//Count is increase once while condition true.
   }

   for (i=1;i<=looplimit;i++)//Condition will contunue to loop unill false.
   {
      printf("%2d ",i);//The results are printed two spaces reserved.
   	count ++;
      if ( count==7)//If statement true 0 is assigned to count.
      {
      	printf("\n");
         count=0;
      }
    }
    daystart=count;//Daystart is set equal to count.
    printf("\n");
}

void printMonthHeader()//Assigns value to the statement printMonthHeader.

{

   printf("January\n");//Prints out statement.
	printWeekHeader();//Recalls value for printWeekHeader.
   printdays(0);//Recalls value for printdays.
   					 //Assigns the first value in the string to January etc.
   printf("\n");
   getchar();//Program pauses after every month.
   printf("February\n");
   printWeekHeader();
   printdays(1);
   printf("\n");
   getchar();
   printf("March\n");
   printWeekHeader();
   printdays(2);
   printf("\n");
   getchar();
   printf("April\n");
   printWeekHeader();
   printdays(3);
   printf("\n");
   getchar();
   printf("May\n");
   printWeekHeader();
   printdays(4);
   printf("\n");
   getchar();
   printf("June\n");
   printWeekHeader();
   printdays(5);
   printf("\n");
   getchar();
   printf("July\n");
   printWeekHeader();
   printdays(6);
   printf("\n");
   getchar();
   printf("August\n");
   printWeekHeader();
   printdays(7);
   printf("\n");
   getchar();
   printf("September\n");
   printWeekHeader();
   printdays(8);
   printf("\n");
   getchar();
   printf("October\n");
   printWeekHeader();
   printdays(9);
   printf("\n");
   getchar();
   printf("November\n");
   printWeekHeader();
   printdays(10);
   printf("\n");
   getchar();
   printf("December\n");
   printWeekHeader();
   printdays(11);
   printf("\n");
}
//End.
