// xmaster5000.cpp : Defines the entry point for the console application.
// Chris Mailloux   chrismailloux@rogers.com

#include "stdafx.h"
#include <iostream>
#include <windows.h>
#include <conio.h>
using namespace std;

class cMenu
{
public:
	cMenu();
	~cMenu();
	int m_nChoice;
	void m_Menu();
//	void m_Scores();
};
cMenu::cMenu()
{
}
cMenu::~cMenu()
{
}
void cMenu::m_Menu()
{
	HANDLE handle = GetStdHandle ( STD_OUTPUT_HANDLE );
	SetConsoleTextAttribute ( handle, FOREGROUND_GREEN | FOREGROUND_INTENSITY /*| BACKGROUND_INTENSITY*/ );
	cout<<"-----------------"<<endl;
	cout<<"X MASTER 5000\n";
	cout<<endl;
	cout<<"(1) Play\n";
	cout<<"(2) View Scores\n";
	cout<<"(3) Clear Scores\n";
	cout<<"(4) Help\n";
	cout<<"(5) About\n";
	cout<<"(6) Exit\n";
	cin>>m_nChoice;

	if(m_nChoice==1){
		system("cls");
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<"                       YOU ARE NOW ENTERING LEVEL 1"<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<"Lives:5"<<endl;
		unsigned long delay = GetTickCount() + (500);
			while (GetTickCount() < delay) { }
		cout<<endl;
		cout<<endl;
		cout<<endl;
		system("pause");
		system("cls");

	}
	if(m_nChoice==2){
		system("cls");
		cout<<"This feature is incomplete"<<endl;
		cout<<endl;
		cMenu::m_Menu();
//		exit(0);
	}
	if(m_nChoice==3){
		system("del smscores.ini");
		system("cls");
		cout<<"clearing scores...Done"<<endl;
		cout<<endl;
		cMenu::m_Menu();
	}
	if(m_nChoice==4){
		
		system("cls");
		cout<<"You have discovered an ancient tomb under the \n";
		cout<<"desert. Not only did you discover it, but your\n";
		cout<<"also lost in it. You must find your way out alive.\n";
		cout<<"Make sure you dont get to close to the many monsters \n";
		cout<<"and traps scattered throughout the tomb. To explore,\n";
		cout<<"use the LEFT, and RIGHT arrow keys. To jump use the UP\n";
		cout<<"arrow key.  There are four stages that you must survive\n";
		cout<<"if you ever want to find your way out.  Press escape \n";
		cout<<"key at any time to exit. Good luck!\n";
		cout<<endl;
		m_nChoice=0;
		cMenu::m_Menu();
	}
	if(m_nChoice==5){
	
		system("cls");
		cout<<"X Master 5000 was made by Chris Mailloux.\n";
		cout<<"You can reach me at: chrismailloux@rogers.com.\n";
		cout<<endl;
		m_nChoice=0;
		cMenu::m_Menu();
	}
	if(m_nChoice==6)
		exit(0);
	if(m_nChoice<1 || m_nChoice>6)
	{
		system("cls");
		cMenu::m_Menu();
	}
	
}
/*
void cMenu::m_Scores()
{
	system("cls");   
	ifstream open("smscores.ini", ios::in);
	cFileIO readfile;
	while (open.good())
	{
		open.read((char *) &readfile, sizeof readfile);
		if (!open.good()) break; 
		if(readfile.m_nVF==0)
			cout<<readfile.m_arcName<<"    SCORE: "<<readfile.m_nScore<<"    STAGE: "<<readfile.m_nStage<<"    TIME: "<<readfile.m_nTime<<"    STAT SAVE"<<endl;
		else if(readfile.m_nVF==1)
			cout<<readfile.m_arcName<<"    SCORE: "<<readfile.m_nScore<<"    STAGE: "<<readfile.m_nStage<<"    TIME: "<<readfile.m_nTime<<"    VICTORY"<<endl;
		else if(readfile.m_nVF==2)
			cout<<readfile.m_arcName<<"    SCORE: "<<readfile.m_nScore<<"    STAGE: "<<readfile.m_nStage<<"    TIME: "<<readfile.m_nTime<<"    FAILURE"<<endl;
	}
	open.close();
	m_nChoice=0;
	cMenu::m_Menu();

}
*/
class cGame
{
public:
int y, x, m_xCrash, m_yCrash, m_nKey, m_nCount, m_nExit, m_nBot1x, m_nBot1y, m_nSpeed, m_nTime, m_nBot1T, m_nBot1Dir, m_nUp, m_nDown, m_nLeft, m_nRight, m_nGravity, m_nGravOff, m_nDie, m_nJump, m_nJumpT, m_nJumpS, m_nReverseBot, m_nBot2x, m_nBot2T, m_nBot2Dir, m_nBot2y, m_nBot3x, m_nBot3T, m_nBot3Dir, m_nBot3y, m_nBot4x, m_nBot4T, m_nBot4Dir, m_nBot4y, m_nBot5x, m_nBot5T, m_nBot5Dir, m_nBot5y, m_nBot6x, m_nBot6T, m_nBot6Dir, m_nBot6y, m_nBot7x, m_nBot7T, m_nBot7Dir, m_nBot7y, m_nBot8x, m_nBot8T, m_nBot8Dir, m_nBot8y, m_nRise, m_nRiseA, m_nJlimit, m_nBot9x, m_nBot9T, m_nBot9Dir, m_nBot9y, m_nBot10x, m_nBot10T, m_nBot10Dir, m_nBot10y, m_nBot11x, m_nBot11T, m_nBot11Dir, m_nBot11y, m_nTrap1, m_nTrap2, m_nTrap3, m_nTrap4, m_nTrap5, m_nTrap5x, m_nTrap5y, m_nTrap5C, m_nTrap5D, m_nTrap10, m_nTrap11, m_nBot12T, m_nBot12W,  m_nBot13x, m_nBot13T, m_nBot13Dir, m_nBot13y, m_nBot14x, m_nBot14T, m_nBot14Dir, m_nBot14y, m_nBot15x, m_nBot15T, m_nBot15Dir, m_nBot15y, m_nBot16x, m_nBot16T, m_nBot16Dir, m_nBot16y, m_nBot17x, m_nBot17T, m_nBot17Dir, m_nBot17y, m_nBot19x, m_nBot19T, m_nBot19Dir, m_nBot19y, m_nBot20T, m_nBot20x, m_nBot20y, m_nBot20Dir, m_nBot21x, m_nBot21T, m_nBot21Dir, m_nBot21y, m_nBot22x, m_nBot22T, m_nBot22Dir, m_nBot22y, m_nBot23x, m_nBot23T, m_nBot23Dir, m_nBot23y, m_nBot24x, m_nBot24T, m_nBot24Dir, m_nBot24y,  m_nBot25x, m_nBot25T, m_nBot25Dir, m_nBot25y, m_nBot26x, m_nBot26T, m_nBot26Dir, m_nBot26y, m_nBot27x, m_nBot27T, m_nBot27Dir, m_nBot27y, m_nBot28x, m_nBot28T, m_nBot28Dir, m_nBot28y, m_nBot29x, m_nBot29T, m_nBot29Dir, m_nBot29y, m_nBot30x, m_nBot30T, m_nBot30Dir, m_nBot30y, m_nBot31x, m_nBot31T, m_nBot31Dir, m_nBot31y, m_nBot32x, m_nBot32T, m_nBot32Dir, m_nBot32y, m_nLevel, m_nLevel1, m_nLevel2, m_nLevel3, m_nLevel4, m_nLives, m_nMenu;
public:
#define tr char(176)
#define n char(0)
#define c char(2)
#define win char(1)
#define o char(219)
#define t char(177)
#define w char(178)
#define g char(219)
#define s char(30)
#define e char(223)
	cGame();
	~cGame();
	void m_Level2();
	void m_Level3();
	void m_Level4();
	void m_Map();
	void m_Win();
	void m_Die();
	void m_Jump();
	void m_Rise();
	void m_Reset();
	void m_BotCon();
	void m_InputCon();
	void m_GravityCon();
	void m_CrashDetector();
	void m_CursorCon(int x, int y);

};

