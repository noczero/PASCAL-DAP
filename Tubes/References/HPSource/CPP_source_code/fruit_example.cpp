// A simple example of a program
#include <iostream.h>
#include <stdio.h>
int main()
{
	int apples, oranges;       // declare variables
	int fruit;                 // 1 more

	apples = 5; oranges = 6;   // set values
	fruit = apples + oranges;  // get total

	cout << endl;              // output new line
	cout << "Oranges are not the only fruit... " << endl
		 << "- and we have " << fruit << " fruits in all.";
	cout << endl;              // output new line           

    getchar();                 // pause

	return 0;                  // exit to system
}