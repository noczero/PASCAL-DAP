//By:			Cream Corn (Kyle Benson, Joe Clementz, Zachary Lark, Frank Vokoun, Casey Hunter)
//Filename:		GroupLab7.cpp
//Date Begun:	10/1/2001
//Date Ended:	10/19/2001

//*********************************************************************
//*  Certificate Of Originality
//*
//*    We certify that this lab has been done by us, that no code
//*  is copied from any student or any other source, except as
//*  noted in the comment blocks attached to said code.
//*
//*
//*
//*
//*
//*
//*
//*********************************************************************

//********************Preprogramming Directives************************
#include <stdlib.h>
#include <stdio.h>
#include <iostream.h>
#include <string.h>
#include <cstdlib>
#include <ctime>

//************************Global Constants*****************************
const int MAX_PLAYERS = 8;
const double MAX_STARTING_CASH = 1000.00;

//****************************Objects**********************************
class CARD
{
	public:
		CARD(void);
		CARD(int index);
		void changePointVal(int newVal);
		void card_initialize(int newCardIndex);
		void card_show();
		int get_pointval();
	private:
		char m_suit;
		char m_face[3];
		int m_pointValue;
};

class DECK
{
	public:
		DECK(void);
		void deck_make();
		void deck_show();
		void shuffle(int timesToShuffle);
		CARD deal_one();
		void deck_reset();
	private:
		CARD m_cardDeck[52];
		int m_lastDealt;
};

class PLAYER
{
	private:
		double m_money;
		double m_bet;
	protected:
		CARD m_hand[11];
		int m_busted;
		int m_BJflag;
	public:
		PLAYER();
		PLAYER(double startingCash);
		int is_busted();
		int calculate_points();
		int BJflag();
		double returnMoney();
		void displayBank();
		void setBJflag();
		void show_hand();
		void aceCheck();
		void recieve_card(CARD newCard);
		void place_bet();
		void blackjack();
		void win();
		void busted();
		void push();
};

class DEALER:public PLAYER
{
	public:
		DEALER();
		void show_dealer_hand();
		int calculate_shown_cards_points();
		int decide_to_hit();
};

class GAME
{
	private:
		int m_activePlayers;
		PLAYER m_thePlayers[MAX_PLAYERS];
		DEALER m_theDealer;
		DECK m_theDeck;
	public:
		GAME(int players, double startingCash);
		void endRound();
		void playDealer();
		void playHands();
		void showPlayingHands();
		void firstDeal();
		void placeBets();
		void deckShuffle();
		void reset();
		int playAgain();
};


//****************************Prototypes*******************************
void gameDriver(GAME theGame);
void prog_start();
int center(char *input);
int getRandInt(int min, int max);
int convert_yes_no_to_int(char reply);
void card_make_driver();
void deck_make_driver();
void prog_continue();
void usage();
void flushInput();

//*******************************Main**********************************
int main(int argc, char *argv[])
{
	if(!(argc == 3)) usage();
	int players = atoi(argv[1]);
	double startingCash = atof(argv[2]);
	if(players > MAX_PLAYERS || startingCash > MAX_STARTING_CASH)
		usage();
	srand((unsigned)time(NULL));
	GAME theGame(players, startingCash);
	prog_start();
	gameDriver(theGame);
}

//****************************Driver***********************************
void gameDriver(GAME theGame)
//*********************************************************************
//*  game driver - runs all functions needed to play the game
//*  Expects: a game to be played
//*  Returns: none
//*  Side Effects: none
//*  Tasks:  1.do 
//*				a. shuffle the deck
//*				b.place bets
//*				c. deal opening hand
//*				d.show hands
//*				e. play the hands
//*				f.play for dealer
//*				g. finish the round
//*				h.reset and prepare to play again
//*********************************************************************
{
	do
	{
		theGame.deckShuffle();
		theGame.placeBets();
		theGame.firstDeal();
		theGame.showPlayingHands();
		theGame.playHands();
		theGame.playDealer();
		theGame.endRound();
		theGame.reset();
	}while(theGame.playAgain());
}

//****************************Functions********************************
GAME::GAME(int players, double startingCash)
//*********************************************************************
//*  game constructor
//*  Expects: number of players, starting money
//*  Returns: none
//*  Side Effects: initializes all aspects of the game
//*  Tasks:  1. create a player & gives it money
//*          2. set up all active players from a player
//*********************************************************************
{
	int i;
	PLAYER aPlayer(startingCash);
	m_activePlayers = players;
	for(i = 0; i < players; i++)
	{
		m_thePlayers[i] = aPlayer;
	}
}


void GAME::deckShuffle()
//*********************************************************************
//*  Deck shuffle - calls the deck shuffle function
//*  Expects: none
//*  Returns: none
//*  Side Effects: Deck is shuffled
//*  Tasks:  1.Calls theDeck.shuffle          
//*********************************************************************
{
	m_theDeck.shuffle(10);
}

