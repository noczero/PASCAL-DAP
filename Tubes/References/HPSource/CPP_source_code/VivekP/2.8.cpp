// Dev-C++ compatible
//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com

/* Write a program to read two numbers from the keyboard
and display the larger value on the screen.*/

#include<conio.h>
#include<iostream.h>

class largest
{
int d;
public :
void getdata(void);
void display_large(largest,largest);
};

void largest :: getdata(void)
{
cout<<"\n\nEnter Value :-";
cin>>d;
}

void largest :: display_large(largest o1,largest o2)
{
	if(o1.d > o2.d)
   	cout<<"\nObject 1 contain Largest Value "<<o1.d;
   else if(o2.d > o1.d)
   	cout<<"\nObject 2 contain Largest Value "<<o2.d;
   else
   	cout<<"\nBOTH ARE EQUAL";
}


int main()
{
largest o1,o2,o3;

o1.getdata();
o2.getdata();

o3.display_large(o1,o2);
getch();
}
