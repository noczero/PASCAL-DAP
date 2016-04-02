// Dev-C++ compatible

//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com

//Unary Operator ++
#include <iostream.h>
#include <conio.h>

class counter
{
  int count;
  public:
  counter(){count=0;}
  counter(int a)
  {count=a;}
  void operator ++()                   //for prefix
  {count++;}
  counter operator ++(int)             //for eg:- c1 = c2++
  {  											  //and postfix expression
     count++;
     counter temp;
     temp.count=count;
     return temp;
  }
  void getdata(void)
  {
    cout<<"\n\nEnter Value for Count :-";
    cin>>count;
  }
  void display(void)
  {
    cout<<"\nValue of count is "<<count<<endl;
  }
};

main()
{
 counter o1(9),o2,o3;
 o1++;
 o1.display();

 o2.getdata();
 o2++;
 ++o2;
 o2.display();

 o3=o2++;
 o3.display();
 getch();
}