void GAME::endRound()
//*********************************************************************
//*  End Round - Decides win and loss for all players
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects: none
//*  Tasks:  1.show dealers hand and points 
//*          2. checks the status of the dealers hand
//*			 3.loops through all players and decides how to pay them
//*********************************************************************
{
	cout << "******************************************" << endl << endl;
	cout << "Dealer: ";
	m_theDealer.show_hand();
	cout << " points = " << m_theDealer.calculate_points() << endl << endl;

	flushInput();

	if(m_theDealer.BJflag())
	{
		for(int q = 0; q < m_activePlayers; q++, prog_continue())
		{
			if(m_thePlayers[q].calculate_points() < m_theDealer.calculate_points())
			{
				cout << "Player " << q + 1 << ": ";
				m_thePlayers[q].show_hand();
				cout << " points = " << m_thePlayers[q].calculate_points() << endl;
				cout << " Dealer has BlackJack, you lose!!!" << endl;
				cout << " Money = ";
				m_thePlayers[q].displayBank();
				cout << endl << endl;

			}

			else if(m_thePlayers[q].BJflag())
			{
				cout << "Player " << q + 1 << ": ";
				m_thePlayers[q].show_hand();
				cout << " points = " << m_thePlayers[q].calculate_points() << endl;
				cout << " !!PUSH!!" << endl ;
				m_thePlayers[q].push();
				cout << " Money = ";
				m_thePlayers[q].displayBank();
			}

			else
			{
				cout << "Player " << q + 1 << ": ";
				m_thePlayers[q].show_hand();
				cout << " points = " << m_thePlayers[q].calculate_points() << endl;
				cout << " Dealer has BlackJack, and you busted!!!" << endl;
				cout << " Money = ";
				m_thePlayers[q].displayBank();
				cout << endl << endl;
			}
		}
	}

	else
	{
		for(int i = 0; i < m_activePlayers; i++)
		{
			cout << "Player " << i + 1 << ": ";
			m_thePlayers[i].show_hand();
			cout << " points = " << m_thePlayers[i].calculate_points() << endl;
			if(!(m_thePlayers[i].is_busted()))
			{
				if(m_theDealer.is_busted())
				{
					if(!(m_thePlayers[i].BJflag()))
					{
						cout << " You're a WINNER!!!" << endl ;
						m_thePlayers[i].win();
					}
					else 
					{
						cout << " You Got BlackJack!!!" << endl ;
						m_thePlayers[i].blackjack();
					}
				}

				else if(m_thePlayers[i].calculate_points() == m_theDealer.calculate_points() )
				{
					cout << " !!PUSH!!" << endl ;
					m_thePlayers[i].push();
				}
				else if(m_thePlayers[i].calculate_points() > m_theDealer.calculate_points() )
				{
					if(m_thePlayers[i].BJflag())
					{
						cout << " You Got BlackJack!!!" << endl ;
						m_thePlayers[i].blackjack();
					}
					else
					{
						cout << " You're a WINNER!!!" << endl;
						m_thePlayers[i].win();
					}
				}
				else
				{
					cout << " You Lose, Sucka!" << endl ;
				}
			}
			else cout << " You Lose, Sucka!" << endl ;
			cout << " Money = ";
			m_thePlayers[i].displayBank();
			cout << endl << endl;
			prog_continue();
		}
	}
}

void GAME::firstDeal()
//*********************************************************************
//*  first deal - deals two cards to each player and two to the dealer
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects: hands are filled with two cards
//*  Tasks:  1. for each active player
//*				a. give them each two cards
//*             b. give the dealer two cards
//*********************************************************************
{

	for(int k = 0; k < 2; k++)					//  First deal
	{
		for(int j=0; j < m_activePlayers; j++)
		{
			m_thePlayers[j].recieve_card(m_theDeck.deal_one());
			
		}
		m_theDealer.recieve_card(m_theDeck.deal_one());
	}

	for(int j = 0; j< m_activePlayers; j++)
	{
		if(m_thePlayers[j].calculate_points()>21) 
		{
				m_thePlayers[j].aceCheck();
		}
	}
	
	if(m_theDealer.calculate_points() > 21)
	{
		m_theDealer.aceCheck();
	}
}

void GAME::placeBets()
//*********************************************************************
//*  place bets - asks for bets from each player
//*  Expects: none
//*  Returns: none
//*  Side Effects: changes amount in bet variable for each player
//*  Tasks:  1. loop through every player, calling place_bet function
//*********************************************************************
{
	for(int i = 0; i < m_activePlayers; i++)	// Places the bets
	{
		cout <<endl << "Player "<< i+1 << ' ';
		m_thePlayers[i].place_bet();
		
		cout << endl;
		
	}
}

