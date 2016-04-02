
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* Program to display on the screen the creation of a double-linked list */
/* on the Heap and to show the action as the structures of the list are  */
/* traversed both forward and backward under the control of the right    */
/* and left arrow keys.                                                  */
/* Then the DOS Debug program is called by means of the spawn.. function */
/* to inspect the heap memory. The segment and offset addresses for the  */
/* previous and next members of the structure can be seen to enclose the */
/* number member of the structure. Note that the addresses appear in the */
/* reverse order to normal - offset low byte first, then offset high     */
/* byte, followed by segment low byte and finally the segment high byte. */
/* Options/Compiler/Model is set to 'large' for this program.            */
/*                                                                       */
/* TWOLINKS.C  ->  .EXE      R. Shaw       24.3.93    6.7.93             */
/*_______________________________________________________________________*/

#include <conio.h>
#include <stdio.h>
#include <dos.h>
#include <alloc.h>
#include <process.h>

struct item
   {
   struct item   *previous;
   int  number;
   struct item   *next;
   };

struct item      *first, *last, *this;
char             *str[10];
int              i, k, n, x, y, interval, stat, stat2, step, check;
char             speed;

instructions()
{
   textcolor(CYAN);
   gotoxy(1,13);
   cputs("    Please press arrow keys <- or -> to move about list or Q to quit");
   gotoxy(1,14);
   cputs("    If at either end, only the inward arrow key is effective.");
   gotoxy(1,15);
   cputs("    The selected record of the double-linked list is shown by ");
   textcolor(RED);
   cputs("red asterisks.");
   gotoxy(14*n+4,12);
}

codedisplay(int k, int colour)
{
   switch (k) {
        case 0 :  x = 1; y = 13; str[0] = "CODE"; break;
        case 1 :  x = 5; y = 14;
           str[1] = "this = (struct item *) malloc(sizeof(struct item))";
           break;
        case 2 :  x = 5; y = 15;
           str[2] = "if (first == (struct item *)NULL) first = this";
           break;
        case 3 :  x = 53; y = 15; str[3] = "else  last->next = this";
           break;
        case 4 :  x = 5; y = 16; str[4] = "this->number = i"; break;
        case 5 :  x = 5; y = 17;
           str[5] = "if (first == this) this->previous = (struct item *)NULL";
           break;
        case 6 :  x = 10; y = 18; str[6] = "else  this->previous = last";
           break;
        case 7 :  x = 5; y = 19; str[7] = "last = this"; break;
        case 8 :  x = 5; y = 20; str[8] = "last->next = (struct item *)NULL";
           break;
   }
   textcolor(colour);
   gotoxy(x,y);
   cputs(str[k]);
}

createlist()
{
   textcolor(YELLOW);
   gotoxy(1,3);
   cputs("Pointer");
   gotoxy(1,5);
   cputs("Record");
   gotoxy(1,6);
   cputs("Address");
   gotoxy(1,8);
   cputs("Record fields");
   gotoxy(1,9);
   cputs("Previous");
   gotoxy(1,10);
   cputs("Number");
   gotoxy(1,11);
   cputs("Next");
   if (step == 1) {
        textcolor(CYAN);
        gotoxy(5,24);
        cputs("Please press the spacebar to continue to next statement. ");
   }
   else {
        textcolor(CYAN);
        gotoxy(5,24);
        cputs("Successive statements are executed and displayed automatically. ");
   }
   textcolor(YELLOW);
   for (i = 1; i <= n; i++)
   {
      this = (struct item *) malloc(sizeof(struct item)); /*see Allocmem.txt*/
      gotoxy(14*i,3);
      cputs("This");
      codedisplay(1,WHITE);
      if (i == n) textcolor(RED);
         else textcolor(WHITE);
      gotoxy(14*i,6);
      printf("%4p",this);
      if (step == 1)
          getch();
      else
          delay(interval);
      codedisplay(1,YELLOW);

      if (first == (struct item *)NULL) {
         first = this;
         gotoxy(14*i,3);
         cputs("First");
         codedisplay(2,WHITE);
      }
      else {
         last->next = this;
         codedisplay(3,WHITE);
         textcolor(WHITE);
         gotoxy(14*(i-1),11);
         printf("%4p",this);
      }
      if (step == 1)
          getch();
      else
          delay(interval);
      codedisplay(2,YELLOW);
      codedisplay(3,YELLOW);

      this->number = i;
      codedisplay(4,WHITE);
      textcolor(WHITE);
      gotoxy(14*i,10);
      printf("%d",i);
      if (step  == 1)
          getch();
      else
          delay(interval);
      codedisplay(4,YELLOW);

      if (first == this) {
         this->previous = (struct item *)NULL;
         codedisplay(5,WHITE);
      }
      else {
         this->previous = last;
         codedisplay(6,WHITE);
      }

      textcolor(WHITE);
      gotoxy(14*i,9);
      printf("%4p",this->previous);

      if (step  == 1)
         getch();
      else
         delay(interval);
      codedisplay(5,YELLOW);
      codedisplay(6,YELLOW);

      last = this;
      gotoxy(14*i,3);
      if (i == 1)
          cputs("First/Last");
      else
          cputs("Last");
      if (i > 1)
         {
            gotoxy(14*(i-1),3);
            if (i == 2)
                cputs("First     ");
            else
                cputs("    ");
         }
      codedisplay(7,WHITE);
      if (step == 1)
          getch();
      else
          delay(interval);
      codedisplay(7,YELLOW);

      last->next = (struct item *)NULL;
      codedisplay(8,WHITE);
      if (i == n)  {
          textcolor(RED);
          gotoxy(14*i,5);
          cputs("*********");
      }
      else
          textcolor(WHITE);
      gotoxy(14*i,11);
      printf("0000:0000");
      if (step == 1)
          getch();
      else
          delay(interval);
      codedisplay(8,YELLOW);
   }
}

