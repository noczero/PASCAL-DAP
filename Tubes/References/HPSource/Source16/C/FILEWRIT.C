/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* Program to write text to a disk file and then to check the contents  */
/* DOS Debug is called by means of the spawn.. function.                */
/* Options/Compiler/Model is set to 'small' for this program.           */
/*                                                                      */
/* FILEWRIT.C     by R. Shaw    2.12.90   revised 12.5.93 and 6.7.93    */
/*______________________________________________________________________*/

#include <stdio.h>
#include <conio.h>
#include <process.h>

main()
{
   char    text[80];
   char    line2[80];
   char    fulltext[160];
   int     c, stat, stat2;
   FILE    *f;

   clrscr();

   if ((f = fopen("textfile.txt", "wt")) == NULL)
   {
      fprintf (stderr, "Cannot open output file.\n");
      return (1);
   }
   printf("Please enter text, less than 80 characters in length, and then press ENTER:\n\n");
   if (gets(text) == NULL || text[0] == '\0')
      {
      printf("\nUnsuccessful. Please try again. Press any key to quit. ");
      getch();
      return(0);
      }
   else
      {
      strcat(text," ");
      fprintf(f, "%s",text);
      }
   fclose(f);


   if ((f = fopen("textfile.txt", "a+")) == NULL)
   {
      fprintf (stderr, "Cannot open output file.\n");
      return (1);
   }
   printf("\nPlease enter more text, up to 80 characters in length, and then press ENTER:\n\n");
   if (gets(line2) == NULL || line2[0] == '\0')
      {
      printf("\nUnsuccessful. Please try again. Press any key to quit. ");
      getch();
      return(0);
      }
   else
      fprintf(f, "%s%c",line2,'\0');

   printf("\nThe complete text is: \n\n");

   fclose(f);

   if ((f = fopen("textfile.txt", "r")) == NULL)
   {
      fprintf (stderr, "Cannot open output file.\n");
      return (1);
   }

   rewind(f);
   while ((c = getc(f)) != NULL)
      putch(c);
   fclose(f);
   printf("\n\nDOS Debug now being called by spawn.. function to inspect the disk file.\n");
   printf("Please wait for - prompt and then type d and press ENTER.\n");
   printf("Finally type q and press ENTER to quit.\n");
   stat = spawnlp(P_WAIT,"DEBUG.EXE","DEBUG.EXE","TEXTFILE.TXT",NULL);
   if (stat == -1)
      stat2 = spawnlp(P_WAIT,"DEBUG.COM","DEBUG.COM","TEXTFILE.TXT",NULL);
   if (stat2 == -1) {
      printf("spawnlp error = %d\n\n",stat);
      printf("Please check that you have DEBUG.EXE or DEBUG.COM available on the DOS path.\n\n");
      printf("Press any key to continue: ");
      getch();
   }
}
