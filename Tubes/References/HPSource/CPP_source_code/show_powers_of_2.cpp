//  multi counters to show powers of 2
#include <iostream.h>
#include <iomanip.h>
#include <stdio.h>
int main()
{
	long i=0, power=0;
	const int MAX = 20;

	for(i=0, power=1; i<=MAX; i++, power+=power)
		cout << endl
		     << setw(10) << i << setw(10) << power; //loop statement

	cout << endl;
	getchar();
	return 0;
}