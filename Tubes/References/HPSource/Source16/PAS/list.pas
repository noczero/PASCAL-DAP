{List, for Turbo Pascal 3.x, http://rudih.info}

program TextFileDemo;
VAR
 Filvar: text;
 line: string[255];
 I: integer;
 Filename: string[14];
begin
 write('enter name of file to list: ');
 Readln(filename);
 assign(filvar,filename);
 reset(filvar);
 I:=0;
 while not Eof(filvar) do
 begin
  I:=I+1;
  if (I>23) then
    begin
    I:=0;     
    write ('...press enter <Ctrl-C> exits');
    readln(line); 
    end;
  readln(filvar,line);
  writeln(line);
 end; {while not eof}
 write ('...press enter');
 readln(line); 
end.