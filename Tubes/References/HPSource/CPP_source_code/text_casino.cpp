#include <iostream>
#include <cmath> 

#include "stdlib.h" 
#include "time.h"
 
using namespace std; 

int catsEye();

short drink();
short roulette();
short blackjack(); 
short lotto();
short slots();
short dice();
short tictactoe();
short surprise();

bool winner1();					
bool winner2();
bool card_check();

void card_gen();
void card_determine();
void booze_check();
void IntermediateAI();			
void gridDisplay();
void cleargrid();

long bet, cash, money_steal, bet_amount, playerwins; 
char name[16], game[5]; 
short unsigned alcohol_rating, z = 1, mainchoice, drinkchoice, x = 1,passout = 0, menu, card[14][5], suit, value, playerhand, dealerhand, drunk = 0; 

int main(void) 
{ 
    srand((short) time(NULL)); 

    cout << "Welcome to the world's greatest casino game ever!\n"; 
    cout << "In this game you can buy your booze, and amass a fortune!"; 

    cash = 500; 
    alcohol_rating = 0;
	
    	
    while(x) 
    { 
         cout << "\n\n\n"; 
         cout << "***Things To Do***\n"; 
         cout << "(1):Check your cash\n"; 
         cout << "(2):Buy a drink\n"; 
         cout << "(3):Play Roulette\n"; 
         cout << "(4):Play Dice\n"; 
		 cout << "(5):Play Blackjack\n";
         cout << "(6):Play Slots\n"; 
         cout << "(7):Play Lotto\n"; 
		 cout << "(8):Retire\n"; 
         cout << "What will you do? "; 
         cin >> mainchoice; 

         switch(mainchoice) 
         { 
              case 1:  cout << "\nYou have $" << cash << " at this time.\n\n"; 
                       break; 
              
			  case 2:  drink(); 
                       break; 
              
			  case 3:  roulette(); 
                       x = 1;
					   break; 
              
			  case 4:  dice(); 
                       x = 1;
					   break; 
              
			  case 5:  blackjack();
					   x = 1;
					   break;
              
			  case 6:  slots(); 
                       x = 1;
					   break; 
              
			  case 7:  lotto();
					   x = 1;
                       break; 
              			  
			  case 8: cout << "You are retiring with $" << cash << "."; 
                      return 0; 
			  
			  case 9: cout << "\n\nEaster Egg #1 found\n" << "Casino Written by Chris Phillips and Chad Hartman\n";
					  break;
		 } 

		 x = 1;
    
		if(cash < 1)
		{
			cout << "\n\n\n\n\nSorry, but you've run out of money. Try again another day.";
			return 0;
		}
	} 
return 0;
} 


