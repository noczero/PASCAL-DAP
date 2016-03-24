program kalkulator;

var
	bil1,bil2,total: real;
        pilih : char;

function tambah(a,b:real): real;
begin
	tambah := a + b;
end;

function kurang(a,b:real): real;
begin
	kurang := a - b;
end;

function kali(a,b:real): real;
begin
	kali := a * b;
end;

function bagi(a,b:real): real;
begin
	bagi := a / b;
end;

procedure keluar;
begin
	writeln;
	writeln;
	writeln('Keluar Program');
	
	readln;
end;

procedure showmenu;
begin
	writeln('========================');
	writeln('kalkulator Sederhana');
	writeln('Pilih Menu');
	writeln('1. Penjumlahan');
	writeln('2. Pengurangan');
	writeln('3. Perkalian');
	writeln('4. Pembagian');
	writeln('5. Keluar');
	writeln('=======================');
end;

procedure menu(bil1,bil2:real ; pilih:char; var total:real);
begin
	case pilih of
	'1' : total := tambah(bil1,bil2);
	'2' : total := kurang(bil1,bil2);
	'3' : total := kali(bil1,bil2);
	'4'	: total := bagi(bil1,bil2);
	'5' : keluar;
        end;
end;

begin
	showmenu;
	repeat
	write('Masukkan Bilangan Peratama '); readln(bil1);
	write('Masukkan Bilangan Kedua '); readln(bil2);
	write('Pilih Menu Opearsi '); readln(pilih);
	writeln('=====================');
	menu(bil1,bil2,pilih,total);
	if (pilih <> '5') then writeln('Hasilnya : ', total:0:0);
	until pilih = '5';
	
end.

