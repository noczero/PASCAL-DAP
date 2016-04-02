// Dev-C++ compatible

//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com

//Three steps for Polar cordinates
//1)convert points to rectangular cordinates
//2)Addition of Points
//3)Converting Back to Polar cordinates

#include <iostream.h>
#include <math.h>
#include <conio.h>

class polar
{
  double radius;
  double angle;

  double getx()
    {return radius*cos(angle);} //These two function
  double gety()                 //convert this polar objects
    {return radius*sin(angle);} //into x and y rectangular coords

 public:
   polar()
   {radius=0.0;angle=0.0;}

   polar(float r,float a)
    {
      radius=r;
      angle=a;
    }

   void display()
    {
      cout<<"("<<radius<<", "<<angle<<")";
    }

  polar operator + (polar o2)
  {
    double x=getx()+o2.getx();
    double y=gety()+o2.gety();
    double r=sqrt(x*x + y*y);   //converts x and y to
    double a=atan(y/x);         //Polar co-ordinate.
    return polar(r,a);
  }
};

main()
{
 polar o1(10,2),o2(10,5),o3;

 o3=o1+o2;

 cout<<"\no1 =";
 o1.display();
 cout<<"\no2 =";
 o2.display();
 cout<<"\no3 =";
 o3.display();

 getch();
}
