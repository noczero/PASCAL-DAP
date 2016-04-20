program sequentialsearch;
uses crt;
type data = array [1..10] of integer;

var
 A : data;
 i,n,cari,indeks : integer;


 procedure input( var T : data; var n,dicari : integer);
 
  begin
      write('Masukkan Jumlah data : '); readln(n);
      for i:= 1 to n do
      begin
          write('Data ',i,' :'); readln(T[i]);
      end;

      write('Masukkan Data yang mau di cari : '); readln(dicari);
  end;


  procedure search( T: data; N,x : integer; var idx : integer);
 
  begin
      i:=1;
      while (i<N) and (T[i] <> x) do
      begin
          i := i + 1;
      end;
      if T[i] = x then
       writeln('Data ditemukan pada indeks ke ', i)
      else
       writeln('Data tidak ditemukan');

  end;

begin
    clrscr;
    input(A,n,cari);
    search(A,n,cari,indeks);
    readln;
end.


