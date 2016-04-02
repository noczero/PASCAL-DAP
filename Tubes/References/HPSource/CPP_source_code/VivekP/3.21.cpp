// Dev-C++ compatible

//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com


/*	write a function using refrence variable as argument to swap
   the value of a pair of integers. */


#include <iostream.h>
#include <conio.h>

class swaping
{
int a;
public :
void getdata(void);
friend void swap(swaping &,swaping &);
void display(void);
};

void swaping :: getdata(void)
{
cout<<"\n\nEnter any Integer :-";
cin>>a;
}

void swap(swaping &o1,swaping &o2)
{
int temp;
temp	=	o1.a;
o1.a	=	o2.a;
o2.a	=	temp;
}

 void swaping :: display(void)
{
cout<<a<<endl;
}

int main()
{
swaping o1,o2;

cout<<"Before Swaping\n";
o1.getdata();
o2.getdata();

swap(o1,o2);

cout<<"\n\nAfter Swaping\n";
o1.display();
o2.display();

getch();
}


