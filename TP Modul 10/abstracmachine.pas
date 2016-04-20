{File        : abstracmachine.pas}
{Description : Abstrac Mesin menghitung jumlah karakter dan huruf vokal}
{Date        : 26 Maret '16}


program mesinabstrak;
uses crt,sysutils;
var
	dibaca : Char;
	tot_kar, tot_A : Integer;
	myfile : text;
	Kata,hurufkecil : String;

procedure WriteFile();
begin
	assign(myfile,'log.txt');
	rewrite(myfile);
	write('Ketikkan Kata yang mau dibaca : '); readln(Kata);
	hurufkecil := lowercase(Kata);
	writeln(myfile,hurufkecil);
	close(myfile);
end;

procedure START();
begin
	assign(myfile,'log.txt');
	reset(myfile);
end;

procedure ADV();
begin
	read(myfile,dibaca);
end;

procedure ADV_banyakkarakter(var banyakKar : Integer);
begin
	banyakKar := -2;
	read(myfile,dibaca);
    reset(myfile);
	while not eof(myfile) do
	 begin
	 	read(myfile,dibaca);
	 	banyakKar := banyakKar + 1;
	 end;

end;

procedure ADV_Vokal(var banyakA : Integer);
begin
	banyakA := 0;
    read(myfile,dibaca);
    reset(myfile);
	while not eof(myfile) do
	begin
		if (dibaca = 'a') or (dibaca = 'i') or (dibaca = 'u') 
		or (dibaca = 'e') or (dibaca = 'o')then
			banyakA := banyakA + 1;
		read(myfile,dibaca)
	end;

end;
begin

	WriteFile();
	START();
	write(' Karakternya : ');

	while not eof(myfile) do
	begin
		ADV();
		write(dibaca, ' ');
	end;

	ADV_banyakkarakter(tot_kar);
	writeln('Banyaknya Semua Karakter : ', tot_kar);

	ADV_Vokal(tot_A);
	writeln('Banyaknya Huruf Vokal :', tot_A);
        readln;
end.
