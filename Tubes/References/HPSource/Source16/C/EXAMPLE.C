/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* This is a simple illustration of the structure of a program in C.    */
/* and illustrates the use of a function with arguments .               */
/* The function simply creates a Times Table for the entered value of   */
/* the multiplicand, or base, for the range of multiplier values also   */
/* entered by the user. The function is called 'timestable' and has     */
/* three arguments: basevalue, lower and upper.                         */
/*                                                                      */
/* EXAMPLE.C  ->  .EXE        R Shaw            14.4.93                 */
/*______________________________________________________________________*/

#include <conio.h>
#include <stdio.h>

int   base, lowlimit, toplimit, i;

timestable(int basevalue, int lower, int upper)
{
   printf("\n%d Times Table\n\n",basevalue);
   for (i = lower; i <= upper; i++)
      printf("%2d * %2d = %5d\n", basevalue,i,basevalue*i);
}

main()
{
   clrscr();
   printf("Please enter base value and lower and upper limits of multiplier (all < 100)\n");
   printf("with a space between each number and then press ENTER: ");
   scanf("%d %d %d",&base,&lowlimit,&toplimit);
   timestable(base,lowlimit,toplimit);
   printf("\nPress any key to conclude.\n");
   getch();
}