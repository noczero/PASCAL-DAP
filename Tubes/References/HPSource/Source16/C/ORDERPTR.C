/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/*   Illustration of the precedence in pointer operations.       */
/*                                                               */
/*   ORDERPTR.C         R. Shaw      9.11.90      19.5.93        */
/*                                                               */
/*_______________________________________________________________*/

#include <stdio.h>
#include <conio.h>

int    firstdata[2]  = {1,5};
int    seconddata[2] = {3,7};

int main(void)
{
   int *pt1, *pt2, *pt3;

   pt1 = pt2 = firstdata;
   pt3 = seconddata;
   textmode(2);

   printf("Unary operators * and ++ have same precedence but associate from right to left.\n");
   printf("So ++ applies to pt, not *pt. Post ++ increments after reference, pre ++ before.\n");
   printf("The declarations are:          int    firstdata[2]  = {1,5};\n");
   printf("                               int    seconddata[2] = {3,7};\n");
   printf("                               int    *pt1, *pt2, *pt3;\n");
   printf("The assignments are:           pt1 = pt2 = firstdata;\n");
   printf("                               pt3 = seconddata;\n");
   printf("So the initial array data is:  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿\n");
   printf("                               ³ First array data  ³ Second array data ³\n");
   printf("                               ³    1    ³    5    ³    3    ³    7    ³\n");
   printf("                               ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ\n");
   printf("                                    ÀÄÄÄÄÄÄÄ¿  ³        ³         ÀÄÄÄÄÄÄÄÄÄ¿\n");
   printf("*pt1 points to value %d which is at address %d ³        ÀÄÄÄÄÄÄÄÄÄÄÄÄ¿      ³\n"
           ,*pt1,pt1);
   printf("*pt2 also points to value %d at address %d ÄÙ  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿      ³      ³\n"
           ,*pt2,pt2);
   printf("*++pt1 points to value %d which is at the incremented address %d     ³      ³\n"
           ,*++pt1,pt1+1);
   printf("*pt3 points to value %d at address %d of the first item of array seconddata ³\n"
           ,*pt3,pt3);
   printf("*++pt3 points to value %d which is at the incremented address %d  ÄÄÄÄÄÄÄÄÄÄÙ\n"
           ,*++pt3,pt3+1);
   printf("*pt1++ points to value %d and then increments the pointer to %d\n"
           ,*pt1++,pt1+1);
   printf("   so now *pt1 points to value %d which at the address %d\n"
           ,*pt1,pt1);
   printf("*++pt2 points to value %d which at the incremented address %d\n"
           ,*++pt2,pt2+1);
   printf("(*pt3)++ points to value %d and adds 1 to that value at"
                    " address %d\n",(*pt3)++,pt3);
   printf("   so *pt3 now points to value %d at that address %d\n\n"
           ,*pt3,pt3);

   printf("                                               Press any key to continue ");
   getch();
   textmode(3);
   return 0;
}


