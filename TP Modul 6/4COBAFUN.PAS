{File        : maxFunction.pas}
{Description : contoh penggunaan Fungsi untuk mencari nilai maksimum antara dua bilangan.}
{Date        : 9 Maret '16}

Program Nilai_maks;
uses crt;
var
   bil1,bil2,hasil : integer;

function max(num1, num2 : integer) : integer;
{*Menggembalikkan nilai maksimum antara dua bilangan*}
var
 {*Local Declaration*}
 maxval : integer;

begin
     if (num1>num2) then
        maxval := num1
     else
         maxval := num2;
     max := maxval;
end;

begin
     clrscr;
     writeln('Masukkan bilangan ke-1 : '); readln(bil1);
     writeln('Masukkan bilangan ke-2 : '); readln(bil2);

     {*Memanggil fungsi untuk mendapatkan nilai maksimum*}
     hasil := max(bil1,bil2);

     writeln('Nilai Maksimum adalah : ' , hasil);
readln;
end.

