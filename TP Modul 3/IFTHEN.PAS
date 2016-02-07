{File : Ifthen.pas}
{Description : Struktur If then .}
{Date : 7 Feb 2016}

{
====== Algoritma ======
==  Struktur If then ==
=======================

if kondisi then
   aksi
endif

=======================

if kondisi then
   aksi1
else
    aksi2
endif

=======================

}

program ifthen;
uses crt;

var
   a,b: boolean;

begin
     clrscr;

     a:= true;
     { Only 1 Action }
     if a =  true then
        writeln(a)
     else
         writeln('false');

     { Multiple Action }
     b:=false;

     if b = false then
        begin
             writeln(b);
             writeln('salah');
             writeln('wrong');
        end
     else
         writeln(a);
     readln;
end.


