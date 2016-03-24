program functionkalkulator;
uses crt;

var
 x,y :integer;
 pilih : char;

function tambah(x,y :integer): integer;
begin
    tambah := x + y;
end;

function kurang(x,y : integer) : integer;
begin
    kurang := x - y;
end;

function kali(x, y : integer): integer;
begin
    kali := x * y;
end;

function bagi( x, y : integer): integer;
begin
    bagi := x div y;
end;

function tutup:integer;
begin
    writeln;
    writeln;
    writeln('Press any key to Quit');
    readln;
end;

function menu:char;
var xx : char;
begin
    writeln('Pilihan : ');
    writeln('1. Masukkan Data ');
    writeln('2. Hasil Tambah');
    writeln('3. Hasil Kurang');
    writeln('4. Hasil Kali');
    writeln('5. Hasil Bagi');
    writeln('6. Keluar');
    xx := readkey;
    menu := xx;
end;

//Main  Program
begin
repeat
pilih := menu;

case pilih of
'1' : begin
        clrscr;
        write('Masukkan Bilangan 1 :' ); readln(x);
        write('Masukkan Bilangan 2 : '); readln(y);
        end;
'2' : begin
        clrscr;
        writeln('Hasil Penjumlahan adalah');
        writeln('Hasil tambah', x , ' + ' , y , ' = ' , tambah(x,y));
       end;
'3' : begin
        clrscr;
        writeln('Hasil Pengurangan adalah');
        writeln('Hasil kurang', x , ' - ', y , ' = ', kurang(x,y));
        end;
'4' : begin
        clrscr;
        writeln('Hasil Perkalian adalah ');
        writeln('Hasil Kali ' , x , ' * ', y , ' = ', kali(x,y));
        end;
'5' : begin
        clrscr;
        writeln('Hasil Pembagian adalah ');
        writeln('Hasil Bagi ' , x , ' / ' , y , ' = ', bagi(x,y));
        end;
'6' : tutup;
else
begin
    writeln('Invalid Value');
    readln;
end;

end;
UNTIL pilih='6';
end.
