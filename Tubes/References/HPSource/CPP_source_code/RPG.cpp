			/////////////////////////////
			//		    RPG            //
			//	Created by Tom Woodman //
			//		   E-mail:         //
			// Xterria@Xterria.cjb.net //
			//         Website:		   //
            //http://xterria.cjb.net   //
			/////////////////////////////


#include <iostream.h>						//For the usual stuff
#include <windows.h>						//For setting the txt
#include <string.h>							//For any input strings
#include <stdio.h>							//For some stuff
int newgame();
int death(char string[50]);
int task1(), task2(), task3(), task4(), task5();
int passwords();
int main()									//Starting main()
{
int input;									//Any sort of input that the program requires

SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
cout << "\t\t\t\tX T E R R I A" << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_INTENSITY);
cout << "   \t\t\t\t    R P G\n" << endl;
cout << endl;

SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
cout << "\n1:" << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_BLUE | FOREGROUND_INTENSITY);
cout << "New Game" << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
cout << "\n2:" << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_BLUE | FOREGROUND_INTENSITY);
cout << "Load Game" << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
cout << "\n3:" << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_BLUE | FOREGROUND_INTENSITY);
cout << "Exit" << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_INTENSITY);
cout << "\nSelection:";
cin >> input;
while (1)
{
if (input == 1)								//Starting a New Game?
{
	newgame();
	break;
}
else if (input == 2)
{
	passwords();							//Loading a Game?
	
}
else if (input == 3)						//Leaving?
{
	break;
}
else										//being a moron?
{
	cout << "Your Selection is Invalid\n";
	break;
	
}


}return 0;}



int newgame()								//Starting a New Game
{
char input2[50];
int x;
for (x=0; x<70; x++)
{
	cout << endl;
}
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
cout << "\t\t\t\tX T E R R I A" << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_INTENSITY);
cout << "   \t\t\t\t    R P G\n" << endl;
cout << endl;
cout << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_BLUE | FOREGROUND_INTENSITY);
cout << "Your name is Al, and you have just come back from a fishing trip." << endl;
cout << "When you get home, you see that your wife is not there. You walk in." << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_INTENSITY);
cout << "Type in anything and hit enter to go on:";
cin >> input2;
cout << endl;
cout << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED| FOREGROUND_INTENSITY);
cout << "\"PUT EM UP!\"" << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_BLUE | FOREGROUND_INTENSITY);
cout << "You get knocked out from behind." << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_INTENSITY);
cout << "\n5 minutes later..." << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
cout << "\n\n\"Huh...Where am I?\" "<< endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_BLUE | FOREGROUND_INTENSITY);
cout << "You look around, you see nothing.\n...except your cat, Frisky." << endl;

SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_INTENSITY);
cout << "Type anything and hit enter to go on:";
cin >> input2; cout << endl;



SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_BLUE | FOREGROUND_INTENSITY);
cout << "You hear a noise coming from outside..." << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
cout << "\"Move your butt, Fragis!\"" << endl;
cout << "\"Em\' Sorrrrry, Motty!\"" << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_BLUE | FOREGROUND_INTENSITY);
cout << endl;
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_INTENSITY);
cout << "Type in anything and hit enter to go on:";
cin >> input2;
cout << "\n";
SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);

for (x=0; x<70; x++)
{
	cout << endl;
}
cout << "--Instructions--" << endl;
cout << "You've read the story. Now you know what is going on." << endl;
cout << "Everytime you see a" << endl;
cout << "--" << endl;
cout << "You will know the game is waiting for your response." << endl;
cout << "You must type in the corrisponding letter or number of you choice," << endl;
cout << "and hit enter." << endl;
cout << "Also, once you get to a point in the story, the game will give you a password.";
cout << "To warp to the point that you last got the password, simply at the menu when";
cout << "\nyou first start to run the game, just select \'load game\'\n and type in the password" << endl;
cout << "You received. It's as simple as that." << endl;
cout << "The program will now clear the screen and you will start the game..." << endl;
cout << "Type anything and hit enter to continue...";
cin  >> input2;
task1();
return -6872;
}


