/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/*  Illustration of Increment (++) and Decrement (--) Operators.    */
/*                                                                  */
/*  INCDECOP.C   by R. Shaw     29.1.91      13.5.93                */
/*__________________________________________________________________*/

#include <stdio.h>
#include <conio.h>

main()
{
   int   a,b,c,sum;

   clrscr();
   a = b = c = 5;
   printf("    INCREMENT (++) and DECREMENT (--) OPERATORS.\n\n");
   printf("   a = 5 initially, but changes. b = 5 throughout.\n\n");
   printf("    operation          comment \n\n");
   sum = a   + b;
   printf("   a   + b = %d      a = %d and is unchanged \n",sum,a);
   c = a; sum = a++ + b;
   printf("   a++ + b = %d      a = %d but changes value after addition to  %d\n",sum,c,a);
   sum = ++a + b;
   printf("   ++a + b = %d      a = %d having changed value before addition\n",sum,a);
   sum = --a + b;
   printf("   --a + b = %d      a = %d having changed value before addition\n",sum,a);
   c = a; sum = a-- + b;
   printf("   a-- + b = %d      a = %d but changes value after addition to  %d\n",sum,c,a);
   sum = a   + b;
   printf("   a   + b = %d      a = %d the value from last operation\n",sum,a);
   printf("\n\n\n\n          Press any key to continue");
   getch();
}