short drink() 
{ 
    cout << "\n\n\n"; 
    cout << "***Drinks Available***\n"; 
    cout << " (1):Water Free\n"; 
    cout << " (2):Soda $3\n"; 
    cout << " (3):Coffee $2\n";
	cout << " (4):Whiskey $8\n"; 
    cout << " (5):Vodka $8\n"; 
    cout << " (6):Beer $5\n"; 
    cout << " (7):Martini $10\n"; 
    cout << " (8):Bloody Mary $10 \n"; 
    cout << " (9):Gin and Tonic $10 \n"; 
    cout << "(10):Nothing\n"; 
    cout << "Which drink do you want?"; 
    cin >> drinkchoice; 

    switch(drinkchoice) 
    { 
         case 1: cout << "One water coming up!\n"; 
                 break; 

         case 2: if(cash - 3 <= 0)
				 {
					 cout << "You don't have enough money pal.";
					 break;
				 }					 

				 cout << "One soda coming up!\n"; 
                 cash = cash - 3; 
                 break; 

         
		 case 3: if(cash - 2 <= 0)
				 {
					 cout << "You don't have enough money pal.";
					 break;
				 }
			 
				  cout << "Coffee on the way!\n";
				  cash = cash - 2;
				  alcohol_rating = alcohol_rating - 1;
				  break;
		 
		 
		 case 4: if(cash - 8 <= 0)
				 {
					 cout << "You don't have enough money pal.";
					 break;
				 }
			 
				 cout << "One whiskey coming up!\n"; 
                 cash = cash - 8; 
                 alcohol_rating = alcohol_rating + 3; 
                 booze_check();
				 break; 

         case 5: if(cash - 8 <= 0)
				 {
					 cout << "You don't have enough money pal.";
					 break;
				 }
			 
				 cout << "One vodka comin up!\n"; 
                 cash = cash - 8; 
                 alcohol_rating = alcohol_rating + 2; 
                 booze_check();
				 break; 

         case 6: if(cash - 5 <= 0)
				 {
					 cout << "You don't have enough money pal.";
					 break;
				 }

				 cout << "One beer coming up!\n"; 
                 cash = cash - 5; 
                 alcohol_rating = alcohol_rating + 1; 
                 booze_check();
				 break; 

         case 7: if(cash - 10 <= 0)
				 {
					 cout << "You don't have enough money pal.";
					 break;
				 }
			 
				 cout << "One Martini coming up!\n"; 
                 cash = cash - 10; 
                 alcohol_rating = alcohol_rating + 1; 
                 booze_check();
				 break; 

         case 8: if(cash - 10 <= 0)
				 {
					 cout << "You don't have enough money pal.";
					 break;
				 }
			 
				 cout << "One Bloody Mary coming up!\n"; 
                 cash = cash - 10; 
                 alcohol_rating = alcohol_rating + 2; 
                 booze_check();
				 break; 

         case 9: if(cash - 10 <= 0)
				 {
					 cout << "You don't have enough money pal.";
					 break;
				 }
			 
				 cout << "One Gin and Tonic coming up!\n"; 
                 cash = cash - 10; 
                 alcohol_rating = alcohol_rating + 2;
				 booze_check();
                 break; 
         
		case 10: return 0; 
    } 
    return 0; 
} 

int bets_made, num_bets, bet_num[50], betmoney[50];
short roulette_choice,spinval;
	
short roulette()
{
	while(z)
	{

		short bet = 0;
		
		while(!bet)
		{
		menumain:cout << "\n\n\n***Roulette***\n";
				 cout << "(1):Place a bet\n";
			     cout << "(2):Check your cash\n";
				 cout << "(3):Mortgage your house\n";
			     cout << "(4):Quit roulette\n";
				 cout << "Please enter your choice: ";
			    
				 cin >> roulette_choice;
		
			switch(roulette_choice)
			{
		
				case 1:	cout << "\n\n\nHow many bets will you place?";
						cin >> num_bets;
						bets_made = 0;
							
						while(bets_made < num_bets)
						{
						
beginning:					cout << "\nWhat number will you place a bet on(0-36)? ";
							cin >> bet_num[bets_made];
						
							if(36 < bet_num[bets_made] || 0 > bet_num[bets_made])
							{
								goto beginning;
							}
						
bet:						cout << "How much will you bet on number " << bet_num[bets_made] << "?";
							cin >> betmoney[bets_made];
						
							if(cash - betmoney[bets_made] < 0)
							{
								goto bet;
							}
							cash = cash - betmoney[bets_made];
						
							bets_made++;
						
						}
						bet = 1;
						break;
	
				case 2:	cout << "\n\nYou have $" << cash << " at this time.";
						break;
	
				case 3:	cout << "\n\nI think you need to go cool it for a while.";
						return 0;
					
				case 4:	return 0;
					
		
				default: cout << "\n\n\nStay away from the bar for a while would ya?";
						 goto menumain;
						 break;		
			}
		}

		spinval = rand() %37;
		cout << "\n\n\nThe winning number is "<< spinval << "!";

		int betcheck = 0;

		while(betcheck < num_bets)
		{
		
			if(bet_num[betcheck] - spinval == 0)
			{
				cout << "\n\n\nYou won with the number " << bet_num[betcheck] << "!";
				cash = cash + (betmoney[betcheck] * (37.00/num_bets) - betmoney[betcheck]) ;
				cout << "\nYou made $" << betmoney[betcheck] * (37.00/(num_bets)) << " off of this game!";
			
			}
			betcheck ++;
		
		}

		cout << "\n\nSorry pal, better luck next time\n";
	}
}

