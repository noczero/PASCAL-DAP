/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/*    Memory peeking illustration, using functions.                 */
/*                                                                  */
/*    PEEK.C          R. Shaw         14.11.90                      */
/*__________________________________________________________________*/

#include <stdio.h>
#include <conio.h>
#include <dos.h>

/*  Function declarations */

void initialize(void);
void pseudovar(void);
void ptradd(void);

/*  Global variable declarations  */

int     x,y,z;
int     *ptx,*pty,*ptz;

/*  Function definitions */

void initialize(void)
{
   clrscr();
   x = 0;
   y = 0;
   z = 0;
}

void pseudovar(void)
{
   unsigned int    Dseg,value;

   Dseg = _DS;     /* Pseudo variable _DS gives Data Segment address */
   printf("\nVALUES USING PSEUDO-VARIABLE _DS\n\n");

   printf("Data segment = %4X and offset for x = %4X\n",Dseg,ptx);
   value = peek(Dseg,ptx);   /* Call peek function in dos.h to read memory */
   printf("Contents of address %4X:%4X        = %4X\n\n",Dseg,ptx,value);

   printf("Data segment = %4X and offset for y = %4X\n",Dseg,pty);
   value = peek(Dseg,pty);   /* Call peek function in dos.h to read memory */
   printf("Contents of address %4X:%4X        = %4X\n\n",Dseg,pty,value);

   printf("Data segment = %4X and offset for z = %4X\n",Dseg,ptz);
   value = peek(Dseg,ptz);   /* Call peek function in dos.h to read memory */
   printf("Contents of address %4X:%4X        = %4X\n\n",Dseg,ptz,value);
}

void ptradd(void)
{
   printf("VALUES USING POINTERS, ADDRESS-OF OPERATORS & INDIRECTION OPERATORS\n\n");

   printf("                         x                 y                z\n\n");
   printf("Address of pointer      %4X              %4X             %4X\n",
                                  &ptx,&pty,&ptz);
   printf("Address pointed to      %4X              %4X             %4X\n",
                                  ptx,pty,ptz);
   printf("Value of variable       %4X              %4X             %4X\n\n",
                                  *ptx,*pty,*ptz);
}

int main(void)
{
   textmode(2);       /* Call textmode function in conio.h for BW80 */
   window(1,1,80,25); /* Call window function in conio.h for full screen */
   initialize();      /* Call initialize function above to set values to 0 */

   printf("Enter hex. integers for x,y and z with comma between values ");
   scanf("%X,%X,%X",&x,&y,&z);     /* Read data from keyboard */
   ptx = &x;                       /* Address of x is assigned to ptx */
   pty = &y;                       /*  ........  y  ............. pty */
   ptz = &z;                       /*  ........  z  ............. ptz */

   pseudovar();       /* Call pseudo variable function  */
   ptradd();          /* Call pointer, address-of and indirection function */

   printf("Press any key to continue");
   getch();   /* Call function getch in conio.h to get char. from keyboard */
   textmode(3);  /* Call textmode function in conio.h to revert to colour  */
   clrscr();  /* Call function clrscr in conio.h to clear screen           */
   return 0;  /* To indicate to DOS that the program terminated normally   */
}
