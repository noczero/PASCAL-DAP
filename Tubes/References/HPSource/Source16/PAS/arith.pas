{Arithmetic Questioner, for Turbo/FreePascal, http://rudih.info}
program ArithQ;

var
  num,den,operat,division,user,result,upperadd,uppermul:integer;

begin
  writeln('Arithmetic Questioner - enter a negative number to quit');
  writeln;
  write('Set greatest number to add or subtract (1-15990): ');
  readln(upperadd);
  if(upperadd<=0) then halt;
  write('Set greatest number to multiply or divide (1-178): ');
  readln(uppermul);
  if(uppermul<=0) then halt;
  if(uppermul>178) or(upperadd>15990) then
    begin
      writeln('Number too large error');
    end;
  user:=1;
  while(user>=0) do
    begin
      operat:=random(4);
      if(operat < 2) then {less than 2 is add or subtract}
        begin
          num:=random(upperadd);
          den:=random(upperadd);
          if(den>=num) then {avoid negative responses}
            begin
              operat:=0; {set operat}
              write(num,' + ',den,' = ');
            end
          else
            begin
              operat:=1;
              write(num,' - ',den,' = ');
            end;
        end;
      if(operat=2) then {2 is multiply}
        begin
            num:=random(uppermul);
            den:=random(uppermul);
            den:=den+1;
            num:=num+1;
            write(num,' * ',den,' = ');
        end;
      if(operat=3) then {3 is divide}
        begin
            num:=random(uppermul);
            den:=random(uppermul);
            den:=den+1;
            num:=num+1; {avoid division by 0}
            division:=num*den; {get division to reverse}
            write(division,' / ',den,' = ');
        end;
      readln(user);  {get user input}
      if(operat=0) then result:=num+den;
      if(operat=1) then result:=num-den;
      if(operat=2) then result:=num*den;
      if(operat=3) then result:=division div den;
      if(user=result) then
        begin
          writeln('Correct');
        end
       else
        begin
          writeln('Incorrect, it''s ',result);
        end;
    end;
end.