int GAME::playAgain()
//*********************************************************************
//*  play again -  asks the users if they want to continue playing
//*  Expects: nothing
//*  Returns: 1 integer - 1 if the user wants to continue 0 if not
//*  Side Effects:none
//*  Tasks:  1. prints continue message
//*          2. stores users reply
//*			 3. returns (call convert yes no to int)
//*********************************************************************
{
	char reply;
	cout << "Do you want to play another round? (Y or N)" << endl;
	cin >> reply;
	cout << endl;
	return(convert_yes_no_to_int(reply));
}

void GAME::playDealer()
//*********************************************************************
//*  play dealer - handles the dealer playing the game
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects:none
//*  Tasks:  1. checks for dealer BlackJack
//*          2. continues to pick up cards from the deck until decide to hit returns a 0
//*			 3. checks for the dealer busting
//*********************************************************************
{
	char bell = 7;

	if(m_theDealer.calculate_points() == 21)
		{	cout << "Dealer: ";
			m_theDealer.show_hand();
			cout << " points = " << m_theDealer.calculate_points() << endl << endl;
			m_theDealer.setBJflag();
			cout << "DEALER HAS BLACKJACK!!!" << bell << bell << endl << endl;
		}

	while(m_theDealer.decide_to_hit())
	{
		m_theDealer.recieve_card(m_theDeck.deal_one());
	
		if(m_theDealer.calculate_points()>21) 
		{
				
			m_theDealer.aceCheck();
			if(m_theDealer.calculate_points() > 21)
			{
				cout << endl;
				m_theDealer.busted();
				cout << "Dealer: ";
				m_theDealer.show_hand();
				cout << " points = " << m_theDealer.calculate_points() << endl;
				cout << "Dealer Busted" << endl << endl;
				m_theDealer.busted();
			}
		}
	

		if(m_theDealer.calculate_points() <21)
		{
			cout << "Dealer: ";
			m_theDealer.show_hand();
			cout << " points = " << m_theDealer.calculate_points() << endl;
		}
	}
}

void GAME::playHands()
//*********************************************************************
//*  play hands - handles the player side of the game, hitting, recieving 21, etc
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects:none
//*  Tasks:  1. loops through very user asking if they want to hit
//*          2. checks for 21 or a bust by the players
//*			 3. continues with all players hitting till noone wants a hit.
//*********************************************************************
{
	char reply;
	int response = 1;

	for(int i = 0; i < m_activePlayers; i++)
	{
		cout << "Player " << i+1 << ":" ;
		m_thePlayers[i].show_hand();
		cout << " points = " << m_thePlayers[i].calculate_points() << endl;
		if(m_thePlayers[i].calculate_points() == 21)
			{
				cout << endl;
				response = 0;

			}
		else
		{
			cout << "Do you want to take a Hit? (Y or N)" << endl;
			cin >> reply;
			cout << endl;
			response = convert_yes_no_to_int(reply);
		}
		
		
		while(response)
		{	
			m_thePlayers[i].recieve_card(m_theDeck.deal_one());
			if(m_thePlayers[i].calculate_points()>21) 
			{
				
				m_thePlayers[i].aceCheck();
				if(m_thePlayers[i].calculate_points() > 21)
				{
					cout << endl;
					m_thePlayers[i].busted();
					response = 0;
					cout << "Player " << i+1 << ":" ;
					m_thePlayers[i].show_hand();
					cout << " points = " << m_thePlayers[i].calculate_points() << endl;
					cout << "You're Busted" << endl << endl;
				}
			}

			if(m_thePlayers[i].calculate_points() == 21)
			{
				response = 0;
				cout << endl;
				cout << "Player " << i+1 << ":" ;
				m_thePlayers[i].show_hand();
				cout << " points = " << m_thePlayers[i].calculate_points() << endl << endl;
			}
			else if(m_thePlayers[i].calculate_points() < 21)
			{
				m_thePlayers[i].show_hand();
				cout << " points = " << m_thePlayers[i].calculate_points() << endl;
				cout << "Do you want to take a Hit? (Y or N)" << endl;
				cin >> reply;
				response = convert_yes_no_to_int(reply);
			}
		}	
	}
}

void GAME::reset()
//*********************************************************************
//*  game reset - resets the game to play again
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects:players and deck are reset to beginnning values
//*  Tasks:  1. shuffles the deck
//*          2. stores the players bank in a temp variable
//*			 3. sets each player equal to the ctor for a player that
//*				using the temp value as the players money
//*********************************************************************
{
	double tempMoney;
	m_theDeck.shuffle(10);
	m_theDealer = DEALER();
	for(int i = 0; i < m_activePlayers; i++)
	{
		tempMoney = m_thePlayers[i].returnMoney();
		m_thePlayers[i] = PLAYER(tempMoney);
	}
		
}

