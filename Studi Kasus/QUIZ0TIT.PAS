PROGRAM QUIZ0_TitikTengah;
uses crt;

type Titik = record
             x : real;
             y : real;
             end;

var
   P1,P2, P3 : Titik;

Begin
     clrscr;
     textcolor(green);
     writeln('--------');
     write('P1.x = '); readln(P1.x);
     write('P1.y = '); readln(P1.y);

     write('P2.x = '); readln(P2.x);
     write('P2.y = '); readln(P2.y);

     P3.x := (P1.x + P2.x)/2;
     P3.y := (P1.y + P2.y)/2;

     writeln('--------');
     writeln('Titik Tengah Antara P1(',P1.x,',',P1.y,') dan P2(',P2.x,',',P2.y,') adalah P3(',P3.x,',',P3.y,')');
     writeln('--------');
readln;
end.