short lotto()
{
	
	int lottonum[7];
	double lottobet[7];
	short lottochoice;

	x = 0;
	while(!x)
	{
		cout << "\n\n\n***LOTTO***\n";
		cout << "(1):Play Lotto $2\n";
		cout << "(2):Check your cash\n";
		cout << "(3):Quit playing Lotto\n";
		cout << "What will you do? ";
		cin >> lottochoice;
	
		switch(lottochoice)
		{
			case 2:	cout << "\n\nYou have $" << cash << " at this time.";
					break;
	
			case 1:	x = 1;
					break;

			case 3:	return 0;
		}
	}

	cash = cash - 2;
	cout << "\nPlease select the 5 numbers you think will be drawn(1 - 100): ";

	bets_made = 0;

	while(bets_made < 5)
	{
		cin >> lottobet[bets_made];
		bets_made++;
	}

	short number = 0;
	
	while(number < 5)
	{
		lottonum[number] = rand() %100 + 1 ;
		number++;
	}

	number = 0;

	cout << "\n\nThe winnning numbers are ";
	
	while(number < 5)
	{
		cout << lottonum[number] << " ";
		number++;
	}

	number = 0;
	short lotto_count = 0;

	while(number < 5)
	{
		bets_made = 0;
		while(bets_made < 5)
		{
					
			if(lottonum[number] == lottobet[bets_made])
			 {
				 lotto_count++;
			 }
		
			bets_made++;
		}
		number++;
	}

	if(lotto_count == 1)
	{
		cash = cash + 5;
		cout << "\n\nCongratulations, you won $5";
	}

	if(lotto_count == 2)
	{
		cash = cash + 50;
		cout << "\n\nCongratulations, you won $50";
	}

	if(lotto_count == 3)
	{
		cash = cash + 200;
		cout << "\n\nCongratulations, you won $200";
	}

	if(lotto_count == 4)
	{
		cash = cash + 2000;
		cout << "\n\nCongratulations, you won $2000";
	}

	if(lotto_count == 5)
	{
		cash = cash + 10000;
		cout << "\n\nCongratulations, you won $10000";
	}

	if(lotto_count == 0)
	{
		cout << "\n\nBetter luck next time.\n";
	}
	
	return 0;
	
}


short slots()
{
	bool playing = true;
	int symbol;
	short slotschoice;

	while(z)
	{
		x=1;
	
		while(x)
		{
			cout << "\n\n\n***SLOTS***\n";
			cout << "(1):Play the Slots $1\n";
			cout << "(2):Check your cash\n";
			cout << "(3):Quit Slots\n";
			cout << "What will you do?";
			cin >> slotschoice;
		
			switch(slotschoice)
			{
			case 1:	x=0;
					break;
	
			case 2:	cout << "\n\nYou have $" << cash << " at this time.";
					break;
	
			case 3:	return 0;
				
			}
		}
	
		cash = cash - 1;
		symbol = rand() %1000 + 1;
		if(symbol == 1000)
		{
			cout << "\n\nJackpot!";
			cash = cash + 100;
		}

		if(symbol < 751)
		{
			cout << "\n\nYou get nothing.";
		}
	
		if(symbol > 750 && symbol < 801)
		{
			cout << "\n\nYou earned back your money";
			cash = cash + 1;
		}

		if(symbol > 800 && symbol <851)
		{
			cout << "\n\nYou made $2!";
			cash = cash + 2;
		}

		if(symbol > 850 && symbol < 871)
		{
			cout << "\n\nYou made $3!";
			cash = cash + 3;
		}

		if(symbol > 870 && symbol < 901)
		{
			cout << "\n\nYou made $5!";
			cash = cash + 5;
		}

		if(symbol > 900 && symbol < 921)
		{
			cout << "\n\nYou made $10!";
			cash = cash + 10;
		}
	
		if(symbol > 920 && symbol < 931)
		{
			cout << "\n\nYou made $20!";
			cash = cash + 20;
		}
	
		if(symbol > 930 && symbol < 951)
		{
			cout << "\n\nYou made $30!";
			cash = cash + 30;
		}

		if(symbol > 950 && symbol < 1000)
		{
			cout << "\n\nYou get nothing.";
		}

		if(cash < 1)
		{
			return 0;
		}

	}
return 0;
}