cGame::cGame()
{
	y=19;
	x=0;
	m_nCount=0;
	m_nExit=0;
	m_nBot1x=6;
	m_nBot1y=22;
	m_nBot1T=0;
	m_nSpeed=1;
	m_nTime=0;
	m_nBot1Dir=0;
	m_xCrash=0;
	m_nLives=5;
	m_nKey=0;
	m_yCrash=0;
	m_nUp=0;
	m_nDown=0;
	m_nLeft=0;
	m_nRight=0;
	m_nGravity=0;
	m_nGravOff=0;
	m_nDie=0;
	m_nJump=0;
	m_nJumpT=0;
	m_nJumpS=0;
	m_nReverseBot=0;
	m_nJlimit=19;
	m_nRise=0;
	m_nRiseA=0;
	m_nMenu=0;
	m_nTrap1=0;
	m_nTrap2=0;
	m_nTrap3=0;
	m_nTrap4=0;
	m_nTrap5=0, m_nTrap5x=4, m_nTrap5y=5, m_nTrap5C=0, m_nTrap5D=0, m_nTrap10=0, m_nTrap11=0;
	m_nBot2x=39, m_nBot2T=0, m_nBot2Dir=0, m_nBot2y=22;
	m_nBot3x=76, m_nBot3T=0, m_nBot3Dir=1, m_nBot3y=11;
	m_nBot4x=45, m_nBot4T=0, m_nBot4Dir=1, m_nBot4y=22;
	m_nBot5x=61, m_nBot5T=0, m_nBot5Dir=0, m_nBot5y=22;
	m_nBot6x=74, m_nBot6T=0, m_nBot6y=24;
	m_nBot7x=74, m_nBot7T=0, m_nBot7y=20;
	m_nBot8x=74, m_nBot8T=0, m_nBot8y=16;
	m_nBot9x=39, m_nBot9T=0, m_nBot9Dir=0, m_nBot9y=17;
	m_nBot10x=60, m_nBot10T=0, m_nBot10Dir=1, m_nBot10y=17;
	m_nBot11x=19, m_nBot11T=0, m_nBot11Dir=0, m_nBot11y=16;
	m_nBot12T=0, m_nBot12W=0;
	m_nBot13x=46, m_nBot13T=0, m_nBot13Dir=0, m_nBot13y=11;
	m_nBot14x=41, m_nBot14T=0, m_nBot14Dir=1, m_nBot14y=11;
	m_nBot15x=23, m_nBot15T=0, m_nBot15Dir=0, m_nBot15y=11;
	m_nBot16x=13, m_nBot16T=0, m_nBot16Dir=1, m_nBot16y=11;
	m_nBot17x=4, m_nBot17T=0, m_nBot17Dir=0, m_nBot17y=11;
	m_nBot19x=14, m_nBot19T=0, m_nBot19Dir=0, m_nBot19y=4;
	m_nBot20T=0, m_nBot20x=22, m_nBot20y=1, m_nBot20Dir=0;
	m_nBot21x=24, m_nBot21T=0, m_nBot21Dir=3, m_nBot21y=4;
	m_nBot22x=26, m_nBot22T=0, m_nBot22Dir=0, m_nBot22y=1;
	m_nBot23x=28, m_nBot23T=0, m_nBot23Dir=3, m_nBot23y=4;
	m_nBot24x=30, m_nBot24T=0, m_nBot24Dir=0, m_nBot24y=1;
	m_nBot25x=43, m_nBot25T=0, m_nBot25Dir=0, m_nBot25y=4;
	m_nBot26x=48, m_nBot26T=0, m_nBot26Dir=1, m_nBot26y=4;
	m_nBot27x=50, m_nBot27T=0, m_nBot27Dir=0, m_nBot27y=4;
	m_nBot28x=57, m_nBot28T=0, m_nBot28Dir=0, m_nBot28y=4;
	m_nBot29x=62, m_nBot29T=0, m_nBot29Dir=1, m_nBot29y=4;
	m_nBot30x=64, m_nBot30T=0, m_nBot30Dir=0, m_nBot30y=4;
	m_nBot31x=76, m_nBot31T=0, m_nBot31Dir=1, m_nBot31y=4;
	m_nBot32x=70, m_nBot32T=0, m_nBot32Dir=1, m_nBot32y=4;
	m_nLevel=1, m_nLevel1=0, m_nLevel2=0, m_nLevel3=0, m_nLevel4=0;
}
cGame::~cGame()
{
}


void cGame::m_Level2()
{
	system("cls");
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<"                       YOU ARE NOW ENTERING LEVEL 2"<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<"Lives:"<<m_nLives<<endl;
	unsigned long delay = GetTickCount() + (1000);
		while (GetTickCount() < delay) { }
	cout<<endl;
	cout<<endl;
	cout<<endl;
	system("pause");
	m_nLevel=2;
	system("cls");
	cGame::m_Map();
}
void cGame::m_Level3()
{
		system("cls");
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<"                       YOU ARE NOW ENTERING LEVEL 3"<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<"Lives:"<<m_nLives<<endl;
	unsigned long delay = GetTickCount() + (1000);
		while (GetTickCount() < delay) { }
	cout<<endl;
	cout<<endl;
	cout<<endl;
	system("pause");
	m_nLevel=3;
	system("cls");
	cGame::m_Reset();
	cGame::m_Map();
}
void cGame::m_Level4()
{
	system("cls");
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<"                       YOU ARE NOW ENTERING LEVEL 4"<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<"Lives:"<<m_nLives<<endl;
	unsigned long delay = GetTickCount() + (1000);
		while (GetTickCount() < delay) { }
	cout<<endl;
	cout<<endl;
	cout<<endl;
	system("pause");
	m_nLevel=4;
	system("cls");
	cGame::m_Reset();
	cGame::m_Map();
}

void cGame::m_Map()
{
	HANDLE handle = GetStdHandle ( STD_OUTPUT_HANDLE );
	SetConsoleTextAttribute ( handle, FOREGROUND_GREEN | FOREGROUND_INTENSITY /*| BACKGROUND_INTENSITY*/ );
	cout<<"Level:"<<m_nLevel<<"       Lives:"<<m_nLives<<endl;
	cout<<endl;
	cout<<endl;
	cout<<"                                                                               "<<win;
	cout<<"                                          "<<g<<"      "<<g<<"      "<<g<<"      "<<g<<"             "<<g<<g<<g;	
	cout<<n<<n<<n<<w<<t<<t<<t<<t<<t<<t<<t<<t<<t<<t<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<n<<n<<g<<n<<g<<n<<g<<n<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w;
	cout<<n<<n<<w<<w<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<n<<n<<w<<n<<w<<n<<w<<n<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w;
	cout<<n<<w<<w<<w<<s<<s<<s<<s<<s<<s<<s<<s<<s<<s<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<s<<s<<w<<s<<w<<s<<w<<s<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w;
	cout<<endl;
	cout<<g<<endl;
	cout<<g<<g<<"       "<<g<<"     "<<g<<"    "<<g<<g<<"       "<<g<<g<<g<<"                                               "<<tr;
	cout<<g<<g<<g<<g<<n<<n<<n<<n<<g<<g<<g<<n<<n<<n<<g<<g<<g<<n<<n<<g<<g<<g<<g<<n<<n<<n<<n<<n<<g<<g<<g<<g<<g<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<w<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<n<<g<<g;
	cout<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<s<<s<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<n<<n<<n<<n<<g<<g<<g<<g<<g<<g<<g<<g<<g<<n<<g<<n<<g<<n<<g<<n<<g<<n<<g<<n<<g<<n<<g<<g<<g<<g<<g<<g<<g<<g<<g<<n<<g<<g;
	cout<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<n<<n<<n<<n<<w<<w<<w<<w<<w<<w<<w<<w<<w<<s<<w<<s<<w<<s<<w<<n<<w<<s<<w<<s<<w<<s<<w<<w<<w<<w<<w<<w<<w<<w<<w<<n<<w<<w;
	cout<<endl;
	cout<<endl;
	cout<<n<<tr<<"            "<<g<<g<<endl;
	cout<<g<<g<<g<<g<<g<<g<<g<<n<<n<<n<<n<<n<<"     "<<g<<g<<g<<g<<g<<endl;
	cout<<w<<w<<w<<w<<w<<w<<w<<w<<w<<n<<n<<n<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<n<<w<<w<<w<<w<<w<<w<<w<<w<<t<<t<<t<<t<<s<<s<<s<<s<<s<<s<<s<<s<<s<<s<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<w<<n<<w<<w<<w<<w<<w<<w<<w<<w<<endl;
	cout<<endl;
	cout<<endl;
	cout<<"                       "<<g<<g<<endl;
	cout<<"     "<<g<<"       "<<g<<"        "<<g<<g<<g<<g<<"                              "<<g<<endl;
	cout<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<n<<g<<g<<g<<g<<g<<g<<g<<g<<n<<n<<n<<n<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<g<<s<<g<<g<<g<<g<<g<<g<<"          ";
//		  0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79

}
	
