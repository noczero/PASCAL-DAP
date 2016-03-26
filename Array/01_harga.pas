program hargahotel;

var
	Nama : array[1..100] of String;
	Harga,SubTotal : array[1..100] of Real;
	Lama : array[1..100] of Real;
 	Total : Real;
 	i : integer;

function hitung(Lama, Harga: Real ): Real;
 	begin
 		hitung := Lama * Harga;
 	end;

procedure InputData();
begin
	i := 1;
	while i <= 3 do
	begin
		writeln('Data Ke : ', i);
		writeln('=============');
		write('Inputkan Nama Tamu : '); readln(Nama[i]);
		write('Inputkan Lama Menginap :'); readln(Lama[i]);
		write('Inputkan Harga Kamar : '); readln(Harga[i]);
		SubTotal[i] := hitung(Lama[i],Harga[i]);
        Total := Total + SubTotal[i];
		i := i + 1;
	end;
end;

procedure ShowData();
begin
	writeln('=================================');
	writeln('No  Nama    Lama    Harga    Sub');
	writeln('    Tamu    Inap    Kamar    Total');
	writeln('=================================');	

	for i := 1 to 3 do
	begin
		writeln(i:1, Nama[i]:8, Lama[i]:8:0, Harga[i]:9:0, SubTotal[i]:8:0);		
	end;

	writeln('=================================');
	writeln('TOTAL : ', Total:12:0);
end;

begin
	InputData();
	ShowData();
	readln;
end.
