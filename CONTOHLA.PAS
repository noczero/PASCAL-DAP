program apaituarray;
uses crt;

var larik : array [1..3] of integer;

begin
     clrscr;

     write('Masukkan bilangan ke-1 : '); readln(larik[1]);
     write('Masukkan bilangan ke-2 : '); readln(larik[2]);
     write('Masukkan bilangan ke-3 : '); readln(larik[3]);

     writeln ('Bilangan ke-1 : ', larik[1]);
     writeln ('Bilangan ke-2 : ', larik[2]);
     writeln ('Bilangan ke-3 : ', larik[3]);

     readln;
end.