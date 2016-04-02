/********************************************************/
/*                    Binary converter                  */
/*                     By Matt Fowler                   */
/*                philosopher150@yahoo.com              */
/*  converts text into binary using the division method */
/*                   through ASCII code                 */
/*compiled with the Dev-C++ compiler (www.bloodshed.net)*/
/********************************************************/

#include <iostream>
using namespace std;
#include <cstring>
#include <cstdlib>

char *entry, letter, choice[2];
int ascii, len, binary[8], total;
void prog();

int main()
{
      prog();     
      return 0;
}        
        
void prog()
{
   entry = new char[501]; 
   /* entry should be dynamic, otherwise a new 
      string entry of 501 chars would be created
      each time function is called!  
      Talk about memory hog! */
   cout<<"Enter string to convert (up to 500 chars): ";
   cin.getline(entry, 500);
   len = strlen(entry);  /* get the number of characters in entry. */
   /* this loop is executed for each letter in the string. */
   for(int i = 0; i<len; i++)
   {
      total = 0;
      letter = entry[i]; /* store the first letter */
      ascii = letter;    /* put that letter into an int, so we can 
                            see its ASCII number */ 
      while(ascii>0) /* This while loop converts the ASCII # into binary,
                        stores it backwards into the binary array. */
      {
         /* To get the binary code one must take the decimal number in
            question, take it and divide it by two repeatedly, save
            the remainder (which will become the binary number), save
            the whole number, divide by two, and repeat the whole
            process until 0 is reached.  This if-else statement serves
            this functionality, by getting the remainder of the ascii
            code, storing it in the array and then dividing the int
            ascii by two */
         if((ascii%2)==0)
         {
            binary[total] = 0;
            ascii = ascii/2;
            total++; /* increasing by one each time will yeild the
                        number of numbers in the array. */
         }
         else
         {
            binary[total] = 1;
            ascii = ascii/2;
            total++;
         }
      }
      total--; /* due to data type factors, the program will actually
                  add a 0 at the end of the array that is not supposed
                  to be there, decrementing total will solve this
                  problem, as that 0 will not be displayed. */
      /* this while loop displays the binary code for that letter. */
      while(total>=0)
      {
         cout<<binary[total];
         total--;
      }
   }
   delete[] entry; /* free up the memory used by entry */
   cout<<endl<<"Do again(1 = yes, 2= no)?: ";
   cin.getline(choice,3);
   if(choice[0] == '1')
      prog(); /* program is recursive, it calls itself.  It's kinda
                 like a function loop of sorts. */
   else
      exit(0); /* quits the program */  
}