void cGame::m_InputCon()
{
	do{
		cMenu menu;
		menu.m_Menu();
		cGame::m_Map();
		do{
			unsigned long delay = GetTickCount() + (m_nSpeed);
			while (GetTickCount() < delay) { }

			if(kbhit())
			{
				m_nKey = getch();
			}
			
			if (m_nKey == 72 && m_nUp==0 && m_nJump==0 && m_nDown==1)
			{
				m_nJump=1;//activates m_Jump() function
				m_nUp=1;
				m_nDown=0, m_nRight=0, m_nLeft=0;//see crash detector
			}

			else if (m_nKey == 80 && m_nDown==0)
			{
				cout<<" ";//comment off for trail	
				cGame::m_CursorCon(x, ++y);
				cout<<"x";
				m_nKey=0;// comment off to make it move automatically; you will have to adjust delay speed
				m_nUp=0, m_nRight=0, m_nLeft=0;//see crash detector
			}

			else if (m_nKey == 75 && m_nLeft==0)
			{
				cout<<" ";//comment off for trail		
				cGame::m_CursorCon(--x, y);
				cout<<"x";	
				m_nKey=0;// comment off to make it move automatically; you will have to adjust delay speed
				m_nUp=0, m_nDown=0, m_nRight=0;//see crash detector
			}

			else if (m_nKey == 77 && m_nRight==0)
			{
				cout<<" ";//comment off for trail	
				cGame::m_CursorCon(++x, y);
				cout<<"x";
				m_nKey=0;// comment off to make it move automatically; you will have to adjust delay speed
				m_nUp=0, m_nDown=0, m_nLeft=0;//see crash detector
			}

			else if (m_nKey== 27)
			{
				m_nExit=1;
			}
			cGame::m_Jump();
			cGame::m_CrashDetector();
			cGame::m_BotCon();
			m_nTime+=1;
			//----------<<*>>---------
			cGame::m_CursorCon(x, y); //THIS LINE IS IMPORTANT IT ELIMINATES THE TRAIL
			cGame::m_GravityCon(); //THIS MUST REMAIN BELOW THE ABOVE FUNCTIONS
			//----------<<*>>---------
			
			
			
			//-----------
			cGame::m_CursorCon(1, 24);
			cout<<"X:"<<x<<" Y:"<<y<<"        "<<m_nUp<<" "<<m_nDown<<" "<<m_nLeft<<" "<<m_nRight;
			cout<<"                    ";
			cGame::m_CursorCon(x, y);
			//-----------
		}while(m_nExit!=1);
		system("cls");
		m_nLives=5;
		m_nLevel=0, m_nLevel1=0, m_nLevel2=0, m_nLevel3=0, m_nLevel4=0;
		cGame::m_Reset();
	}while(1);
		
}

