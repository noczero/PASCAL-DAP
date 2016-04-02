/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* This program illustrates the use of Pointers and Structures.    */
/* In this example a linked list is formed by including in the     */
/* structure a member which points to the next structure.          */
/* The address pointed to by each of the pointers is displayed so  */
/* that DOS Debug can be called using the spawn.. function and     */
/* memory locations inspected to check that the data has been      */
/* placed in memory correctly. Options/Compiler/Model is set to    */
/* 'large' for this program.                                       */
/*                                                                 */
/* LINKLIST.C  ->  .EXE         R Shaw         5.5.93              */
/*_________________________________________________________________*/

#include <stdio.h>
#include <conio.h>
#include <alloc.h>
#include <dos.h>
#include <process.h>


struct person {
    char            name[20];
    char            job[20];
    struct person   *next;
};

struct person   *first, *last, *this;
int             i, stat, stat2;


initpointers()
{
  first = last = this = (struct person *)NULL;
}

createlist()
{
  printf("Please enter the names and jobs of 3 persons as prompted below.\n");
  printf("Please use no more than to 20 characters for each entry.\n");
  for (i = 0; i <3; i++)
  {
     this = (struct person *)malloc(sizeof(struct person)); /*see Allocmem.txt*/
     strcpy(this->name,"                    ");
     strcpy(this->job,"                    ");
     this->next = (struct person *)NULL;
     if (first == (struct person *)NULL) {
           first = this; }
     else {
           last->next = this; }
     printf("\nName %d : ",i+1);
     gets(this->name);
     printf("Job %d  : ",i+1);
     gets(this->job);
     last = this;
     last->next = (struct person *)NULL;
  }
}

displaydata()
{
  this = first;
  for (i = 0; i < 3; i++)
  {
     printf("\n%s is a %s",this->name,this->job);
     this = this->next;
  }
}

inspectmemory()
{
  printf("\n\nAddress of first structure  = %4p\n",first);
  printf("Address of second structure = %4p\n",first->next);
  printf("Address of last structure   = %4p\n\n",last);
  printf("DOS Debug now being called by spawn.. function. Please wait for - prompt.\n");
  printf("Then type d followed by the addresses given above to inspect memory.\n");
  printf("Note that the data may not be in contiguous blocks of memory.\n");
  printf("Finally type q to quit.\n");
  stat = spawnlp(P_WAIT,"DEBUG.EXE","DEBUG.EXE",NULL);   /*see Childprg.txt*/
  if (stat == -1)
     stat2 = spawnlp(P_WAIT,"DEBUG.COM","DEBUG.COM",NULL);
  if (stat2 == -1) {
     printf("spawnlp error = %d\n\n",stat);
     printf("Please check that you have DEBUG.EXE or DEBUG.COM available on the DOS path.\n\n");
  }
}

main()
{
  clrscr();
  initpointers();
  createlist();
  displaydata();
  inspectmemory();
  printf("Press any key to continue: ");
  getch();
}




