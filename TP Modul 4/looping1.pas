{File : looping1.pas}
{Desc : deret 1 .... n}
{Date : 13 Februari 2016}

program looping1;

uses math, crt;

var
        i,m,n : integer;

begin
        clrscr;

        readln(m,n);

        i := 1;

        while (i <= max(n,m))  do

        begin
                writeln(i,' ');

                i := i+1;

        end;

      readln;

end.

