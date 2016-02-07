{File : kayu.pas}
{Description : Menentukan kayu yang paling panjang }
{Date : 7 Feb 2016}

program kayu;
uses crt;

var
   p1,p2,p3,p4,p5 : integer;

begin
     clrscr;

     writeln('Masukkan panjang kayu pertama : '); readln(p1);
     writeln('Masukkan panjang kayu kedua   : '); readln(p2);
     writeln('Masukkan panjang kayu ketiga  : '); readln(p3);
     writeln('Masukkan panjang kayu keempat : '); readln(p4);
     writeln('Masukkan panjang kayu kelima  : '); readln(p5);

     if (p1 > p2) and (p1 > p3) and (p1 > p4) and (p1 > p5) then
        writeln('Kayu Paling Panjang adalah Kayu Pertama')
        else
            if (p2 > p1) and (p2 > p3) and (p2 > p4) and (p2 > p5) then
               writeln('Kayu Paling Panjang adalah Kayu Kedua')
            else
                if (p3 > p2) and (p3 > p1) and (p3 > p4) and (p3 > p5) then
                   writeln('Kayu Paling Panjang adalah Kayu Ketiga')
                else
                    if (p4 > p1) and (p4 > p3) and (p4 > p2) and (p4 > p5) then
                       writeln('Kayu Paling Panjang adalah Kayu Keempat')
                    else
                        if (p5 > p1) and (p5 > p2) and (p5 > p3) and (p5 > p4) then
                           writeln('Kayu Paling Panjang adalah Kayu Kelima');

     readln;
end.



