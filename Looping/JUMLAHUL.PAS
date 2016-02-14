program penjumlahanulang;

var
n, jumlah, x : integer;

begin
     x := 1;
     repeat
           begin
           writeln('Masukkan Bilangan '); readln(n);

           jumlah := jumlah + n;

           x := x +1;

           end;

     until n < 0 ;
     writeln(jumlah);
     readln;

end.