void GAME::showPlayingHands()
//*********************************************************************
//*  show playing hands - shows the players opening hands, and checks for blackjack
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects:none
//*  Tasks:  1. loops through every player 
//*          2. prints the cards in the players hands
//*			 3. checks for Blackjack and displays a msg if so.
//*			 4. sets BJflag accordingly
//*********************************************************************
{
	char bell = 7;

	m_theDealer.show_dealer_hand();
	cout << " points showing = "<< m_theDealer.calculate_shown_cards_points() << endl << endl;

	flushInput();

	for(int i = 0; i < m_activePlayers; i++)
		{
			cout << "Player " << i+1 << ": ";
			m_thePlayers[i].show_hand();
			cout << " points = " << m_thePlayers[i].calculate_points() << endl << endl;
			if(m_thePlayers[i].calculate_points() == 21)
			{
				m_thePlayers[i].setBJflag();
				cout << "YOU HAVE BLACKJACK!!!" << bell << bell<< bell << endl << endl;
			}
			prog_continue();

		}
}

void PLAYER::aceCheck()
//*********************************************************************
//*  Ace check - checks a players hand and sets one ace with a value of 11 to 1
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects:value of an ace is changed to one
//*  Tasks:  1. loops throught the players hand till an ace is found the changes the value of it to 1
//*********************************************************************
{
	int gotAce = 0;

	for(int i=0; gotAce == 0 && i < 11; i++)
	{
		if(m_hand[i].get_pointval() == 11)
		{
			m_hand[i].changePointVal(1);
			gotAce = 1;
		}
	}
}

int PLAYER::BJflag()
//*********************************************************************
//*  Black jack flag- returns the current value of the m_Bjflag variable
//*  Expects: nothing
//*  Returns: 1 integer (value of the flag)
//*  Side Effects: none
//*  Tasks:  1. return m_BJflag
//*********************************************************************
{
	return m_BJflag;
}

void PLAYER::blackjack()
//*********************************************************************
//*  Black jack - this pays the player 2.5 times their bet
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects: none
//*  Tasks:  1. set m_money equal to 2.5 times m_bet
//*********************************************************************
{
	m_money+= 2.5 * m_bet;
}

void PLAYER::busted()
//*********************************************************************
//*  busted- sets m_busted = 1
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects: none
//*  Tasks:  1. set m_busted = 1
//*********************************************************************
{
	m_busted = 1;
}

void PLAYER::displayBank()
{
	cout << m_money;
}

int PLAYER::is_busted()
//*********************************************************************
//*  is busted- tells whether a player has already busted
//*  Expects: nothing
//*  Returns: 1 integer (value of the m_busted flag)
//*  Side Effects: none
//*  Tasks:  1.  if m_busted = 1 return 1
//*          2. return 0
//*********************************************************************
{
	if(m_busted) return 1;
	return 0;
}

void PLAYER::place_bet()
//*********************************************************************
//*  Place Bet- gets a bet from the player
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects: none
//*  Tasks:  1. print Place you bet
//*			 2. if the bet = = 0 call place_bet
//*			 3.if the bet is larger then the players bank bet all of the bank
//*			 4.subtract m_bet from m_money
//*********************************************************************
{
	cout << "Place your bet" << endl;
	cin >> m_bet;

	if(m_bet == 0) place_bet();

	else
	{
		if(m_bet > m_money)
		{
			cout << endl << "You have entered more money than you have in your bank." << endl;
			cout << "Betting all remaining money. Bet = " << m_money << endl;
			m_bet = m_money;
		}
		m_money -= m_bet;
	}
	
}

PLAYER::PLAYER(double startingCash)
//*********************************************************************
//*  player ctor - creates a player and sets their money equal to startingCash
//*  Expects: 1 double (the amount of money to start with)
//*  Returns: nothing
//*  Side Effects: changes m_money, m_busted, m_bet
//*  Tasks:  1. sets m_BJflag = 0
//*			 2. sets m_money equal to starting cash
//*          3. sets m_busted and m_bet equal to zero
//*          4. loops to fill the entire hand with empty cards
//*********************************************************************
{
	int i;
	m_BJflag = 0;
	m_money = startingCash;
	m_busted = 0;
	m_bet = 0;
	for(i=0;i<11;i++) m_hand[i] = CARD();
}

PLAYER::PLAYER()
//*********************************************************************
//*  player ctor - creates an empty player 
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects: m_busted, m_bet
//*  Tasks:  1. sets m_busted, BJflag, m_money and m_bet equal to zero
//*          2. loops to fill the entire hand with empty cards
//*********************************************************************
{
	int i;
	m_BJflag = 0;
	m_money = 0;
	m_busted = 0;
	m_bet = 0;
	for(i=0;i<11;i++) m_hand[i] = CARD();
}

void PLAYER::push()
//*********************************************************************
//*  push- gives the player back his bet
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects: m_money is changed
//*  Tasks:  1. m_money is given the value of m_bet
//*********************************************************************
{
	m_money += m_bet;
}

