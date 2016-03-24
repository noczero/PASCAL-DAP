program tukabilangan;

var
bil1,bil2 : integer;

procedure tukar(var bil1,bil2 : integer);
var temp: integer;
begin
 temp:= bil1;
 bil1 := bil2;
 bil2 := temp;
end;

begin
 write('Masukkan Bilangan 1 '); readln(bil1);
 write('Masukkan Bilangan 2 '); readln(bil2);
 writeln('Bilangan 1 : ', bil1);
 writeln('Bilangan 2 : ', bil2);
 tukar(bil1,bil2);
 writeln('Tukar ', bil1 ,' ',bil2);
 readln;
 end.