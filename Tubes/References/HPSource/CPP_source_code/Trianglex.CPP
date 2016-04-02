// Dev-C++ compatible
//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com

#include<conio.h>
#include<iostream.h>
#include<iomanip.h>
main()
{
int i,j,num,c;
cout<<"Enter number:-";
cin>>num;
cout<<setw(num+2)<<"*\n";
for(c=2,i=num;i>0;i--)
{
    cout<<setw(i)<<"*";

	for(j=1;j<=1;j++)
   {
    cout<<setw(c)<<"*";
   }
 c=c+2;
cout<<"\n";
}
getch();
}