change(int j, int colour)
{
   textcolor(colour);
   if ((j > 0) && (j <= n))
      {
      gotoxy(1,5);
      clreol();
      textcolor(RED);
      gotoxy(14*j,5);
      cputs("*********");
      }
}

advance(int i, int colour)
{
   int   j;

   textcolor(colour);
   if (colour == 0)  i = i - 1;
   gotoxy(14*i+9,11);
   cputs("ÄÄÙ");
   for (j = 7; j <= 10; j++)
      {
         gotoxy(14*i+11,j);
         cputs("³");
      }
   gotoxy(14*i+11,6);
   cputs("ÚÄ>");
   if (i != n)  i = i + 1;
   gotoxy(14*i-1,12);
   cputs("Please Wait");
   if (colour != 0) delay(1000);
   textcolor(CYAN);
   gotoxy(70,13);
}

retreat(int i, int colour)
{
   int   j;

   textcolor(colour);
   if (colour == 0)  i = i + 1;
   gotoxy(14*i-3,9);
   cputs("ÀÄÄ");
   for (j = 7; j <= 8; j++)
      {
         gotoxy(14*i-3,j);
         cputs("³");
      }
   gotoxy(14*i-5,6);
   cputs("<Ä¿");
   gotoxy(14*(i-1)-1,12);
   cputs("Please Wait");
   if (colour != 0) delay(1000);
   textcolor(CYAN);
   gotoxy(70,13);
}


arrowkey()
{
   char    key;
   int     ekey;

 interval = 500;
 do
  {
    do
      {
      ekey = 0;
      key = getch();
      if ((key == 'Q') || (key == 'q')) break;
      if (key == 0)
        {
          ekey = 1;
          key = getch();
          if ((key == 75) && (i > 1))
            {
              retreat(i,RED);
              delay(interval);
              i--;
              change(i, RED);
              retreat(i,BLACK);
            }
          if ((key == 77) && (i < 5))
            {
              advance(i,RED);
              delay(interval);
              i++;
              change(i, RED);
              advance(i,BLACK);
            }
        }
      }
    while ((ekey == 0) && ((key != 75) || (key != 77)));
    if ((key == 'Q') || (key == 'q')) break;
  }
  while ((key != 'Q') || (key != 'q'));
}

dosdebug()
{
  textcolor(LIGHTGRAY);
  stat = spawnlp(P_WAIT,"DEBUG.EXE","DEBUG.EXE",NULL);   /*see Childprg.txt*/
  if (stat == -1)
     stat2 = spawnlp(P_WAIT,"DEBUG.COM","DEBUG.COM",NULL);
  if (stat2 == -1) {
     printf("spawnlp error = %d\n\n",stat);
     printf("Please check that you have DEBUG.EXE or DEBUG.COM available on the DOS path.\n\n");
     printf("Press any key to continue: ");
     getch();
  }
}


main()
{
   textmode(3);
   window(1,1,80,25);
   textbackground(BLACK);
   step = 0;
   textcolor(LIGHTGRAY);
   do {
      clrscr();
      cputs("Please specify speed of display as Slow[S] or Fast[F] or Key Step[K]: ");
      speed = getch();
      if (speed == 's' || speed == 'f' || speed == 'k') check = 1;
      if (speed == 'S' || speed == 'F' || speed == 'K') check = 1;
   } while (check != 1);

   clrscr();
   textcolor(CYAN);
   cputs("THE CREATION OF A DOUBLE-LINKED LIST AND MOVEMENT FROM RECORD TO RECORD.");
   switch (speed) {
      case 's' :
      case 'S' : interval = 4000;
                 break;
      case 'f' :
      case 'F' : interval = 1000;
                 break;
      case 'k' :
      case 'K' : step = 1;
                 break;
      default  : interval = 500;
   }
   codedisplay(0,CYAN);
   for (k = 1; k < 9; k++)  codedisplay(k, YELLOW);
   n = 5;
   createlist();
   window(1,12,80,25);
   clrscr();
   window(1,1,80,25);
   instructions();
   gotoxy(70,13);
   i = 5;
   arrowkey();
   window(1,13,80,25);
   clrscr();
   textcolor(CYAN);
   gotoxy(1,1);
   cputs("Please wait for DOS Debug prompt (-) and then type d followed by a space and");
   gotoxy(1,2);
   cputs("then the address of the first record, as shown above, and then press ENTER.");
   gotoxy(1,3);
   cputs("After studying the contents of memory, press Q followed by ENTER to quit.");
   textcolor(LIGHTGRAY);
   cputs(" ");
   window(1,16,80,25);
   clrscr();
   dosdebug();
}

