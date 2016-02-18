program faktorisasi;

var
   i,bil : integer;

begin
     readln(bil);

     for i:=1 to bil do
         begin
              if bil mod i = 0 then
                 write(i, ' ');
         end;

readln;
end.