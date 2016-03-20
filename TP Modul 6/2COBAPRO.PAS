{File        : CobaProcedure.pas}
{Description : contoh penggunaan Procedure untuk mencari luas dan keliling persehi.}
{Date        : 9 Maret '16}

Program CobaProcedure;
uses crt;

var
   sisi,luas,kel,i : integer;

procedure persegi ( s : integer; var K, L : integer);
{procedure persegi ( s: interge; K, L : integer);  {tidak ada variable output yang dideklarasi}
{*Procedure Persegi akan menghasilkan luas pada variable L dan keliling
pada variable K dari data sisi yang ada pada variable s *}
begin
     K := 4*s;
     L := s*s;
end;

begin
     clrscr;
     i := 1;
     repeat
     write('Masukkan Sisi ',i,' : '); readln(sisi);

     if (sisi < 1) then
     begin
     write('=Selesai=');
     break;
     end

     else
     persegi(sisi,luas,kel);
     writeln('Luas = ', luas);
     writeln('Keliling : ', kel);

     i := i + 1;
     until (sisi < 1) ;
readln;
end.