int death(char string[50])
{
	char choice;
	
	for (int x=0; x<70; x++)
	{
		cout << endl;
	}
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_INTENSITY | BACKGROUND_RED);
	for (int y=0; y<95; y++)
	{
		cout << "\t";
	}
	cout << string << endl;
	cout << "\nYou have died. Would you like to play again(Y/N)?";
	for (int z=0; z<95; z++)
	{
		cout << "\t";
	}
	cin >> choice;
	while(1)
	{
	if (choice == 'y' || choice == 'Y')
	{
		main();
	}
	else if (choice == 'n' || choice == 'N')
	{
		break;
	}
	}
	return 0;
}
	

int task1()        // Right after you hear the story and instructions
{
	for(int x=0; x<70; x++)
	{
		cout << endl;
	}
	char choice;
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);
	cout << "You get up from the ground, you hear their car start!" << endl;
	while (1)
	{
		cout << "--" << endl;
		cout << "A: Chase after the car" << endl;
		cout << "B: Grab your gun and run out" << endl;
		cout << "C: Be carefull and call the cops" << endl;
		cin  >> choice;
		if (choice == 'a' || choice == 'A')
		{
			cout << endl;
			cout << endl;
		 
			death(""
			
			"\nYou run out,you get about 5 feet away from the car\n"
			"and are about to grab it and get on, but both back doors\n" 
			"of the truck swing open and several rounds of bullets go into\n"
			"your chest."
			"");
		}
		 if (choice == 'b' || choice == 'B')
		{
			cout << endl;
			cout << endl;
			cout << "You run out with your gun..." << endl;
			cout << "You try to catch up to it..." << endl;
			cout << "pant..pant..it's no use." << endl;
			continue;
		}
		 if (choice == 'c' || choice == 'C')
		{
			cout << endl;
			cout << endl;
			cout << "You call the cops.";
            task2();	break;	
		}
		
	}
return 0;
}



int task2()
{
		for(int x=0; x<70; x++)
		{
			cout << endl;
		}
		char choice;
		
		cout << "A woman responds:" << endl;
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
		cout << "\"911...How may I help you?\"" << endl;
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);
		cout << "Oh no! your cat frisky has bitten the line! Now what?";
		while (1)
		{

		cout << "--" << endl;
		cout << "\nA: Go to the bathroom" << endl;
		cout << "B: Scold Frisky"<< endl;
		cout << "C: Go next door" << endl;
		cin >> choice;
		if (choice == 'a' || choice == 'A')
		{
			cout << "O.K... You've gone to the bathroom...now what?";
			continue;
		}
		if (choice == 'b' || choice == 'B')
		{
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
			cout << "\"Bad Frisky! Bad! Kitty!\"" << endl;
			cout << "\"HISSSSSS.....MEAOWWWWWWWWW\"" << endl;
			
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);
			
			
			death("Bad Frisky! Bad Kitty!\nHISSSSS...MEAOOWWWWWWWW!!!!!");
			break;
		}
		if (choice == 'c' || choice == 'C')
		{
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);

			
			task3(); break;
		}
		}
		
		return 0;
}



int task3()
{
	for (int x=0; x<75; x++)
	{
		cout << endl;
	}
	char choice;
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_INTENSITY);
	cout << "Password:" << endl;
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_GREEN);
	cout << "ABB712" << endl;
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);
				cout << "You walk next door, about to ring the doorbell...";
			cout << "\nWhipp...!" << endl;
			cout << "WHAA! YOU'VE BEEN CAUGHT IN A NET!" << endl;
			cout << "The People next door sure are cautious..." << endl;
			
			
			while (1)
			{
			cout << "--" << endl;
			cout << "A: Call For Help" << endl;
			cout << "B: Bite the net" << endl;
			cout << "C: Close your eyes and count to 10" << endl;
			cin >> choice;
			if (choice == 'a' || choice == 'A')
			{
				task4(); break;
			}
			if (choice == 'b' || choice == 'B')
			{
				death("\n"
				"You try biting the net...nothing happens.\n"
				"Sept all your teeth fall out! AHHHHAHAHAHAHA\n"
				""); break;
			}
			if (choice == 'c' || choice == 'C')
			{
				cout << "This isn't the shineing...\n";
				continue;
			}
			}
	
	return 0;
}


