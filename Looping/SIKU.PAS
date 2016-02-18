{
*
**
***

}


program segitiga;

var
   s,a,t : integer;

begin
     readln(t);

     for s:= 0 to t do
         begin
              for a := s+1 to t  do
                  write('*');
                  writeln('*');
         end;
readln;
end.