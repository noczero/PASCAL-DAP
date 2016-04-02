// Dev-C++ compatible

//Download More Projects.........
//only from   www.vivekpatel.cjb.net
//Email : vivek_patel9@rediffmail.com

#include <iostream.h>
#include <iomanip.h>
#include <conio.h>
#define MAX_REC 10

class Inventory{
	char itemName[15];
	int code;
	double cost;
	public:
	void getdata();
	void showdata();
};

void Inventory :: getdata(){
	cout<<"\nEnter Item Name : ";
	cin>>itemName;
	cout<<"Enter Code : ";
	cin>>code;
	cout<<"Enter Cost : ";
	cin>>cost;
}

void Inventory :: showdata(){
	cout<<endl;
	cout.width(15);
	cout.setf(ios::left, ios::adjustfield);
	cout<<itemName;

	cout.width(8);
	cout<<code;

	cout.width(15);
	cout.setf(ios::right, ios::adjustfield);
	cout.setf(ios::showpoint);
	cout.setf(ios::fixed,ios::floatfield);
	cout.precision(2);
	cout<<cost;
}

main(){
	Inventory record[MAX_REC];
	int i,n;

	cout<<"\n=====Inventory Management=====\n";
	cout<<"\nHow many Records to be created : ";
	cin>>n;

	cout<<"Enter "<<n<<" Records\n";
	for(i=0;i<n;i++)
		record[i].getdata();

	cout<<"\n\n---Stock Information---\n";
	cout<<"\n"<<setw(8)<<"Item Name"
	    <<setw(10)<<"Code"
	    <<setw(19)<<"Cost"<<endl;
	cout<<"-------------------------------------------";

	for(i=0;i<n;i++)
		record[i].showdata();

	getch();
}
