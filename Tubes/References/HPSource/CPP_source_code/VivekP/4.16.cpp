// Dev-C++ compatible

//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com

//The Effect of a default argument can be alternatively achieved
//by overloading. Discuss with an example.

#include <iostream.h>
#include <conio.h>
int main()
{
int sum(int,int);         //function with 2 argument
int sum(int,int,int);     //function with 3 argument
int sum(int,int,int,int); //function with 4 argument
int sum(int[],int);       //function with n argument
int a,b,c,d,result;

cout<<"\n\nfor 2 argument\n";
cout<<"Enter 2 Integers\n";
cin>>a>>b;
result=sum(a,b);
cout<<"Addition ="<<result;


cout<<"\n\nfor 3 argument\n";
cout<<"Enter 3 Integers\n";
cin>>a>>b>>c;
result=sum(a,b,c);
cout<<"Addition ="<<result;



cout<<"\n\nfor 4 argument\n";
cout<<"Enter 4 Integers\n";
cin>>a>>b>>c>>d;
result=sum(a,b,c,d);
cout<<"Addition ="<<result;


cout<<"\n\nHow many Argument You want to enter:-";
int no;
cin>>no;
int num[50];
cout<<"Enter "<<no<<" Integers\n";
for(int i=0;i<no;i++)
	cin>>num[i];
result=sum(num,no);
cout<<"Addition ="<<result;

getch();
}


//function with 2 argument
int sum(int a,int b)
{
return(a+b);
}


//function with 3 argument
int sum(int a,int b,int c)
{
return(a+b+c);
}

//function with 4 argument
int sum(int a,int b,int c,int d)
{
return(a+b+c+d);
}

//function with n argument
int sum(int a[],int n)
{
int sum=0;
	for(int i=0;i<n;i++)
   {
      sum=sum+a[i];
   }
return(sum);
}
