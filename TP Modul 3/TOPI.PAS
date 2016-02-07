{File : topi.pas}
{Description : hitung berat topi yang sama }
{Date : 7 Feb 2016}

program topi;
uses crt;

var
   top1,top2,top3 : integer;

begin
     clrscr;

     writeln('Berat topi pertama : '); readln(top1);
     writeln('Berat topi kedua   : '); readln(top2);
     writeln('Berat topi ketiga  : '); readln(top3);

     if (top1<>top2) or (top1<>top3) or (top2<>top3) then
        writeln('Berat topi berbeda')
     else
         writeln('Berat topi sama');

     readln;
end.