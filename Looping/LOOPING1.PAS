program looping1;

var
 i,a, jumlah : integer;
 j,b, jm: integer;
begin
     writeln('Masukkan Jumlah Angka : '); readln(a);
     for i:= 1  to a-1  do
      begin

      if (i mod 2 = 0) then
         jumlah := jumlah + i;

      end;

      writeln(jumlah);

      writeln('============================================');
      writeln('Ini dengan while : ');
      writeln('Masukkan Jumlah Angka : '); readln(b);

      jm:=0;
      j:=1;

      while j < b do
       begin

        if ( j mod 2 = 0) then
         begin

         if ( j < b ) then
            write(j , ' + ')
         else
             write(' = ');

         jm := jm + j;

         end;
        j := j + 1;
       end;

      writeln(jm);

      readln;
end.