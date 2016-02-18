{Description : cetak bilangan ganjil dari range }

program ganjil;
uses crt;

var
   i : integer;

begin
     clrscr;
     writeln(' Perulangan Repeat Until ' );
     writeln('-------------------------');
     writeln(' Masukkan range bilangan : '); readln(i);
     writeln;
     repeat
           begin
                if i mod 2 = 1 then
                   write (i:3);
                   i := i -1;
           end;
     until i <= 1;

readln;
end.
