
//**************************************
//INCLUDE files for: GuessingProgram
//**************************************
#include <stdio.h>
#include <time.h>
#include <stdlib.h>

//**************************************
// Name: GuessingProgram
// Description:
//     This program can guess any number between one and nine that you might 
//     have in mind by asking you some simple questions.
// By: Gonzales Cenelia
//
// Inputs: it takes characters as input
//
// Returns: it return sentences
//
// Assumes: None
//
// Side Effects: no side effects
// This code is copyrighted and has limited warranties.
// Please see 
//   http://www.Planet-Source-Code.com/xq/ASP/txtCodeId.3445/lngWId.3/qx/vb/scripts/ShowCode.htm
// for details.
//**************************************

char GetAnswer( void ) {
    getchar();
	int choice = getchar();
	while( choice != 'y' && choice != 'Y' && choice != 'n' && choice != 'N' ) {
		printf("Please choose \"y\" or \"Y\" for yes or \"n\" or \"N\" for no: ");
		getchar();
		choice = tolower(getchar());
	}
	return choice;
}

int random( int num ) {
    if(num == 0) {
		return 0;
	}
	srand(( unsigned ) time( NULL ));
    return rand() % num;
}

int main()
{
    int recursion = 0;
	while(1) {
	printf("\n\t\t\t================");
	printf("\n\t\t\tGuessing program\n");
	printf("\t\t\t================\n\n\n");
	printf("Do you have a number between 1 and 9 in mind? Yes(y) No(n): ");
	if(recursion > 0) getchar();
	char answer = tolower(getchar());
    if( answer == 'y' ) {
        printf("Is it a prime number? Yes(y) No(n): ");
        if( GetAnswer() == 'y' ) {
            printf("Is it bigger than 4? Yes(y) No(n): ");
            if( GetAnswer() == 'y' ) {
                switch(random(2)){
				case 0:
					printf("Your number is 7? Yes(y) No(n): ");
                    if( GetAnswer() == 'y' ) {
						printf("Well,i am intelligent i have found your number !\n");
					} 
					else {
						printf("Now,i know for sure that your number is 5\n");
					}
                    break;
                case 1:
					printf("Your number is 5? Yes(y) No(n): ");
                    if( GetAnswer() == 'y' ) {
						printf("Well,i am intelligent i have found your number !\n");
					}
                    else {
						printf("Now,i know for sure that your number is 7\n");
					}
                    break;
				}
			}
			else {
				switch(random(2)){
				case 0:
					printf("Your number is 3? Yes(y) No(n): ");
                    if( GetAnswer() == 'y' ) {
						printf("Well,i am intelligent i have found your number !\n");
					}
                    else {
                        printf("Now,i know for sure that your number is 2\n");
					}
                    break;
                case 1:
					printf("Your number is 2? Yes(y) No(n): ");
					if( GetAnswer() == 'y' ) {
						printf("Well,i am intelligent i have found your number !\n");
					}
					else {
						printf("Now,i know for sure that your number is 3\n");
					}
					break;
				}
			}
		}
		else {
			printf("Is it odd? Yes(y) No(n): ");
			if( GetAnswer() == 'y' ) {
				switch(random(2)){
				case 0:
					printf("Your number is 1? Yes(y) No(n): ");
					if( GetAnswer() == 'y' ) {
						printf("Well,i am intelligent i have found your number !\n");
					}
					else {
						printf("Now,i know for sure that your number is 9\n");
					}
                    break;
				case 1:
					printf("Your number is 9? Yes(y) No(n): ");
					if( GetAnswer() == 'y' ) {
						printf("Well,i am intelligent i have found your number !\n");
					}
                    else {
						printf("Now,i know for sure that your number is 1.\n");
					}
                    break;
				}
			}
			else {
				printf("So,your number is even? Yes(y) No(n): ");
				if( GetAnswer() == 'n' ) {
					printf("I think that you are not telling me the truth.\n");
				}
				else {
					printf("Is it bigger than 5? Yes(y) No(n): ");
					if( GetAnswer() == 'n')
						printf("Without any doubt,i know that your number is 4\n");
					else {
						switch(random(2)){
						case 0:
							printf("Your number is 8? Yes(y) No(n): ");
							if( GetAnswer() == 'y' ) {
								printf("Well,i am intelligent i have found your number !\n");
							}
                            else {
								printf("Now,i know for sure that your number is 6\n");
							}
							break;
						case 1:
							printf("Your number is 6? Yes(y) No(n): ");
							if( GetAnswer() == 'y' ) {
								printf("Well,i am intelligent i have found your number !\n");
							}
							else {
								printf("Now,i know for sure that your number is 8.\n");
							}
							break;
						}
					}
				}
			}
		}
    }
	printf("\n\ndo you want to continue Yes(y) No(n): ");
	getchar();
	int choice = getchar();
	if( choice != 'y' && choice != 'Y') break;
	system("cls");
	recursion++;
    }
	return 0;
}
                                        			
                                        		
		
