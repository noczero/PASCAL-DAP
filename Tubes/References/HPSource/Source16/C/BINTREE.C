
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* Program to show how a binary tree can be used to order    */
/* a set of integers                                         */
/*                                                           */
/* BINTREE.C  ->  BINTREE.EXE      R Shaw      25.3.93       */
/*___________________________________________________________*/

#include <conio.h>
#include <stdio.h>
#include <alloc.h>
#include <process.h>

struct tnode
   {
    struct tnode   *left;
    int   number;
    struct tnode   *right;
   };

int              num;
struct tnode     *parent, *child;
struct tnode     *firstnode, *l, *r;
char             reply;

init()
{
   firstnode = NULL;
   parent = NULL;
   child = NULL;
}

createnode(int n)
{
   child = (struct tnode *) malloc(sizeof(struct tnode)); /*see Allocmem.txt*/
   child->number = n;
   child->left   = NULL;
   child->right  = NULL;
}

nextnode(struct tnode *node)
{
  if (firstnode == NULL)
     {
        createnode(num);
	firstnode = child;
     }
  if (node->number > num)
     {
        if (node->left == NULL)
           {
              createnode(num);
              node->left = child;
           }
        else {
              node = node->left;
              nextnode(node);
             }
     }
     else if (node->right == NULL)
              {
                 createnode(num);
                 node->right = child;
              }
          else {
                 node = node->right;
                 nextnode(node);
               }
}

tree(struct tnode *node)
{
   l = node->left;
   if (l != NULL) tree(l);
   if (node->number != -1) printf("%d\n",node->number);
   r = node->right;
   if (r != NULL) tree(r);
}


main()
{
   clrscr();
   init();
   num = 0;
   while (num != -1)
     {
       printf("Please enter a number in range 0 to 30000 or -1 to conclude ");
       scanf("%d",&num);
       nextnode(firstnode);
      }

   printf("\n");
   printf("Do you wish for an ordered list of the data (Y/N) ? ");
   reply = getche();
   printf("\n");
   if ((reply == 'Y') || (reply == 'y')) tree(firstnode);
   printf("\n");
   printf("Press any key to continue: ");
   getch();
}

