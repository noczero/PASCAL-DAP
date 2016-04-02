
/***************************************************************************

                            Towers of Hanoi

  Version 1.6


  The object of the game is to transfer the disks from the leftmost tower
  to the rightmost tower obeying the following set of rules:

  1) Only the top disk of any tower may be moved at a time
  2) At no time must a larger disk be placed on a smaller disk

  Original source downloaded from IBM-RBBS PC, Tulsa Finland
						    918-664-8737,
						    24H 300/1200 Baud XMODEM.
						    Sysop Lynn Long.

  Original author unknown.

  Converted to Turbo C by Sturt Ison 16th Oct 1990, Helsinki Finland,
  as a means of learning Turbo C.

  Mailing address for suggestions etc.
					P.O.Box 150
					Coraki N.S.W.
					2471
					Australia

  IMPROVEMENTS
  Version 1.2
  16-oct-90    Ison    - Converted code to modern ANSII.
				   - Changed wait routine so that it only waits when
                         a non blank character is written.
				   - Placed maximum and minimum values on arguments.
				   - Added comments.

  Version 1.3
  16-oct-90    Ison    - Allow change of delay while program running.
					'+' to increase the speed.
					'-' to decrease the speed.
  17-oct-90    Ison    - Showed moves made on screen.
				   - Showed moves to make on screen.
				   - Enhanced checking of arguments and to display
				the number of moves to move n disks if the moves
					cannot be shown graphically.
				   - Added a "fast" mode, so that when the delay is 0,
					the disk is not shown moving to the correct post,
					it is moved directly there.
				   - Changed method of speed change. User presses a key
					from 0 to 9. Pressing 0 stops the display until
					another key is pressed, display continues at the
					previous speed. Pressing 9 initiates the fastest
					speed.
				   - Added program exit by pressing ESC.

  Version 1.4
  17-oct-90    Ison    - Added manual capability, letting the user move
			 the disks.

  Version 1.5
  25-oct-90    Ison    - Improved user playing routines by:
			 Allowing escape while waiting for move.
			 Allowing change of speed while waiting for move.
			 Allowing type ahead of the moves.

  Version 1.6
  28-oct-90    Ison    - In bloody T””l” hospital.
		       - Improved move type-ahead by queing the entered
			 keystrokes instead of acting on the keystroke
			 immediately. This does not effect the ESC
			 and speed change options.

***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define PROG_VERSION            "Towers of Hanoi Version 1.6"
#define FORMFEED		0x0c
#define ESC			0x1b

#define POST			0xba
#define POST_BASE		0xca
#define BASE			0xcd
#define RING			0xdc

#define SCREEN_WIDTH	80
#define SCREEN_HEIGHT	25


#define RING_WIDTH		((((SCREEN_WIDTH - 2)/3) & 0xfe)-1)
#define LEFT_POST		(RING_WIDTH/2+1)
#define CENTER_POST		(LEFT_POST+RING_WIDTH)
#define RIGHT_POST		(LEFT_POST+2*RING_WIDTH)

#define MOVING_ROW		2
#define BASE_ROW		17
#define POST_HEIGHT		12

#define MAX_PLAYABLE		12
#define MAX_DISKS_CALC		50

#define LEN_KEYBUF		80	/* length of keyboard buffer	*/

void	wait(void);			/* delay routine		*/
void	hanoi(int n, int a, int b, int c);	/* main routine!	*/
void	setup(int rings);			/* set up screen	*/
double	get_total_moves (int n);		/* calc. total moves	*/
void	cput(int x, int y, char ch);		/* place a char ch	*/
void	draw(int ring, int centre, int y, char ch);
void	move_ring(int ring, int from, int to);
void	centre_text(char *text, int line);
void	noise(int ring, int up_down);

void	user_plays(void);
void	display_user_array(void);
void	change_delay(void);
void	set_delay(char ch);
void	usage(void);

void	keystore(char q);	/* store a character 			*/
char	keyretrieve(void);	/* retrieve a character from queue	*/

