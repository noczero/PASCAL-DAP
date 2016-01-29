{ Perbedaan Read dan Readln}

program perbedaanreaddanreadln;

var
   a,b : string;

begin
     writeln('Memmasukkan variable kata dengan Enter menggunakan readln'); readln(a);
     writeln('Memasukkan variable kata dengan Spasi menggunakan read'); read(b);

     writeln(a);
     writeln(b);
     readln;
end.