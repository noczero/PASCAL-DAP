// Dev-C++ compatible

//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com


#include<stdio.h>
#include<conio.h>
main()
{
int i,j,num,space,k;
printf("Enter the number:-");
scanf("%d",&num);
k=num;
for(i=num;i>=0;i--)
{

	for(space=k;space>0;space--)
   {
   	printf(" ");
   }

   for(j=num -(i-1);j>=1;j--)
   {
   


   	printf("%d ",i);
   }
printf("\n");
k--;
}

getch();
}
