program hitungdurasi;

type jam = record
         hh : integer;
         mm : integer;
         ss : integer;
         end;

var
   JamAwal, JamAkhir : jam;
   Durasi : integer;

begin
     {Input}
     writeln('Masukkan Jam Awal'); readln(JamAwal.hh);
     writeln('Masukkan Menit Awal'); readln(JamAwal.mm);
     writeln('Masukkan Detik Awal'); readln(JamAwal.ss);
     writeln('----------------------------------------');
     writeln('Masukkan Jam Akhir'); readln(JamAkhir.hh);
     writeln('Masukkan Menit Akhir'); readln(JamAkhir.mm);
     writeln('Masukkan Detik Akhir : '); readln(JamAkhir.ss);

     if JamAkhir.hh > JamAwal.hh then
      {Formula}
      begin
      durasi := (JamAkhir.hh * 3600 + JamAkhir.mm * 60 + JamAkhir.ss) - (JamAwal.hh *3600 + JamAwal.mm * 60 + JamAwal.ss);

      {Output}
      writeln('Durasi Total : ', durasi,' detik ');

      end
     else
      begin
      writeln('Data tidak valid, ulangi lagi!');
      end;
readln;
end.