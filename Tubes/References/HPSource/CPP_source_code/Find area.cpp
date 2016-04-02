//To Find the area of user defined figures.
//Areas of Square, Rectangle, Triangle.
#include<iostream>   
using namespace std;
int main()
{
    int ch;
    float s1,s2,area,b,h,side,l,r,m,n,v,a,k,g,z,o,j,f,w,e;
                                                                              
    cout<<"Enter the name of figure: ";
    cout<<"\n1 Square";
    cout<<"\n2 Reactangle";
    cout<<"\n3 Triangle";
    cout<<"\n4 Cylinder";
    cout<<"\n5 Sphere";
    cout<<"\n6 Cuboid";
    cout<<"\n7 Cube";
    cout<<"\n8 Prism";
    cout<<"\n9 Cone"; 
    cout<<"\n10 Hemisphere";
    cout<<"\n11 Pyramid";
    cout<<"\nFigure: ";
    cin>>ch;
    if (ch==1)
    {
    cout<<"\nEnter Side: ";
    cin>>side;  
    }
  if (ch==2)
    {
    cout<<"\nEnter First Side: ";
    cin>>s1;
    cout<<"\nEnter second side :";
    cin>>s2;
    }
  if(ch==3)
    {
    cout<<"\nEnter Base: ";
    cin>>b;
    cout<<"\nEnter Height: ";
    cin>>h;
    }
  if(ch==4)
    {
    cout<<"\nEnter height:";
    cin>>l;
    cout<<"\nEnter radius:";
    cin>>r;
    }
  if(ch==5)
    {
    cout<<"\nEnter radius:";
    cin>>m;
    }
 if (ch==6)
    {
    cout<<"\nEnter length:";
    cin>>n;
    cout<<"\nEnter breadth:";
    cin>>b;
    cout<<"\nEnter height:";
    cin>>v;
    }
if (ch==7)
    {
    cout<<"\nEnter side:";
    cin>>a;
    }
 if (ch==8)
    {
    cout<<"\nEnter height:";
    cin>>k;
    cout<<"\nEnter side:";
    cin>>g;
    }
    if (ch==9)
    {
    cout<<"\nEnter slant height:";
    cin>>j;
    cout<<"\nEnter radius:";
    cin>>o;
    }
 if (ch==10)
   {
    cout<<"\nEnter radius:";
    cin>>f; 
   }   

if (ch==11)
    {
    cout<<"\nEnter base:";
    cin>>w;
    cout<<"\nEnter slant height:";
    cin>>e;
    }  
    switch(ch)
    
{
    case 1:area=side*side;
           cout<<"\nThe Area is "<<area<<"\n";   
           break;
    case 2:area=s1*s2;
           cout<<"\nThe Area is "<<area<<"\n";    
           break;                  
    case 3:area=b*h/2;
           cout<<"\nThe Area is "<<area<<"\n";      
           break;  
    case 4:area=2*r*(r+l)*22/7; 
           cout<<"\nThe Area is ="<<area<<"\n";      
           break;
    case 5:area=4*3.144*(m*m);
           cout<<"\nThe Area is "<<area<<"\n"; 
             break;
    case 6:area=2*(n*b+b*v+v*n);
           cout<<"\nThe Area is "<<area<<"\n"; 
             break;
    case 7: area=6*(a*a);
    cout<<"\nThe Area is "<<area<<"\n"; 
             break;
    case 8:  area=3*g*k+2*(1.72/7)*(g*g);
             cout<<"\nThe Area is "<<area<<"\n"; 
             break; 
   case 9: area=o*22/7*(j+o);
           cout<<"\nThe Area is "<<area<<"\n"; 
             break; 
  case 10:  area=3*3.144*(f*f);
            cout<<"\nThe Area is "<<area<<"\n"; 
             break; 
  case 11: area=(3*w)/2 * e +(1.72/4)*(w*w);
            cout<<"\nThe Area is "<<area<<"\n"; 
             break;                                                                        
    case 12 : cout<<"You have entered wrong figure";        
            break;      
 }
    cout<<"Program written by Bhupendra Singh.\n";
    system("Pause");
    return 0;
    }

