// Tyler Rhodes
// 12/8/99
// Special Numeric Function Program
// Implements different numeric functions, including:
//				factorial, perfect number, fibonacci sequence
//				gcf and lcm, and permutation and combinations


#include <iostream.h>
#include <conio.h>
#include <stdlib.h>
#include <assert.h>

// Function Prototypes

// FindGCF - returns gcf of num1 and num2
int FindGCF(int num1, int num2);

// FindLCM - returns lcm of num1 and num2
int FindLCM(int num1, int num2);

// Displays a Fibonacci Sequence up to term num
void ShowFiboSeq(int num);

// fact - returns the factorial of num
long double fact(int num);

// permutation - returns nPr
long permutation(int n, int r);

// combination - returns nCr
long combination(int n, int r);

// perfectNum - adds up the factors of num, and stores them in sum
void perfectNum(int num, int& sum);

// Get2Numbers - displays output message, and then inputs 2 intergers
void Get2Numbers(int& n1, int& n2, char* szString);

// Get1Number - display output and then input 1 integer
void Get1Number(int& n1, char* szString);

// MainMenuFunction - main loop, program branches out from here
void MainMenuFunction();

// TestForPerfectNumbers - Function that test for Perfect Numbers
void TestForPerfectNumbers();

// CalculateAFactorial - Factorial Function
void CalculateAFactorial();

// CalcPermorCombination - permutation and combination function 
void CalcPermorCombination();

// FibonacciSeq - Fibonacci Function
void FibonacciSeq();

// FindGCForLCM - GCF or LCM Function
void FindGCForLCM();

// ShowOptions - Option Function
void ShowOptions();

// SwitchChoice - call appropriate function based on choice
void SwitchChoice(int choice);

// End of Function Proto-types


int main()
{
	MainMenuFunction();

	return 0;
} // End of Main


//========================
//Function Definations


void FindGCForLCM()
// precondition: none
// postcondition: none
{
	int choice = -1;		// user entered choice
	int num1 = 0, num2 = 0;	// num1 and num2, store user's input

	// clrscr();
	do
	{
		Get1Number(choice, "\n\nFind (1)GCF or (2)LCM: ");
	} while(choice != 1 && choice != 2);
	
	Get2Numbers(num1, num2, "Enter 2 numbers greater than 0 seperated by a space: ");
	switch(choice)
	{
	case 1:
		cout << "The GCF of " << num1 << " and " << num2 << " is " << FindGCF(num1, num2) << endl;
		break;
	case 2:
		cout << "The LCM of " << num1 << " and " << num2 << " is " << FindLCM(num1, num2) << endl;
		break;
	} // end switch-case
	cout << "\nPress any key to continue..." << endl;
	getch();
}

void TestForPerfectNumbers()
// precondition: none
// postcondition: none
{
	int number = 0;		// number to test 
	int sum = 0;		// sum of factors
	// clrscr();
	cout << "\n\nTest For Perfect Number!\n";
	Get1Number(number, "Enter a valid integer greater than 0: ");
	perfectNum(number, sum);
	if(sum == number)
	{
		cout << " = " << number;
		cout << "\n" << number << " is a pefect number." << endl;
	}
	else
	{
		cout << " <> " << number;
		cout << "\n" << number << " is not a perfect number." << endl;
	} // end of if-else
	cout << "Press a key to continue..." << endl;
	getch();
} // end of TestForPerfectNumbers

void CalculateAFactorial()// Function tests for Factorial of a inputed number
// precondition: none
// postcondition: none
{
	int number = 0;				// number to find factorial of
	long double factorial = 0;	// factorial of number

	// clrscr();
	cout << "\n\nCalculate a Factorial!" << endl;
	Get1Number(number, "Enter a integer greater than 0: ");
	factorial = fact(number);
	cout << "The factorial of " << number << " is " << factorial << endl;
	cout << "Press a key to continue..." << endl;
	getch();
} // end of CalculateAFactorial

void CalcPermorCombination()
// precondition: none
// postcondition: none
{
	int n = 0, r = 0;		// n and r to find permutation of 
	int choice;				// input to store wheter to do a perm or comb
	long perm = 0;			// perm of n and r
	long comb = 0;			// comb of n and r
	do 
	{
		// clrscr();
		cout << "\n\nFind a (1)Permutation or (2)Combination: ";
		cin >> choice;
	} while(choice != 1 && choice != 2);
	switch(choice)
	{
	case 1:
		cout << "\nCalculate a a permutation!" << endl;
		Get2Numbers(n, r, "Enter n then r seperated by a space: ");
		perm = permutation(n, r);
		cout << n << " P " << r << " is " << perm << endl;
		break;
	case 2:
		cout << "\nCalculate a combination!" << endl;
		Get2Numbers(n, r, "Enter n then r seperated by a space: ");
		comb = combination(n, r);
		cout << n << " C " << r << " is " << comb << endl;
		break;
	} //end switch-case
	cout << "\nPress a key to continue..." << endl;
	getch();
} // end of CalcPermorCombination



