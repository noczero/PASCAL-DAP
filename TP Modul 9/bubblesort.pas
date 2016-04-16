program bubblesort;

type data = array [1..10] of integer;

var
 A : data;
 i,n,j,tmp : integer;


 procedure input ( var T : data; var n :integer);
 begin
        write('Masukkan Jumlah data yang ingin di input ' ); readln(n);

        for i := 1 to n do
        begin
            write('Data ', i,' :'); readln(T[i]);
        end;

 end;

 procedure urutbubble(var T : data; n : integer);
 begin
     for i := n downto 2 do
      for j:= 2 to i do
       if (T[j-1] > T[j]) then
       begin
          tmp := T[j-1];
          T[j-1] := T[J];
          T[j] := tmp;
       end;

 end;

 procedure show ( var T: data; n : integer);
 begin
     for i:= 1 to n do
     begin
         write(T[i], ' ');
     end;

 end;
 begin
     input(A,n);
     urutbubble(A,n);
     writeln('Setelah di urut');
     show(A,n);
     readln;

 end.

