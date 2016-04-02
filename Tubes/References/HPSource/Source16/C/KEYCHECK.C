/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* This program illustrates the use of Header files in Turbo C.         */
/* Source code in the header file can be incorporated into the current  */
/* program by the declaration #include "limitkey.h"                     */
/* The header file limitkey.h provides a function that only allows a    */
/* selected set of keys to be acceptable input. The selected keys are   */
/* defined as the first argument of the function limitchar(...)         */
/*                                                                      */
/* KEYCHECK.C  ->  .EXE       R Shaw         31.3.93                    */
/*______________________________________________________________________*/

#include <conio.h>
#include <stdio.h>
#include "limitkey.h"

main()
{
   char    ch;
   int     colour, xkey;

   clrscr();
   textmode(3);
   window(1,1,80,25);
   cputs("Please press a number key 1 - 7 to change foreground color or Q to quit: ");
   do
      {
      do
        {
	limitchar("1234567Qq",&ch,&xkey);
        }
      while (xkey != 0);
      if ((ch == 'Q') || (ch == 'q')) break;
	{
	   colour = (int)ch-48;
	   textcolor(colour);
	   printf("\n");
	   cputs("This text is now displayed in foreground colour ");
	   putch((int)ch);
	   printf("\n\n");
	   cputs("Please press a number key 1 - 7 to change foreground color again or Q to quit: ");
	}
      if ((ch == 'Q') || (ch == 'q')) break;
   }
   while ((ch != 'Q') || (ch != 'q'));
}