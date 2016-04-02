//**************************************
//     
// Name: Fortune Teller
// Description:This is a very basic fort
//     une teller which generates a random numb
//     er and then gives the user an answer cor
//     responding to that number.
// By: Right City
//
//This code is copyrighted and has// limited warranties.Please see http://
//     www.Planet-Source-Code.com/vb/scripts/Sh
//     owCode.asp?txtCodeId=6507&lngWId=3//for details.//**************************************
//     

#include <iostream>
#include <time.h>
#include <stdlib.h>
#include <string>
using namespace std;
int main()


    {
    cout <<"Press 0 to stop loop."<<endl;
    int RandomGod;


        while (RandomGod != 0){
        srand((unsigned)time(NULL));
        string yeah;
        RandomGod = 1 + rand() % 4;
        cout <<"Type in the ultimate question to ask the all wise one. It must be yes or no."<<endl;
        cin >>yeah;
        switch (RandomGod)


            {
            case 1:
            cout<<"Most likely."<<endl;
            break;
            case 2:
            cout<<"No way in hell."<<endl;
            break;
            case 3:
            cout<<"OH YES!."<<endl;
            break;
            case 4:
            cout<<"Probably not."<<endl;
            break;
            default: break;
        }
    }
    return 0;
}
