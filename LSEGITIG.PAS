PROGRAM Segitiga;

var
   i, N : integer;
   a, t : real;

   procedure HitungLuasSegitiga(alas, tinggi : real);

   var
        luas : real;

   begin
        luas := (alas * tinggi) /2;
        write ('Luas Segitiga = ' , luas:0:2);
   end;

begin
     write ('Banyaknya segitiga ? '); readln(N);
     for i:=1 to N do
         begin
              write('Panjang alas segitiga ?'); readln(a);
              write('TInggi segitiga?' ); readln(t);
              HitungLuasSegitiga(a,t);
         end; {for}
readln;
end.
                                            s