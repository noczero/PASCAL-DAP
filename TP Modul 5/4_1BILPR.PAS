{File : 4DERPRIMA.PAS}
{Desc : Deret Prima dari 2 bilangan inputan}
{Date : 21 Februari 2016}

program cekbilanganprima_deret;
uses crt;

var
   bil1,bil2,c,p,i,j : integer;

begin
     clrscr;
     writeln('Masukkan Bilangan Pertama : '); readln(bil1);
     writeln('Masukkan Bilangan Kedua    : '); readln(bil2);

     if (bil1 > bil2) then
        begin
            c := bil1;
            bil1 := bil2;
            bil2 := c;
        end;

     for i:=bil1 to bil2 do
         begin
              p := 0;
              for j := 1 to i do

                 begin
                 if (i mod j = 0) then
                 p := p +1;
                 end;

                 if (p = 2) then
                 write( i ,' ');
         end;

     readln;
end.