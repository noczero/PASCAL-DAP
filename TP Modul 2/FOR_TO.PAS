{File : loopFor.pas}
{Description : menampilkan 'hello' sebanyak n berikut counter 1 s.d. n menggunakan skema perulangan for.}
{Data : 25 Jan 2016}

program for_to;

var
   n,i:integer;

begin

     readln(n);
     for i:=1 to n do
     begin
          writeln('Hello, ',i);
     end;

     writeln('selesai');
     readln;
end.