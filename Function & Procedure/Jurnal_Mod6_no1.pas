program soalno1;

var
	bil,bilnegatif,bilgenap,i,bilkelipatan5: Integer;

function isGenap(bil:integer): Boolean;
begin
	isGenap := (bil mod 2 = 0) and (bil > 0);
end;

function isKelipatan5(bil:integer): Boolean;
begin
	isKelipatan5 := (bil mod 5 =0) and (bil > 0);
end;

function negatif(bil:integer): Boolean;
begin
	negatif := (bil < 0);
end;

function terbilang(bil:integer): string;
begin
	case bil of
		0 : terbilang := 'nol';
		1 : terbilang := 'satu';
		2 : terbilang := 'dua';
		3 : terbilang := 'tiga';
		4 : terbilang := 'empat';
		5 : terbilang := 'lima';
		6 : terbilang := 'enam';
		7 : terbilang := 'tujuh';
		8 : terbilang := 'delapan';
		9 : terbilang := 'sembilan';
		10 : terbilang := 'sepuluh';
	end;
end;

procedure check;
begin
	if isGenap(bil) then
	begin
	bilgenap := bilgenap + 1;
	end;

	 if isKelipatan5(bil) then
	 begin
	 	bilkelipatan5 := bilkelipatan5 + 1;
	 end;

	 if negatif(bil) then
	 begin
	 	bilnegatif := bilnegatif + 1;
	 end;
end;

procedure show();
begin
	writeln('Jumlah Bilangan Genap : ', terbilang(bilgenap));
	writeln('Jumlah Bilangan Kelipatan 5 : ',  terbilang(bilkelipatan5));
	writeln('Jumlah Bilangan Negatif : ', terbilang(bilnegatif));
end;

begin
	//	i := 0;
	bilnegatif := 0;
	bilkelipatan5 := 0;
	bilnegatif := 0;
	
	for i := 1 to 10 do
	begin
	write('Masukkan Bilangan : '); readln(bil);
	check;

	if bil = 0 then break;
	// while (bil <> 0) or (i <= 10) do
	// begin
	// 	writeln('Masukkan Bilangan :'); readln(bil);
	// 	check;
 	//                i := i + 1;
	// end;
	end;
	show;
	readln;
end.
