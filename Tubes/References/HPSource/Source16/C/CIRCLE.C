/* This program computes the circumference and
   area of a cirle given its radius.
   use an ANSI C compiler */

#include "stdio.h"

/*function type definitions*/
double circum();
double area();

main()
{
  double radius;

  printf("enter radius: ");
  scanf("%lf", &radius);
  printf("circumference: %lf\n", circum(radius));
  printf("area: %lf\n", area(radius));
}

double circum(double rad)
{
  return rad*3.1416;
}

double area(double rad)
{
  return rad*rad*3.1416;
}