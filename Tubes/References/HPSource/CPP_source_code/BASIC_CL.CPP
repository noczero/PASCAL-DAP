// Dev-C++ compatible

//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com

//Conversion BASIC TO CLASS TYPE
//string to class object

#include <iostream.h>
#include <conio.h>
#include <string.h>

class string
{
  char *p;
  int len;
  public:
    string::string()
    {}
    string::string(char *a)
    {
      len=strlen(a);
      p=new char[len+1];
      strcpy(p,a);
    }
    void display()
    {
      cout<<p;
    }
};

int main()
{
 string s1,s2;
 char *name1="vivek";
 char *name2="patel";
 s1=string(name1);       //Invoke constructor
 s2=name2;               //Invoke constructor

 s1.display();
 cout<<endl;
 s2.display();
 getch();
 }
