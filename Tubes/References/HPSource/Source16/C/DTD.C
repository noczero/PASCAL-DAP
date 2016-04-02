/* Date & Time display 
   use an ANSI C compiler */

#include "stdio.h"
#include "time.h"

main()
{
  struct tm *ptr;
  time_t lt;
  lt=time('\0');
  ptr = localtime(&lt);
  printf(asctime(ptr));
}