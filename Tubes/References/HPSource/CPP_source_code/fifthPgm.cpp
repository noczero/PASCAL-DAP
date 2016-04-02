  
  
  
/*****************************************************
 * File: fifthPgm.cpp
 *
 * Purpose: request three numbers from the user, add the 
 * three numbers and store the result in variable sum
 * and write the value of sum out to the screen
 *           
 *****************************************************/

#include <iostream.h>

main()  {
   int a, b, c, sum;

   cout << "Enter the first integer" << endl;
   cin >> a ;

   cout << "Enter the second integer" << endl;
   cin >> b ;

   cout << "Enter the third integer" << endl;
   cin >> c ;

   sum = a + b + c ;

   cout << "The value of a + b + c is " << sum << endl;
} 
  
  