short dice()
{
	
	short dicechoice, dicevalue1, dicevalue2, totalvalue;
	long dicebet;

while(z)
{
	x = 1;
	while(x)
	{
		cout << "\n\n\n***Dice***\n";
		cout << "(1):Play Dice\n";
		cout << "(2):Check your cash\n";
		cout << "(3):Quit Dice\n";
		cout << "What will you do? ";
		cin >> dicechoice;

		switch(dicechoice)
		{
		case 1:	dice: cout << "\n\nHow much will you bet?";
				cin >> dicebet;
				if(cash - dicebet < 0)
				{
					goto dice;
				}
				x = 0;
				break;

		case 2:	cout << "\n\nYou have $" << cash << " at this time.";
				break;

		case 3:	return 0;
		}
	}

	dicevalue1 = rand() %6 + 1;
	dicevalue2 = rand() %6 + 1;
	totalvalue = dicevalue1 + dicevalue2;
	
	cout << "\n\n" << totalvalue;

	if(totalvalue == 7)
	{
		cout << "\n\nYou made $" << 3 * dicebet << " on this roll!";
		cash = cash + (2 * dicebet);
	}

	else
	{
		cout << "\n\nSorry pal, better luck next time.";
		cash = cash - dicebet;
		
		if(cash < 1)
		{
			return 0;
		}
	}
}
	return 0;
}

