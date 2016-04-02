// nested loops to generate a multiplication table
#include <iostream.h>
#include <iomanip.h>
#include <stdio.h>
int main()
{
	const int SIZE =12;
	int i=0, j=0;

	cout << endl
		 << SIZE << " by " << SIZE
		 << " Multiplication Table" << endl << endl;
	cout << endl << "    |";
	for (i=1; i<=SIZE; i++)
        cout << setw(3) << i << "  ";

	cout << endl;
	for(i=0; i<=SIZE; i++)
		cout << "_____";

	for(i=1; i<=SIZE; i++)
	{
		cout << endl
			 << setw(3) << i << " |";
		
		for(j=1; j<=SIZE; j++)
			cout << setw(3) << i*j << "  ";
	}
	cout << endl;
	getchar();
	return 0;
}