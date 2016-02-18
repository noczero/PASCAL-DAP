program ganjil3;
uses crt;

var
   i : integer;

begin
     clrscr;
     writeln('  PERULANGAN FOR  ');
     writeln('------------------');
     writeln('Masukkan Range Bilangan : '); readln(i);

     for i:=i downto 1 do
         begin
              if i mod 2 = 1 then
                 write( i :3);
         end;
readln;
end.
