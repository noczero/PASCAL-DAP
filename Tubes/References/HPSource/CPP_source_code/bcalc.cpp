
#include <iostream.h>
float count[10];
char function;
float entered;
int i;
int main()


    {
    cout<<"Please enter a number: ";
    cin>>count[i];//thanks to RVProductions for showing me how to fix the bug.
    entered = count[i];
    for(;i<11;i++)


        {
        cout<<"enter a fuction(+,-,*,/, E to exit)"<<endl;
        cin>>function;
        if(function == '+')


            {
            cout<< "enter a number" <<endl;
            cin>>count[i];
            entered = count[i] + entered;
            if(i = 10)


                {
                i = 0;
            }
            cout<<"equals: "<< entered <<endl;
        }
        if(function == '-')


            {
            cout<< "enter a number" <<endl;
            cin>>count[i];
            entered = entered - count[i];
            if(i = 10)


                {
                i = 0;
            }
            cout<<"equals: "<< entered <<endl;
        }
        if(function == '*')


            {
            cout<< "enter a number" <<endl;
            cin>>count[i];
            entered = count[i] * entered;
            if(i = 10)


                {
                i = 0;
            }
            cout<<"equals: "<< entered <<endl;
        }
        if(function == '/')


            {
            cout<< "enter a number" <<endl;
            cin>>count[i];
            entered = entered / count[i];
            if(i = 10)


                {
                i = 0;
            }
            cout<<"equals: "<< entered <<endl;
        }
        if(function =='E' || function =='e')


            {
            return 0;
        }
    }
}
	
