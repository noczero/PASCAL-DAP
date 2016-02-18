program jumlahderet;

var
   i,n,jumlah : integer;

begin
     readln(n);
     write('Jumlah = ');
     for i:= 1 to n do
         begin
              if (i <> n) then
                 write ( i, '+')
              else
                  write (i, '=');
         jumlah := jumlah + i;

         end;
     writeln(jumlah);

readln;
end.