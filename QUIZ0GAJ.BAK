PROGRAM QUIZ0Gaji;
uses crt;

var
   golongan : char;
   nama : string;
   jamkerja : longint;
   jamlembur : longint;
   jamkerjalembur : longint;
   gajimingguan : longint;
   lembur : longint;

begin
     clrscr;
     textcolor(green);

     jamkerjalembur:=48;

     writeln('--------------------');
     writeln('Masukkan Nama Karyawan : '); readln(nama);
     writeln('Masukkan Jumlah jam kerja selama seminggu : '); readln(jamkerja);
     writeln('Masukkan Golongan (A,B,C,D) : '); readln(golongan);

     if jamkerja > jamkerjalembur then
        lembur := (jamkerja-jamkerjalembur) * 3000
     else
         ;


     case golongan of

     'A' : begin
           gajimingguan := (jamkerja * 4000) + lembur;
           writeln('Nama Karyawan : ', nama);
           writeln('Jam Kerja : ', jamkerja);
           writeln('Gaji Mingguan Karyawan : ', gajimingguan);
           writeln('--------------------');
           end;

     'B' : begin
           gajimingguan := (jamkerja * 5000) + lembur;
           writeln('Nama Karyawan : ', nama);
           writeln('Jam Kerja : ', jamkerja);
           writeln('Gaji Mingguan Karyawan : ', gajimingguan);
           writeln('--------------------');
           end;

     'C' : begin
           gajimingguan := (jamkerja * 6000) + lembur;
           writeln('Nama Karyawan : ', nama);
           writeln('Jam Kerja: ', jamkerja);
           writeln('Gaji Mingguan Karyawan : ', gajimingguan);
           writeln('--------------------');
           end;

     'D' : begin
           gajimingguan := (jamkerja * 7500) + lembur;
           writeln('Nama Karyawan : ',nama);
           writeln('Jam Kerja: ', jamkerja);
           writeln('Gaji Mingguan Karyawan : ', gajimingguan);
           writeln('--------------------');
           end;
     end;
readln;
end.






