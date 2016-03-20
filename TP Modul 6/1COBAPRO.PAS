{File        : CobaProcedure.pas}
{Description : contoh penggunaan Procedure untuk mencari luas dan keliling persehi.}
{Date        : 9 Maret '16}

Program CobaProcedure;
uses crt;

var
   sisi,luas,kel : integer;

procedure persegi ( s : integer; var K, L : integer);

{*Procedure Persegi akan menghasilkan luas pada variable L dan keliling
pada variable K dari data sisi yang ada pada variable s *}
begin
     K := 4*s;
     L := s*s;
end;

begin
     clrscr;

     write('Masukkan Sisi : '); readln(sisi);
     persegi(sisi,luas,kel);
     writeln('Luas = ', luas);
     writeln('Keliling : ', kel);

     readln;
end.