void PLAYER::recieve_card(CARD newCard)
//*********************************************************************
//*  recieve card-stores a card into the next available spot in a players hand
//*  Expects: CARD (card being given to a player
//*  Returns: nothing
//*  Side Effects: none
//*  Tasks:  1. loops through the players hand till a
//*            card with a 0 point value is found 
//*          2. sets this card equal to the card passed in
//*********************************************************************
{
	int i = 0;

	while(i < 11)
	{
		if(m_hand[i].get_pointval() == 0)
		{
			m_hand[i] = newCard;
			i = 12;
		}
		i++;
	}
}

double PLAYER::returnMoney()
//*********************************************************************
//*  return money-returns the value of a players bank
//*  Expects: nothing
//*  Returns: 1 double- the players bank
//*  Side Effects: none
//*  Tasks:  1. returns the value of the players m_money
//*********************************************************************
{
	return m_money;
}

void PLAYER::setBJflag()
//*********************************************************************
//*  set BJ flag - sets the value of m_BJflag to 1
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects: the value of the m_BJflag is changed
//*  Tasks:  1.m_bjflag = 1
//*********************************************************************
{
	m_BJflag = 1;
}

void PLAYER::show_hand()
//*********************************************************************
//*  Show hand-shows every none blank card in a users hand
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects: none
//*  Tasks:  1. for (the point value of the next card is not equal 
//*                 to 0
//*					a.calls card_show
//*			 2.prints and endl
//*********************************************************************
{
	int i;
	for(i = 0; m_hand[i].get_pointval() != 0; i++)
	{
		m_hand[i].card_show();
		cout << " ";
	}
	cout << endl;
}

void PLAYER::win()
//*********************************************************************
//*  win-pays a player two time the bet
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects: m_money is changed
//*  Tasks:  1. m_bet is multiplied by two and added to m_money
//*********************************************************************
{
	m_money+= 2 * m_bet;
}

int PLAYER::calculate_points()
//*********************************************************************
//*  Calcualte Points- calculates and returns the total value of 
//*  the cards a player is holding
//*  Expects: nothing
//*  Returns: 1 integer the final point total
//*  Side Effects: none
//*  Tasks:  1. for i less then the number of cards a player can hold
//*				a.temppoints equals temppoints+the next card point value
//*********************************************************************
{
	int i;
	int tempPoints = 0;

	for(i = 0; i < 11; i++)
	{
		tempPoints += m_hand[i].get_pointval();
	}

	return tempPoints;
}

int DEALER::calculate_shown_cards_points()
//*********************************************************************
//*  calculate shown card points - calculates shown card points for dealer
//*  Expects: none
//*  Returns: 1 integer (shown card points)
//*  Side Effects: none
//*  Tasks:  1. returns shown card points
//*********************************************************************
{
	int i;
	int tempPoints = 0;

	for(i = 1; i < 11; i++)
	{
		tempPoints += m_hand[i].get_pointval();
	}

	return(tempPoints);
}

DEALER :: DEALER()
//*********************************************************************
//*  Dealer constructor
//*  Expects: none
//*  Returns: none
//*  Side Effects: initialize hand
//*  Tasks:  1. loops every card in hand array to initialize hand
//*********************************************************************
{
	int i;
	m_BJflag = 0;
	m_busted = 0;
	for(i=0;i<11;i++) m_hand[i] = CARD();
}

int DEALER::decide_to_hit()
//*********************************************************************
//*  decide to hit - dealer decides to hit or not
//*  Expects: none
//*  Returns: 1 integer (yes/no)
//*  Side Effects: none
//*  Tasks:  1. return 1 if the total points are less than 17
//*          2. else return 0
//*********************************************************************
{
	if(calculate_points() < 17) return 1; //while decide_to_hit someplace else
	return 0;
}

void DEALER::show_dealer_hand()
//*********************************************************************
//*  show dealer hand - shows dealers shown cards
//*  Expects: none
//*  Returns: none
//*  Side Effects: none
//*  Tasks:  1. shows dealers cards except first card
//*********************************************************************
{
	int i;
	char bsmile = 1;
	char wsmile = 2;

	cout << "Dealer: " << wsmile << bsmile << wsmile;

	for(i = 1; m_hand[i].get_pointval() != 0; i++)
	{
		m_hand[i].card_show();
		cout << " ";
	}
	cout << endl;
}

CARD DECK::deal_one()
//*********************************************************************
//*  deal one - deals one card
//*  Expects: 1	pointer to a DECK
//*  Returns: 1 card (the card dealt)
//*  Side Effects: lastDealt inside of DECK structure is incrimented
//*  Tasks:  1. error check lastDealt > 50 (empty deck)
//*          2. incriment lastDealt
//*          3. return card dealt
//*********************************************************************
{
	if(m_lastDealt > 50) exit(101);
	m_lastDealt = m_lastDealt + 1;
	return (m_cardDeck[m_lastDealt]);
}

