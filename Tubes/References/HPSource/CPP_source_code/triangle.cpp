// Program to make a pyramid of characters based on input from user
// Purpose is to examine use of <iomanip.h> and how setw is used
// Created by Gary Paduana
// email : gary3141@home.com
// Written on 4.15.01
 
# include <iostream.h>
# include <iomanip.h>   // library that has the setw output manipulator
 
int main ()
{
 
 char letter;      // letter is the symbol or letter made into a giant triangle
 int width;        // width is how far to go into the center of screen
 int base;         // base is how many symbols are on bottom line
 int a;            // a is how many lines down the triangle is
 int b = 1;        // b is how many symbols are displayed on each line
 int counter = 0;  // counter is how many times the loop executed
 
 cout<<"This program will make a triangle of the symbol entered."<<endl;
 cout<<"It must be an odd number for the triangle to form properly."<<endl; 
 cout<<"If an even number is entered, it will be lowered to the previous odd."<<endl;
 
 
 while(cin)        // This allows the program to loop until the user closes the window
 {
  
  cout<<"Enter a symbol or character."<<endl;
  cin>>letter;
 
  cout<<"Enter the number of characters the base should have."<<endl;
  
  cin>>base;
 
  width = (base / 2) + 5 - counter;    // This is how far into the center it should space until it starts outputting the symbol
                                       // It must first be given a value before it enters the loop
  a = 1;                               // a is how many lines down the triangle is, and natuarally it starts on the first line
 
  while(width > 5)    // It will loop and continue to output the symbol until it reaches 5 spaces from the left margin...
                      // so that everything isn't jammed against the side
  {      
   width = (base / 2) + 5 - counter;   // This is how far into the center it should space until it starts outputting the symbol
   
   cout<<setw(width);  // setw is an output manipulator in the <iomanip.h> library.  this tell the compiler how many lines
                       // to move until it first sends a character to the screen.  It is currently set to move the value of 
                       // "width" spaces to the right before it outputs.
   
   while(b > 0)  // This while loop will continue to output the desired symbol to the current line until it is equal to 1
   {
    cout<<letter;    // outputs the letter or symbol entered
    b--;             // b is decremented so only so many letters are outputted per line
   }
   cout<<endl;       // an endl is used to jump to the next line to output the next part of the triangle
   b = (a * 2) - 1;  // the number of symbols per line is found using this equation
 
   width--;          // the width is decremented so that everything is spaced properly
   b = b + 2;        // b is given 2 more symbols because it is on the next line, and every line has 2 more than the previous
   a++;              // this is how many lines into the triangle it is
   counter++;        // the counter is used to ensure proper spacing done by the width variable
  }
  cout<<endl<<endl;  // endl is used to add some space between each time the program is executed
  b = 1;             // b is returned to 1 because the program started over
  counter = 0;       // counter is returned to 0 because the program started over
 }
return 0;
}
  

  