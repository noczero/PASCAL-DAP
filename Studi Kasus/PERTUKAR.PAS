PROGRAM PertukaranAdanB;
uses crt;

var
 A,B,C : integer;

begin
     clrscr;
     textcolor(green);
     writeln('Masukkan nilai A : '); readln(A);
     writeln('Masukkan nilai B : '); readln(B);

     C:=A;
     A:=B;
     B:=C;

     writeln('Nilai A : ', A);
     writeln('Nilai B : ', B);
readln;
end.