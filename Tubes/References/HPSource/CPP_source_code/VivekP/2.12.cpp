// Dev-C++ compatible
//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com

/* Redo Exercise 2.11 using a CLASS called TEMP and
member functions.*/

#include<iostream.h>
#include<conio.h>

class TEMP
{
	float f,c;
   public:
      float  getdata();
      void display(void);
};

 float  TEMP :: getdata()
{
cout<<"Enter Value for farenheit degree to find for celsius:- ";
cin>>f;
c = (f-32)/1.8;
return(c);
}

void TEMP :: display(void)
{
float v;
 v=getdata();
cout<<"CELSIUS DEGREE = "<<v;
}

int  main()
{
TEMP c;
c.display();
}
