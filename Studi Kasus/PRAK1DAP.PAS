Program PraktikumASDGaji;
uses crt;

type karyawan = record
              nama : string;
              jml_lembur,gol : integer;
              gaji_pokok,bonus_tetap,bonus_lembur,gaji_bulan,gaji_total: real;
              end;

var
   a : karyawan;

begin
     clrscr;
     write('Masukkan nama karyawan : '); readln(a.nama);
     writeln('Golongan Karyawan :       ');
     writeln('         1. Golongan I    ');
     writeln('         2. Golongan II   ');
     writeln('         3. Golongan III  ');
     write('Masukkan golongan karyawann : '); readln(a.gol);
     write('Masukkan jumlah lembur : '); readln(a.jml_lembur);
     case a.gol of
          1 : begin
              a.gaji_pokok := 250000;
              end;
          2 : begin
              a.gaji_pokok := 500000;
              end;
          3 : begin
              a.gaji_pokok := 750000;
              end;
     end;   {tambahin end}

     a.bonus_tetap := 0.25 * a.gaji_pokok;
     a.bonus_lembur := a.jml_lembur*a.bonus_tetap;
     a.gaji_bulan := a.gaji_pokok+a.bonus_tetap+a.bonus_lembur;

     writeln('----Jumlah Gaji-----');
     writeln('Nama Karyawan          : ', a.nama);
     writeln('Golongan Karyawan      : ', a.gol);
     writeln('Jumlah Lembur          : ', a.jml_lembur);
     writeln('Total Gaji per bulan   : ', a.gaji_bulan);

     readln;

end.
