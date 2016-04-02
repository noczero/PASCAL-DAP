//i'm amir reza and 17.i'm learning vc++ for a week.
//if u like it and have a time please tell me about that
//& vote it
//if u know a code for ^ & ... tell me 
//amirreza_nl@myself.com
#include <iostream.h>
#include <stdlib.h>  //for system("cls");
//********************************
double factorial(double one)
{
	if (one<=0)
		return (1);
	else
		return (one * factorial (one-1)); //n*(n-1)
}
double add (double x, double y)
{
	cout << x << " + " << y << " = ";
	return (x+y);
}

double multiply (double x, double y)
{
	cout << x << " * " << y << " = ";
	return(x*y);
}

double subtract (double x, double y)
{
	cout << x << " - " << y << " = ";
	return(x-y);
}

double divide (double x, double y)
{
	cout << x << " / " << y << " = ";
	return(x/y);
}

double percent (double x , double y)
{
	cout << "(" << x << " / " << y <<") * 100 = ";
	return ((x/y)*100);
}

double repercent (double x , double y)
{
	cout << x <<"% (" << y << ") = ";
	return ((x/100)*y);
}

double delta (double a, double b, double c)
{
	cout << a << "(X)^2 + " << b << "X + (" << c << ") =0" << endl;
	cout << "Delta = b^2-4ac" << endl;
	cout << b << "*" << b << "-4(" << a << ")(" << c <<")" << endl;
	return ( (b*b)-(4*a*c)); 
}

double delta1 (double a,double b, double c)
{
	return( (b*b)-(4*a*c));
}
//********************************
main()
{
	system ("cls"); //clean the page 
	int amir1;      
	double amir;   //case 1
	double a;      //case 3
	double b;	   //case 3
	int amir2;	   //integer variable (case 3)
	char restart;  //charactor variable
	double a1;
	double b1;
	double c1;

	cout <<"(1)Factorial , (2)Delta , (3)Other operation"<<endl;
	cin >> amir1;
	switch (amir1)
	{
	case 1:   //for factorial
		system ("cls");
		cout <<"Enter a number :"<<endl;
		cin>>amir;
		system ("CLS");
		cout <<"\n"<<amir<<"! = " << factorial(amir) <<"\a"<<endl; //beep(\a)
		break;
	//******************************
	case 2:   //for delta
		system ("cls");
		cout <<"Enter a & b & c" << endl;
		cin >> a1>> b1>> c1;

		system ("cls");   
   
		cout <<"\nAnswer is: "<<delta(a1,b1,c1)<< endl;
	
		if (delta1(a1,b1,c1)>0)
			cout <<"\a\n\f two answers (X1,X2) \f\n";
		else if (delta1(a1,b1,c1)==0)
			cout <<"\a\n\f one answer (X1=X2) \f\n";
		else
			cout <<"\a\n\f no X1 , X2 \f\n";
		break;

	//******************************
	case 3:    //for other operation
		system ("cls");
		cout <<"Enter X & Y :"<<endl;
		cin >>a;
		cin >>b;

		cout << "(1)Add, (2)Subtract, (3)Multiply, (4)Divide , (5)Per cent , (6)Re per cent :" << endl;
		cin>> amir2;
		system ("cls");
		cout <<"\n";  //seprate line(\n)
		
		switch (amir2)
		{
		case 1:    //+
			cout << add(a,b) <<"\a"<<endl;
			break;
		case 2:    //-
			cout << subtract(a,b) <<"\a"<<endl;
			break;
		case 3:    //*
			cout << multiply(a,b) <<"\a"<<endl;
			break;
		case 4:    //(/)
			cout << divide(a,b) <<"\a"<<endl;
			break;
		case 5:    //(%)
			//fill the a & b in percent (x,y)
			cout << percent(a,b)<<"%\a"<<endl; 
			break;  
		case 6:    //re (%)
			cout << repercent(a,b)<<"\a"<<endl;
			break;
		}
		break;

	}
	cout << "\n\f Mr AMIR REZA NIAKAN \f\n"<<endl;
	cout << "(R)restart , (E)exit " <<endl; //a seprate line (\n) 
	cin>> restart;
	
	switch (restart)
	{
	case 'r':
		 system("cls");
		 return main();
		 break;
	case 'e':
		 return (0);
		 break;
	}
	return (0);
}