int passwords()
{
	char password[10];
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);
	cout << "Enter Password:";
	cin >> password;
	if (strcmp (password, "ABB712")==0)
	{
		task3();
	}
		if (strcmp (password, "XSNARF")==0)
	{
		task5();
	}
	else
	{
		cout << "Incorrect Password." << endl;
		main();
	}
return 0;
}

int task4()
{
	char choice;	
	SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);
		for (int x=0; x<90; x++)
		{
			cout << endl;
		}
		cout << "You see somthing move in the bushes..." << endl;
		cout << "It's...It's..." << endl;
		cout << "A HOMELESS GUY...?" << endl;
		cout << "\nHe walks up to you..." << endl;
		cout << "\nHomeless guy:" << endl;
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
		cout << "\"explosions...\"" << endl;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);
		cout << "You:" << endl;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
		cout << "\"What?\"" << endl;
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);
		cout << "Homeless guy:" << endl;	
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
			
			cout << "\"explosions...!!!!\"" << endl;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);
		cout << "You:" << endl;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
		cout << "\"Ok, whatever. Could you please get me down from here?\""<<endl;
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);
		cout << "Homeless guy:" << endl;
		SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
					
			cout << "\"i HAVE liberTY...NO MORE explosions...\""  << endl;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);
		cout << "He is obviously drunk." << endl;
		
		while(1){
		cout << "\n--"<<endl;
		cout << "A: Smack him" << endl;
		cout << "B: Yell at him" << endl;
		cout << "C: Shoot him" << endl;
		cin >> choice;
		if (choice == 'a' || choice == 'A')
		{
			death(""
			"\nYou stick out your hand to smack him,"
			"But he thinks one of your fingers is"
			"a ciggie."
			"");break;
		}
		if (choice == 'b' || choice == 'B')
		{
			task5();
			break;
		}
		if (choice == 'C' || choice == 'c')
		{
			cout << "Yeah, sure. If you had a gun.";
			continue;
		}
		}
return 0;
}


int task5()
{
			for (int x=0; x<90; x++)
			{
				cout << endl;
			}
			char input[50];
			cout << "You yell at him. He panics," << endl;
			cout << "and cuts you loose and tells" <<endl;
			cout << "You to stop all the explosions." << endl;
			cout << endl;
			cout << "Wait a minute...!" <<endl;
			cout << "That's Motty's and Fragis's truck!" << endl;
			cout << "They've been in an accident!" << endl;
			cout << "Better go check it out!" << endl;
			cout << "Your wife is alive!" << endl;
			cout << "Type anything and hit enter to continue" << endl;
			cin >> input;
			for (int y=0; y<90; y++)
			{
				cout << endl;
			}
			
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_RED | FOREGROUND_INTENSITY);
			cout << "\"OHH ALLLL.....\"" << endl;
			cout << "\"TANKS FOR TAVING ME!\"" << endl;
			cout << "\"Welcome, hunny...\""<< endl;
			cout << "\"I'M NOT HUNNY!!!!!!\"" << endl;
			
				
				cout << "Type anything and hit enter to continue:" << endl;
				cin >> input;
				cout << endl;
			SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE),FOREGROUND_GREEN | FOREGROUND_BLUE);
			death (""
			"\nWelp, it looks like your wife was actually fragis.\n"
			"I'm glad you wasted all your time playing this.\n"
			"Sucks for you.\n"
			"Oh yeah, password: XSNARF"
			"");
			return 0;
}
