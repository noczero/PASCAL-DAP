program insertionsort;
uses crt;

type data = array [1..10] of integer;

var
A : data;
i,n,tmp : integer;

procedure input ( var T : data; var n : integer);
begin
    write('Masukkan jumlah data yang ingin di input : ' ); readln(n);
    for i:= 1 to n do
    begin
        write('Data ' ,i,' : '); readln(T[i]);
    end;
end;

procedure urutinsertion( var T : data; n : integer);
var j : integer;
begin
    for i := 2 to n do
    begin
     tmp := T[i];
     j := i ;
      while (j>1) and (tmp < T[j-1]) do
      begin
          T[j] := T[j-1];
          j := j -1;
      end;
      T[j] := tmp;
     end;
end;

procedure show ( var T : data; n : integer);
begin
    for i := 1 to n do
    begin
     write(T[i], ' ');
    end;
end;

begin
    input(A,n);
    urutinsertion(A,n);
    writeln('Setelah di Urut ' );
    show(A,n);
    readln;
end.