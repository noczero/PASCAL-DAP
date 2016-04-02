{PrintTxt2paper, for Turbo Pascal 3.x, http://rudih.info}

program PrintText;

var
 TextFile : Text;
 Scratch  : String[128];

begin
  Write('File to print: ');
  Readln(Scratch);
  Assign(TextFile, Scratch);
  {$I-}
  Reset(TextFile);
  {$I+}
  if IOresult<>0 then
    Writeln('Cannot find ', Scratch)
  else
  begin
    while not Eof(Textfile) do
    begin
      Readln(TextFile, Scratch);
      Writeln(Lst, Scratch)
    end;
    Writeln(Lst)
  end
end.
