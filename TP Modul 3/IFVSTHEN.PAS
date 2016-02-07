{File : ifvscase.pas}
{Description : perbedaan if dengan case}
{Date : 7 Feb 2016}

program ifvscase;
uses crt;
label return;

var
   password : string;
   menu : char;

begin
     return : clrscr;

     writeln('Masukkan Password'); readln(password);

     if password = 'admin' then
        writeln('Login Success')
     else
         writeln('Login Failed');

     {Case tidak nerima tipe data String. hanya tipe integer dan char.}

     { Uncomment untuk nencoba error

     case password of
          'admin' : writeln('Password Benar')
     else
         writeln('Password Salah');
     end;

     }

     {######## CONTOH CASE ############}

     writeln('Pilih Menu (1/2/3) : '); readln(menu);
     case menu of
          '1' : writeln('Play');
          '2' : writeln('Save');
          '3' : begin
                     writeln('Exit');
                delay(1000);
                goto return;
                end;
     end;
     readln;

end.