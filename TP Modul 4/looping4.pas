{File : looping4.pas}
{Desc : looping ganjil}
{Date : 13 Februari 2016}

program looping4;

uses math, crt;

var
        i,a,b : integer;

begin
        readln(a,b);

        for i:=max(a,b) downto min(a,b) do

                if (i mod 2 = 1) then

                        write(i ,' ');

       readln;

end.

