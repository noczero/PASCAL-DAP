// time_example.cpp
// for Borland C++, Visual C++, Dev-C++.

#include <iostream.h>
#include <conio.h>
#include "time.h"

//print time
main()
{
  struct tm *ptr;
  time_t lt;
  lt=time('\0');
  ptr = localtime(&lt);
  cout << (asctime(ptr));
  while (!kbhit());
}

