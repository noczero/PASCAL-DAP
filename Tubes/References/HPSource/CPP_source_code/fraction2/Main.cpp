
// Allow the integer type to be changed on the fly
#define BIGGEST_INT int

#include <iostream.h> // Include C++ input/output functions
#include <stdio.h>	  // Include C input/output functions
#include <conio.h>    // Include for pausing the program
#include <stdlib.h>   // Include C Library functions
#include "Fraction.h" // Includes the Fraction Header File
#include <msoftcon.h> // Allows more functionality to MVC++ console

int main() {
	Fraction a;
	Fraction b;
	Fraction c;
	int op;
	char opchar;

	init_graphics(); // Initialize graphics in msoftcon.h

	a.SetAll(1); // 1 indicates that it's the 1st Fraction
	b.SetAll(2); // 2 indicates that it's the 2nd Fraction

	cout << "Enter an operation to perform { + - / * } ";
	cin >> opchar;

	switch (opchar) {
	case '+':
		op = FRAC_ADD;
		break;
	case '-':
		op = FRAC_SUB;
		break;
	case '*':
		op = FRAC_MUL;
		break;
	case '/':
		op = FRAC_DIV;
		break;
	default: // If operator is illegal shut program down
		cout << "Invalid operator." << endl;
		return(0);
	}
	if((a.den == 0) || (b.den == 0)) // Fraction undefined if so
		cout << "\n\nFraction is undefined.";
	else { // Else Function can be worked with
		c = Fraction_Do_Op(op, a, b);
		cout << "\n\n";
		c.Reduce(); // Reduce to simplify Fraction
		cout << "Fraction value: " << c.num << "/" << c.den << endl;
		cout << "Decimal value: " << FracDecVal(c) << endl;
		c.DisplayMixed();
	}
	cout << "Press any key to continue" << endl;
	cout.flush();
	getch();
	return(0);
}