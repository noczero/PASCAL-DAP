// Greet.cpp: The C++ source code for the Greet program.

#include <iostream.h>

char Name [16];

void main ()
   {   
   cout << "enter your name: ";
   cin.get (Name, sizeof (Name));
   cout << "\ngreetings, " << Name << "\n";
   }
