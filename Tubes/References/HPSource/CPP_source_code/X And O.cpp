//Norts & Crosses (Win32 Console version)

// Header Files
#include <iostream.h>	// Used for 'cout' and 'cin' functions.

// Prototypes (each function must have a prototype)
void DrawGameBoard(void);	// Does not return any value (void); No Paramters (void)
void ClearBoard(void);		// Does not return any value (void); No Paramters (void)
int GameOver(void);			// Returns an Integer; No Paramters (void)
int GetWinnerInfo(void);	// Returns an Integer; No Paramters (void)

// Globals (variables outside the functions are available to all)
char gameBoard[9];			// An array of the board in Memory (0 to 8)
char gameOverBoard[9];		// An array of the temp board to draw line thru winner.
char currentPlayer = 'O';	// Current Player, 'X' or 'O'.
char winnerPlayer;			// The winners piece, ('X' or 'O') or ' ' if no one won.

int main()
{
	int inputPos;	// Integer variable used by 'cin' to store input of 'X' or 'O' position on the board

	cout << "Norts And Crosses\n";	// Prints "Norts And Crosses" to the screen, '\n' prints a newline.
	
	// Calls the functions
	ClearBoard();
	DrawGameBoard();

	while(1)	// 1 is TRUE, so this will loop forever or until 'break' is used.
	{
		cout << "\nEnter a number 0-8 or 10 to Exit\n";
		cin >> inputPos;	// Get input from user and store it in inputPos (an int variable)
		if ((inputPos >= 0) && (inputPos <= 8))		// If inputPos is between 0 and 8 then...
		{
			if (gameBoard[inputPos] == ' ')		// If the position on the board is empty then...
			{
				gameBoard[inputPos] = currentPlayer;	// Set the piece to the currentPlayer ('X' or 'O') at inputPos
				DrawGameBoard();						// Redraw the board
				
				// Swap X and O
				if (currentPlayer == 'O')
					currentPlayer = 'X';
				else
					currentPlayer = 'O';
			}
			if (GameOver() == 1)	// If GameOver function returns 1 (TRUE) then
				break;				// 'break' out of the loop.
		}
		else	// else if inputPos = 10 then 'break' out of the loop. (quit game)
			if (inputPos == 10)
				break;
	}
	
	cout << "\n\nGAME OVER\n";
	if (winnerPlayer != ' ')	// If winnerPlayer does NOT = ' ' then...
		cout << "Player " << winnerPlayer << " Wins!\n\n";
	else
		cout << "Nobody wins.\n\n";

	return 0;	// main() Should always return 0
}

void DrawGameBoard()
{
	//  ___ ___ ___
	// |   |   |   |
	// | 0 | 1 | 2 |
	// |___|___|___|
	// |   |   |   |
	// | 3 | 4 | 5 |
	// |___|___|___|
	// |   |   |   |
	// | 6 | 7 | 8 |
	// |___|___|___|

	cout << " ___ ___ ___\n";
	cout << "|   |   |   |\n";
	cout << "| " << gameBoard[0] <<" | " << gameBoard[1] << " | " << gameBoard[2] << " |\n";
	cout << "|___|___|___|\n";
	cout << "|   |   |   |\n";
	cout << "| " << gameBoard[3] <<" | " << gameBoard[4] << " | " << gameBoard[5] << " |\n";
	cout << "|___|___|___|\n";
	cout << "|   |   |   |\n";
	cout << "| " << gameBoard[6] <<" | " << gameBoard[7] << " | " << gameBoard[8] << " |\n";
	cout << "|___|___|___|\n";
}

void ClearBoard()
{
	for (int i = 0; i < 9; i++)
	{
		gameBoard[i] = ' ';
	}
}

