{Description In Case Katak Keluar dari sumur}

program katak;
uses crt;

var
   merosot,kedalaman,selisih : real;
   naik, hari                : integer;

begin
     clrscr;
     writeln('Masukkan kedalaman sumur : '); readln(kedalaman);
     writeln('Jumlah  Hari  Naik  Merosot  Jumlah Naik  Kedalaman');
     writeln('                             PerHari               ');

     begin
          hari := 1;
          naik := 3;
          merosot := 1;
          selisih := naik - merosot;

     while kedalaman > 0 do
           begin
                kedalaman := kedalaman - selisih;
                writeln(hari:7, naik :10, merosot:10:2, selisih:11:2, kedalaman:14:2);

                hari := hari + 1;
                     if (hari>5) and (hari<=15) then
                        begin
                             naik := 2;
                             merosot := 1.25;
                             selisih := naik - merosot;
                        end
                     else
                         if (hari > 15) then
                            begin
                                 naik := 2;
                                 merosot := 1.5;
                                 selisih := naik - merosot;
                            end;
           end;
     end;
readln;
end.
          kedalaman := kedalaman - selisih ;