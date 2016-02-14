program faktorial;

var
 i,n,fak,r : integer;

begin
     writeln('Masukkan Bilangan : '); readln(n);

     i := 1;
     fak := 1;
     r := n;
     while i < n do

     begin ;
         fak := fak  * r;
         r := r -1;
         i := i + 1;
     end;

     writeln(fak);
     readln;
end.