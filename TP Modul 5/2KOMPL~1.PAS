{File : 2KOMPLEKS.PAS}
{Desc : Hitung Jumlah, Perkalian, Rata-Rata, Minimal, Maksimal}
{Date : 21 Februari 2016}

program jumlah_kali_rata_minimal_maksimal;
uses crt;

var
   n,nmin,nmaks,i,jumlah,rata,kali : integer;

begin
     clrscr;
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

     writeln('Hasil Penjumlahan = ', jumlah);
     writeln('Hasil Perkalian   = ', kali);
     writeln('Rata-rata         = ', rata);
     writeln('Nilai Minimum     = ', nmin);
     writeln('Nilai Maksimum    = ', nmaks);

readln;
end.