DECK::DECK(void)
//*********************************************************************
//*  deck make - creates a deck
//*  Expects: none
//*  Returns: 1 DECK (the new deck)
//*  Side Effects: none
//*  Tasks:  1. call card_make 52 times to create a deck
//*          2. set lastDealt to -1
//*            a. create cards in reverse
//*            b. lastDealt automatically set in the process
//*********************************************************************
{
	for(m_lastDealt = 51; m_lastDealt > -1; m_lastDealt--)
	{
		m_cardDeck[m_lastDealt].card_initialize(m_lastDealt);
	}

}

void DECK::deck_make()
//*********************************************************************
//*  deck make - creates a deck
//*  Expects: none
//*  Returns: 1 DECK (the new deck)
//*  Side Effects: none
//*  Tasks:  1. call card_make 52 times to create a deck
//*          2. set lastDealt to -1
//*            a. create cards in reverse
//*            b. lastDealt automatically set in the process
//*********************************************************************
{
	for(m_lastDealt = 51; m_lastDealt > -1; m_lastDealt--)
	{
		m_cardDeck[m_lastDealt].card_initialize(m_lastDealt);
	}

}

void DECK::deck_reset()
//*********************************************************************
//*  deck reset - resets the deck
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects: m_lastdealt is changed and the deck is shuffled
//*  Tasks:  1. lastdealt is set to - 1 
//*			 2. deck is shuffled 10 times
//*********************************************************************
{
	m_lastDealt = -1;
	shuffle(10);
}

void DECK::deck_show()
//*********************************************************************
//*  deck show - displays the deck's remaining cards to the user
//*  Expects: 1	DECK
//*  Returns: none
//*  Side Effects: none
//*  Tasks:  1. display deck to user
//*            a. execpt cards already dealt
//*            b. 13 per line
//*            c. show deck by showing each card through card_show
//*********************************************************************
{
	int perLine = 0;
	int lastDealt;
	lastDealt = m_lastDealt;
	while(lastDealt < 51)
	{
		if(perLine > 12)
		{
			cout << endl;
			perLine = 0;
		}

		lastDealt++;
		m_cardDeck[lastDealt].card_show();
		perLine++;
	}
	cout << "\n";
}

void DECK::shuffle(int timesToShuffle)
//*********************************************************************
//*  shuffle - shuffles the card order inside of the deck
//*  Expects: 1	pointer to a DECK, 1 integer (# of times to shuffle)
//*  Returns: none
//*  Side Effects: the cards inside of the deck are shuffled
//*  Tasks:  1. create a new DECK (shuffled deck)
//*          2. loop entire program timesToShuffle number of times
//*            a. get random integer(13 - 39) to divide deck
//*            b. set up new pointers to create 2 decks from original
//*              1. for first deck
//*                a. use -1 to start
//*                b. use random int to end
//*              2. for second deck
//*                a. use random int to start
//*                b. use 51 to end
//*            c. do while cards remain in both half decks
//*              1. get random integer(1 - 7)
//*              2. if that many cards remain in bottom deck
//*                a. deal that many cards
//*                b. else deal all remaining cards in half deck
//*              3. get random integer(1 - 7)
//*              4. if that many cards remain in top deck
//*                a. deal that many cards
//*                b. else deal all remaining cards in half deck
//*            d. deal all remaining cards from both decks
//*           3. copy shuffled deck over theDeck
//*********************************************************************
{
	DECK shuffledDeck;
	int deckSplit, randomToPlace;
	int topLocation, botLocation, topEnd, botEnd;
	int i,j;
	int shuffledIndex;

	for(/*none*/;timesToShuffle > 0; timesToShuffle--)
	{
		//set pointers for top and bottom halves of original deck
		deckSplit = getRandInt(13,39);
		topLocation = -1;
		topEnd = deckSplit;
		botLocation = deckSplit;
		botEnd = 51;
		shuffledIndex = -1;

		while(topLocation < topEnd && botLocation < botEnd)
		{
//************************************************
// THE BOTTOM COMES BEFORE THE TOP HALF OTHERWISE
// THE FIRST CARD CAN NEVER CHANGE!
//************************************************
	// BOTTOM HALF
			randomToPlace = getRandInt(1,7);
			if((botEnd - botLocation) > randomToPlace)
			{
				//place card
				for(i = 0;i < randomToPlace; i++)
				{
					shuffledIndex++;
					botLocation++;
					shuffledDeck.m_cardDeck[shuffledIndex] =
						m_cardDeck[botLocation];
				}
			}
			//loop triger loop if failed to place cards
			else
			{
				//dump all remaining cards from half deck
				while(botLocation < botEnd)
				{
					shuffledIndex++;
					botLocation++;
					shuffledDeck.m_cardDeck[shuffledIndex] =
						m_cardDeck[botLocation];
				}
			}
	// TOP HALF
			randomToPlace = getRandInt(1,7);
			if((topEnd - topLocation) > randomToPlace)
			{
				//place card
				for(i = 0;i < randomToPlace; i++)
				{
					shuffledIndex++;
					topLocation++;
					shuffledDeck.m_cardDeck[shuffledIndex] =
						m_cardDeck[topLocation];
				}
			}
			else
			{
				//dump all remaining cards from half deck
				while(topLocation < topEnd)
				{
					shuffledIndex++;
					topLocation++;
					shuffledDeck.m_cardDeck[shuffledIndex] =
						m_cardDeck[topLocation];
				}
			}	
		}
	// deal all remaining cards
		while(topLocation < topEnd)
		{
			shuffledIndex++;
			topLocation++;
			shuffledDeck.m_cardDeck[shuffledIndex] =
				m_cardDeck[topLocation];
		}
		while(botLocation < botEnd)
		{
			shuffledIndex++;
			botLocation++;
			shuffledDeck.m_cardDeck[shuffledIndex] =
				m_cardDeck[botLocation];
		}

	// copy shuffled DECK over theDeck
		for(j = 0;j < 52;j++)
		{
			m_cardDeck[j] = shuffledDeck.m_cardDeck[j];
		}
		//reset lastDealt
		m_lastDealt = -1;
	}
}

