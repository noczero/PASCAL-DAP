{SOAL NO 1 MODUL2}
program biodata;
uses crt;

var
 nim : longint;
 nama,kelas : string;

begin
     writeln('Masukkan NIM anda : '); readln(nim);
     writeln('Masukkan Nama Anda : '); readln(nama);
     writeln('Masukkan Kelas Anda : '); readln(kelas);

     writeln(' Selamat ',nama,' anda memiliki NIM = ',nim,' dengan kelas ',kelas);
     readln;
end.