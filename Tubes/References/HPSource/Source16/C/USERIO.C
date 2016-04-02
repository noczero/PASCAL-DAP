/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* Program to demonstrate the scanf and printf functions for  */
/* input from the keyboard and output to the screen.          */
/*                                                            */
/* USERIO.C             R Shaw          29.1.93               */
/*____________________________________________________________*/

#include <stdio.h>
#include <conio.h>

main()
{
   int           integer;
   float         real;
   unsigned int  hex;
   char          str[20];

   clrscr();
   printf("Please enter the data requested below and press the ENTER key to conclude\n");
   printf("each entry.\n\n");
   printf("Enter a 5 figure decimal integer, less than 30000 [eg 12345]: ");
   scanf("%5d",&integer);
   printf("\nEnter a 4 digit float number, with 2 digit decimal part [eg 12.34]: ");
   scanf("%5f",&real);
   printf("\nEnter a 4 digit hexadecimal number with lower case letters [eg abcd]: ");
   scanf("%4x",&hex);
   printf("\nEnter your first name, up to 20 characters [eg Ronald]: ");
   scanf("%20s",&str);
   printf("\n\n    ------------------------      \n\n");
   printf("The 5 figure decimal integer    = %5d \n",integer);
   printf("The 4 digit float number        = %5.2f \n",real);
   printf("The 4 digit hexadecimal number  = %4x \n",hex);
   printf("The string of characters [name] = %20s \n",str);
   printf("\nNote that this last output is right justified in a field width of 20");
   printf("\n\n\nPress any key to continue");
   getch();
}