// Demonstration of variable scope.
#include <iostream.h>
#include <stdio.h>
int main()
{
	int count1 = 10;
	int count3 = 50;
	cout << endl
		 << "Value of outer count1 = " << count1;
	
	{
		int count1 = 20;
		int count2 = 30;
		cout << endl
			 << "Value of inner count1 = " << count1;
		count1 += 3;
		count3 += count2;
	}

	cout << endl
		 << "Value of outer count1 = " << count1
		 << endl
		 << "Value of outer count3 = " << count3
         << endl;

	getchar();
	return 0;
}
