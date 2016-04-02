/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* Program to initialize a file, named 'product.dat', of structures, or */
/* records, of 5 products and to update and read the structures.        */
/* The program uses static memory, not the heap, and is therefore not   */
/* dynamic in memory allocation. The programs TWOLINKS.C and BINTREE.C  */
/* illustrate the use of the heap with dynamic memory management.       */
/* Options/Compiler/Model set to 'large' for this program.              */
/*                                                                      */
/* STRUCTUR.C  ->  .EXE      R. Shaw      14.4.93 and 6.7.93            */
/*______________________________________________________________________*/

#include <stdio.h>
#include <conio.h>
#include <stdlib.h>
#include <process.h>

typedef struct {
   int   itemno;
   char  name[20];
   int   instock;
   char  supplier[24];
} product ;

product   stock[5];
FILE      *fstock;
char      reply;
int       stat, stat2;


main()
{

char      reply;

   reply = ' ';
   while (reply != 'q')
   {
      clrscr();
      printf("   **** MENU ****\n\n ");
      printf("   i to initialize\n    r to read\n    u to update\n    q to quit\n ");
      printf("\nPlease select option by typing the appropriate letter: ");
      reply = getche();

         if (reply == 'i') init();
         if (reply == 'r') recread();
         if (reply == 'u') update();
   }
}  /*End of function main */


int init()
{
   product stock[5] = {0,"",0,"",
                       1,"",0,"",
                       2,"",0,"",
                       3,"",0,"",
                       4,"",0,""
                      };

   clrscr();
   if ((fstock = fopen("product.dat", "wt")) == NULL)
   {
      fprintf (stderr, "Cannot open output file.\n");
      return (1);
   }

   fwrite(&stock,sizeof(stock),1,fstock);

   fclose(fstock);
   printf("\n");
   printf("\n\nPress any key to continue");
   getch();
   return (0);
}

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* Function to read a disk file of structures (records) of stock.       */
/*                                                                      */
/* File name is  product.dat                                            */
/*______________________________________________________________________*/

int recread()
{
   int   i;

   if ((fstock = fopen("product.dat", "r+t")) == NULL)
   {
      fprintf (stderr, "Cannot open input file.\n");
      return (1);
   }

   textmode(3);
   clrscr();
   printf("\n   Item      Name                   Number         Supplier\n");
   for(i = 0; i <=4; i++)   {
      fread(&stock[i],sizeof(product),1,fstock);
      printf("\n   %2d        %-20s      %3d         %-24s", stock[i].itemno,
                stock[i].name, stock[i].instock, stock[i].supplier);
   }
   printf("\n\n");
   printf(" The segment:offset address of the first structure is %X:%X",_DS,&stock[0]);
   printf("\n\n Do you wish to see the data as stored in memory (Y/N)? ");
   reply = getche();
   if ((reply == 'Y') || (reply == 'y')) inspectmemory();
   printf("\n\n");
   printf("  Press any key to continue ");
   getch();
   fclose(fstock);
   return(0);
}

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* Function to read a disk file of structures (records) of stock,       */
/*                                                                      */
/* modify a structure and then resave to disk file (product.dat).       */
/*______________________________________________________________________*/

int update()
{
   int   i;
   long int  offset;
   product   *ptr;

   if ((fstock = fopen("product.dat", "r+t")) == NULL)
   {
      fprintf (stderr, "Cannot open input file.\n");
      return (1);
   }

   textmode(3);
   clrscr();
   printf("\n   Item        Name                Number       Supplier\n");
   for(i = 0; i <=4; i++)   {
      fread(&stock[i],sizeof(product),1,fstock);
      printf("\n   %2d          %-20s  %3d         %-24s", stock[i].itemno,
                stock[i].name, stock[i].instock, stock[i].supplier);
   }
   printf("\n\n");
   printf("\n  Entries for stock name and supplier terminate on either whitespace");
   printf("\n  or ENTER, so use the underscore (_) as a separator in strings");
   printf("\n\nEnter item number for modification (int < 5)  ");
   scanf("%d",&i);
   stock[i].itemno = i;
   printf("\nEnter stock name ( <20 char )  ");
   scanf("%20s",stock[i].name);
   printf("\nEnter number in stock ( <1000 )  ");
   scanf("%d",&stock[i].instock);
   printf("\nEnter supplier name ( <24 char )  ");
   scanf("%24s",stock[i].supplier);
   offset = i * sizeof(product);
   fseek(fstock,offset,SEEK_SET);
   fwrite(&stock[i],sizeof(product),1,fstock);

   fclose(fstock);
   printf("\n\n\n   Press any key to continue ");
   getch();
   return (0);
}

inspectmemory()
{
  stat = 0;
  stat2 = 0;
  printf("\n\n");
  printf("DOS Debug now being called by spawn.. function. Please wait for - prompt. Then\n");
  printf("type d followed by the address given above and press ENTER to inspect memory.\n");
  printf("Type d & press ENTER for next memory block. Then type q & press ENTER to quit.\n");
  stat = spawnlp(P_WAIT,"DEBUG.EXE","DEBUG.EXE",NULL);   /*see Childprg.txt*/
  if (stat == -1)
     stat2 = spawnlp(P_WAIT,"DEBUG.COM","DEBUG.COM",NULL);
  if (stat2 == -1) {
     printf("spawnlp error = %d\n\n",stat);
     printf("Please check that you have DEBUG.EXE or DEBUG.COM available on the DOS path.\n\n");
     printf("Press any key to continue: ");
     getch();
  }
  return(0);
}
