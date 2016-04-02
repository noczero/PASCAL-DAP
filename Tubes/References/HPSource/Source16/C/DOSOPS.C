/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* Program to illustrate the use of DOS operations from a Turbo C Program. */
/*                                                                         */
/* DOSOPS.C         R. Shaw         27.3.93                                */
/*                                                                         */
/*_________________________________________________________________________*/

#include<conio.h>
#include <stdio.h>
#include <dos.h>
#include <stdlib.h>
#include <process.h>


int     x,y,z,stat;
char    dir[80],dir2[80],dir3[80];
char    c;

main()
{
   clrscr();
   /*This is a trivial background task into which DOS commands are inserted*/
   x = 1;
   y = 3;
   z = 0;
   getcurdir(0,dir);
   printf("Start directory is \\%s\n",dir);
   printf("Press any key to continue\n");
   printf("\n");
   c = getch();
   z = x + y;
   chdir("\\");
   getcurdir(0,dir2);
   printf("Changed directory is \\%s\n",dir2);
   printf("Press any key to continue for directory listing of *.SYS files:\n");
   printf("\n");
   c = getch();
   stat = system("DIR *.SYS");               /*see note Childprg.txt*/
   if (stat == -1) {
      printf("Error in system function call to COMMAND.COM\n");
      printf("Please check that your active disk has this file.\n");
   }
   printf("\n");
   chdir(dir);
   getcurdir(0,dir3);
   printf("Return to start directory \\%s\n",dir3);
   printf("Press any key to continue:");
   c = getch();
   z = z + 3;
   printf("\n\nThe background task gives z = x + y + 3 = %d + %d + %d = %d\n",x,y,3,z);
   printf("\nPress any key to continue:");
   c = getch();
}

