{File : cekkarakter.pas}
{Description : apakah kedua karakter tersebut sama atau tidak}
{Data : 25 Jan 2016}

program cekkarakter;
uses crt;

var
   char1,char2,charup1,charup2 : char;

begin

     clrscr;
     writeln('Masukkan karakter pertama : '); readln(char1);
     writeln('Masukkan karakter kedua : '); readln(char2);

     {Convert to Upcase}
     charup1  := upcase(char1);
     charup2  := upcase(char2);


     if charup1 = charup2 then
        writeln('sama')
     else
        writeln('tidak sama');

     readln;
end.

