//**************************************
//     
// Name: Alphabets and Number Counter
// Description:This program calculates t
//     he number of alphabets and numbers in th
//     e word entered. This is just for the beg
//     inners and there is nothing special.
// By: Karthik A
//
// Inputs:A string
//
// Returns:Count
//
//This code is copyrighted and has// limited warranties.Please see http://
//     www.Planet-Source-Code.com/vb/scripts/Sh
//     owCode.asp?txtCodeId=9856&lngWId=3//for details.//**************************************
//     

#include<iostream.h>
#include<string.h>
#include<conio.h>
#include<ctype.h>
void strcounter(char* base,int len)


    {
    int ct1=0,ct2=0;
    for(int i=0;i<len;i++)


        {
        int a=isalpha(*(base+i));
        int b=isdigit(*(base+i));
        if(a!=0)


            {
            ct1++;
        }
        if(b!=0)


            {
            ct2++;
        }
    }
    cout<<"\n The number of alphabets is:"<<ct1<<"\n The number of numbers is:"<<ct2<<"\n";
}
int main()


    {
    char string[40];
    cout<<"\t\t\t Alphabets and Number Counter"<<endl;
    cout<<"\n Enter the string:";
    cin>>string;
    strcounter(string,strlen(string));
    getch();
}
