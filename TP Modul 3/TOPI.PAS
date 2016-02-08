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

     if (top1<>top2) and (top1<>top3) then
        writeln('Topi 1 berbeda dengan yang lain')
     else
         if (top2<>top1) and (top2<>top3) then
            writeln('Topi 2 berbeda dengan yang lain')
         else
             if (top3<>top1) and (top3<>top1) then
                writeln('Topi 3 berbeda dengan yang lain');

     readln;
end.