void cGame::m_BotCon()
{
	if(x==m_nBot1x && y==22)
		cGame::m_Die();

	if(x==m_nBot2x && y==22)
		cGame::m_Die();

	if(x==m_nBot3x && y==11)
		cGame::m_Die();

	if(x==m_nBot4x && y==22)
		cGame::m_Die();

	if(x==m_nBot5x && y==22 && m_nBot5y==23)
		cGame::m_Die();

//-----------------------------------elevator
	if(x==74 && y==m_nBot6Dir || x==75 && y==m_nBot6Dir)
	{
		m_nDown=1;
		m_nRise=m_nBot6T;
		m_nLeft=0;
		m_nRight=0;
		m_nUp=0;
		m_nJlimit=14;
		cGame::m_Rise();
	}
	if(x==74 && y==m_nBot7Dir || x==75 && y==m_nBot7Dir)
	{
		m_nDown=1;
		m_nRise=m_nBot7T;
		m_nLeft=0;
		m_nRight=0;
		m_nUp=0;
		m_nJlimit=14;
		cGame::m_Rise();
	}
	if(x==74 && y==m_nBot8Dir || x==75 && y==m_nBot8Dir)
	{
		m_nDown=1;
		m_nRise=m_nBot8T;
		m_nLeft=0;
		m_nRight=0;
		m_nUp=0;
		m_nJlimit=14;
		cGame::m_Rise();
	}
	//-------------------------------------

	if(x>38 && x<49 && y==17 && m_nBot9y==18)
		cGame::m_Die();

	if(x==m_nBot10x && y==17)
		cGame::m_Die();
	if(x==m_nBot11x && y==16)
		cGame::m_Die();
	if(x==m_nBot13x && y==11)
		cGame::m_Die();
	if(x==m_nBot14x && y==11)
		cGame::m_Die();
	if(x==m_nBot15x && y==11)
		cGame::m_Die();
	if(x==m_nBot16x && y==11)
		cGame::m_Die();
	if(x==m_nBot17x && y==11)
		cGame::m_Die();
	if(x==m_nBot19x && y==4)
		cGame::m_Die();
	if(x==m_nBot20x && y==m_nBot20y)
		cGame::m_Die();
	if(x==m_nBot21x && y==m_nBot21y)
		cGame::m_Die();
	if(x==m_nBot22x && y==m_nBot22y)
		cGame::m_Die();
	if(x==m_nBot23x && y==m_nBot23y)
		cGame::m_Die();
	if(x==m_nBot24x && y==m_nBot24y)
		cGame::m_Die();
	if(x==m_nBot25x && y==4)
		cGame::m_Die();
	if(x==m_nBot26x && y==4)
		cGame::m_Die();
	if(x==m_nBot27x && y==4)
		cGame::m_Die();
	if(x==m_nBot28x && y==4)
		cGame::m_Die();
	if(x==m_nBot29x && y==4)
		cGame::m_Die();
	if(x==m_nBot30x && y==4)
		cGame::m_Die();
	if(x==m_nBot31x && y==4)
		cGame::m_Die();
	if(x==m_nBot32x && y==4)
		cGame::m_Die();


	//<======***(BOT1)***======>
	m_nBot1T+=1;
	if(m_nBot1T==40)
	{
		if(m_nBot1x==6 && m_nBot1Dir==1)
				m_nBot1Dir=0;
		if(m_nBot1x==12)
			m_nBot1Dir=1;
		if(m_nBot1Dir==0)
			m_nBot1x+=1;
		if(m_nBot1Dir==1)
			m_nBot1x-=1;

		cGame::m_CursorCon(m_nBot1x, m_nBot1y);
		cout<<".";
		
		if(m_nBot1Dir==0 && m_nBot1x!=6)
		{
			cGame::m_CursorCon(--m_nBot1x, m_nBot1y);
			cout<<" ";
			++m_nBot1x;
		}
		if(m_nBot1Dir==1)
		{
			cGame::m_CursorCon(++m_nBot1x, m_nBot1y);
			cout<<" ";
			--m_nBot1x;
		}

		m_nBot1T=0;
	}//<=========**<<|*|>>**=========>

	//<======***(BOT2)***======>
	m_nBot2T+=1;
	if(m_nBot2T==10)
	{
		if(m_nBot2x==39 && m_nBot2Dir==1)
				m_nBot2Dir=0;
		if(m_nBot2x==55)
			m_nBot2Dir=1;
		if(m_nBot2Dir==0)
			m_nBot2x+=1;
		if(m_nBot2Dir==1)
			m_nBot2x-=1;

		cGame::m_CursorCon(m_nBot2x, m_nBot2y);
		cout<<".";
		
		if(m_nBot2Dir==0 && m_nBot2x!=39)
		{
			cGame::m_CursorCon(--m_nBot2x, m_nBot2y);
			cout<<" ";
			++m_nBot2x;
		}
		if(m_nBot2Dir==1)
		{
			cGame::m_CursorCon(++m_nBot2x, m_nBot2y);
			cout<<" ";
			--m_nBot2x;
		}

		m_nBot2T=0;		
	}//<=========**<<|*|>>**=========>


	//<======***(BOT3)***======>
	m_nBot3T+=1;
	if(m_nBot3T==20)
	{
		if(m_nBot3x==68 && m_nBot3Dir==1)
				m_nBot3Dir=0;
		if(m_nBot3x==76)
			m_nBot3Dir=1;
		if(m_nBot3Dir==0)
			m_nBot3x+=1;
		if(m_nBot3Dir==1)
			m_nBot3x-=1;

		cGame::m_CursorCon(m_nBot3x, m_nBot3y);
		cout<<".";
		
		if(m_nBot3Dir==0 && m_nBot3x!=68)
		{
			cGame::m_CursorCon(--m_nBot3x, m_nBot3y);
			cout<<" ";
			++m_nBot3x;
		}
		if(m_nBot3Dir==1)
		{
			cGame::m_CursorCon(++m_nBot3x, m_nBot3y);
			cout<<" ";
			--m_nBot3x;
		}

		m_nBot3T=0;		
	}//<=========**<<|*|>>**=========>
		

	//<======***(BOT4)***======>
	m_nBot4T+=1;
	if(m_nBot4T==20)
	{
		if(m_nBot4x==39 && m_nBot4Dir==1)
				m_nBot4Dir=0;
		if(m_nBot4x==55)
			m_nBot4Dir=1;
		if(m_nBot4Dir==0)
			m_nBot4x+=1;
		if(m_nBot4Dir==1)
			m_nBot4x-=1;

		cGame::m_CursorCon(m_nBot4x, m_nBot4y);
		cout<<".";
		
		if(m_nBot4Dir==0 && m_nBot4x!=39)
		{
			cGame::m_CursorCon(--m_nBot4x, m_nBot4y);
			cout<<" ";
			++m_nBot4x;
		}
		if(m_nBot4Dir==1)
		{
			cGame::m_CursorCon(++m_nBot4x, m_nBot4y);
			cout<<" ";
			--m_nBot4x;
		}

		m_nBot4T=0;		
	}//<=========**<<|*|>>**=========>

	//<======***(BOT5)***======>
	m_nBot5T+=1;
	if(m_nBot5T==150 && m_nBot5Dir==0)
	{
		cGame::m_CursorCon(m_nBot5x, 23);
		cout<<" ";
		cGame::m_CursorCon(m_nBot5x, m_nBot5y);
		cout<<s;
		m_nBot5y=23;
		m_nBot5Dir=1;
		m_nBot5T=0;	
	}
	if(m_nBot5T==150 && m_nBot5Dir==1)
	{	
		cGame::m_CursorCon(m_nBot5x, 22);
		cout<<" ";
		cGame::m_CursorCon(m_nBot5x, m_nBot5y);
		cout<<s;
		m_nBot5y=22;
		m_nBot5Dir=0;
		m_nBot5T=0;	
	}//<=========**<<|*|>>**=========>

	//--------------------------------Elevator------------------------------
	//<======***(BOT6)***======>
	m_nBot6T+=1;
	if(m_nBot6T==100)
	{
		if(m_nBot6y==15)
		{
			cGame::m_CursorCon(74, 15);
			cout<<"  ";
			m_nBot6y=27;
		}
		
		m_nBot6y-=1;

		if(m_nBot6y<=24){
			cGame::m_CursorCon(m_nBot6x, m_nBot6y);
			cout<<e<<e;
			cGame::m_CursorCon(m_nBot6x, ++m_nBot6y);
			cout<<"  ";
			--m_nBot6y;
		}
		m_nBot6Dir=m_nBot6y-1;		
		m_nBot6T=0;		
	}//<=========**<<|*|>>**=========>


	//<======***(BOT7)***======>
	m_nBot7T+=1;
	if(m_nBot7T==100)
	{
		if(m_nBot7y==15)
		{
			cGame::m_CursorCon(74, 15);
			cout<<"  ";
			m_nBot7y=27;
		}
		
		m_nBot7y-=1;

		if(m_nBot7y<=24){
			cGame::m_CursorCon(m_nBot7x, m_nBot7y);
			cout<<e<<e;
			cGame::m_CursorCon(m_nBot7x, ++m_nBot7y);
			cout<<"  ";
			--m_nBot7y;
		}
		m_nBot7Dir=m_nBot7y-1;
		m_nBot7T=0;		
	}//<=========**<<|*|>>**=========>

		//<======***(BOT8)***======>
	m_nBot8T+=1;
	if(m_nBot8T==100)
	{

		if(m_nBot8y==15)
		{
			cGame::m_CursorCon(74, 15);
			cout<<"  ";
			m_nBot8y=27;
		}
		
		m_nBot8y-=1;

		if(m_nBot8y<=24){
			cGame::m_CursorCon(m_nBot8x, m_nBot8y);
			cout<<e<<e;
			cGame::m_CursorCon(m_nBot8x, ++m_nBot8y);
			cout<<"  ";
			--m_nBot8y;
		}
		m_nBot8Dir=m_nBot8y-1;
		m_nBot8T=0;		
	}//<=========**<<|*|>>**=========>
	//------------------------------------------------------------------------

	//<======***(BOT9)***======>
	m_nBot9T+=1;
	if(m_nBot9T==200 && m_nBot9Dir==0)
	{
		cGame::m_CursorCon(m_nBot9x, 18);
		cout<<"          ";
		cGame::m_CursorCon(m_nBot9x, m_nBot9y);
		cout<<s<<s<<s<<s<<s<<s<<s<<s<<s<<s;
		m_nBot9y=18;
		m_nBot9Dir=1;
		m_nBot9T=0;	
	}
	if(m_nBot9T==200 && m_nBot9Dir==1)
	{	
		cGame::m_CursorCon(m_nBot9x, 17);
		cout<<"          ";
		cGame::m_CursorCon(m_nBot9x, m_nBot9y);
		cout<<s<<s<<s<<s<<s<<s<<s<<s<<s<<s;
		m_nBot9y=17;
		m_nBot9Dir=0;
		m_nBot9T=0;	
	}//<=========**<<|*|>>**=========>

	//<======***(BOT10)***======>
	m_nBot10T+=1;
	if(m_nBot10T==15)
	{
		if(m_nBot10x==49 && m_nBot10Dir==1)
				m_nBot10Dir=0;
		if(m_nBot10x==60)
			m_nBot10Dir=1;
		if(m_nBot10Dir==0)
			m_nBot10x+=1;
		if(m_nBot10Dir==1)
			m_nBot10x-=1;

		cGame::m_CursorCon(m_nBot10x, m_nBot10y);
		cout<<".";
		
		if(m_nBot10Dir==0 && m_nBot10x!=49)
		{
			cGame::m_CursorCon(--m_nBot10x, m_nBot10y);
			cout<<" ";
			++m_nBot10x;
		}
		if(m_nBot10Dir==1)
		{
			cGame::m_CursorCon(++m_nBot10x, m_nBot10y);
			cout<<" ";
			--m_nBot10x;
		}

		m_nBot10T=0;		
	}//<=========**<<|*|>>**=========>
	
		//<======***(BOT11)***======> 
	m_nBot11T+=1;
	if(m_nBot11T==50)
	{
		if(m_nBot11x==17 && m_nBot11Dir==1)
				m_nBot11Dir=0;
		if(m_nBot11x==21)
			m_nBot11Dir=1;
		if(m_nBot11Dir==0)
			m_nBot11x+=1;
		if(m_nBot11Dir==1)
			m_nBot11x-=1;

		cGame::m_CursorCon(m_nBot11x, m_nBot11y);
		cout<<".";
		
		if(m_nBot11Dir==0 && m_nBot11x!=17)
		{
			cGame::m_CursorCon(--m_nBot11x, m_nBot11y);
			cout<<" ";
			++m_nBot11x;
		}
		if(m_nBot11Dir==1)
		{
			cGame::m_CursorCon(++m_nBot11x, m_nBot11y);
			cout<<" ";
			--m_nBot11x;
		}

		m_nBot11T=0;		
	}//<=========**<<|*|>>**=========>


	//<======***(BOT12)***======>  transporter
	if(x==1 && y==16)
	{
		m_nLeft=1, m_nRight=1, m_nUp=1;
		m_nBot12T+=1;
		if(m_nBot12T==10)
		{
			cGame::m_CursorCon(1, 16);
			cout<<tr;
			m_nBot12W+=1;
		}
		if(m_nBot12T==20)
		{
			cGame::m_CursorCon(1, 16);
			cout<<"x";
			m_nBot12T=0;
		}
		if(m_nBot12W==10){
			cGame::m_CursorCon(1, 16);
			cout<<tr;
			x=79, y=10;
			m_nBot12T=0;
		}
	}

	if(x==79, y==10)
	{
		if(m_nBot12W!=9)
		{
			m_nLeft=0, m_nUp=0;
			m_nBot12T+=1;
			if(m_nBot12W==10)
			{
				cGame::m_CursorCon(x, y);
				cout<<"x";
				m_nBot12W=0;
			}

			if(m_nBot12T==10)
			{
				cGame::m_CursorCon(79, 10);
				cout<<tr;
			}
			if(m_nBot12T==20)
			{
				cGame::m_CursorCon(79, 10);
				cout<<"x";
				m_nBot12T=0;
				m_nBot12W+=1;
			}
		}

	}
	if(x==78 && y==10 || x==79 && y==9)
	{
		cGame::m_CursorCon(79, 10);
		cout<<tr;
	}//<=========**<<|*|>>**=========> 

	//<======***(BOT13)***======>
	m_nBot13T+=1;
	if(m_nBot13T==30)
	{
		if(m_nBot13x==46 && m_nBot13Dir==1)
				m_nBot13Dir=0;
		if(m_nBot13x==53)
			m_nBot13Dir=1;
		if(m_nBot13Dir==0)
			m_nBot13x+=1;
		if(m_nBot13Dir==1)
			m_nBot13x-=1;

		cGame::m_CursorCon(m_nBot13x, m_nBot13y);
		cout<<".";
		
		if(m_nBot13Dir==0 && m_nBot13x!=46)
		{
			cGame::m_CursorCon(--m_nBot13x, m_nBot13y);
			cout<<" ";
			++m_nBot13x;
		}
		if(m_nBot13Dir==1)
		{
			cGame::m_CursorCon(++m_nBot13x, m_nBot13y);
			cout<<" ";
			--m_nBot13x;
		}

		m_nBot13T=0;		
	}//<=========**<<|*|>>**=========>

	//<======***(BOT14)***======>
	m_nBot14T+=1;
	if(m_nBot14T==30)
	{
		if(m_nBot14x==33 && m_nBot14Dir==1)
				m_nBot14Dir=0;
		if(m_nBot14x==41)
			m_nBot14Dir=1;
		if(m_nBot14Dir==0)
			m_nBot14x+=1;
		if(m_nBot14Dir==1)
			m_nBot14x-=1;

		cGame::m_CursorCon(m_nBot14x, m_nBot14y);
		cout<<".";
		
		if(m_nBot14Dir==0 && m_nBot14x!=33)
		{
			cGame::m_CursorCon(--m_nBot14x, m_nBot14y);
			cout<<" ";
			++m_nBot14x;
		}
		if(m_nBot14Dir==1)
		{
			cGame::m_CursorCon(++m_nBot14x, m_nBot14y);
			cout<<" ";
			--m_nBot14x;
		}

		m_nBot14T=0;		
	}//<=========**<<|*|>>**=========>

	//<======***(BOT15)***======>
	m_nBot15T+=1;
	if(m_nBot15T==15)
	{
		if(m_nBot15x==23 && m_nBot15Dir==1)
				m_nBot15Dir=0;
		if(m_nBot15x==27)
			m_nBot15Dir=1;
		if(m_nBot15Dir==0)
			m_nBot15x+=1;
		if(m_nBot15Dir==1)
			m_nBot15x-=1;

		cGame::m_CursorCon(m_nBot15x, m_nBot15y);
		cout<<".";
		
		if(m_nBot15Dir==0 && m_nBot15x!=23)
		{
			cGame::m_CursorCon(--m_nBot15x, m_nBot15y);
			cout<<" ";
			++m_nBot15x;
		}
		if(m_nBot15Dir==1)
		{
			cGame::m_CursorCon(++m_nBot15x, m_nBot15y);
			cout<<" ";
			--m_nBot15x;
		}

		m_nBot15T=0;		
	}//<=========**<<|*|>>**=========>

	//<======***(BOT16)***======>
	m_nBot16T+=1;
	if(m_nBot16T==15)
	{
		if(m_nBot16x==11 && m_nBot16Dir==1)
				m_nBot16Dir=0;
		if(m_nBot16x==13)
			m_nBot16Dir=1;
		if(m_nBot16Dir==0)
			m_nBot16x+=1;
		if(m_nBot16Dir==1)
			m_nBot16x-=1;

		cGame::m_CursorCon(m_nBot16x, m_nBot16y);
		cout<<".";
		
		if(m_nBot16Dir==0 && m_nBot16x!=11)
		{
			cGame::m_CursorCon(--m_nBot16x, m_nBot16y);
			cout<<" ";
			++m_nBot16x;
		}
		if(m_nBot16Dir==1)
		{
			cGame::m_CursorCon(++m_nBot16x, m_nBot16y);
			cout<<" ";
			--m_nBot16x;
		}

		m_nBot16T=0;		
	}//<=========**<<|*|>>**=========>

	//<======***(BOT17)***======>
	m_nBot17T+=1;
	if(m_nBot17T==20)
	{
		if(m_nBot17x==4 && m_nBot17Dir==1)
				m_nBot17Dir=0;
		if(m_nBot17x==7)
			m_nBot17Dir=1;
		if(m_nBot17Dir==0)
			m_nBot17x+=1;
		if(m_nBot17Dir==1)
			m_nBot17x-=1;

		cGame::m_CursorCon(m_nBot17x, m_nBot17y);
		cout<<".";
		
		if(m_nBot17Dir==0 && m_nBot17x!=4)
		{
			cGame::m_CursorCon(--m_nBot17x, m_nBot17y);
			cout<<" ";
			++m_nBot17x;
		}
		if(m_nBot17Dir==1)
		{
			cGame::m_CursorCon(++m_nBot17x, m_nBot17y);
			cout<<" ";
			--m_nBot17x;
		}

		m_nBot17T=0;		
	}//<=========**<<|*|>>**=========>


	//<======***(BOT18)***======>....trap
	if(x>=4 && x<14 && y==4)
	{
		m_nTrap5=1;
	}
	if(m_nTrap5>0)	
	{
		m_nTrap5+=1;
		if(m_nTrap5==5 && m_nTrap5C!=10)
		{
			cGame::m_CursorCon(m_nTrap5x, m_nTrap5y);
			cout<<" ";
			m_nTrap5=1;
			m_nTrap5x++;
			m_nTrap5C+=1;
			m_nTrap5D+=1;
		}
	}
	if(m_nTrap5D==10 && x>=4 && x<14){
			m_nDown=0;
	}
	//<=========**<<|*|>>**=========>

	//<======***(BOT19)***======>
	m_nBot19T+=1;
	if(m_nBot19T==50)
	{
		if(m_nBot19x==14 && m_nBot19Dir==1)
				m_nBot19Dir=0;
		if(m_nBot19x==21)
			m_nBot19Dir=1;
		if(m_nBot19Dir==0)
			m_nBot19x+=1;
		if(m_nBot19Dir==1)
			m_nBot19x-=1;

		cGame::m_CursorCon(m_nBot19x, m_nBot19y);
		cout<<".";
		
		if(m_nBot19Dir==0 && m_nBot19x!=14)
		{
			cGame::m_CursorCon(--m_nBot19x, m_nBot19y);
			cout<<" ";
			++m_nBot19x;
		}
		if(m_nBot19Dir==1)
		{
			cGame::m_CursorCon(++m_nBot19x, m_nBot19y);
			cout<<" ";
			--m_nBot19x;
		}

		m_nBot19T=0;		
	}//<=========**<<|*|>>**=========>
	
	//<======***(BOT20)***======>

	if(m_nBot20Dir<3 )
	{
		m_nBot20T+=1;
		if(m_nBot20T==3)
		{
			cGame::m_CursorCon(m_nBot20x, m_nBot20y);
			cout<<" ";
			cGame::m_CursorCon(m_nBot20x, ++m_nBot20y);
			cout<<c;
			m_nBot20T=0;
			m_nBot20Dir+=1;
		}
	}
	if(m_nBot20Dir>=3)
	{
		m_nBot20T+=1;
		if(m_nBot20T==40)
		{
			cGame::m_CursorCon(m_nBot20x, m_nBot20y);
			cout<<" ";
			cGame::m_CursorCon(m_nBot20x, --m_nBot20y);
			cout<<c;
			m_nBot20T=0;
			m_nBot20Dir+=1;
			if(m_nBot20Dir==6)
				m_nBot20Dir=0;
		}
	}//<=========**<<|*|>>**=========>

	//<======***(BOT21)***======>

	if(m_nBot21Dir<3 )
	{
		m_nBot21T+=1;
		if(m_nBot21T==3)
		{
			cGame::m_CursorCon(m_nBot21x, m_nBot21y);
			cout<<" ";
			cGame::m_CursorCon(m_nBot21x, ++m_nBot21y);
			cout<<c;
			m_nBot21T=0;
			m_nBot21Dir+=1;
		}
	}
	if(m_nBot21Dir>=3)
	{
		m_nBot21T+=1;
		if(m_nBot21T==40)
		{
			cGame::m_CursorCon(m_nBot21x, m_nBot21y);
			cout<<" ";
			cGame::m_CursorCon(m_nBot21x, --m_nBot21y);
			cout<<c;
			m_nBot21T=0;
			m_nBot21Dir+=1;
			if(m_nBot21Dir==6)
				m_nBot21Dir=0;
		}
	}//<=========**<<|*|>>**=========>

	
	//<======***(BOT22)***======>

	if(m_nBot22Dir<3 )
	{
		m_nBot22T+=1;
		if(m_nBot22T==3)
		{
			cGame::m_CursorCon(m_nBot22x, m_nBot22y);
			cout<<" ";
			cGame::m_CursorCon(m_nBot22x, ++m_nBot22y);
			cout<<c;
			m_nBot22T=0;
			m_nBot22Dir+=1;
		}
	}
	if(m_nBot22Dir>=3)
	{
		m_nBot22T+=1;
		if(m_nBot22T==40)
		{
			cGame::m_CursorCon(m_nBot22x, m_nBot22y);
			cout<<" ";
			cGame::m_CursorCon(m_nBot22x, --m_nBot22y);
			cout<<c;
			m_nBot22T=0;
			m_nBot22Dir+=1;
			if(m_nBot22Dir==6)
				m_nBot22Dir=0;
		}
	}//<=========**<<|*|>>**=========>

	//<======***(BOT23)***======>

	if(m_nBot23Dir<3 )
	{
		m_nBot23T+=1;
		if(m_nBot23T==3)
		{
			cGame::m_CursorCon(m_nBot23x, m_nBot23y);
			cout<<" ";
			cGame::m_CursorCon(m_nBot23x, ++m_nBot23y);
			cout<<c;
			m_nBot23T=0;
			m_nBot23Dir+=1;
		}
	}
	if(m_nBot23Dir>=3)
	{
		m_nBot23T+=1;
		if(m_nBot23T==40)
		{
			cGame::m_CursorCon(m_nBot23x, m_nBot23y);
			cout<<" ";
			cGame::m_CursorCon(m_nBot23x, --m_nBot23y);
			cout<<c;
			m_nBot23T=0;
			m_nBot23Dir+=1;
			if(m_nBot23Dir==6)
				m_nBot23Dir=0;
		}
	}//<=========**<<|*|>>**=========>

	//<======***(BOT24)***======>

	if(m_nBot24Dir<3 )
	{
		m_nBot24T+=1;
		if(m_nBot24T==3)
		{
			cGame::m_CursorCon(m_nBot24x, m_nBot24y);
			cout<<" ";
			cGame::m_CursorCon(m_nBot24x, ++m_nBot24y);
			cout<<c;
			m_nBot24T=0;
			m_nBot24Dir+=1;
		}
	}
	if(m_nBot24Dir>=3)
	{
		m_nBot24T+=1;
		if(m_nBot24T==40)
		{
			cGame::m_CursorCon(m_nBot24x, m_nBot24y);
			cout<<" ";
			cGame::m_CursorCon(m_nBot24x, --m_nBot24y);
			cout<<c;
			m_nBot24T=0;
			m_nBot24Dir+=1;
			if(m_nBot24Dir==6)
				m_nBot24Dir=0;
		}
	}//<=========**<<|*|>>**=========>

	//<======***(BOT25)***======>
	m_nBot25T+=1;
	if(m_nBot25T==8)
	{
		if(m_nBot25x==43 && m_nBot25Dir==1)
				m_nBot25Dir=0;
		if(m_nBot25x==48)
			m_nBot25Dir=1;
		if(m_nBot25Dir==0)
			m_nBot25x+=1;
		if(m_nBot25Dir==1)
			m_nBot25x-=1;

		cGame::m_CursorCon(m_nBot25x, m_nBot25y);
		cout<<".";
		
		if(m_nBot25Dir==0 && m_nBot25x!=43)
		{
			cGame::m_CursorCon(--m_nBot25x, m_nBot25y);
			cout<<" ";
			++m_nBot25x;
		}
		if(m_nBot25Dir==1)
		{
			cGame::m_CursorCon(++m_nBot25x, m_nBot25y);
			cout<<" ";
			--m_nBot25x;
		}

		m_nBot25T=0;		
	}//<=========**<<|*|>>**=========>

	//<======***(BOT26)***======>
	m_nBot26T+=1;
	if(m_nBot26T==8)
	{
		if(m_nBot26x==43 && m_nBot26Dir==1)
				m_nBot26Dir=0;
		if(m_nBot26x==48)
			m_nBot26Dir=1;
		if(m_nBot26Dir==0)
			m_nBot26x+=1;
		if(m_nBot26Dir==1)
			m_nBot26x-=1;

		cGame::m_CursorCon(m_nBot26x, m_nBot26y);
		cout<<".";
		
		if(m_nBot26Dir==0 && m_nBot26x!=43)
		{
			cGame::m_CursorCon(--m_nBot26x, m_nBot26y);
			cout<<" ";
			++m_nBot26x;
		}
		if(m_nBot26Dir==1)
		{
			cGame::m_CursorCon(++m_nBot26x, m_nBot26y);
			cout<<" ";
			--m_nBot26x;
		}

		m_nBot26T=0;		
	}//<=========**<<|*|>>**=========>

	//<======***(BOT27)***======>
	m_nBot27T+=1;
	if(m_nBot27T==8)
	{
		if(m_nBot27x==50 && m_nBot27Dir==1)
				m_nBot27Dir=0;
		if(m_nBot27x==55)
			m_nBot27Dir=1;
		if(m_nBot27Dir==0)
			m_nBot27x+=1;
		if(m_nBot27Dir==1)
			m_nBot27x-=1;

		cGame::m_CursorCon(m_nBot27x, m_nBot27y);
		cout<<".";
		
		if(m_nBot27Dir==0 && m_nBot27x!=50)
		{
			cGame::m_CursorCon(--m_nBot27x, m_nBot27y);
			cout<<" ";
			++m_nBot27x;
		}
		if(m_nBot27Dir==1)
		{
			cGame::m_CursorCon(++m_nBot27x, m_nBot27y);
			cout<<" ";
			--m_nBot27x;
		}

		m_nBot27T=0;		
	}//<=========**<<|*|>>**=========>

	//<======***(BOT28)***======>
	m_nBot28T+=1;
	if(m_nBot28T==8)
	{
		if(m_nBot28x==57 && m_nBot28Dir==1)
				m_nBot28Dir=0;
		if(m_nBot28x==62)
			m_nBot28Dir=1;
		if(m_nBot28Dir==0)
			m_nBot28x+=1;
		if(m_nBot28Dir==1)
			m_nBot28x-=1;

		cGame::m_CursorCon(m_nBot28x, m_nBot28y);
		cout<<".";
		
		if(m_nBot28Dir==0 && m_nBot28x!=57)
		{
			cGame::m_CursorCon(--m_nBot28x, m_nBot28y);
			cout<<" ";
			++m_nBot28x;
		}
		if(m_nBot28Dir==1)
		{
			cGame::m_CursorCon(++m_nBot28x, m_nBot28y);
			cout<<" ";
			--m_nBot28x;
		}

		m_nBot28T=0;		
	}//<=========**<<|*|>>**=========>

	//<======***(BOT29)***======>
	m_nBot29T+=1;
	if(m_nBot29T==8)
	{
		if(m_nBot29x==57 && m_nBot29Dir==1)
				m_nBot29Dir=0;
		if(m_nBot29x==62)
			m_nBot29Dir=1;
		if(m_nBot29Dir==0)
			m_nBot29x+=1;
		if(m_nBot29Dir==1)
			m_nBot29x-=1;

		cGame::m_CursorCon(m_nBot29x, m_nBot29y);
		cout<<".";
		
		if(m_nBot29Dir==0 && m_nBot29x!=57)
		{
			cGame::m_CursorCon(--m_nBot29x, m_nBot29y);
			cout<<" ";
			++m_nBot29x;
		}
		if(m_nBot29Dir==1)
		{
			cGame::m_CursorCon(++m_nBot29x, m_nBot29y);
			cout<<" ";
			--m_nBot29x;
		}

		m_nBot29T=0;		
	}//<=========**<<|*|>>**=========>

	//<======***(BOT30)***======>
	m_nBot30T+=1;
	if(m_nBot30T==13)
	{
		if(m_nBot30x==64 && m_nBot30Dir==1)
				m_nBot30Dir=0;
		if(m_nBot30x==76)
			m_nBot30Dir=1;
		if(m_nBot30Dir==0)
			m_nBot30x+=1;
		if(m_nBot30Dir==1)
			m_nBot30x-=1;

		cGame::m_CursorCon(m_nBot30x, m_nBot30y);
		cout<<".";
		
		if(m_nBot30Dir==0 && m_nBot30x!=64)
		{
			cGame::m_CursorCon(--m_nBot30x, m_nBot30y);
			cout<<" ";
			++m_nBot30x;
		}
		if(m_nBot30Dir==1)
		{
			cGame::m_CursorCon(++m_nBot30x, m_nBot30y);
			cout<<" ";
			--m_nBot30x;
		}

		m_nBot30T=0;		
	}//<=========**<<|*|>>**=========>

	//<======***(BOT31)***======>
	m_nBot31T+=1;
	if(m_nBot31T==13)
	{
		if(m_nBot31x==64 && m_nBot31Dir==1)
				m_nBot31Dir=0;
		if(m_nBot31x==76)
			m_nBot31Dir=1;
		if(m_nBot31Dir==0)
			m_nBot31x+=1;
		if(m_nBot31Dir==1)
			m_nBot31x-=1;

		cGame::m_CursorCon(m_nBot31x, m_nBot31y);
		cout<<".";
		
		if(m_nBot31Dir==0 && m_nBot31x!=64)
		{
			cGame::m_CursorCon(--m_nBot31x, m_nBot31y);
			cout<<" ";
			++m_nBot31x;
		}
		if(m_nBot31Dir==1)
		{
			cGame::m_CursorCon(++m_nBot31x, m_nBot31y);
			cout<<" ";
			--m_nBot31x;
		}

		m_nBot31T=0;		
	}//<=========**<<|*|>>**=========>

	//<======***(BOT32)***======>
	m_nBot32T+=1;
	if(m_nBot32T==13)
	{
		if(m_nBot32x==64 && m_nBot32Dir==1)
				m_nBot32Dir=0;
		if(m_nBot32x==76)
			m_nBot32Dir=1;
		if(m_nBot32Dir==0)
			m_nBot32x+=1;
		if(m_nBot32Dir==1)
			m_nBot32x-=1;

		cGame::m_CursorCon(m_nBot32x, m_nBot32y);
		cout<<".";
		
		if(m_nBot32Dir==0 && m_nBot32x!=64)
		{
			cGame::m_CursorCon(--m_nBot32x, m_nBot32y);
			cout<<" ";
			++m_nBot32x;
		}
		if(m_nBot32Dir==1)
		{
			cGame::m_CursorCon(++m_nBot32x, m_nBot32y);
			cout<<" ";
			--m_nBot32x;
		}

		m_nBot32T=0;		
	}//<=========**<<|*|>>**=========>


}//end botcon function



