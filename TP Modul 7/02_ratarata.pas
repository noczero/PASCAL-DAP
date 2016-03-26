{File        : 02_ratarata.pas}
{Description : contoh penggunaan array untuk input data dan output data cari rata-rata}
{Date        : 26 Maret '16}

program cariratarata;

type indeks = 1..10;
var
 a : array[indeks] of Integer;
 i : Integer;
 apa : Integer;
 ini : Real;

begin
	for i := 1 to 10 do
	begin
		read(a[i]);
		apa := apa + a[i];
	end;
	ini := 	apa / 10;
	write(ini);
	readln;
end.
