  /*This is a simple Tic-Tac-Toe game that uses pretty simple 
	programming techniques(not that I could have done much 
	better than this). It should be understood pretty easily 
	by programmers of all skill.*/


#include <iostream>
#include <cmath>

#include "time.h"
#include "stdlib.h"

using namespace std;

int grid[3][3], key[3][3];		//grid is the array where we store marks. key is used to compare to grid later in the program
int tie;						

char answer[4];					

short int f=0, g=0;				//I'm not sure where these are used actually
short int a=1, b=2;				//I used these for the ASCII characters
short int x, y;					//coordinates
short int num_players, rating;	//The number of players, and the difficulty rating

bool win=false;					//boolean variable to determine winners

bool winner1();					//function prototypes
bool winner2();

int catsEye();					//function for ties

void Easy();					//AI function
void IntermediateAI();			//AI function
void ImpossibleAI();			//AI function
void gridDisplay();				//displays the grid
void AI(short rating);			//Picks the appropriate AI

int main(void)
{
			
	srand( (short unsigned) time (NULL) );	//Seed the pseudorandom number generator

	cout << "Would you like to play my text based Tic-Tac-Toe?";
	cin >> answer;
	cout << "\n\nWould you like to play one player, or two players?";
	cin >> num_players;
	
	if(num_players == 1)				//Set a computer difficulty for 1 player mode
	{
rating:		cout << "\n\nSelect a difficulty(1 easy, 2 intermediate, 3 impossible)";
			cin >> rating;
			if(rating!=1 && rating!=2 && rating!=3)
			{
				goto rating;			//Laugh if you will, but goto's rock!!!
			}
	}

	if (answer[0] == 'n')
	{	cout << "\nGoodbye then\n\n";
		return 0;
	}

	else
	{ 
		gridDisplay();					//Displays the grid with coordinates
		while(!win)
		{
			bool p1=false, p2=false;
			
			while(!p1)					//Loop to run player 1's turn
			{	
				cout << "\n\nPlease enter the coordinates of the position you want to mark (0,0 is upper left).";
				cin >> x >> y;			
				
				if(grid[x][y]!=key[x][y]) // Compare the selected coordinates to a key
				{
					cout << "\n\nPlease enter new coordinates, because those have been used.\n\n\n";
					gridDisplay();
				}

				else
				{
					grid[x][y]=1;
					
					
					tie = catsEye();		//Do we have a tie?
					if(tie==9)				//If so, declare a tie, and end the program
					{
						goto catseye;
					}
					
					win=winner1();			//Do we have a winner?
					if (win)				//If so, declare the winner, and end the program
					{
						goto win1;			//Once again you may laugh but this goto is essential from what I can see
					}
					p1=true;				//Player 1's turn is done
					
					gridDisplay();			//Show Tic-Tac-Toe grid with coordinates
					
				}
			}

			while(!p2)						//Run player 2's turn 
			{
				if(num_players==2)			//IF the players selected 2 player mode, let a human input coordinates
				{
					cout << "\n\nPlease enter the coordinates of the position you want to mark (0,0 is upper left).";
					cin >> x >> y;
				
					if(grid[x][y]!=key[x][y])	//Are the coordinates used?
					{
						cout << "\n\nPlease enter new coordinates, because those have been used.\n\n\n";	//If so, enter new coordinates
						gridDisplay();
					}
					grid[x][y]=2;			//Set position x,y to 2, indicating player 2 marked the point
				
				}

				else						//ELSE Run an AI based on the difficulty selected if in 1 player mode
				{
					AI(rating);
				}

					win=winner2();			//Is there a winner?
					tie=catsEye();			//Is there a tie?
					if(tie==9)
					{
						goto catseye;
					}
					p2=true;				//Player 2's turn is done
					gridDisplay();
					
				
			}
		}

	cout <<"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nPlayer 2 wins! Good job! Player 1 is a loser!!!\n\n\n\n\n\n\nCopyright 2002\n\npress any key then ENTER to quit";
	cin >> x;
	}
	return 0;

win1: cout << "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nPlayer 1 wins! Good job! Player 2 is a loser!!!\n\n\n\n\n\n\nCopyright 2002\n\npress any key then ENTER to quit";
cin >> x;
return 0;

catseye: cout << "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" << "It's a tie! Nobody wins! Everybody sucks!!!\n\n\n\n\n\n\nCopyright 2002\n\npress any key then ENTER to quit";
cin >> x;
return 0;
}


bool winner1(void)			//this function determines winners using every possible combination
{
	if(grid[0][0]==1 && grid[1][0]==1 && grid[2][0]==1)
	{
		return 1;
	}
	
	else if(grid[0][1]==1 && grid[1][1]==1 && grid[2][1]==1)
	{
		return 1;
	}

	else if(grid[0][2]==1 && grid[1][2]==1 && grid[2][2]==1)
	{
		return 1;
	}

	else if(grid[0][0]==1 && grid[0][1]==1 && grid[0][2]==1)
	{
		return 1;
	}

	else if(grid[1][0]==1 && grid[1][1]==1 && grid[1][2]==1)
	{
		return 1;
	}

	else if(grid[2][0]==1 && grid[2][1]==1 && grid[2][2]==1)
	{
		return 1;
	}

	else if(grid[0][0]==1 && grid[1][1]==1 && grid[2][2]==1)
	{
		return 1;
	}

	else if(grid[2][0]==1 && grid[1][1]==1 && grid[0][2]==1)
	{
		return 1;
	}

	else
	{
		return false;
	}
}

