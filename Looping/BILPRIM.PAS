program cekbilanganprima_range;
uses crt,math;

var
   bil1,bil2,p,i : integer;

begin
     clrscr;
     readln(bil1);
     readln(bil2);

     for i:= min(bil1,bil2) to max(bil1,bil2) do
         begin
              for j := 1 to i do
                 begin
                 p := p +1;

                 end;

                 if p = 2 then
                    write( i ,' ');
                 p:=0;
         end;
     readln;
end.