/* Array top holds the screen line number of the top disk on each post. */
int	top[3] = { BASE_ROW-1, BASE_ROW-1, BASE_ROW-1 };

/* Array dsk holds for each post, the disks and their order		*/
int	dsk[3][12];

/* Array dsk holds for each post, the pointer to the top most disk in
   array dsk. */
int	dsks[3] = { MAX_PLAYABLE-1, MAX_PLAYABLE-1, MAX_PLAYABLE-1 };

int	pause = 0;			/* game slowdown in msec	*/
int	user_playing = 0;		/* initially false		*/

char	keybuf[LEN_KEYBUF];		/* KEYBOARD BUFFER		*/
int	spos = 0;			/* store position		*/
int	rpos = 0;			/* retrieve position		*/
int     bufact = 0;

main(int argc, char *argv[])
{
	int nrings;

	if(argc <= 1  ||  argc > 5)
	{
		usage();
		exit(0);
	}

	nrings = atoi(argv[1]);
	pause = argc > 2 ? atoi(argv[2]) : 1;
	user_playing = argc > 3 ? 1 : 0;

	bufact = (argc != 5);

	if(nrings < 1 || nrings > MAX_DISKS_CALC)
	{
		usage();
		exit(0);
	}

	if(nrings > MAX_PLAYABLE)
	{
		printf("Moving %d rings takes %16.0f moves",
			nrings, get_total_moves(nrings));
		exit(0);
	}

	setup(nrings);

	if(user_playing)
		user_plays();
	else
		hanoi(nrings, 0, 2, 1);

	centre_text("Press ESC to exit: ",SCREEN_HEIGHT-1);
	for(;;) if(getch()==ESC) break;
}


void hanoi(int n, int a, int b, int c)
{
	if(n == 0) return;

	hanoi(n-1, a, c, b);
	move_ring(n, a, b);
	hanoi(n-1, c, b, a);
}

/* user moves the disks */

void user_plays(void)
{
	int n, peg_from, peg_to;

	do
	{
		get_user_move(&n, &peg_from, &peg_to);
		move_ring(n, peg_from, peg_to);
	} while(no_user_end());
}

get_user_move(int *n, int *from, int *to)
{
	char ok;
	ok = ' ';
	do
	{
		gotoxy(1,BASE_ROW+1);
		printf("Press the post number 1..3.  From:  \b");
		*from=get_post();
		if(top[*from] == BASE_ROW-1) continue;	/* no disk */

		gotoxy(38,BASE_ROW+1);
		printf("To:  \b");
		*to=get_post();
		if(top[*to] == BASE_ROW-1)
		{
			ok = 'Y';
			continue;

		}

		if(*from == *to) continue;
		if(is_larger(*from,*to)) continue;

		ok = 'Y';
	} while(ok == ' ');

	*n = dsk[*from] [dsks[*from]];

	move_user_disk(*from,*to);

}

/*
   Get a valid value for a post.
   Returns 0, 1 or 2.
*/

int get_post(void)
{
	int post = 0;
	char ch;

	do
	{
		ch = keyretrieve();
		if(ch==NULL) ch = getch();
		set_delay(ch);
		post = ch - '1';
	} while(post < 0 || post > 2);
	putch(ch);
	return(post);
}

/*
   Check if the disk on the destination post is larger then the disk
   that is to be moved.
   Returns true if the disk is larger.
*/

int is_larger(int from, int to)
{
	int index_from, index_to;

	index_from = dsks[from];
	index_to = dsks[to];

	return(dsk[from][index_from] > dsk[to][index_to]);
}

/*
   Move a users disk from post from to post to.
*/
move_user_disk(int from, int to)
{
	int index_from, index_to, disk;

	index_from = dsks[from];
	index_to = dsks[to];

	disk = dsk[from][index_from];
	dsk[from][index_from] = 0;
	if(index_from != (MAX_PLAYABLE-1)) ++index_from;

	if(dsk[to][index_to] != 0) --index_to;
	dsk[to][index_to] = disk;

	dsks[from] = index_from;
	dsks[to] = index_to;
}

