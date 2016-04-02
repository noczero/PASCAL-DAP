// Dev-C++ compatible
//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com

#include<iostream.h>
#include<fstream.h>
#include<conio.h>
#include<process.h>
#include<string.h>

main()
{
	fstream fin,fout;
	char ch;
	int flag = 1;
	fin.open("data.txt",ios :: out | ios :: in);
	fout.open("data1.txt",ios :: out | ios :: in);
	fin.seekg(0);
	if(fin==NULL)
	   cout<<"Unable to open file";
	while(fin)
	{
		fin.get(ch);
		if(ch == ' ')
		{
			 flag = 0;
		}
		else
		{
			if(flag == 0)
			{
				fout.put(' ');
				cout<< ' ';
				flag = 1;
			}
			fout.put(ch);
			cout<<ch;
		}
	}
}
