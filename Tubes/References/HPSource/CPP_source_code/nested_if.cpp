// A nested if demonstration
#include <iostream.h>
#include <stdio.h>
int main()
{
	char letter = 0;

	cout << endl
	     << "Enter a letter: ";
    cin >> letter;
    
	if(letter >= 'A')
		if(letter <= 'Z')
	    {
	    	cout << endl
	  	    	 << "You enter a capital letter."
		     	 << endl;
		    getchar();
			return 0;
	    }

	if(letter >= 'a')
		if(letter <= 'z')
	    {
		    cout << endl
				 << "You entered a small letter."
				 << endl;
			getchar();
			return 0;
	    }

	cout << endl << "You did not enter a letter." << endl;
	getchar();
	return 0;
}