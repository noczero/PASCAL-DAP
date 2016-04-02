// case actions
#include <iostream.h>
#include <stdio.h>
int main()
{
	char Letter = 0;
	cout << endl
		 << "Enter a small letter: ";
	cin >> Letter;

	switch(Letter*(Letter>='a' && Letter <='z'))
	{
	    case 'a':
		case 'e':
		case 'i':
		case 'o':
		case 'u': cout << endl << "You entered a vowel.";
			      break;

		case 0: cout << endl << "It is not a small letter.";
			    break;

		default: cout << endl << "You entered a consonant.";
	}
	cout << endl;
	getchar();
	return 0;
}