CARD::CARD(void)
//*********************************************************************
//*  CARD constructor - make null card
//*  Expects: none
//*  Returns: none
//*  Side Effects: creates card
//*  Tasks:  1. set card face, suit, & point value
//*********************************************************************
{
	m_suit = 0;
	
	m_face[0] = '0';
	m_face[1] = '\n';
	m_face[2] = '\n';

	m_pointValue = 0;
}

void CARD::card_initialize(int newCardIndex)
//*********************************************************************
//*  card initialize - convert index passed in into a new card
//*  Expects: 1 int (card index)
//*  Returns: none
//*  Side Effects: initialize card
//*  Tasks:  1. determine card suit
//*          2. determine card number
//*          3. determine card point value
//*********************************************************************
{
	int cardValue;
	char cardList[14] = "KA23456789nJQ";

	// set card suit
	m_suit = (newCardIndex % 4) + 3;
	
	// set default card face values
	m_face[0] = ' ';
	m_face[1] = '\n';
	m_face[2] = '\n';

	// set card face
	cardValue = newCardIndex % 13;

	if(cardValue == 10)
	{
		//set 10 card face
		m_face[0] = '1';
		m_face[1] = '0';
		//set 10 card value
		m_pointValue = 10;
	}
	else if(cardValue < 13)
	{
		m_face[1] = cardList[cardValue];
		
		if(cardValue < 2 || cardValue > 9) m_pointValue = 10;
		else m_pointValue = cardValue;
		//correct points for ace
		if(cardValue == 1) m_pointValue = 11;
	}
	else cout << "Error setting card value";
}

void CARD::card_show()
//*********************************************************************
//*  card show - displays card to the user
//*  Expects: none
//*  Returns: none
//*  Side Effects: none
//*  Tasks:  1. display card to the user
//*********************************************************************
{
	cout <<" ";
	cout << m_face[0];
	cout << m_face[1];
	
	cout << m_suit;
}

void CARD::changePointVal(int newVal)
{
	m_pointValue = newVal;
}

int CARD::get_pointval()
//*********************************************************************
//*  get point value - returns point value of card
//*  Expects: none
//*  Returns: 1 int (point value of the card)
//*  Side Effects: none
//*  Tasks:  1. return point value of card
//*********************************************************************
{
	return m_pointValue;
}

CARD::CARD(int index)
//*********************************************************************
//*  card constructor - convert index passed in into a new card
//*  Expects: 1 int (card index)
//*  Returns: none
//*  Side Effects: creates and initializes card
//*  Tasks:  1. call card_initialize
//*********************************************************************
{
	card_initialize(index);
}

void prog_start()
//*********************************************************************
//*  program start - displays program info to user
//*  Expects: none
//*  Returns: none
//*  Side Effects: none
//*  Tasks:  1. print data to screen
//*********************************************************************
{
	center("BLACKJACK\n");
	center("by Cream Corn\n");
	center("(Kyle Benson, Joe Clementz, Zachary Lark, Frank Vokoun, Casey Hunter)\n");
	center("(c) 2001, Cream Corn\n");
	cout << "\n\n\n";
}

