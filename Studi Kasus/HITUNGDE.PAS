program hitungdetikkehari;
uses crt;

 type jam = record
            dd : integer;
            hh : integer;
            mm : integer;
            ss : integer;
            end;

 var
 waktu, sisa : jam;
 detik : integer;

 begin
      clrscr;

      writeln('Masukkan Nilai Detik  : '); readln(detik);

      waktu.dd := detik div 86400;
      sisa.dd := detik mod 86400;
      waktu.hh := sisa.dd div 3600;
      sisa.hh := sisa.dd mod 3600;
      waktu.mm := sisa.hh div 60;
      waktu.ss := sisa.hh mod 60;

      writeln('Hari : ',waktu.dd,' Jam : ',waktu.hh,' Menit : ',waktu.mm,' Detik : ',waktu.ss);
      readln;
 end.