bool winner2(void)		//this function determines winners using every possible combination
{
	if(grid[0][0]==2 && grid[1][0]==2 && grid[2][0]==2)
	{
		return 1;
	}
	
	else if(grid[0][1]==2 && grid[1][1]==2 && grid[2][1]==2)
	{
		return 1;
	}

	else if(grid[0][2]==2 && grid[1][2]==2 && grid[2][2]==2)
	{
		return 1;
	}

	else if(grid[0][0]==2 && grid[0][1]==2 && grid[0][2]==2)
	{
		return 1;
	}

	else if(grid[1][0]==2 && grid[1][1]==2 && grid[1][2]==2)
	{
		return 1;
	}

	else if(grid[2][0]==2 && grid[2][1]==2 && grid[2][2]==2)
	{
		return 1;
	}

	else if(grid[0][0]==2 && grid[1][1]==2 && grid[2][2]==2)
	{
		return 1;
	}

	else if(grid[2][0]==2 && grid[1][1]==2 && grid[0][2]==2)
	{
		return 1;
	}

	else
	{
		return false;
	}

}



void gridDisplay()		//This function displays our Tic-Tac-Toe grid using ASCII symbols(this needs a lot of work still)
{
	
	cout << "\n\n 0  1  2";
		
	if(grid[0][0]==1)
	{
		cout << "\n0 " << (char)b << "|";
	}

	else
	{
		if(grid[0][0]==2)
		{
			cout << "\n0 " << (char)a << "|";
		}

		else
		{
			cout << "\n0  |";
		}

	}	
	
	if(grid[1][0]==1)   
	{
		cout << (char)b << "|";
	}

	else
	{
		if(grid[1][0]==2)
		{
			cout << (char)a << "|";
		}

		else
		{
			cout << " |";
		}
	}
	
	if(grid[2][0]==1)
	{
		cout << (char)b;
	}

	else
	{
		if(grid[2][0]==2)
		{
			cout << (char)a;
		}

		else
		{
			cout << " ";
		}
	}
	
	if(grid[0][1]==1)
	{
		cout << "\n1 " << (char)b << "|";
	}

	else
	{
		if(grid[0][1]==2)
		{
			cout << "\n1 " << (char)a << "|";
		}

		else
		{
			cout << "\n1  |";
		}
	}
		
	
	if(grid[1][1]==1)
	{
		cout << (char)b << "|";
	}

	else
	{
		if(grid[1][1]==2)
		{
			cout << (char)a << "|";
		}

		else
		{
			cout << " |";
		}
	}
		
	if(grid[2][1]==1)
	{
		cout << (char)b;
	}

	else
	{
		if(grid[2][1]==2)
		{
			cout << (char)a;
		}

		else
		{
			cout << " ";
		}
	}
	
	if(grid[0][2]==1)
	{
		cout << "\n2 " << (char)b << "|";
	}

	else
	{
		if(grid[0][2]==2)
		{
			cout << "\n2 " << (char)a << "|";
		}

		else
		{
			cout << "\n2  |";
		}
	
	}
	
	if(grid[1][2]==1)
		{
			cout << (char)b <<"|";
		}

	else
	{
		if(grid[1][2]==2)
		{
			cout << (char)a << "|";
		}

		else
		{
			cout << " |";
		}

	}
	
	if(grid[2][2]==1)
	{
		cout << (char)b;
	}

	else
	{
		if(grid[2][2]==2)
		{
			cout << (char)a;
		}

		else
		{
			cout << " ";
		}
	}

}

int catsEye()		//This function determines if there's a tie by counting the number of positions used
{
	short int r, c;
	int counter= 0;
	c = 0;

	while (c<3)		//Increments through the grid, taking note of all marked positions
	{
		r = 0;
		while(r<3)
		{
			if(grid[r][c]!= 0)	//IF grid[r][c] is not equal to 0, take note of it
			{
				counter++;
			}
			r++;
		}
		
		c++;
	}

		return counter;			//Return the number of used positions
}

void EasyAI()					//The Easy AI function... any child should be able to beat this AI
{
	bool not_taken=false;
	short int row=0, column=0;

	while(!not_taken)			//This loop looks for the first open position on the grid, and takes it
	{
		if(grid[row][column] == 1 || grid[row][column] == 2)
		{
			row++;
			
			if(row>2)
			{
				row = 0;
				column++;
			}
		}

		else
		{
			not_taken = true;
		}
		
	}
	grid[row][column]=2;		//Marks a position for player 2

}

/*For some reason this function isn't working properly. 
  It doesn't mark player 2's position on the grid array*/

void IntermediateAI()			//This is the intermediate AI, it uses a random number generator to find coordinates to use
{
	short int row=0, column=0;
	bool not_taken = false;

	while(!not_taken)		//This loop finds the coordinates
	{
		
		
		row = rand() %4;			//These should generate the coordinates
		column = rand() %4;
		
		if(row < 3 && column < 3)
		{

			if(grid[row][column] == 0)	//Checks the coordinates to make sure they aren't taken
			{
				not_taken = true;
				grid[row][column] = 2;	//Mark the coordinates as taken by player 2
			}
		}

		if(row > 2 || column > 2)
		{
			row = 0;
			column = 0;
		}
	}
}

void ImpossibleAI()					//This is the expert AI..... I know of no way whatsoever to beat it, without changing the code
{
	grid[x][y]=2;				//Replaces player 1's coodinate with player 2's
}

void AI(short rating)			//Runs the appropriate AI difficulty
{
	if(rating==1)
	{
		EasyAI();
	}

	if(rating==2)
	{
		IntermediateAI();
	}

	if(rating==3)
	{
		ImpossibleAI();
	}
}