void cGame::m_Jump()
{
	cGame::m_CursorCon(x, y);
	if(m_nJump==1)
	{
		m_nJumpS+=1;
		m_nGravOff=1;
		if(m_nJumpS==6)//controls up-time of jump---- (ascend)
		{//											|
			if(y>m_nJlimit){//						|
				m_nDown=0, m_nRight=0, m_nLeft=0;//	|
				cout<<" ";//comment off for trail	|
				cGame::m_CursorCon(x, --y);//		|
				cout<<"x";//                        |
				cGame::m_CursorCon(x, y);//         |
			}//										|
			m_nJumpT+=1;//							|
			if(m_nJumpT!=3)//controls height of jump|
				m_nJumpS=0;//						|
		}//                                         |
		//							                |
		if(m_nJumpS==18)//controls down-time of jump| (descend)
		{
			m_nJumpS=0, m_nJumpT=0, m_nJump=0, m_nKey=0, m_nGravOff=0;
			m_nDown=0, m_nRight=0, m_nLeft=0;//see crash detector;
		}
	}
	//cGame::m_CursorCon(x, y);
}

void cGame::m_GravityCon()
{
	m_nGravity+=1;
	if(m_nGravity>=20 && m_nDown==0 && m_nGravOff==0)
	{
		cout<<" ";
		cGame::m_CursorCon(x, ++y);
		cout<<"x";
		cGame::m_CursorCon(x, y);
		m_nUp=0;
		m_nGravity=0;
	}
}

