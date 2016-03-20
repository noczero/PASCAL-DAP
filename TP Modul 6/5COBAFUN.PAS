{File        : maxFunction.pas}
{Description : contoh penggunaan Fungsi untuk mencari nilai maksimum antara dua bilangan.}
{Date        : 9 Maret '16}

Program Nilai_maks;
uses crt;
var
   bil1,bil2,bil3,hasil : integer;

function max(num1, num2, num3 : integer) : integer;
{*Menggembalikkan nilai maksimum antara dua bilangan*}
var
 {*Local Declaration*}
 maxval : integer;

begin
     if (num1>num2) and (num1>num3) then
        maxval := num1
     else
     if (num2>num1) and (num2>num3) then
         maxval := num2
     else
         maxval := num3;
     max := maxval;
end;

begin
     clrscr;
     writeln('Masukkan bilangan ke-1 : '); readln(bil1);
     writeln('Masukkan bilangan ke-2 : '); readln(bil2);
     writeln('Masukkan bilangan ke-3 : '); readln(bil3);

     {*Memanggil fungsi untuk mendapatkan nilai maksimum*}
     hasil := max(bil1,bil2,bil3);

     writeln('Nilai Maksimum adalah : ' , hasil);
readln;
end.

