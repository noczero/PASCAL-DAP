PROGRAM hitungtitiktengah;

type Titik = record
           x : real;
           y : real;
           end;

var
P1 , P2 : Titik;
Pt : Titik;
y : integer;

  function TitikTengah ( P1, P2 : Titik ; var Pt : Titik) :integer;

  begin
       Pt.x := (P1.x + P2.x) / 2;
       Pt.y := (P1.y + P2.y) / 2;

       TitikTengah := 1;
  end;

begin
     writeln (' Titik P1 : ');
     write ('P1.x : '); readln(P1.x);
     write ('P1.y : '); readln(P1.y);
     writeln ('Titik P2 : ');
     write ('P2.x : '); readln(P2.x);
     write ('P2.y : '); readln(P2.y);

     y := TitikTengah(P1,P2,Pt);

     writeln('Titik Tengah = (', Pt.x,',', Pt.y,')');
     readln;
end.