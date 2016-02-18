program kalideret;

var
   n,i,kali : integer;

begin
     readln(n);
     write('Kali = ');
     kali := 1;
     for i:=1 to n do
         begin
              if i < n then
                 write( i , 'x')
              else
                  write( i , '=');
         kali := kali * i;
         end;
     writeln(kali);

readln;
end.