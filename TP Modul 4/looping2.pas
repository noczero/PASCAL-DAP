{File : looping2.pas}
{Desc : Perulangan}
{Date : 13 Februari 2016}

program looping2;

uses crt;

var
        i,n : integer;

begin
        clrscr;

        i := 0;
        n := 10;

        repeat
                write(i+1);

                // add this
                // make true situation in order to stop the looping
                // i always add by 1 until the value 10

                i := i + 1;

        until(i=n);

        readln;

end.

