program Puzzle;
uses sysutils, crt;
var
	kotak: array[0..2,0..2] of Char;
	kolom,baris : Integer;

procedure GenerateKotak;
begin
	kotak[0][0] := '1';
	kotak[0][1] := '2';
	kotak[0][2] := '3';
	kotak[1][0] := '4';
	kotak[1][1] := '5';
	kotak[1][2] := '6';
	kotak[2][0] := '7';
	kotak[2][1] := ' ';
	kotak[2][2] := '8';
	baris := 2;
	kolom := 1;
end;

function cekMenang: Boolean;
var
	i, j, k: Integer;

begin
	k := 1;
	cekMenang := False;
	for i := 0 to 2 do
	begin
		for j := 0 to 2 do
		begin
			cekMenang := IntToStr(k) = kotak[i][j];
			k := k + 1;
			if (k = 9) or (not cekMenang) then
				break;
		end;
		if (k = 9) or (not cekMenang) then
				break;
	end;
	// if kotak[0][0] = '1' then
	// 	if kotak[0][1] = '2' then
	// 		if kotak[0][2] = '3' then
	// 			if kotak[1][0] = '4' then
	// 				if kotak[1][1] = '5' then
	// 					if kotak[1][2] = '6' then
	// 						if kotak[2][0] = '7' then
	// 							if kotak[2][1] = '8' then
	// 							begin
	// 								cekMenang := True;
	// 								break;
	// 							end;

end;

procedure atas;
var
	temp: Char;
begin
	if baris <> 0 then
	begin
		temp := kotak[baris][kolom];
		kotak[baris][kolom] := kotak[baris-1][kolom];
		kotak[baris-1][kolom] := temp;
		baris := baris - 1;
	end;	
end;

procedure kanan;
var
	temp: Char;
begin
	if kolom <> 2 then
	begin
		temp := kotak[baris][kolom];
		kotak[baris][kolom] := kotak[baris][kolom+1];
		kotak[baris][kolom+1] := temp;
		kolom := kolom + 1;
	end;
end;

procedure kiri;
var
	temp: Char;
begin
	if kolom <> 0 then
	begin
		temp := kotak[baris][kolom];
		kotak[baris][kolom] := kotak[baris][kolom-1];
		kotak[baris][kolom-1] := temp;
		kolom := kolom - 1;
	end;	
end;

procedure bawah;
var
	temp: Char;
begin
	if baris <> 2 then
	begin
		temp := kotak[baris][kolom];
		kotak[baris][kolom] := kotak[baris+1][kolom];
		kotak[baris+1][kolom] := temp;
		baris := baris + 1;

	end;	
end;

procedure cetak;
var
	i,j: Integer;
begin
	clrscr;
	for i := 0 to 2 do
	begin
		for j := 0 to 2 do
		begin
			write(kotak[i][j], ' ');
		end;
		writeln;
	end;
end;

procedure move(kebaris : Char);

begin
	if kebaris = #72 then
		atas
	else if kebaris = #75 then
		kiri
	else if kebaris = #77 then
		kanan
	else if kebaris = #80 then
		bawah;
end;

procedure Main();
begin
	GenerateKotak;
	while not cekMenang do
	begin
		cetak;
		move(readkey);
		writeln(baris, ' ', kolom);
	end;
	//cetak;
	writeln('cekMenang');
end;

begin
	Main();
end.