short blackjack()
{
blakjak:
	while(z)
	{
		playerhand = 0;
		dealerhand = 0;
		x=0;
		short choice;
		
		while(!x)
		{
			cout << "\n\n\n***BLACKJACK***\n";
			cout << "(1):Play Blackjack\n";
			cout << "(2):Check your cash\n";
			cout << "(3):Quit Blackjack\n";
			cout << "What will you do? ";
			cin >> choice;
		
			switch(choice)
			{
				case 1:	x = 1;
						break;
	
				case 2:	cout << "\n\nYou have $" << cash << " at this time.";
						break;
		
				case 3: return 0;
						break;
			}
		}
		
		short done = 0;
	
		short bet;
		bet = 0;
		
		while(!bet)
		{
			cout << "\n\nPlease enter a bet: ";
			cin >> bet_amount;
			
			if(cash - bet_amount > -1)
			{
				bet = 1;
			}
		}
		
		cash = cash - bet_amount;
		
		cout << "\nYou get ";
	
		while(done < 2)
		{
			card_gen();
			card_determine();
			
			if(value == 1)
			{
				short pdone = 0;
				
				while(!pdone)
				{
					cout << "\nYou've drawn an Ace, what value do you want it to have(1 or 11)? ";
					cin >> value;
					
					if(value == 1 || value == 11)
					{
						pdone = 1;
					}
				
					
				}
			}
			
			playerhand = playerhand + value;
			done++;
		}
	
		cout << "\n\nThe dealer has drawn ";
		card_gen();
		card_determine();
		
		if(value == 1)
		{
			value = 11;
		}
	
		dealerhand = dealerhand + value;
		card_gen();
		
		if(value > 10)
		{
			value = 10;
		}
	
		if(dealerhand < 11 && value == 1)
		{
			value = 11;
		}
	
		dealerhand = dealerhand + value;
	
		done = 0;
	
		while(!done)
		{
			cout << "\n(1):Hit me\n";
			cout << "(2):Hold\n";
			cout << "What will you do? ";
			cin >> choice;
	
			switch(choice)
			{
				case 1:	card_gen();
						card_determine();
						
						if(value == 1)
						{
							short pdone = 0;
							
								while(!pdone)
							{
								cout << "\nYou've drawn an Ace, what value do you want it to have(1 or 11)? ";
								cin >> value;
								
								if(value == 1 || value == 11)
								{
									done = 1;
								}
							}
							
							
						}
					
						playerhand = playerhand + value;
	
						if(playerhand > 21)
						{
							cout << "\n\nYou went above 21. You lose!\n\n";
							goto blakjak;
						}
	
						break;
	
				case 2:	done = 1;
						break;
			}
		}

			if(playerhand > 21)
			{
				cout << "\n\nYou went above 21. You lose!\n\n";
				goto blakjak;
			}

			short ddone = 0;
			
			while(!ddone)
			{
				if(dealerhand < 17)
				{
					card_gen();
					
					if(value > 10)
					{
						value = 10;
					}
		
					dealerhand = dealerhand + value;
				}
	
				else
				{
					ddone = 1;
				}
	
				if(dealerhand > 21)
				{
					cout << "\n\nThe dealer has gone past 21, you win!";
					cash = cash + 2 * bet_amount;
					goto blakjak;	
				}
			}
	
			cout << "You have a hand value of " << playerhand;
			cout << "\n\nAnd the dealer's hand has a value of " << dealerhand;
		
			if(dealerhand >= playerhand)
			{
				cout << "\n\nThe dealer wins this game!";
				goto blakjak;
			}

			else
			{
				cout << "\n\nYou win!";
				cash = cash + 2 * bet_amount;
				goto blakjak;
			}
	}
return 0;
}

void card_gen()
{
	bool check = false;

	while(!check)
	{
		suit  = rand() %4  + 1;
		value = rand() %13 + 1;
		check = card_check();
	}
}


bool card_check()
{
	if(card[value][suit] != 1)
	{
		card[value][suit] = 1;
		return true;	
	}

	return false;
}


void card_determine()
{
	if(value == 1)
	{
		cout << "A";
	}

	if(value == 2)
	{
		cout << "2";
	}

	if(value == 3)
	{
		cout << "3";
	}

	if(value == 4)
	{
		cout << "4";
	}

	if(value == 5)
	{
		cout << "5";
	}

	if(value == 6)
	{
		cout << "6";
	}

	if(value == 7)
	{
		cout << "7";
	}

	if(value == 8)
	{
		cout << "8";
	}

	if(value == 9)
	{
		cout << "9";
	}

	if(value == 10)
	{
		cout << "10";
	}

	if(value == 11)
	{
		cout << "J";
		value = 10;
	}

	if(value == 12)
	{
		cout << "Q";
		value = 10;
	}

	if(value == 13)
	{
		cout << "K";
		value = 10;
	}

	if(suit == 1)
	{
		cout << (char)3 << " ";
	}

	if(suit == 2)
	{
		cout << (char)4 << " ";
	}

	if(suit == 3)
	{
		cout << (char)5 << " ";
	}

	if(suit == 4)
	{
		cout << (char)6 << " ";
	}
}

