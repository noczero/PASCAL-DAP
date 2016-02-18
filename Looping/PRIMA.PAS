program cekbilanganprima;
uses crt;

var
   bil,p,i : integer;

begin
     readln(bil);
     for i:= 1 to bil do
         begin
              if bil mod i = 0 then
                 p := p + 1;
         end;

     if p = 2 then
        writeln('Bilangan adalah prima ')
     else
         writeln('Bukan bilangan prima');
     readln;

end.