//---------------------for elevators
void cGame::m_Rise()
{
	if(m_nRise==99 && y!=14){
		m_nGravOff=1;
		cout<<" ";
		cGame::m_CursorCon(x, --y);
		cout<<"x";
		m_nRise=0;
	}
	if(y==14 && m_nRise==99)
		m_nGravOff=0, m_nDown=0;
	m_nRiseA=1;

}

void cGame::m_CrashDetector()
{
	//<-----***crash detection***----->
			if(x==0){   
				m_nLeft=1;
			}
			if(x==79){
				m_nRight=1;
			}
			if(y==1){
				m_nUp=1;
			}
			if(y==22){
				if(x!=26 && x!=35 && x!=36 && x!=37 && x!=38 && x<68)
					m_nDown=1;
			}
			//-------------jump limiter
			if(y>19 && x<68)
				m_nJlimit=19;
			if(y>18 && y<13)
				m_nJlimit=19;
			if(y==14)
				m_nJlimit=14;
			if(y==10)
				m_nJlimit=8;
			if(x==0 && y==8)
				m_nJlimit=1, m_nRight=0;
			if(x==1 && y==8 || x==1 && y==9)
				m_nJlimit=8;
			//-------------

			if(y==23 && x>73 || y==24 && x>73){
				m_nLeft=1;
				m_nRight=1;
				m_nUp=1;
			}
			if(y==17){
				if(x<70 && x!=61 && x!=26 && x!=9 && x!=10 && x!=11 && x!=35 && x!=36 && x!=37 && x!=38)
					m_nDown=1;
			}
			
			if(y==4)
			{
				if(x==0 || x==1 || x==2)
					m_nDown=0;
				if(x==3 || x>13 && x!=33 && x!=34 && x!=36 && x!=38 && x!=40)
					m_nDown=1;
				if(m_nTrap5D!=10 && x>=4 && x<14)
					m_nDown=1;
			}


			//---------for elevator
			if(x>77 && y==10)
				m_nDown=1, m_nUp=0;


			if(y==11){
				if(x!=77 && x!=67 && x!=65 && x!=63 && x!=61 && x!=59 && x!=57 && x!=55 && x!=42 && x!=43 && x!=44 && x!=45 && x!=17 && x!=18) 
					m_nDown=1;
			}
			
			if(y==12 && x==17 || y==12 && x==18)
				cGame::m_Die();
			if(y==13)
			{
				if(x==67)
					cGame::m_Die();
				if(x==65)
					cGame::m_Die();
				if(x==63)
					cGame::m_Die();
//				if(x==61)
//					cGame::m_Die();
				if(x==59)
					cGame::m_Die();
				if(x==57)
					cGame::m_Die();
				if(x==55)
					cGame::m_Die();
			}

			if(y==12 && x>40)
				m_nLeft=1, m_nRight=1;
			if(y==14 && x>40)
				m_nLeft=0, m_nRight=0;
			
			if(y==19){
				if(x<70)
					m_nUp=1;
			}
			if(x==70 && y==18)
				m_nLeft=1;
			
			if(y==18 && x<70)
				m_nLeft=1, m_nRight=1;
			if(y==19)
				m_nLeft=0, m_nRight=0;

			if(y==24)
				cGame::m_Die();//activate the function of DEATH

			if(x==73 && m_nRiseA==1 && m_nJump==0 || x==75 && m_nRiseA==1 && m_nJump==0){
				m_nGravOff=0;
				m_nRiseA=0;//allows player to leave the elevator
			}
			if(x==73 && m_nRiseA==1 && m_nJump==1 || x==75 && m_nRiseA==1 && m_nJump==1){
				m_nRiseA=0;
			}//allows player to leave the elevator
			
			
	//----------------------------TRAP------------>
			if(y==17 && x>34 && x<39)
			{
				if(m_nTrap1!=-1 && m_nTrap2!=-1 && m_nTrap3!=-1 && m_nTrap4!=-1){ 
					if(m_nTrap1!=100 || m_nTrap2!=100 || m_nTrap3!=100 || m_nTrap4!=100)
						m_nDown=1;
					if(x==35)
						m_nTrap1+=1;
					if(x==36)
						m_nTrap2+=1;
					if(x==37)
						m_nTrap3+=1;
					if(x==38)
						m_nTrap4+=1;
				}	
			}

			if(m_nTrap1>=1)
				m_nTrap1+=1;
			if(m_nTrap1>=100){
				cGame::m_CursorCon(35, 18);
				cout<<" ";
				m_nTrap1=-1;
			}
			if(x==35 && m_nTrap1==-1 && y==17)
				m_nDown=0;

			if(m_nTrap2>=1)
				m_nTrap2+=1;
			if(m_nTrap2>=100){
				cGame::m_CursorCon(36, 18);
				cout<<" ";
				m_nTrap2=-1;
			}
			if(x==36 && m_nTrap2==-1 && y==17)
				m_nDown=0;

			if(m_nTrap3>=1)
				m_nTrap3+=1;
			if(m_nTrap3>=100){
				cGame::m_CursorCon(37, 18);
				cout<<" ";
				m_nTrap3=-1;
			}
			if(x==37 && m_nTrap3==-1 && y==17)
				m_nDown=0;
			
			if(m_nTrap4>=1)
				m_nTrap4+=1;
			if(m_nTrap4>=100){
				cGame::m_CursorCon(38, 18);
				cout<<" ";
				m_nTrap4=-1;
			}
			if(x==38 && m_nTrap4==-1 && y==17)
				m_nDown=0;

			//----------------------------ENDTRAP------------>

			//---------------Block1
			if(x==5 && y==21){
				m_nDown=1;
			}
			if(x==4 && y==22){
				m_nRight=1;
			}
			if(x==6 && y==22){
				m_nLeft=1;
			}

			//---------------Block2
			if(x==13 && y==21){
				m_nDown=1;
			}
			if(x==12 && y==22){
				m_nRight=1;
			}
			if(x==14 && y==22){
				m_nLeft=1;
			}

			//---------------Block3
			if(x==21 && y==22){
				m_nRight=1;
			}
			if(x==22 && y==21){
				m_nDown=1;
				m_nRight=1;
			}
			if(x==23 && y==20){
				m_nDown=1;
			}
			if(x==24 && y==20){
				m_nDown=1;
			}
			if(x==25 && y==21){
				m_nDown=1;
				m_nLeft=1;
			}
			if(x==26 && y==22){
				m_nLeft=1;
			}

			//---------------Block4
			if(x==55 && y==22){
				m_nRight=1;
			}
			if(x==56 && y==21){
				m_nDown=1;
			}
			if(x==57 && y==22){
				m_nLeft=1;
			}
			
			//---------------Block5
			if(x==22 && y==17)
				m_nLeft=1;
			if(x==16 && y==17)
				m_nRight=1;
			if(x<22 && x>16 && y==16)
				m_nDown=1;
			
			//---------------Block6
			if(x==15 && y==17 || x==14 && y==17)
				 m_nUp=1;
			if(x==13 && y==16)  
				 m_nRight=1;
			if(x==13 && y==17)
				m_nRight=0;
			if(x==16 && y==16)
				 m_nLeft=1;
			if(x==16 && y==17)
				m_nLeft=0; 
			if(x==15 && y==15 || x==14 && y==15)
				 m_nDown=1;

			//---------------Block7
			if(x==7 && y==17)
				m_nLeft=1;
			if(x<7 && y==16)
				m_nDown=1;

			//---------------Block8
			if(x==77 && y==11)
				m_nRight=1;
			if(x==77 && y==10)
				m_nRight=0;
			if(x==78 && y==10)
				m_nRight=1;
			if(x==79 && y==9)
				m_nDown=1;

			//---------------Block9
			if(x==53 && y==11)
				m_nRight=1;
			if(x==55 && y==11)
				m_nLeft=1;
			if(x==54 && y==10)
				m_nDown=1;

			//---------------Block10
			if(x==33 && y==11)
				m_nLeft=1;
			if(x==27 && y==11)
				m_nRight=1;
			if(x==32 && y==10)
				m_nDown=1, m_nLeft=1;
			if(x==28 && y==10)
				m_nDown=1, m_nRight=1;
			if(x<32 && x>28 && y==9)
				m_nDown=1;

			//---------------Block11
			if(x==23 && y==11)
				m_nLeft=1;
			if(x==18 && y==11)
				m_nRight=1;
			if(x==22 && y==10)
				m_nDown=1, m_nLeft=1;
			if(x==19 && y==10)
				m_nDown=1, m_nRight=1;
			if(x<22 && x>19 && y==9)
				m_nDown=1;

			//---------------Block12
			if(x==17 && y==11)
				m_nLeft=1;
			if(x==13 && y==11)
				m_nRight=1;
			if(x==16 && y==10)
				m_nDown=1, m_nLeft=1;
			if(x==14 && y==10)
				m_nDown=1, m_nRight=1;
			if(x==15 && y==9)
				m_nDown=1;

			//---------------Block13
			if(x==11 && y==11)
				m_nLeft=1;
			if(x==7 && y==11)
				m_nRight=1;
			if(x==10 && y==10)
				m_nDown=1, m_nLeft=1;
			if(x==8 && y==10)
				m_nDown=1, m_nRight=1;
			if(x==9 && y==9)
				m_nDown=1;

			//---------------Block14
			if(x==4 && y==11)
				m_nLeft=1;
			if(x==3 && y==10)
				m_nDown=1;
			if(x==2 && y==10)
				m_nDown=1, m_nLeft=1;
			if(x==1 && y==9)
				m_nDown=1, m_nLeft=1;
			if(x==0 && y==8)
				m_nDown=1;
			
			//---------------Block15
			if(x==0 && y==7)
				m_nRight=1;
			if(x==1 && y==6)
				m_nRight=1, m_nDown=1;
			if(x==2 && y==5)
				m_nRight=1, m_nDown=1;

			//---------------Block16
			if(x==41 && y==4)
				m_nRight=1;
			if(x==43 && y==4)
				m_nLeft=1;
			if(x==42 && y==3)
				m_nDown=1;

			//---------------Block17					
			if(x==41 && y==6)
				m_nDown=1, m_nRight=1;
			if(x==41 && y==5)
				m_nRight=1;
			
			//---------------Block18
			if(x>3 && y==5)
				m_nLeft=1, m_nRight=1;
			if(x>3 && y==7)
				cGame::m_Die();

			//---------------Block19
			if(x==48 && y==4)
				m_nRight=1;
			if(x==49 && y==3)
				m_nDown=1;
			if(x==50 && y==4)
				m_nLeft=1;

			//---------------Block19
			if(x==55 && y==4)
				m_nRight=1;
			if(x==56 && y==3)
				m_nDown=1;
			if(x==57 && y==4)
				m_nLeft=1;

			//---------------Block20
			if(x==62 && y==4)
				m_nRight=1;
			if(x==63 && y==3)
				m_nDown=1;
			if(x==64 && y==4)
				m_nLeft=1;

			//---------------Block21
			if(x==76 && y==4)
				m_nRight=1;
			if(x>76 && y==3)
				m_nDown=1;
			if(x==79 && y==3)
				cGame::m_Win();

			//---------------Level Change
			if(x>69 && x<=79)
			{
				if(y==18 && m_nLevel2==0)
				{
					m_nLevel2=1;
					cGame::m_Level2();
				}
			}
			if(x==1 && y==16 && m_nLevel3==0)
			{
				m_nLevel3=1;
				cGame::m_Level3();
			}
			if(x==0 && y==8 && m_nLevel4==0)
			{
				m_nLevel4=1;
				cGame::m_Level4();
			}




	//<-----***crash detection***----->
}

