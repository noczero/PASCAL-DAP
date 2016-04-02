{file i/o demo, for Turbo Pascal 3.x, http://rudih.info}

program fileio;

var
 filvar: text;
 inp3: string[80];
 inp2: integer;

begin
 write ('enter filename: ');
 readln (inp3);
 clrscr;
 writeln('enter text or exit to quit');
 assign(filvar,inp3);
 rewrite(filvar);
 while inp2<>1 do
  begin
    readln (inp3);
    if (inp3='exit') then
     begin
      close(filvar);
      halt;
     end;
    writeln (filvar, inp3);
  end;
end.