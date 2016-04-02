//**************************************
// Name: Tic-tac-toe game
// Description:A simple tic-tac-toe game.
// By: Irene Sam
//
//
// Inputs:Input the number of row and column that you wish to put the character.
//
// Returns:None
//
//Assumes:None
//
//Side Effects:None
//This code is copyrighted and has limited warranties.
//Please see http://www.Planet-Source-Code.com/xq/ASP/txtCodeId.5477/lngWId.3/qx/vb/scripts/ShowCode.htm
//for details.
//**************************************

#include <iostream>
using namespace std;
class Matrix


    {
    private:
    	char board[3][3];
    	int i, j;
    	int turn;						//player 1 == 1; player 2 == 2
    	char play;
    public:
    	Matrix ();
    	bool checkEmpty (int, int);		//check if the user selected place is empty or not
    	void getInput ();				//get input character from user
    	void display ();				//display the matrix
    	void playGame ();
    	void checkWin ();
    	void nextPlayer ();
};
Matrix::Matrix ()


    {
    	for (i = 0; i < 3; i++)
    		for (j = 0; j < 3; j++)
    			board[i][j] = '\0';		//initialize all the position to null
    	turn = 1;						//player 1 play first
    	play = 'O';
}
bool Matrix::checkEmpty (int a, int b)


    {
    	if (board[a][b] == '\0')
    		return true;
    	else 
    		return false;
}
void Matrix::getInput ()


    {
    	bool empty;
    		
    	cout<<"Enter number of Row: ";
    	cin>>i;
    	cout<<"Enter number of Column: ";
    	cin>>j;
    		
    	empty = checkEmpty (i, j);
    	if (empty == true)
    		board[i][j] = play;
    	else


        	{
        		cout<<"Already occupied!"<<endl;
        		nextPlayer ();
        	}
    }
    void Matrix::display ()


        {
        	cout<<"\n-----+-------+-------+-------+"<<endl;
        	cout<<" | Col 0 | Col 1 | Col 2 |"<<endl;
        	cout<<"-----+-------+-------+-------+"<<endl;
        	for (i = 0; i < 3; i++)


            	{
            		cout<<"Row "<<i<<"|";
            		for (j = 0; j < 3; j++)


                		{
                			cout<<""<<board[i][j];
                			cout<<"|";
                		}
                		
                		cout<<"\n-----+-------+-------+-------+"<<endl;
                	}
            }
            void Matrix::playGame ()


                {
                	cout<<"Player ["<<turn<<"] please enter move: "<<endl;
                	getInput ();
                	checkWin ();
                	display ();
                	nextPlayer ();
            }
            void Matrix::nextPlayer ()


                {
                	if (turn == 1)


                    	{
                    		turn = 2;
                    		play = 'X';
                    	}
                    	else


                        	{
                        		turn = 1;
                        		play = 'O';
                        	}
                    }
                    void Matrix::checkWin ()


                        {
                        	if ((board[0][0] == play && board[1][0] == play && board[2][0] == play) ||
                        		(board[0][1] == play && board[1][1] == play && board[2][1] == play) ||
                        		(board[0][2] == play && board[1][2] == play && board[2][2] == play) ||
                        		(board[0][0] == play && board[0][1] == play && board[0][2] == play) ||
                        		(board[1][0] == play && board[1][1] == play && board[1][2] == play) ||
                        		(board[2][0] == play && board[2][1] == play && board[2][2] == play) ||
                        		(board[0][0] == play && board[1][1] == play && board[2][2] == play) ||
                        		(board[0][2] == play && board[1][1] == play && board[2][0] == play))


                            	{
                            		cout<<"\nPlayer ["<<turn<<"] win!"<<endl;
                            		exit (1);
                            	}
                        }
                        int main ()


                            {
                            	Matrix m;
                            	char choice;
                            	
                            	m.display ();
                            	do


                                	{
                                		m.playGame ();
                                		cout<<"\nDo you want to continue?";
                                		cin>>choice;
                                		cout<<endl;
                                	} while (choice != 'N' && choice != 'n');
                                	cout<<"\nThank you for your playing....."<<endl;
                                	return 0;
                            }
		