int GameOver()
{
	int tmpGameOver;
	int tmp = 1;

	// Check if board is full
	for (int i = 0; i < 9; i++)
	{
		if (gameBoard[i] == ' ')
			tmp = 0;
	}

	tmpGameOver = GetWinnerInfo();
	if ((tmp == 0) && (tmpGameOver == 1)) tmp = 1;

	if (tmp == 1)
	{
		cout << " ___ ___ ___\n";
		cout << "|   |   |   |\n";
		cout << "| " << gameOverBoard[0] <<" | " << gameOverBoard[1] << " | " << gameOverBoard[2] << " |\n";
		cout << "|___|___|___|\n";
		cout << "|   |   |   |\n";
		cout << "| " << gameOverBoard[3] <<" | " << gameOverBoard[4] << " | " << gameOverBoard[5] << " |\n";
		cout << "|___|___|___|\n";
		cout << "|   |   |   |\n";
		cout << "| " << gameOverBoard[6] <<" | " << gameOverBoard[7] << " | " << gameOverBoard[8] << " |\n";
		cout << "|___|___|___|\n";
	}

	return tmp;
}

// Return 0 if no one has won
int GetWinnerInfo()
{
	char tmpPlayer = 'O';
	int i = 0;

	winnerPlayer = ' ';

	// reset borad2
	for (i = 0; i < 9; i++)
	{
		gameOverBoard[i] = gameBoard[i];
	}

	for (i = 0; i < 2; i++)
	{
		if (winnerPlayer != ' ') break;
		if (i == 1) tmpPlayer = 'X';
		
		if ((gameBoard[0] == tmpPlayer) && (gameBoard[1] == tmpPlayer) && (gameBoard[2] == tmpPlayer))
		{
			gameOverBoard[0] = '-';
			gameOverBoard[1] = '-';
			gameOverBoard[2] = '-';
			winnerPlayer = tmpPlayer;
		}
		else{if ((gameBoard[3] == tmpPlayer) && (gameBoard[4] == tmpPlayer) && (gameBoard[5] == tmpPlayer))
			{
				gameOverBoard[3] = '-';
				gameOverBoard[4] = '-';
				gameOverBoard[5] = '-';
				winnerPlayer = tmpPlayer;
			}
		else{if ((gameBoard[6] == tmpPlayer) && (gameBoard[7] == tmpPlayer) && (gameBoard[8] == tmpPlayer))
			{
				gameOverBoard[6] = '-';
				gameOverBoard[7] = '-';
				gameOverBoard[8] = '-';
				winnerPlayer = tmpPlayer;
			}
		else{if ((gameBoard[0] == tmpPlayer) && (gameBoard[3] == tmpPlayer) && (gameBoard[6] == tmpPlayer))
			{
				gameOverBoard[0] = '|';
				gameOverBoard[3] = '|';
				gameOverBoard[6] = '|';
				winnerPlayer = tmpPlayer;
			}
		else{if ((gameBoard[1] == tmpPlayer) && (gameBoard[4] == tmpPlayer) && (gameBoard[7] == tmpPlayer))
			{
				gameOverBoard[1] = '|';
				gameOverBoard[4] = '|';
				gameOverBoard[7] = '|';
				winnerPlayer = tmpPlayer;
			}
		else{if ((gameBoard[2] == tmpPlayer) && (gameBoard[5] == tmpPlayer) && (gameBoard[8] == tmpPlayer))
			{
				gameOverBoard[2] = '|';
				gameOverBoard[5] = '|';
				gameOverBoard[8] = '|';
				winnerPlayer = tmpPlayer;
			}
		else{if ((gameBoard[0] == tmpPlayer) && (gameBoard[4] == tmpPlayer) && (gameBoard[8] == tmpPlayer))
			{
				gameOverBoard[0] = '\\';
				gameOverBoard[4] = '\\';
				gameOverBoard[8] = '\\';
				winnerPlayer = tmpPlayer;
			}
		else{if ((gameBoard[6] == tmpPlayer) && (gameBoard[4] == tmpPlayer) && (gameBoard[2] == tmpPlayer))
			{
				gameOverBoard[6] = '/';
				gameOverBoard[4] = '/';
				gameOverBoard[2] = '/';
				winnerPlayer = tmpPlayer;
			}
		}
		}
		}
		}
		}
		}
		}
	}

	if (winnerPlayer == ' ')
		return 0;
	else
		return 1;
}