program ganjilgenap;
uses crt;
var
bil1,bil2,i :integer;

function ganjil(bil1:integer):boolean;
begin
    ganjil := (bil1 mod 2 = 1);
end;

function genap(bil1 : integer): boolean;
begin
    genap := (bil1 mod 2 = 0);
end;

function minus(bil1 : integer): boolean;
begin
    minus := (bil1 < 0);
end;

begin
clrscr;
 for i:= 1 to 10 do
  begin
      write('Masukkan Bilangan ', i, ' : '); read(bil1);
      //write('Masukkan Bilangan', i + 1 ,' : '); readln(bil2);
      if genap(bil1) and (bil1 > 0) then
        writeln('Bilangan Genap');

      if ganjil(bil1) and (bil1 > 0) then
        writeln('Bilangan Ganjil');

      if minus(bil1) then
        writeln('Bilangannya minus');
  end;

  readln;
end.
