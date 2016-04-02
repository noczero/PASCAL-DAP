// Using the extended if
#include <iostream.h>
#include <stdio.h>
int main()
{
	long number =0;
	cout << endl
	     << "Enter an integer number less than 2 billion: ";
    cin >> number;
	
	if(number%2L) // div by 2 to get remainder
		cout << endl
		     << "Your number is odd." << endl;
	else
		cout << endl
		     << "Your number is even." << endl;
    getchar();
	return 0;
}