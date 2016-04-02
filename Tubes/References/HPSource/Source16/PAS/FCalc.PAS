{Calculator, for Turbo/FreePascal, http://rudih.info}

program fcalc;

var
 num,den,radians:real;
 op:string[6];

begin
 num:=1;
 while num<>0 do
 begin
  den:=0;
  write('Calculator - enter a number - 0 exits: ');
  readln(num);
  radians:=3.141593*(num/180);
  if(num=0) then halt;
  write('Enter operator [+,-,*,/,sqrt,cos,sin,arctan,exp]: ');
  readln(op);
  if(op='+') or(op='-') or(op='*') then
    begin
      write('Enter 2nd number: ');
      readln(den);
    end;
  if(op='/') then
    begin
      write('Enter 2nd number: ');
      readln(den);
    end;
  if(op='+') then writeln(num+den);
  if(op='-') then writeln(num-den);
  if(op='*') then writeln(num*den);
  if(op='/') then writeln(num/den);
  if(op='sqrt') then writeln(sqrt(num));
  if(op='cos') then writeln(cos(radians));
  if(op='sin') then writeln(sin(radians));
  if(op='arctan') then writeln(arctan(radians));
  if(op='exp') then writeln(exp(num));
 end;
end.