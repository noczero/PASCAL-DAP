//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com

//Binary Operator + to add two object
#include <iostream.h>
#include <conio.h>

class distance
{
 int feet;
 float inches;
 public:
   distance()
   { feet=0;inches=0.0;}
   distance(int ft,float in)
   { feet=ft; inches=in;}
   void getdist()
   {
     cout<<"\nEnter feet   : ";
     cin>>feet;
     cout<<"\nEnter Inches : ";
     cin>>inches;
   }
   void showdist()
   {
     cout<<feet<<"\'-"<<inches<<'\"';
   }

   distance operator + (distance);
 };

 distance distance :: operator + (distance d2)
 {
   int   f = feet + d2.feet;
   float i = inches + d2.inches;
   if(i >= 12.0)
     {
       i = i - 12.0;
       f++;
     }
   return distance(f,i);
 }


 main()
 {
  distance dist1,dist2(11,6.25),dist3,dist4;
  dist1.getdist();

  dist3=dist1 + dist2;

  dist4=dist1 + dist2 + dist3;

  cout<<"\ndist1 = ";
  dist1.showdist();
  cout<<"\ndist2 = ";
  dist2.showdist();
  cout<<"\ndist3 = ";
  dist3.showdist();
  cout<<"\ndist4 = ";
  dist4.showdist();

 getch();
}
