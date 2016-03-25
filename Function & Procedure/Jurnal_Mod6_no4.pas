program tukar;

var
	bil1,bil2,tukbil1,tukbil2 : Integer;

procedure tukar(a,b : integer; var bil1,bil2: integer);
var temp : integer;
begin
	temp := a;
	bil1 := b;
	bil2 := temp;

end;

procedure input;
begin
	writeln('Masukkan Bilangan Pertama : '); readln(bil1);
	writeln('Masukkan Bilangan Kedua : '); readln(bil2);
end;

procedure show;
begin
	writeln('=================');
	writeln('Proses TUkar');
	writeln('Bilangan Pertama :' , tukbil1);
	writeln('Bilangan Kedua :', tukbil2);
	writeln;
end;

begin
 input;
 tukar(bil1,bil2,tukbil1,tukbil2);
 show;
 readln;
end.
