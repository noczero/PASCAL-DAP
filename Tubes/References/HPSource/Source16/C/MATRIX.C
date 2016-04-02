/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* Program to illustrate matrix multiplication using arrays.          */
/*                                                                    */
/* MATRIX.C  by R. Shaw     13.8.90        14.5.93                    */
/*____________________________________________________________________*/

#include <stdio.h>
#include <conio.h>

main()
{
   int ia, ib, ja, jb;      /* ja must equal ib */
   int a[4][4], b[4][4], c[4][4];
   int i,j,k;

   clrscr();
   printf("Two matrices can only be multiplied together if the number of columns in\n");
   printf("the one is equal to the number of rows in the other.\n");
   printf("In this case please make the number of rows of the second 'b' equal to the\n");
   printf("number of columns of the first 'a', with a maximum of 4 rows and 4 columns\n");
   printf("\nEnter the size as number of rows, then a space and then number of columns\n");
   printf("and then press the ENTER key.\n\n");
   printf("Enter size of the first matrix 'a': ");
   scanf("%d %d",&ia,&ja);
   printf("\nEnter size of the second matrix 'b': ");
   scanf("%d %d",&ib,&jb);
   if (ja != ib) {
      printf("\nThe rows of 'b' must be equal to the columns of 'a'.\n\n");
      printf("Press any key to quit and re-try.");
      getch();
      exit(0);
		 }
   printf("\nEnter each value for matrix 'a' as requested and then press the ENTER key\n");
   for (i = 0; i < ia; i++)  {
      for (j = 0; j < ja; j++)  {
         printf("a[%d][%d] = ",i,j);
         scanf("%d",&a[i][j]);
      }
   }
   printf("\nEnter each value for matrix 'b' as requested and then press the ENTER key\n");
   for (i = 0; i < ib; i++)  {
      for (j = 0; j < jb; j++)  {
         printf("b[%d][%d] = ",i,j);
         scanf("%d",&b[i][j]);
      }
   }
   for (i = 0; i < ia; i++) {
       for (j = 0; j < jb; j++) {
          c[i][j] = 0;
          for (k =0; k < ja; k++)
              c[i][j] += a[i][k] * b[k][j];
       }
   }
   printf("\n");
   for (i = 0; i < ia; i++)  {
      for (j = 0; j < jb; j++)
        printf("c[%d][%d] = %d   ",i,j,c[i][j]);
      printf("\n");
   }
   printf("\n");
   printf("\n\nPress any key to continue");
   getch();
}