void cGame::m_CursorCon(int x, int y)
{
	COORD coord;
	coord.X = x;
	coord.Y = y;
	SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord);
}

void cGame::m_Win()
{
	system("cls");
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<endl;
	cout<<"                               CONGRATULATIONS"<<endl;
	cout<<"                             YOU HAVE ESCAPED!!!"<<endl;
	unsigned long delay = GetTickCount() + (1000);
		while (GetTickCount() < delay) { }
	cout<<endl;
	cout<<endl;
	cout<<endl;
	system("pause");
	system("cls");
	m_nJlimit=19;
	m_nLives=5;
	y=22;
	x=0;
	m_nLevel=0, m_nLevel1=0, m_nLevel2=0, m_nLevel3=0, m_nLevel4=0;
	cGame::m_Reset();
	cGame::m_InputCon();
}


void cGame::m_Die()
{
	system("cls");
	if(m_nLives!=0)
	{
		m_nLives-=1;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<"                           YOU HAVE DIED"<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<"Lives:"<<m_nLives<<endl;
		unsigned long delay = GetTickCount() + (500);
			while (GetTickCount() < delay) { }
		cout<<endl;
		cout<<endl;
		cout<<endl;
		system("pause");
		system("cls");
		if(m_nLevel==1)
			x=0, y=19, m_nJlimit=19;
		if(m_nLevel==2)
			x=69, y=14, m_nJlimit=14;
		if(m_nLevel==3)
			x=78, y=8, m_nJlimit=8;
		if(m_nLevel==4)
			x=1, y=1, m_nJlimit=1;
		cGame::m_Reset();
		cGame::m_Map();
	}
	else{
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<endl;
		cout<<"                              GAME OVER"<<endl;
		cout<<"                      YOU HAVE FAILED TO ESCAPE"<<endl;
		unsigned long delay = GetTickCount() + (1000);
			while (GetTickCount() < delay) { }
		cout<<endl;
		cout<<endl;
		cout<<endl;
		system("pause");
		m_nLives=5;
		m_nLevel=0, m_nLevel1=0, m_nLevel2=0, m_nLevel3=0, m_nLevel4=0;
		system("cls");
		cGame::m_Reset();
		cGame::m_InputCon();
	}

}

