{File : konversisuhu.pas}
{Description : menghitung suhu konversi Celsius ke Reamur}
{Date : 30 Jan 2016}

program konversisuhu;

uses crt;

var
   C,R : real;

begin
     clrscr;
     writeln('Masukkan Suhu dalam Celcius : '); readln(C);

     {Rumus Celcius ke Reamur}
     R := 4/5 * C;

     writeln('Suhu adalah ',R:0:0,' Reamur');

     readln;
end.