void usage()
//*********************************************************************
//*  usage-prints messages to user to set up a game
//*  Expects: nothing
//*  Returns: nothing
//*  Side Effects: none
//*  Tasks:  1. prints all messages to the user
//*			 2. extis with a value of 100
//*********************************************************************
{
	cout << "Usage:" << endl;
	cout << "blackjack.exe n1 n2" << endl;
	cout << "where n1 = the number of players" << endl;
	cout << "where n2 = the starting amount" << endl;
	cout << "The number of players must less than or equal to " << MAX_PLAYERS << endl;
	cout << "The starting amount must less than or equal to " << MAX_STARTING_CASH << endl;
	exit(100);
}

int center(char *input)
//*********************************************************************
//*  Center - displays text centered on the screen
//*  Expects: input - the text to display
//*  Returns: none
//*  Side Effects: none
//*  Tasks:  1. get width of text array
//*          2. check array width exit and return 0 if too big
//*          3. space text over for centering
//*          4. print array
//*          5. return 1
//*********************************************************************
{
	int width,i;

	width = strlen(input);
	if(width > 80) return 0;

	cout.width((80 - width)/2);

	// loop to print all characters in array
	for(i =0; i < width; i++, input++) cout << *input;

	return 1;
}

// the getRandInt function was given to me by Professor Samuelson
// for use in this program and is not my own creation in any part
int getRandInt(int min, int max)
//*********************************************************************
//* GetRandInt
//* Expects: min -- smallest number to return
//*          max -- largest number to return
//* Returns: A number between min and max
//* Side Effects: None
//* Tasks: 1. set a num = to random number generator.
//*        2. make num = num % (max - min +1); add min.
//*        3. Return the num
//*********************************************************************
{
	int numToReturn;
	
	numToReturn = rand();
	numToReturn = numToReturn % (max - min + 1) + min;
	
	return numToReturn;
}

int convert_yes_no_to_int(char reply)
//*********************************************************************
//*  convert yes or no to integer - converts char to int response
//*  Expects: 1 char (reply)
//*  Returns: 1 integer (reply converted to integer)
//*  Side Effects: none
//*  Tasks:  1. return 1 if reply is yes (y or Y)
//*          2. return 0 if reply is not yes (y or Y)
//*********************************************************************
{
	if(reply == 'y' || reply == 'Y') return 1;
	return 0;
}

void card_make_driver()
//*********************************************************************
//*  card make driver - create a new card and display the card to user
//*  Expects: none
//*  Returns: none
//*  Side Effects: none
//*  Tasks:  1. prompt user for card index
//*          2. do the following while user responds less than 52
//*            a. make card
//*            b. show card
//*            c. show returned point value of card
//*            d. prompt user for new card index
//*********************************************************************
{
	int index;
	CARD newCard;

	//get first response
	cout << "Enter a number between 0 and 51. 52 to quit.\n";
	cin >> index;
	//loop until response is 52 or greater, then exit loop
	while(index < 52)
	{
		newCard.card_initialize(index);
		newCard.card_show();
		cout << "Pointvalue: " << newCard.get_pointval();
		cout << endl;
		cout << "Enter a number between 0 and 51. 52 to quit.\n";
		cin >> index;
	}
}

void deck_make_driver()
//*********************************************************************
//*  deck make driver - tests deck functions
//*  Expects: none
//*  Returns: none
//*  Side Effects: none
//*  Tasks:  1. call deck_make
//*          2. call deck_show
//*          3. call shuffle
//*          4. call deck_show
//*          5. call deal_one
//*            a. call while not done
//*            b. call card_show
//*********************************************************************
{
	DECK theDeck;
	int timesToShuffle,continueDealing;
	CARD lastDealtCard;
	char reply;

	theDeck.deck_make();
	theDeck.deck_show();
	cout << "How many times do you want to shuffle the deck:";
	cin >> timesToShuffle;
	theDeck.shuffle(timesToShuffle);
	theDeck.deck_show();
	cout << "Would you like to deal a card? (Y or N) \n";
	cin >> reply;
	continueDealing = convert_yes_no_to_int(reply);
	while(continueDealing)
	{
		lastDealtCard = theDeck.deal_one();
		lastDealtCard.card_show();
		cout << "\n";
		cout << "Would you like to deal another a card? (Y or N) \n";
		cin >> reply;
		continueDealing = convert_yes_no_to_int(reply);
	}
	//to check that the cards have been dealt from the deck
	//theDeck.deck_show();
}

void prog_continue()
//*********************************************************************
//*  prog_continue - prompts user to determine to continue or not
//*  Expects: none
//*  Returns: none
//*  Side Effects: none
//*  Tasks:  1. print data to screen prompting for continue yes/no
//*          2. gets response from user
//*********************************************************************
{
	center("Hit the <Return> key to continue...");
	cout << endl;
	cin.get();
}

void flushInput()
//*********************************************************************
//*  flushInput - prints blank line
//*  Expects: none
//*  Returns: none
//*  Side Effects: none
//*  Tasks:  1. flushes input
//*********************************************************************
{
	cin.get();
}