/*
   Check the the user has moved all the disks to the right hand post.
*/

int no_user_end()
{
	return(top[0] != BASE_ROW-1 || top[1] != BASE_ROW-1);
}

/*
   Used in debugging the user playing routine to show the numbers of the
   disks on each peg.
*/

void display_user_array(void)
{
	int i;
	int row = BASE_ROW-1;

	for(i=MAX_PLAYABLE-1; i>= 0; i--)
	{
		gotoxy(LEFT_POST,row); printf("%d",dsk[0][i]);
		gotoxy(CENTER_POST,row); printf("%d",dsk[1][i]);
		gotoxy(RIGHT_POST,row); printf("%d",dsk[2][i]);
		row--;
	}
}

/*
   Set up the screen for the number of disks.
   Initialise the array to hold the line of the top disk of each post.
   Initialise the array used to hold the numbers of each disk on each post
   that is used when the player moves the disks.

   The number of a disk is from 1 .. 12.
   The posts are numbered internally 0,1 and 2.
*/

void setup(int n)
{
	char i;

	clrscr();

	centre_text(PROG_VERSION,1);
	centre_text("Press 4..9 to change speed. 0 to pause. ESC to exit."
				,BASE_ROW+3);

	gotoxy((SCREEN_WIDTH-30)/2,SCREEN_HEIGHT-2);
	printf("Total moves: %-.0f",get_total_moves(n));
	printf(" for %d disks.",n);

	/* draw the posts */

	for(i = MOVING_ROW+2; i < BASE_ROW; ++i)
	{
		cput(LEFT_POST, i, POST);
		cput(CENTER_POST, i, POST);
		cput(RIGHT_POST, i, POST);
	}

	/* draw the base line */

	gotoxy(1, BASE_ROW);

	for(i = 1; i < SCREEN_WIDTH; ++i) putchar(BASE);

	/* place the characters for the base posts */

	cput(LEFT_POST, BASE_ROW, POST_BASE);
	cput(CENTER_POST, BASE_ROW, POST_BASE);
	cput(RIGHT_POST, BASE_ROW, POST_BASE);

	/* draw the rings in the initial position */

	for(i = n; i > 0; --i)
	{
		draw(i, LEFT_POST, top[0]--, RING);
		dsk[0][MAX_PLAYABLE-n+i-1] = i;
		dsk[1][MAX_PLAYABLE-n+i-1] = 0;
		dsk[2][MAX_PLAYABLE-n+i-1] = 0;
	}
	dsks[0] = (MAX_PLAYABLE-n);		/* get index */
}


/*
   This routine calculates the total number of moves that moving the disks
   will take, given the number of disks.

   The moves taken to move n disks is 2*(moves(n-1))+1.
   This evaluates the sum of a series.

   moves(n) = 1 + 2**(1) + 2**(2) + ..... + 2**(n-1)

*/

double get_total_moves(int rings)
{
	double total_moves = 1;
	int i;

	if(rings == 1) return(1);
	else for(i=1; i< rings; i++) total_moves = total_moves + pow(2,i);
	return(total_moves);
}

/*
   Center text within a width of SCREEN_WIDTH,
   and display in on the line given.
*/

void centre_text(char *text, int line)
{
	gotoxy((SCREEN_WIDTH-strlen(text)+1)/2, line);
	printf("%s",text);
}

/*
   Place a character on the screen at position x,y
*/

void cput(int x, int y, char ch)
{
	gotoxy(x,y);
	putchar(ch);
}

/*
   Draw a ring of size 'ring' with a centre at column 'centre',
   on line 'y' using character 'ch'
*/

void draw(int ring, int centre, int y, char ch)
{
    int i;

	gotoxy(centre-ring, y);
	for(i=0; i<ring; ++i) putchar(ch);

	gotoxy(centre+1, y);
	for(i=0; i<ring; ++i) putchar(ch);

	if(ch != ' ') wait();
}

/*
   Graphically move a ring of size 'ring' from post 'from' to post 'to'
*/