void FibonacciSeq()
// precondition: none
// postcondition: none
{
	int limit = 0;		// upper limit to generete fibonacci sequence up to
	// clrscr();
	cout << "\n\nGenerate a Fibonacci Sequence!" << endl;
	do 
	{
		Get1Number(limit, "Enter an upper limit greater than 3: ");
	} while(limit < 3);
	ShowFiboSeq(limit);
	cout << "\nPress a key to continue..." << endl;
	getch();
} // end of FibonacciSeq

void ShowOptions()
// precondition: none
// postcondition: none
{
	cout << "\n\n\n\n Special Numberic Function \n";
	cout << "\n================================\n";
	cout << "(1) Test for Perfect Numbers\n";
	cout << "(2) Calculate a Factorial \n";
	cout << "(3) Calculate a Permutation or Combination \n";
	cout << "(4) Generate a Fibonacci Sequence\n";
	cout << "(5) Find a GCF or LCM \n";
	cout << "(6) Exit the Program\n";
	cout << "\n\nEnter your choice: ";
} // end of ShowOptions

void SwitchChoice(int choice)
// precondition: choice must contain have a valid integer value
// postcondition: none
{
	switch(choice)
	{
	case 1:
		TestForPerfectNumbers();
		break;
	case 2:
		CalculateAFactorial();
		break;
	case 3:
		CalcPermorCombination();
		break;
	case 4:
		FibonacciSeq();
		break;
	case 5:
		FindGCForLCM();
		break;
	case 6:
		cout << "\n\nProgram exiting...";
		exit(1);
	} // end switch-case
} // end of SwitchChoice

void MainMenuFunction()
// precondition: none
// postcondition: none
{
	int choice = -1;	// users choice inputed
	while(true)
	{
		// clrscr();
		ShowOptions();
		cin >> choice;
		if(choice)
			assert(choice);
		SwitchChoice(choice);
	} // end while
} // end of MainMenuFunction

void Get1Number(int& n1, char* szString)
// precondition: szString must be a valid array of characters
// postcondition: n1 will contain a positive integer value
{
	do 
	{
		cout << szString;
		cin >> n1;
		assert(n1);
	} while(n1 < 1);
} // end of Get1Number

void Get2Numbers(int& n1, int& n2, char* szString)
// precondition: szString must be a valid array of characters
// postcondition: n1 and n2 will contain positive integer values
{
	do 
	{
		cout << szString;
		cin >> n1 >> n2;
		assert(n1); 
		assert(n2);
	} while(n1 < 1 || n2 < 1);
} // end of Get2Numbers

void perfectNum(int num, int& sum)
// precondition: num must have a valid integer value
// postcondtion: sum will contain the sum of num's factors
{
	int temp = num-1;		// temporary number, so num will not change	
	while(temp)
	{
   		if(num % temp  == 0)
		{
      		if(temp != 1)
         		cout << temp << " + ";
			else
         		cout << temp;
			// end if-else
			sum += temp;
		} // end if
		temp--;
	} // end while
} // end of perfectNum

int FindGCF(int num1, int num2)
// precondition: num1 and num2 must be valid integer values
// postcondition: returns the gcf of num1 and num2
{
	int fact = num2;
	while(true) 
	{
		while(num2 % fact)
			fact--;
		if(num1 % fact == 0)
			break;
		fact--;
	}
	return fact;
} // end of FindGCF

int FindLCM(int num1, int num2)
// precondition: num1 and num2 must be valid integer values
// postcondition: returns the lcm of num1 and num2
{
	int lcm = (num1 * num2) / FindGCF(num1, num2);		// lcm of num1 and num2, found using formula
														// lcm = ab/gcf(a,b)
	return lcm;
} // end of FindLCM



void ShowFiboSeq(int num)
// precondition: num must be a valid integer value
// postcondition: none
{
	int a=1, b=1, c;		// a, b, c - store values of terms in Fibonacci sequence
	cout << a << " " << b << " ";
	num-=2;
	while(num--)
	{
   		c=a+b;
		cout << c << " ";
		a=b;
		b=c;
	} // end while
} // end of ShowFiboSeq


long double fact(int num)
// precondition: num must be a valid integer value
// postcondition: returns factorial of num
{
	long fact = 1;		// factorial of number
	if(num < 0) 
		return 0;
	while(num)
		fact *= num--;
	return fact;
} // end of fact

long permutation(int n, int r)
// precondtion: n and r must be valid integer values
// postcondition: n and r will not change, returns nPr
{
	long perm = 1, n2 = n;		// perm is permutation of n and r, n2 stores original value of n
	if(n < r) 
		return 0;
	while(n >= (n2-r+1))
		perm *= n--;
	return perm;
} // end of permutation


long combination(int n, int r)
// precondition: n and r must be valid integer values
// postcondition: n and r will not change, function returns nCr
{
	long comb = permutation(n, r) / fact(r);		// comb - combination of n and r, nCr	
	return comb;
} // end of combination