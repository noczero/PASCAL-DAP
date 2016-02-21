{File : 3PRIMA.PAS}
{Desc : Check Bilangan Prima}
{Date : 21 Februari 2016}

program cekbilanganprima;
uses crt;

var
   bil,p,i : integer;

begin
     clrscr;
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