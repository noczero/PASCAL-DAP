program maksikumminumum;

type data = array [1..10] of integer;

var
A : data;
i, n, max,min,sum : integer;


procedure maksimum ( var T : data);
begin
 max :=  T[1];
  if max < T[i] then
   max := T[i];
end;

procedure minimum ( var T : data);
begin
 min := T[1];
 if min > T[i] then
  min := T[i];
end;

procedure jumlah( var T : data);
begin
 sum := sum + T[i];
end;

begin
    writeln('Masukkan Juldah data '); readln(n);

    for i := 1 to n do
    begin
        write('Data ' ,i,' : '); readln(A[i]);
    end;

    for i := 1 to n do
    begin
     maksimum(A);
     minimum(A);
     jumlah(A);
    end;

    writeln('Nilai Minimum ', min);
    writeln('Nilai Maksimum ', max);
    writeln('Rata - Rata ', sum/n);
    readln;

end.