{File        : 01_arrayofinteger.pas}
{Description : contoh penggunaan array untuk input data dan output data}
{Date        : 26 Maret '16}

program contoharray;

var
	data : array[0..10] of Integer;
	i,n : Integer;

procedure ulang(n:Integer);
begin
	writeln;
	for i := 1 to n do 
		begin
			write('Masukkan angka ',i,' : '); readln(data[i]);
		end;
end;

procedure tampildata();
begin
	writeln;
	for i := 1 to n do
	begin
		writeln('Data ',i, ' : ', data[i]);
	end;
end;

begin
	write('Masukkan Jumlah Data yang ingin diinput : '); readln(n);
	ulang(n);
	tampildata();
	readln;
end.