void move_ring(int ring, int from, int to)
{
	static int move_count = 0;

	char fromc, toc;
	char fromy, toy;

	fromc = LEFT_POST + from * RING_WIDTH;
	toc = LEFT_POST + to * RING_WIDTH;
	fromy = ++top[from];
	toy = top[to]--;

	gotoxy((SCREEN_WIDTH-30)/2,SCREEN_HEIGHT-3);
	printf("Move Number: %-d",++move_count);

	if(pause == 0)
	{
		draw(ring, fromc, fromy, ' ');
		draw(ring, toc, toy, RING);
		wait();
	}

	else /* show the disk moving up, across to the new post, and down. */

	{

	while(fromy != MOVING_ROW)
	{
		draw(ring, fromc, fromy, ' ');
		draw(ring, fromc, --fromy, RING);
	}

	if(fromc < toc)
		while(fromc != toc)
		{
			cput(fromc-ring, fromy, ' ');
			cput(fromc, fromy, RING);
			cput(fromc+1, fromy, ' ');
			cput(fromc+ring+1, fromy, RING);
			++fromc;
			wait();
		}
	else if (fromc > toc)
		while(fromc != toc)
		{
			cput(fromc+ring, fromy, ' ');
			cput(fromc, fromy, RING);
			cput(fromc-1, fromy, ' ');
			cput(fromc-ring-1, fromy, RING);
			--fromc;
			wait();
		}

	while(fromy != toy)
	{
		draw(ring, fromc, fromy, ' ');
		draw(ring, fromc, ++fromy, RING);
	}
	} /* end of draw routine */

}


/*
   Wait for a number of milliseconds held in pause.
   If the user is playing and a ring is on its way from post to post,
   pressing a key for another move or to change the speed will complete
   the move and then change the speed or start the next move
*/

void wait(void)
{
	if(kbhit() && user_playing && !bufact) return;

	if(kbhit())
		change_delay();
	else
		if(pause!=0) delay(pause);
}

/*
   This routine is used if the user hits a key to change the speed of
   disk movement while the computer is moving the disks
*/

void change_delay(void)
{
	char ch;
	ch = getch();

	if(ch >= '1' & ch<='3' & user_playing)
	{
		if (bufact)
		{
			keystore(ch);
		}
	}
	else
		set_delay(ch);
}

/*
   Use the value in ch to set the delay time held in pause.
*/

void set_delay(char ch)
{
	switch (ch)
	{
	  case '0':
	  {
			centre_text("Press a key to continue",SCREEN_HEIGHT);
			for(;;)	if(kbhit()) break;
			ch = getch();
			centre_text("                       ",SCREEN_HEIGHT);
			break;
	  }
	  case '4': pause = 400;	break;
	  case '5': pause = 100;	break;
	  case '6': pause = 50;		break;
	  case '7': pause = 10;		break;
	  case '8': pause = 1;		break;
	  case '9': pause = 0;		break;
	  case ESC: gotoxy(1,SCREEN_HEIGHT); exit(0);
	}
}

/* store characters in the circular queue 				*/

void keystore(char q)
{
	/* check if the buffer is full					*/

	if(spos+1==rpos || (spos+1==LEN_KEYBUF && !rpos)) return;

	keybuf[spos] = q;
	spos++;
	if(spos == LEN_KEYBUF) spos=0;		/* loop back		*/
}

/* retrieve characters from the circular queue				*/

char keyretrieve(void)
{
	if(rpos==LEN_KEYBUF) rpos=0;
	if(rpos==spos) return NULL;

	rpos++;
	return keybuf[rpos-1];
}

void usage(void)
{
	printf("Use: hanoi [rings (delay {play})]\n\n");

	printf("rings - from 1 to %d.\n",MAX_DISKS_CALC);
	printf("delay - 0 to 500. Suggested is 50.\n");
	printf("play  - type this word to move the disks yourself.\n\n");


	printf("Graphical display of the Towers of Hanoi");
	printf(" possible only for rings 1 .. 12\n");
	printf("Cannot calculate moves of disks over %d\n", MAX_DISKS_CALC);
}

	/* end of program */