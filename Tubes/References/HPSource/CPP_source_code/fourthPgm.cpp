  
/*****************************************************
 * File: fourthPgm.cpp
 *
 * Purpose: request two numbers from the user, add the 
 * two numbers and store the result in variable sum
 * and write the value of sum out to the screen
 *           
 *****************************************************/

#include <iostream.h>

main()  {
   int a, b, sum;

   cout << "Enter the first integer" << endl;
   cin >> a ;

   cout << "Enter the second integer" << endl;
   cin >> b ;

   sum = a + b ;

   cout << "The value of a + b is " << sum << endl;
} 
  
