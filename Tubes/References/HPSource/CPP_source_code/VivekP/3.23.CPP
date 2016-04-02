// Dev-C++ compatible
//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com

//OUTPUT PROGRAM
//1
//22
//333
//......

#include<iostream.h>
#include<conio.h>
int main()
{
int i,num,j;
cout<<"Enter number for corresponding output:- ";
cin>>num;
for(i=1;i<=num;i++)
{
	for(j=1;j<=i;j++)
   {
   cout<<i;
   }
cout<<"\n";
}
num--;
getch();
}
