{File : 1DERGENAP.PAS}
{Desc : Jumlah Deret Genap}
{Date : 21 Februari 2016}

program hitung_jumlah_deretgenap_until_9999;
uses crt;

var
   n,jumlah : integer;
begin
     clrscr;
     readln(n);
     while n <> -9999 do
           begin
                if (n mod 2 = 0) then
                   jumlah := jumlah + n;
                   readln(n);
           end;
     writeln(jumlah);
readln;
end.