void cGame::m_Reset()
{
	if(m_nLevel==0)
		m_nJlimit=19, m_nLives=5, y=19,	x=0, m_nLevel=1;
//	y=22;
//	x=0;
	m_nCount=0;
	m_nExit=0;
	m_nBot1x=6;
	m_nBot1y=22;
	m_nBot1T=0;
	m_nSpeed=1;
	m_nTime=0;
	m_nBot1Dir=0;
	m_xCrash=0;
//	m_nLives=5;
	m_nKey=0;
	m_yCrash=0;
	m_nUp=0;
	m_nDown=0;
	m_nLeft=0;
	m_nRight=0;
	m_nGravity=0;
	m_nGravOff=0;
	m_nDie=0;
	m_nJump=0;
	m_nJumpT=0;
	m_nJumpS=0;
	m_nReverseBot=0;
//	m_nJlimit=19;
	m_nRise=0;
	m_nRiseA=0;
	m_nTrap1=0;
	m_nTrap2=0;
	m_nTrap3=0;
	m_nTrap4=0;
	m_nTrap5=0, m_nTrap5x=4, m_nTrap5y=5, m_nTrap5C=0, m_nTrap5D=0, m_nTrap10=0, m_nTrap11=0;
	m_nBot2x=39, m_nBot2T=0, m_nBot2Dir=0, m_nBot2y=22;
	m_nBot3x=76, m_nBot3T=0, m_nBot3Dir=1, m_nBot3y=11;
	m_nBot4x=45, m_nBot4T=0, m_nBot4Dir=1, m_nBot4y=22;
	m_nBot5x=61, m_nBot5T=0, m_nBot5Dir=0, m_nBot5y=22;
	m_nBot6x=74, m_nBot6T=0, m_nBot6y=24;
	m_nBot7x=74, m_nBot7T=0, m_nBot7y=20;
	m_nBot8x=74, m_nBot8T=0, m_nBot8y=16;
	m_nBot9x=39, m_nBot9T=0, m_nBot9Dir=0, m_nBot9y=17;
	m_nBot10x=60, m_nBot10T=0, m_nBot10Dir=1, m_nBot10y=17;
	m_nBot11x=19, m_nBot11T=0, m_nBot11Dir=0, m_nBot11y=16;
	m_nBot12T=0, m_nBot12W=0;
	m_nBot13x=46, m_nBot13T=0, m_nBot13Dir=0, m_nBot13y=11;
	m_nBot14x=41, m_nBot14T=0, m_nBot14Dir=1, m_nBot14y=11;
	m_nBot15x=23, m_nBot15T=0, m_nBot15Dir=0, m_nBot15y=11;
	m_nBot16x=13, m_nBot16T=0, m_nBot16Dir=1, m_nBot16y=11;
	m_nBot17x=4, m_nBot17T=0, m_nBot17Dir=0, m_nBot17y=11;
	m_nBot19x=14, m_nBot19T=0, m_nBot19Dir=0, m_nBot19y=4;
	m_nBot20T=0, m_nBot20x=22, m_nBot20y=1, m_nBot20Dir=0;
	m_nBot21x=24, m_nBot21T=0, m_nBot21Dir=3, m_nBot21y=4;
	m_nBot22x=26, m_nBot22T=0, m_nBot22Dir=0, m_nBot22y=1;
	m_nBot23x=28, m_nBot23T=0, m_nBot23Dir=3, m_nBot23y=4;
	m_nBot24x=30, m_nBot24T=0, m_nBot24Dir=0, m_nBot24y=1;
	m_nBot25x=43, m_nBot25T=0, m_nBot25Dir=0, m_nBot25y=4;
	m_nBot26x=48, m_nBot26T=0, m_nBot26Dir=1, m_nBot26y=4;
	m_nBot27x=50, m_nBot27T=0, m_nBot27Dir=0, m_nBot27y=4;
	m_nBot28x=57, m_nBot28T=0, m_nBot28Dir=0, m_nBot28y=4;
	m_nBot29x=62, m_nBot29T=0, m_nBot29Dir=1, m_nBot29y=4;
	m_nBot30x=64, m_nBot30T=0, m_nBot30Dir=0, m_nBot30y=4;
	m_nBot31x=76, m_nBot31T=0, m_nBot31Dir=1, m_nBot31y=4;
	m_nBot32x=70, m_nBot32T=0, m_nBot32Dir=1, m_nBot32y=4;
//	m_nLevel=0, m_nLevel1=0, m_nLevel2=0, m_nLevel3=0, m_nLevel4=0;
}


int main()
{
	cGame load;
	load.m_InputCon();
	return 0;
}




//void gotoxy(int x, int y); //***Cursor Movement***
/*
void gotoxy(int x, int y) //***Cursor Movement***
{
   COORD coord;
   coord.X = x;
   coord.Y = y;
   SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE), coord);
}*/




