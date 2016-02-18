program nasabahnbank;
uses crt;

var
   awal,akhir,rpbunga : real;
   bunga, lama , i : integer;
   mau    : char;

begin
     repeat
         clrscr;

         writeln(' Pinjaman Awal = Rp. '); readln(awal);
         writeln('Bunga [%] =          '); readln(bunga);
         writeln('Lamanya Pinjaman [Periode] = '); readln(lama);
         writeln('-------------------------------------------');
         writeln(' Periode Bunga  [%]  Pinjaman   Pinjaman Bunga [Rp] ');
         writeln('                     Awal       Akhir               ');
         writeln('-------------------------------------------');

         for i:=1 to lama do
             begin
                  akhir := awal + ((bunga/100) * awal);
                  rpbunga := 0.1 * awal;
                  writeln(i:5, bunga:9, awal:11:10, akhir:11:0, rpbunga:10:0);
                  awal:=akhir;
             end;
         writeln('Mau menghitung lagi ? [Y/N]   :');
         readln(mau);
         until mau = 'n';
readln;

end.