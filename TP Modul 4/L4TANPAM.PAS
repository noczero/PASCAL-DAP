{File : looping4.pas}
{Desc : looping ganjil}
{Date : 13 Februari 2016}

program looping4;

uses crt;

var
        i,a,b : integer;

begin
        readln(a,b);

        {jika b lebih besar dari a, mis a:3 b:10}
        if b > a then
           begin

           { tukar tempat : i menjadi a (3), a menjadi b (10), b menjadi (3).}
                i:=a;
                a:=b;
                b:=i;
           end;

        {i = a (10) decrement ke b (3)}
        for i:=a downto b do
                 {Seleksi Bil. Ganjil}
                 if (i mod 2 = 1) then
                        write(i ,' ');
       readln;

end.

