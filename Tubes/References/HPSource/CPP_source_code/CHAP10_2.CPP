// Dev-C++ compatible

//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com


#include <iostream.h>
#include <iomanip.h>
#include <conio.h>
#define MAX_ROW 5
#define MAX_COL 80


main(){
	char name[MAX_ROW][MAX_COL],c;
	int lines=1; //bcoz. first line will be left to count.
	int words=1; //bcoz. first word will be left to count.
	int chars=1; //bcoz. first char will be left to count.
	cout<<"===Input Status===\n";
	cout<<"Enter string termanate by # : ";
	cin.get(c);

	//Finding no. of lines
	while(c != '#'){
		cin.get(c);
		chars++;
		if(c==' ' || c=='\n')
			words++;
		if(c=='\n')
			lines++;
	}

	cout<<"\n"<<setw(20)<<"Particulars"<<setw(20)<<"Details\n";
	cout<<"-------------------------------------\n";

	cout.setf(ios::left,ios::adjustfield);
	cout<<"\n"<<setw(20)<<"No. of lines  ";
	cout.setf(ios::right,ios::adjustfield);
	cout<<setw(15)<<lines;

	cout.setf(ios::left,ios::adjustfield);
	cout<<"\n"<<setw(20)<<"No. of Words  ";
	cout.setf(ios::right,ios::adjustfield);
	cout<<setw(15)<<words;

	cout.setf(ios::left,ios::adjustfield);
	cout<<"\n"<<setw(20)<<"No. of Characters  ";
	cout.setf(ios::right,ios::adjustfield);
	cout<<setw(15)<<chars;

	getch();

}
