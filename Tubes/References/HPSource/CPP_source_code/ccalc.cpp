#include <iostream.h>
#include <stdlib.h>

double Add (double x, double y)
{
	cout << x << " + " << y << " = ";
	return (x+y);
}

double Multiply (double x, double y)
{
	cout << x << " * " << y << " = ";
	return(x*y);
}

double Subtract (double x, double y)
{
	cout << x << " - " << y << " = ";
	return(x-y);
}

double Divide (double x, double y)
{
	cout << x << " / " << y << " = ";
	return(x/y);
}

double Count (double x, double y)
{
	if (x > y)
	{
		cout << y << endl;
		for (double i = y; i<x; cout << ++i << endl);
	}
		else if (x < y)
	{
		cout << y << endl;
		for (double j = y; j>x; cout << --j << endl);
	}
		return 0;
}


double main()
{
	double firstNumber;
	double secondNumber;
	int operand;
	char Restart;

	cout << "Calculator Adds, Subtracts, Multiplies, Divides and Counts" << endl;
	cout << "Enter First Number:\n";
	cin >> firstNumber;
	cout << "\n";
	
	cout << "Enter Second Number:\n";
	cin >> secondNumber;
	cout << "\n";

	cout << "\n(1)Add, (2)Subtract, (3)Multiply, (4)Divide, (5)Count:" << endl;
		cin >> operand;

	cout << "\n\nThe Answer is:\n\n";
	switch (operand)
	{
		case 1:
			cout << Add(firstNumber, secondNumber);
			break;
		case 2:
			cout << Subtract(firstNumber, secondNumber);
			break;
		case 3:
			cout << Multiply(firstNumber, secondNumber); 
			break;
		case 4:
			cout << Divide(firstNumber, secondNumber);
			break;
		case 5:
			cout << Count(secondNumber, firstNumber);
			break;
	}

	cout << "\n\n(R)restart, (E)exit\n";
		cin >> Restart;
	switch (Restart)
	{
		case 'r':
			system("CLS");
			return main();
			break;
		case 'e':
			return 0;
			break;
	}
	return 0;
}

