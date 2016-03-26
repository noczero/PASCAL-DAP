PROGRAM LuasLingkaran;
uses crt;

const phi=3.14;

type Lingkaran=record
     Jari2:integer;
     Luas : real;
end;

var
   L:Lingkaran;

Begin
     Write('masukkan jari2 lingkaran: ');
     Readln(L.jari2);
     L.Luas:=phi*L.jari2*L.jari2;
     write('Luas lingkaran = ', L.Luas:0:2);
readln;
end.

