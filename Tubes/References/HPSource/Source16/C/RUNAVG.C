/* Compute a running average of numbers
   entered by the user. use an ANSI C compiler */

#include "stdio.h"

int r_avg(int i);

main()
{
  int num;

  do {
    printf("enter numbers (-1 to quit): ");
    scanf("%d", &num);
    printf("running average is: %d\n", r_avg(num));
  } while(num>-1);
}

int r_avg(int i)
{
  static int sum=0, count=0;
  sum = sum + i;
  count++;
  return sum / count;
}