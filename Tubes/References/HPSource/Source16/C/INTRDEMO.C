/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/*  Program to illustrate Turbo C int86 function, from the dos.h header. */
/*                                                                       */
/*  The BIOS Interrupt Service 10 Hex is used with Function (AH) = 0F    */
/*                                                                       */
/*  INTRDEMO.C  -> .EXE     R. Shaw       3.5.93                         */
/*_______________________________________________________________________*/

#include<conio.h>
#include<stdio.h>
#include<dos.h>

main()
{
   int   mode, width, page;
   char  displaymode[20];
   union REGS regs;

   regs.h.ah = 0x0F;           /* Sets ah = 0F for Get Display Mode function */
   int86(0x10, &regs, &regs);  /* Interrupt 10 for ROM BIOS Video Services */
   mode  = regs.h.al;            /* Display Mode returned in al */
   width = regs.h.ah;            /* Screen width returned in ah */
   page  = regs.h.bh;            /* Screen page returned in bh */

   clrscr();
   printf("Display mode is %d\n",mode);
   printf("Screen width is %d columns\n",width);
   printf("Screen page is %d\n\n",page);
   printf("Press any key to conclude...");
   getch();
}