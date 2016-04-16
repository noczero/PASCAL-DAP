program selectionsort;

type data = array[1..10] of integer;

var
	A: data;
	i,n,j,tmp,min : integer;

procedure input(var T : data ; var n : integer) ;
begin
	write('Masukkan jumlah data yang ingin di input'); readln(n);
	for i := 1 to n do
	begin
		write('Data ',i, ' : '); readln(T[i]);
	end;

end;

procedure urutselection(var T : data; n : integer);
begin
	for i:= 1 to n-1 do
	begin
		min := i;
		for j := i + 1 to n do
		 if (T[j] < T[min]) then
		 	min := j;
		tmp := T[min];
		T[min] := T[i];
		T[i] := tmp;
	end;
end;

procedure show(var T : data; n : integer);
begin
	for i := 1 to n do
	begin
		write(T[i], ' ');
	end;
end;

begin
	input(A,n);
	urutselection(A,n);
	writeln('Setelah di Urut');
	show(A,n);
	readln;
end.
