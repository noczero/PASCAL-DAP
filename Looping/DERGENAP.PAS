program hitung_jumlah_deretgenap_until_9999;

var
   n,jumlah : integer;
begin
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