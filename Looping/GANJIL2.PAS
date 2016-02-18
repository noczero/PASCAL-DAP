program ganjil2;

uses crt;

var
   i : integer;

begin
     clrscr;
     writeln('  PERULANGAN WHILE        ');
     writeln(' -------------------------');
     writeln(' Masukkan Range Bilangan :'); readln(i);

     while i >= 1 do
           begin
                if i mod 2 = 1 then
                   write (i:3);
                   i:=i-1;
           end;
     readln;
end.