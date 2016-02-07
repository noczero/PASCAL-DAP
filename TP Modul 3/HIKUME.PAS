{File : hikume.pas}
{Description= : hijau = jalan, kuning = hati hati , merah = berhenti }
{Date : 7 Feb 2016}

program hikume;
uses crt;

var
   status : string;

begin
     clrscr;

     writeln('Masukkan Warna Lampu Lalu Lintas (hijau / kuning / merah): '); readln(status);

     if (status = 'hijau') then
        writeln('Silahkan Jalan')
     else
         if (status = 'kuning') then
            writeln('Bersiap jalan atau Hati-Hati')
         else
             if (status = 'merah') then
                writeln('Berhenti');

     readln;
end.