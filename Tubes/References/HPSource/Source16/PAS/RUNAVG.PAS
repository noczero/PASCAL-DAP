{Running average, for Turbo/FreePascal, http://rudih.info}

program runavg;

var
 count,usernum,answer,total:real;

begin
 total:=0;
 count:=0;
 usernum:=0;
 while(usernum>=0)do
  begin
   write('Enter number or -1 to quit: ');
   readln(usernum);
   count:=count+1;
   total:=total+usernum;
   answer:=total/count;
   writeln(answer);
  end;
end.

