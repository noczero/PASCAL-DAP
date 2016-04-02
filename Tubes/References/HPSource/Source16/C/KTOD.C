/* KTOD: A key to disk program. use an ANSI C compiler */

#include "stdio.h"
#include "stdlib.h"

main(int argc, char *argv[])
{
  FILE *fp;
  char ch;
  if(argc!=2) {
    printf("You forgot to enter the filename\n");
    exit(1);
  }

  if((fp=fopen(argv[1], "w"))==NULL) {
    printf("cannot open file\n");
    exit(1);
  }

  printf("enter $ to end\n");

  do {
    ch = getchar();
    putc(ch, fp);
  } while (ch!='$');

  fclose(fp);
}