program jumlah_kali_rata_minimal_maksimal;

var
   n,nmin,nmaks,i,jumlah,rata,kali : integer;
begin
     readln(n);
     nmaks :=n;
     nmin := n;
     jumlah := 0;
     kali := 1;

     while n <> -9999 do
           begin
                if (nmaks < n) then
                   nmaks := n;
                if (nmin > n ) then
                   nmin := n;

                i := i + 1;
                jumlah := jumlah + n;
                kali := kali * n;
                readln(n);
           end;
     rata := jumlah div i;

     writeln('Total Penjumlahan : ', jumlah);
     writeln('Total Perkalian : ', kali);
     writeln('Rata-Rata       : ', rata);
     writeln('Nilai Maksimum  : ', nmaks);
     writeln('Nilai Minimum   : ', nmin);

readln;
end.