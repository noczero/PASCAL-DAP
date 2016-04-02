// conditional operator demo
#include <iostream.h>
#include <stdio.h>
int main()
{
	int nCakes = 1;

	cout << endl
		 << "We have " << nCakes << " cake" << ((nCakes>1)?"s.":".")
         <<endl;
	
	++nCakes;

	cout << endl
		 << "We have " << nCakes << " cake" << ((nCakes>1)?"s.":".")
         <<endl;

	getchar();
	return 0;
}