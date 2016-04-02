/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/*  Program to illustrate use of Bitwise Operators.                  */
/*  See page 165 of the User's Guide (version 2.0).                  */
/*                                                                   */
/*  BITWISE.C      by  R. Shaw       29.1.91                         */
/*___________________________________________________________________*/

#include <stdio.h>
#include <conio.h>

main()
{
   int    a,b,c;
   char   *format1,*format2;

   clrscr();
   format1 = "\n %04X %s %04X = %04X";
   format2 = "\n %c%04X = %04X";
   a = 0x0FF0;  b = 0xFF00;
   printf("      BITWISE OPERATIONS.\n\n");
   c = a << 4;  printf(format1,a,"<<",4,c);
   printf("   Left shift 4 bits or one hex digit.");
   c = a >> 4;  printf(format1,a,">>",4,c);
   printf("   Right shift 4 bits or one hex digit.");
   c = a & b;   printf(format1,a,"&",b,c);
   printf("    AND means hex digit only when digits occur in both.");
   c = a | b;   printf(format1,a,"|",b,c);
   printf("    OR means hex digit when digit exists in either value.");
   c = a ^ b;   printf(format1,a,"^",b,c);
   printf("    Exclusive OR means digit for digits in only one value.");
   c = ~a;      printf(format2,'~',a,c);
   printf("          NOT means digits where none before and vice versa.");
   c = -a;      printf(format2,'-',a,c);
   printf("          Two's compliment arithmetic in hexadecimal.");
   printf("\n");
   printf("\n\nPress any key to continue");
   getch();
}