void booze_check()
{
	if(alcohol_rating > 10 && alcohol_rating < 15)
	{
		cout << "\n\nYou are starting to feel a nice buzz.";
	}

	if(alcohol_rating > 14 && alcohol_rating < 20)
	{
		cout << "\n\nYou're starting to feel pretty sick now, maybe you should lay off the booze.";
	}

	if(alcohol_rating >19)
	{
		
		money_steal = rand() %cash + 1;
				
		cout << "\n\nYou black out and when you awaken you find that you are missing $" << money_steal;
		cash = cash - money_steal;
		passout++;
	}
		
	if(passout == 3)
	{
		short playing = 1;
		char answer[5];

		while(playing)
		{
			cout << "\n\n\nWhen you awaken, there is a drunk guy next to you.";
			cout << "He asks if you'll play some tic-tac-toe with him.";
			cin >> answer;
			
			while(answer[0] == 'y' || answer[0]=='Y')
			{
				tictactoe();
				
				if(playerwins == 100)
				{
					surprise();
				}

				cout << "\n\nWould you like to play again?";
				cin >> answer;

				if(answer[0] != 'y' || answer[0] != 'Y')
				{
					playing = 0;
				}

			}
			
			if(answer[0] != 'y' || answer[0] != 'Y')
			{
				playing = 0;
			}

		}

	}

}

int grid[3][3], key[3][3];
int tie;

short int f=0, g=0;	
short int a=1, b=2;	
short int v, y;

bool win=false;	

short tictactoe()
{
	cleargrid();
	win = false;
	gridDisplay();	
		while(!win)
		{
			bool p1=false, p2=false;
			
			while(!p1)	
			{	
				cout << "\n\nPlease enter the coordinates of the position you want to mark (0,0 is upper left).";
				cin >> v >> y;			
				
				if(grid[v][y]!=key[v][y])
				{
					cout << "\n\nPlease enter new coordinates, because those have been used.\n\n\n";
					gridDisplay();
				}

				else
				{
					grid[v][y]=1;
					
					
					tie = catsEye();	
					if(tie==9)			
					{
						goto catseye;
					}
					
					win=winner1();		
					if (win)			
					{
						goto win1;		
					}
					p1=true;			
					
					gridDisplay();		
					
				}
			}

			while(!p2)					
			{
				
					IntermediateAI();
					win=winner2();		
					tie=catsEye();		
					
					if(tie==9)
					{
						goto catseye;
					}
					
					p2=true;			
					gridDisplay();
					
				
			}
		}

	cout <<"\n\n\nPlayer 2 wins! Good job! Player 1 is a loser!!!";
	return 0;

win1: 
cout << "\n\n\nPlayer 1 wins! Good job! Player 2 is a loser!!!";
playerwins++;
return 0;

catseye: 
cout << "\n\n\n" << "It's a tie! Nobody wins! Everybody sucks!!!";
return 0;
}

bool winner1(void)
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

bool winner2(void)
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



void gridDisplay()
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

int catsEye()
{
	short int r, c;
	int counter= 0;
	c = 0;

	while (c<3)	
	{
		r = 0;
		while(r<3)
		{
			if(grid[r][c]!= 0)
			{
				counter++;
			}
			r++;
		}
		
		c++;
	}

		return counter;		
}

void IntermediateAI()		
{
	short int row=0, column=0;
	bool not_taken = false;

	while(!not_taken)		
	{
		
		
		row = rand() %4;	
		column = rand() %4;
		
		if(row < 3 && column < 3)
		{

			if(grid[row][column] == 0)
			{
				not_taken = true;
				grid[row][column] = 2;
			}
		}

		if(row > 2 || column > 2)
		{
			row = 0;
			column = 0;
		}
	}
}

void cleargrid()
{
	short int r, c;
	int counter= 0;
	c = 0;

	while (c<3)	
	{
		r = 0;
		
		while(r<3)
		{
			grid[r][c]= 0;			
			r++;
		}
		
		c++;
	}		
}


short surprise()
{
	cout << "\n\n\nCongratulations! You've won 100 games of Tic-Tac-Toe against the really stupid  drunk guy! When you quit playing Tic-Tac-Toe, check your cash for a surprise!";
	cout << "\nNow go get a real life you loser!";
	cash = cash  + 100000;
	return 0;
}