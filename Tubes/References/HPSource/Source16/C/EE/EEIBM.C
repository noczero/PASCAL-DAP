/* eeibm.c -- machine dependent functions for ee.c

This program started around 08-08-88. Don't have much documentation for
previous changes. It will be added this time. 09-19-91. This is a small,
portable word processor. A good program practice to write portable screen
output code.

*/
/*	Software requirment specifications:

Edit key: It is difficult to follow any word processor since every ones
are different. TC arrange the editing keys by keyboard layout while emacs
by the meaning of the function. A precise definitions for each editing key
are very important in help screen.

Screen: The first line contain status report and is also used for error
display, user input prompt etc. The rest of the lines are used for main
editing area. Scrolls are nice. But scroll functions in course package on
unix does not work very well except compiled with gcc and courseX.

Searching: TC style is very good. For replace, a possible example is
/more/less/wn.

Block: A common block buffer is used to copy to a different file. TC's
block method will not be used. Block commands should start with a mark
command. Temporary file is used for large block.

Blanks: If the file contains tabs, then traillings are deleted and blanks
are replaced with tab whenever appropriate. Otherwise, blanks are not
disturbed. This is useful for data files.

Modes: Autofill, overwrite, tab (will convert on save), prefix (control-p
pressed), changed (will ask to save on exit), position (show position),
auto-indent (good for writing program on mainframe), format to cursor
position (to write online document).

Compiler options: Editing keys, color(white/blue) or mono (bold/normal),
default tab size should be 8 to be compatible with other word processor.
Buffer size is also fixed at compile time.

Big file: Read will stop when editor buffer is almost full. Dump to disk
start as soon as buffer is full in sequential manner.

Portability: It is written for MSDOS, unix and VMS operating system with
minimum machine dependent functions. Far pointer should not be used on
MSDOS but it would be nice to be able to compile with compact module. C++
should not be used until it is also available for mainframe.

*/
/* Implementation issues

Program can be loosely grouped by: screen, cursor move, search, block,
file and window, misc, mainloop, main.

This file is not needed when compiled by TC 2.0. It emulate the following
functions: cprintf, putch, clreol, clrscr, insline, delline, gotoxy,
highvideo, lowvideo, getch. These two not needed for TC to emulate
mainframe: ttopen, ttclose. Also to observe the different behavior of
these: system, rename, fopen.

Internally, the whole editing buffer is treated like a array. Each line
is a string which ends with a 0. Malloc() is not used.

*/

/* define one of the following, not all of them work */
#define ANS  0  /* using ansi code, for VMS */
#define CVM  0  /* curses VMS, does not work yet */
#define CUN  0  /* curses unix, no hardware scroll */
#define CUX  1  /* cursesX unix, works best with gcc */

#if CUN | CUX | CMV | ANS
#define AMAX  0xD0000	/* main buffer size */
#define BMAX  0x400 	/* block size */
#define YTOP  0		/* first line */
#endif

#if CMV
#include <curses.h>
#define ttopen() initscr();\
  crmode();system("set term/pasthru/nottsyc/noecho");\
  swhfull=LINES-3;sww=COLS-2
/* #define OPEN "r","var=lf","fmt=fix" */
#define unlink(s) remove(s)
#endif
#if CUN
#include <curses.h>
#define ttopen() initscr();\
  raw();noecho();swhfull=LINES-3;sww=COLS-2
#endif
#if CUX
#include <cursesX.h>
#define ttopen() initscr();\
  idlok(stdscr,1);\
  raw();noecho();swhfull=LINES-3;sww=COLS-2
#endif

#if CUN | CUX | CMV
#define cprintf(x,y)  	printw(x,y)
#define cputs(s)  	addstr(s)
#define putch(c)  	addch(c)
#define clreol()  	clrtoeol()
#define clrscr()  	erase()
#define insline() 	insertln()
#define delline() 	deleteln()
#define gotoxy(x,y)  	move(y,x-1)
#define highvideo() 	standout()
#define lowvideo()  	standend()
#define ttclose() 	addch('\n');refresh();endwin()
#endif

#if ANS
/* deleted */
#endif

/* honest get a key */
int get_key()
{
  static  char k1[]="ABCDrpl";
  static  char k2[]="EXDSdsh";
  int key;
  char  *s;
#ifndef TYEP
  refresh();
  key = getch();
#else /* type ahead, does not works well */
  nodelay(stdscr, 1);
  if((key = getch()) == ERR) {
    refresh();
    nodelay(stdscr, 0);
    key = getch();
  }
#endif
  if(key == 127) return 8;
  if(key == 27) {
    getch();  /* aa nothing */
    if((s=strchr(k1, getch())) != NULL && (key = k2[s-k1]) > 'a')
      flag[ALT]++;
    return key&0x1F;
  }
  return key;
}
