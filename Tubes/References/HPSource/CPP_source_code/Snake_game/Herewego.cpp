#include <windows.h>
#include <iostream>
#include <stdlib.h>
#include <time.h>

using namespace std;

void fMove(int& directions, short& CurX, short& CurY);

struct bits
{
int X[100];
int Y[100];
};

struct coords
{
int X;
int Y;
};

main()
{   
    //Place to type points
    int pointsX;
    int pointsY;
    pointsX = 51;
    pointsY = 10;

    //Matrix =)
    int matrix;

    //Making points available
    int points;
    points = 0;
    
    //Initializing apple cords
    srand( time ( NULL ) );
    coords apple;
    apple.X = rand() % 49 + 1;
    apple.Y = rand() % 23 + 1;


    //for loop variable
    int i;
    
    //Length of snake
    int len;
    len = 5;

    //we need a direction off course
    int dir;
    dir = 1;
    
    //all keyboard shit which i dont understand =)
    HANDLE hInput, hOutput;	
    INPUT_RECORD InputRecord;
    COORD CursorPosition;	
    DWORD Events=0;
    
    hInput = GetStdHandle(STD_INPUT_HANDLE);
    hOutput = GetStdHandle(STD_OUTPUT_HANDLE);
    
    SetConsoleMode(hInput, ENABLE_PROCESSED_INPUT);

    //Creating rectangle with cheap for loop =)
    //Dis be real ugly man! havent learned any rectangle draw and its 00.29AM
    for (i=0;i<=50;i++)
    {
    CursorPosition.X=i;
    CursorPosition.Y=0;
    SetConsoleCursorPosition(hOutput, CursorPosition);
    cout << "*";
    }
    
    for (i=0;i<=50;i++)
    {
    CursorPosition.X=i;
    CursorPosition.Y=24;
    SetConsoleCursorPosition(hOutput, CursorPosition);
    cout << "*";
    }
    
    for (i=0;i<=23;i++)
    {
    CursorPosition.X=0;
    CursorPosition.Y=i;
    SetConsoleCursorPosition(hOutput, CursorPosition);
    cout << "*";
    }
    
    for (i=0;i<=23;i++)
    {
    CursorPosition.X=50;
    CursorPosition.Y=i;
    SetConsoleCursorPosition(hOutput, CursorPosition);
    cout << "*";
    }
      
    CursorPosition.X = 5;
    CursorPosition.Y = 5;
    
    //stupid way off making game able to quit =)
    int on;
    on = 1;

    //create snakepieces array
    bits bit;
    for (i=0;i<=len+1;i++)
    {
    bit.X[i] = 5;
    bit.Y[i] = 5;
    }
    
    //Writing apple before loop
    CursorPosition.X = apple.X;
    CursorPosition.Y = apple.Y;
    SetConsoleCursorPosition(hOutput, CursorPosition);
    cout << "#";
    
    //reset
    CursorPosition.X = bit.X[0];
    CursorPosition.Y = bit.Y[0];    
    
    while(on==true)
    {    
        //again keyboardshit i dont understand...
        SetConsoleCursorPosition(hOutput, CursorPosition);
        if(WaitForSingleObject(hInput,0)==WAIT_OBJECT_0)
		{
		ReadConsoleInput( hInput, &InputRecord, 1, &Events );
		}

        //Checking if apple eaten
        if (apple.X == bit.X[1])
        {
        //yup it should have & =)
                if (apple.Y == bit.Y[1])
                {
                //Giving Point 
                points++;
                
                //Making snake longer
                len++;
                
                //Making new apple
                srand( time ( NULL ) );
                apple.X = rand() % 49 + 1;
                apple.Y = rand() % 23 + 1; 
                
                //Drawing the apple
                CursorPosition.X = apple.X;
                CursorPosition.Y = apple.Y;
                SetConsoleCursorPosition(hOutput, CursorPosition);
                cout << "#";    
                
                //reset
                CursorPosition.X = bit.X[0];
                CursorPosition.Y = bit.Y[0];                 
                
                //Cheking that apple not hidden behind body
                for (i=2; i<=len; i++)
                {
                    if (apple.X == bit.X[i])
                    {
                        if (apple.Y == bit.Y[i])
                        {
                        CursorPosition.X = apple.X;
                        CursorPosition.Y = apple.Y;
                        SetConsoleCursorPosition(hOutput, CursorPosition);
                        cout << "#";     
                        
                                        //reset
                CursorPosition.X = bit.X[0];
                CursorPosition.Y = bit.Y[0];   
                        }
                    }
                }
                
                } //if2 end bracket
        } //if1 end bracket  

        //finally the input coding... AT LAST
        if (InputRecord.Event.KeyEvent.wVirtualKeyCode == VK_LEFT &&
		    InputRecord.Event.KeyEvent.bKeyDown)
		    {
		    switch (dir)
		    {
		    case 5:
		    dir = 1;
		    break;
		    case 3:
		    dir = 1;
		    break;
		    case 4:
		    dir = 1;
		    break;
            }
            }
        
        if (InputRecord.Event.KeyEvent.wVirtualKeyCode == VK_RIGHT &&
                InputRecord.Event.KeyEvent.bKeyDown)
		    {
		    switch (dir)
		    {
		    case 5:
		    dir = 2;
		    break;
		    case 3:
		    dir = 2;
		    break;
		    case 4:
		    dir = 2;
		    break;
		    }
            }
                
        if (InputRecord.Event.KeyEvent.wVirtualKeyCode == VK_ESCAPE &&
                InputRecord.Event.KeyEvent.bKeyDown)
                {
                on=0;
                }
        
        if (InputRecord.Event.KeyEvent.wVirtualKeyCode == VK_UP &&
        InputRecord.Event.KeyEvent.bKeyDown)
		    {
		    switch (dir)
		    {
		    case 5:
		    dir = 3;
		    break;
		    case 1:
		    dir = 3;
		    break;
		    case 2:
		    dir = 3;
		    break;
            }
            }
        
        if (InputRecord.Event.KeyEvent.wVirtualKeyCode == VK_DOWN &&
        InputRecord.Event.KeyEvent.bKeyDown)
		    {
		    switch (dir)
		    {
		    case 5:
		    dir = 4;
		    break;
		    case 1:
		    dir = 4;
		    break;
		    case 2:
		    dir = 4;
		    break;
            }
            }                                

		fMove(dir, CursorPosition.X, CursorPosition.Y);
                        
        //make sure it doesnt run into wall
        if (CursorPosition.X==50)
        {
        CursorPosition.X=1;
        }
        
        if (CursorPosition.X==0)
        {
        CursorPosition.X=49;
        }                        

        if (CursorPosition.Y==0)
        {
        CursorPosition.Y=23;
        }                                                          

        if (CursorPosition.Y==24)
        {
        CursorPosition.Y=1;
        }                              
        
        //Giving snake[] values
        bit.X[0] = CursorPosition.X;
        bit.Y[0] = CursorPosition.Y;
        
        for (i=len; i>=1; i--)
        {
        bit.X[i] = bit.X[i - 1];
        bit.Y[i] = bit.Y[i - 1];
        }
        //Setting position for head
        
        CursorPosition.X = bit.X[1];
        CursorPosition.Y = bit.Y[1];
        SetConsoleCursorPosition(hOutput,CursorPosition);                 
                                   
        //Ugly i know, gotta go to bed =) well heres different heads
        switch (dir)
        {
        case 1:
        cout << "<";
        break;
        case 2:
        cout << ">";
        break;
        case 3:
        cout << "^";
        break;
        case 4:
        cout << "U";
        break;   
        }                                             
                                                                                                      
        //typing
        for (i=2; i<=len-1; i=i+2)
        {
        CursorPosition.X = bit.X[i];
        CursorPosition.Y = bit.Y[i];
        SetConsoleCursorPosition(hOutput,CursorPosition);
        matrix = rand() % 50;
        if (matrix <=25)
        {cout << "0";}
        if (matrix >25)
        {cout << "1";}
        }
        
        //typing
        for (i=3; i<=len-1; i=i+2)
        {
        CursorPosition.X = bit.X[i];
        CursorPosition.Y = bit.Y[i];
        SetConsoleCursorPosition(hOutput,CursorPosition);
        matrix = rand() % 50;
        if (matrix <=25)
        {cout << "0";}
        if (matrix >25)
        {cout << "1";}              
        }
        
        //using last array to clear
        CursorPosition.X = bit.X[len];
        CursorPosition.Y = bit.Y[len];
        SetConsoleCursorPosition(hOutput,CursorPosition);
        cout << " ";
        
        //Points!
        CursorPosition.X = pointsX;
        CursorPosition.Y = pointsY;
        SetConsoleCursorPosition(hOutput,CursorPosition);
        cout << "You have " << points << " points!";
        
        //Reset
        CursorPosition.X = bit.X[0];
        CursorPosition.Y = bit.Y[0];
        
        //Death!
        for (i=2;i<=len-1;i++)
        {
        if ((bit.X[i]==bit.X[0]) && (bit.Y[i]==bit.Y[0]))
        {on = 0;}
        }
                
    //pause between moves
    Sleep(50);
    }//while end bracket

system("pause");    
} //main end bracket

void fMove(int& directions, short& CurX, short& CurY)
{
        //Where to move
		switch(directions)
		{
		case 2:
        CurX++;
		break;
        case 1:
        CurX--;
        break;
		case 3:
        CurY--;
        break;
		case 4:
        CurY++;
        break;
		}
}

