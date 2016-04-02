// Dev-C++ compatible

//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com

//Matrix Addition by Overloading + operator

#include <iostream.h>
#include <conio.h>

class matadd
{
  int **a;
  int row,col;
  public:
   matadd(){}
   matadd(int r,int c);
   void getdata(void);
   void display(void);
   matadd operator + (matadd o2);
};

matadd :: matadd(int r,int c)
{
  row=r;
  col=c;
  a=new int *[row];
   for(int i=0;i<row;i++)
     a[i]=new int[col];
}

void matadd :: getdata(void)
{
   cout<<"\n\nEnter Data for "<<row<<" rows and "<<col
       <<" cols\n\n";
   for(int i=0;i<row;i++)
   {
     for(int j=0;j<col;j++)
        cin>>a[i][j];
   }
}

void matadd :: display(void)
{
  cout<<"\n\n\nMatrix Display\n\n";
  for(int i=0;i<row;i++)
  {
    for(int j=0;j<col;j++)
      cout<<a[i][j]<<" ";
    cout<<endl;
  }
}

matadd matadd :: operator + (matadd o2)
{
   matadd temp(row,col);
    for(int i=0;i<row;i++)
     {
     for(int j=0;j<col;j++)
      {
       temp.a[i][j]=a[i][j] + o2.a[i][j];
      }
     }
return temp;
}

main()
{
  matadd o1(3,2),o2(3,2),o3;

  o1.getdata();
  o2.getdata();

  o3=o1+o2;

  o3.display();

  getch();
}
