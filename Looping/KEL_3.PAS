program kelipatan3;

uses crt;

var
   i,p,nilai : integer;

begin
     clrscr;
     writeln('  PERULANGAN FOR  ');
     writeln('------------------');
     writeln;
     write('Masukkan Jumlah Deret : '); readln(p);
     nilai :=3;

     for i:=1 to p do
         begin
              write(nilai:5);
              nilai := nilai * 3;
         end;
readln;
end.