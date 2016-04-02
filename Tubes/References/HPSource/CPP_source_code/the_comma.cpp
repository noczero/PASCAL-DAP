// exercising the comma opertaor
#include <iostream.h>
#include <stdio.h>
int main()
{
	long num1=0, num2=0, num3=0, num4=0;

	num4 = (num1=10, num2=20, num3=30);
	cout << endl
		 << "The value of a series of expressions "
		 << "is the value of the right most: "
		 << num4
	     << endl;

	getchar(); // wait for enter pressed

	return 0;
}